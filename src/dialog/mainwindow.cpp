#include "mainwindow.h"
#include "startscene.h"
#include "roomscene.h"
#include "server.h"
#include "client.h"
#include "generaloverview.h"
#include "cardoverview.h"
#include "ui_mainwindow.h"
#include "scenario-overview.h"
#include "window.h"
#include "halldialog.h"
#include "pixmapanimation.h"
#include "record-analysis.h"
#include "crypto.h"

#include <cmath>
#include <QGraphicsView>
#include <QGraphicsItem>
#include <QGraphicsPixmapItem>
#include <QGraphicsTextItem>
#include <QVariant>
#include <QMessageBox>
#include <QTime>
#include <QProcess>
#include <QCheckBox>
#include <QFileDialog>
#include <QDesktopServices>
#include <QSystemTrayIcon>
#include <QInputDialog>
#include <QLabel>
#include <QResource>

class FitView : public QGraphicsView
{
public:
    FitView(QGraphicsScene *scene) : QGraphicsView(scene) {
        setSceneRect(Config.Rect);
        setRenderHints(QPainter::TextAntialiasing | QPainter::Antialiasing);
    }

protected:
    virtual void resizeEvent(QResizeEvent *event) {
        QGraphicsView::resizeEvent(event);
        if(Config.FitInView)
            fitInView(sceneRect(), Qt::KeepAspectRatio);

        if(matrix().m11()>1)setMatrix(QMatrix());

        if(scene()->inherits("RoomScene")){
            RoomScene *room_scene = qobject_cast<RoomScene *>(scene());
            room_scene->adjustItems(matrix());
            QPixmap pixmap(Config.BackgroundBrush);
            QBrush brush(pixmap);
            if(pixmap.width() > 100 && pixmap.height() > 100){
                qreal _width = width() / matrix().m11();
                qreal _height= height() / matrix().m22();
                qreal dx = -_width / 2.0;
                qreal dy = -_height / 2.0;
                qreal sx = _width / qreal(pixmap.width());
                qreal sy = _height / qreal(pixmap.height());
                QTransform transform;
                transform.translate(dx, dy);
                transform.scale(sx, sy);
                brush.setTransform(transform);
            }
            room_scene->setBackgroundBrush(brush);
        }
        else{
            MainWindow *main_window = qobject_cast<MainWindow *>(parentWidget());
            if(main_window){
                main_window->setBackgroundBrush();
                QCursor my(QPixmap("backdrop/main.png"));
                main_window->setCursor(my);
            }
        }
    }
};

MainWindow::MainWindow(QWidget *parent)
    :QMainWindow(parent), ui(new Ui::MainWindow)
{
    ui->setupUi(this);
    scene = NULL;

#ifdef USE_RCC
    QResource::registerResource("image/card.rcc");
#endif
    QResource::registerResource("backdrop/shuihu-cover.rcc");

    setWindowTitle(Sanguosha->translate("Shuihusha"));

    connection_dialog = new ConnectionDialog(this);
    connect(ui->actionJoin_Game, SIGNAL(triggered()), connection_dialog, SLOT(exec()));
    connect(connection_dialog, SIGNAL(accepted()), this, SLOT(on_actionRestart_game_triggered()));

    config_dialog = new ConfigDialog(this);
    connect(ui->actionConfigure, SIGNAL(triggered()), config_dialog, SLOT(show()));
    connect(config_dialog, SIGNAL(bg_changed()), this, SLOT(changeBackground()));

    connect(ui->actionAbout_Qt, SIGNAL(triggered()), qApp, SLOT(aboutQt()));

    StartScene *start_scene = new StartScene;

    QList<QAction*> actions;
    actions << ui->actionStart_Game //Start_Server
            << ui->actionJoin_Game
            << ui->actionReplay
            << ui->actionPackaging
            << ui->actionConfigure

            << ui->actionGeneral_Overview
            << ui->actionCard_Overview
            << ui->actionScenario_Overview;

    if(Config.value("UI/ButtonStyle", QFile::exists("image/system/button/plate/background.png")).toBool()){
        actions << ui->actionAcknowledgement;
        start_scene->addMainButton(actions);
    }
    else{
        actions << ui->actionAbout << ui->actionAcknowledgement;
        foreach(QAction *action, actions)
            start_scene->addButton(action);
    }

    view = new FitView(scene);

    setCentralWidget(view);
    restoreFromConfig();

    gotoScene(start_scene);

    addAction(ui->actionShow_Hide_Menu);
    addAction(ui->actionFullscreen);
    addAction(ui->actionMinimize_to_system_tray);

    systray = NULL;
}

void MainWindow::restoreFromConfig(){
    Config.beginGroup("UI");
    //resize(Config.value("WindowSize", QSize(1042, 719)).toSize());
    resize(Config.value("WindowSize", QSize(1340, 820)).toSize());
    move(Config.value("WindowPosition", QPoint(45, 1)).toPoint());
    Config.endGroup();

    QFont font;
    if(Config.AppFont != font)
        QApplication::setFont(Config.AppFont);
    if(Config.UIFont != font)
        QApplication::setFont(Config.UIFont, "QTextEdit");

    ui->actionPause->setChecked(false);
    ui->actionAutoSave->setChecked(Config.value("AutoSave", false).toBool());
    ui->actionEnable_Hotkey->setChecked(Config.EnableHotKey);
    ui->actionExpand_dashboard->setChecked(Config.value("UI/ExpandDashboard", true).toBool());
    ui->actionDraw_indicator->setChecked(!Config.value("UI/NoIndicator", false).toBool());
    ui->actionDraw_cardname->setChecked(Config.value("UI/DrawCardName", true).toBool());
    ui->actionFit_in_view->setChecked(Config.FitInView);
    ui->actionAuto_select->setChecked(Config.AutoSelect);
    ui->actionAuto_target->setChecked(Config.AutoTarget);
    ui->actionEnable_Lua->setChecked(Config.EnableLua);
    ui->actionButton_style->setChecked(Config.value("UI/ButtonStyle", QFile::exists("image/system/button/plate/background.png")).toBool());
    ui->actionEquip_style->setChecked(Config.value("UI/EquipStyle", true).toBool());
}

void MainWindow::closeEvent(QCloseEvent *event){
    Config.beginGroup("UI");
    Config.setValue("WindowSize", size());
    Config.setValue("WindowPosition", pos());
    if(scene->inherits("StartScene") && Config.value("ButtonStyle", false).toBool()){
        StartScene *start_scene = qobject_cast<StartScene *>(scene);
        Config.setValue("PlatePosition", start_scene->button_plate->pos());
    }
    Config.endGroup();

    if(systray){
        systray->showMessage(windowTitle(), tr("Game is minimized"));
        hide();
        event->ignore();
    }
}

MainWindow::~MainWindow()
{
#ifdef USE_RCC
    QResource::unregisterResource("image/card.rcc");
#endif
    delete ui;
}

void MainWindow::gotoScene(QGraphicsScene *scene){
    view->setScene(scene);
    if(this->scene)
        this->scene->deleteLater();
    this->scene = scene;

    changeBackground();
}

void MainWindow::on_actionAutoSave_toggled(bool checked)
{
    if(Config.value("AutoSave").toBool() != checked)
        Config.setValue("AutoSave", checked);
    QDir temp;
    QString path = Config.value("AutoSavePath", "save").toString();
    if(!temp.exists(path))
        temp.mkdir(path);
}

void MainWindow::on_actionAutoSavePath_triggered()
{
    QString path = QInputDialog::getText(this, tr("The path for replay file"),
                                         tr("Please input the path"),
                                         QLineEdit::Normal,
                                         Config.value("AutoSavePath", "save").toString());
    if(!path.isNull()){
        Config.setValue("AutoSavePath", path);
        QDir temp;
        if(!temp.exists(path))
            temp.mkdir(path);
    }
}

void MainWindow::on_actionPause_toggled(bool checked)
{
    if(!Config.value("PCConsole", false).toBool()){
        QMessageBox::warning(this, tr("Warning"), tr("Can not pause in online game!"));
        return;
    }
    if(Config.Pause != checked)
        Config.Pause = checked;
}

void MainWindow::on_actionExit_triggered()
{
    QMessageBox::StandardButton result;
    result = QMessageBox::question(this,
                                   Sanguosha->translate("Shuihusha"),
                                   tr("Are you sure to exit?"),
                                   QMessageBox::Ok | QMessageBox::Cancel);
    if(result == QMessageBox::Ok){
        systray = NULL;
        close();
    }
}

void MainWindow::on_actionStart_Game_triggered()
{
    ServerDialog *dialog = new ServerDialog(this);
    if(dialog->isPCConsole())
        dialog->ensureEnableAI();
    if(!dialog->config())
        return;

    Server *server = new Server(this);
    if(! server->listen()){
        QMessageBox::warning(this, tr("Warning"), tr("Can not start server!"));

        return;
    }

    if(dialog->isPCConsole()){
        server->createNewRoom();

        Config.HostAddress = "127.0.0.1";
        on_actionRestart_game_triggered();
        return;
    }

    server->daemonize();

    ui->actionJoin_Game->disconnect();
    connect(ui->actionJoin_Game, SIGNAL(triggered()), this, SLOT(startGameInAnotherInstance()));

    StartScene *start_scene = qobject_cast<StartScene *>(scene);
    if(start_scene){
        start_scene->switchToServer(server);
        if(Config.value("EnableMinimizeDialog", false).toBool())
            this->on_actionMinimize_to_system_tray_triggered();
    }
}

void MainWindow::checkVersion(const QString &server_version, const QString &server_mod){
    QString client_mod = Sanguosha->getMODName();
    if(client_mod != server_mod){
        QMessageBox::warning(this, tr("Warning"), tr("Client MOD name is not same as the server!"));
        return;
    }

    Client *client = qobject_cast<Client *>(sender());
    QString client_version = Sanguosha->getVersionNumber();

    if(server_version == client_version){
        client->signup();
        connect(client, SIGNAL(server_connected()), SLOT(enterRoom()));

        if(qApp->arguments().contains("-hall")){
            HallDialog *dialog = HallDialog::GetInstance(this);
            connect(client, SIGNAL(server_connected()), dialog, SLOT(accept()));
        }

        return;
    }

    client->disconnectFromHost();

    static QString link = "http://github.com/Moligaloo/QSanguosha/downloads";
    QString text = tr("Server version is %1, client version is %2 <br/>").arg(server_version).arg(client_version);
    if(server_version > client_version)
        text.append(tr("Your client version is older than the server's, please update it <br/>"));
    else
        text.append(tr("The server version is older than your client version, please ask the server to update<br/>"));

    text.append(tr("Download link : <a href='%1'>%1</a> <br/>").arg(link));
    QMessageBox::warning(this, tr("Warning"), text);
}

void MainWindow::on_actionRestart_game_triggered(){
    Client *client = new Client(this);

    connect(client, SIGNAL(version_checked(QString,QString)), SLOT(checkVersion(QString,QString)));
    connect(client, SIGNAL(error_message(QString)), SLOT(networkError(QString)));
}

void MainWindow::on_actionReplay_triggered()
{
    QString location = Config.value("AutoSavePath", "save").toString();
    //QString location = QDesktopServices::storageLocation(QDesktopServices::HomeLocation);
    QString last_dir = Config.value("LastReplayDir").toString();
    if(!last_dir.isEmpty())
        location = last_dir;

    QString filename = QFileDialog::getOpenFileName(this,
                                                    tr("Select a reply file"),
                                                    location,
                                                    tr("Pure text replay file (*.txt);; Image replay file (*.png)"));

    if(filename.isEmpty())
        return;

    QFileInfo file_info(filename);
    last_dir = file_info.absoluteDir().path();
    Config.setValue("LastReplayDir", last_dir);

    Client *client = new Client(this, filename);

    connect(client, SIGNAL(server_connected()), SLOT(enterRoom()));

    client->signup();
}

void MainWindow::networkError(const QString &error_msg){
    if(isVisible())
        QMessageBox::warning(this, tr("Network error"), error_msg);
}

void MainWindow::enterRoom(){
    // add current ip to history
    if(!Config.HistoryIPs.contains(Config.HostAddress)){
        Config.HistoryIPs << Config.HostAddress;
        Config.HistoryIPs.sort();
        Config.setValue("HistoryIPs", Config.HistoryIPs);
    }

    ui->actionJoin_Game->setEnabled(false);
    ui->actionStart_Game->setEnabled(false);
    ui->actionAI_Melee->setEnabled(false);

    RoomScene *room_scene = new RoomScene(this);

    ui->actionView_Discarded->setEnabled(true);
    ui->actionView_distance->setEnabled(true);
    ui->actionServerInformation->setEnabled(true);
    ui->actionKick->setEnabled(true);
    ui->actionSurrender->setEnabled(true);
    ui->actionSaveRecord->setEnabled(true);
    //ui->actionEnable_Lua->setEnabled(false);

    connect(ui->actionView_Discarded, SIGNAL(triggered()), room_scene, SLOT(toggleDiscards()));
    connect(ui->actionView_distance, SIGNAL(triggered()), room_scene, SLOT(viewDistance()));
    connect(ui->actionServerInformation, SIGNAL(triggered()), room_scene, SLOT(showServerInformation()));
    connect(ui->actionKick, SIGNAL(triggered()), room_scene, SLOT(kick()));
    connect(ui->actionSurrender, SIGNAL(triggered()), room_scene, SLOT(surrender()));
    connect(ui->actionSaveRecord, SIGNAL(triggered()), room_scene, SLOT(saveReplayRecord()));
    connect(ui->actionExpand_dashboard, SIGNAL(toggled(bool)), room_scene, SLOT(adjustDashboard(bool)));

    ui->actionExpand_dashboard->toggle();
    ui->actionExpand_dashboard->toggle();

    if(Config.value("Cheat/EnableCheatMenu", false).toBool()){
        ui->menuCheat->setEnabled(true);

        connect(ui->actionGet_card, SIGNAL(triggered()), ui->actionCard_Overview, SLOT(trigger()));
        connect(ui->actionChange_general, SIGNAL(triggered()), ui->actionGeneral_Overview, SLOT(trigger()));
        connect(ui->actionDeath_note, SIGNAL(triggered()), room_scene, SLOT(makeKilling()));
        connect(ui->actionDamage_maker, SIGNAL(triggered()), room_scene, SLOT(makeDamage()));
        connect(ui->actionRevive_wand, SIGNAL(triggered()), room_scene, SLOT(makeReviving()));
        connect(ui->actionSend_lowlevel_command, SIGNAL(triggered()), this, SLOT(sendLowLevelCommand()));
        connect(ui->actionExecute_script_at_server_side, SIGNAL(triggered()), room_scene, SLOT(doScript()));
    }
    else{
        ui->menuCheat->setEnabled(false);
        ui->actionGet_card->disconnect();
        ui->actionDeath_note->disconnect();
        ui->actionDamage_maker->disconnect();
        ui->actionRevive_wand->disconnect();
        ui->actionSend_lowlevel_command->disconnect();
        ui->actionExecute_script_at_server_side->disconnect();
    }

    connect(room_scene, SIGNAL(restart()), this, SLOT(on_actionRestart_game_triggered()));
    connect(room_scene, SIGNAL(return_to_start()), this, SLOT(on_actionReturn_main_triggered()));

    room_scene->adjustItems();
    gotoScene(room_scene);
}

void MainWindow::on_actionReturn_main_triggered(){
    QList<Server *> servers = findChildren<Server *>();
    if(!servers.isEmpty())
        servers.first()->deleteLater();

    StartScene *start_scene = new StartScene;

    QList<QAction*> actions;
    actions << ui->actionStart_Game //Start_Server
            << ui->actionJoin_Game
            << ui->actionReplay
            << ui->actionPackaging
            << ui->actionConfigure

            << ui->actionGeneral_Overview
            << ui->actionCard_Overview
            << ui->actionScenario_Overview;

    if(Config.value("UI/ButtonStyle", QFile::exists("image/system/button/plate/background.png")).toBool()){
        actions << ui->actionAcknowledgement;
        start_scene->addMainButton(actions);
    }
    else{
        actions << ui->actionAbout << ui->actionAcknowledgement;
        foreach(QAction *action, actions)
            start_scene->addButton(action);
    }

    setCentralWidget(view);
    restoreFromConfig();

    ui->menuCheat->setEnabled(false);
    ui->actionGet_card->disconnect();
    ui->actionDeath_note->disconnect();
    ui->actionDamage_maker->disconnect();
    ui->actionRevive_wand->disconnect();
    ui->actionSend_lowlevel_command->disconnect();
    ui->actionExecute_script_at_server_side->disconnect();
    gotoScene(start_scene);

    addAction(ui->actionShow_Hide_Menu);
    addAction(ui->actionFullscreen);
    addAction(ui->actionMinimize_to_system_tray);

    systray = NULL;
    delete ClientInstance;
}

void MainWindow::startGameInAnotherInstance(){
    QProcess::startDetached(QApplication::applicationFilePath(), QStringList());
}

void MainWindow::on_actionGeneral_Overview_triggered()
{
    GeneralOverview *overview = new GeneralOverview(this);
    overview->fillGenerals(Sanguosha->findChildren<const General *>());
    overview->show();
}

void MainWindow::on_actionCard_Overview_triggered()
{
    CardOverview *overview = CardOverview::GetInstance(this);
    overview->loadFromAll();
    overview->show();
}

void MainWindow::on_actionEnable_Hotkey_toggled(bool checked)
{
    if(Config.EnableHotKey != checked){
        Config.EnableHotKey = checked;
        Config.setValue("EnableHotKey", checked);
    }
}

void MainWindow::on_actionAbout_triggered()
{
    // Cao Cao's pixmap
    QString content =  "<center><img src='image/logo/moligaloo.png'> <br /> </center>";

    // Cao Cao' poem
    QString poem = tr("Disciples dressed in blue, my heart worries for you. You are the cause, of this song without pause");
    content.append(QString("<p align='right'><i>%1</i></p>").arg(poem));

    // Cao Cao's signature
    QString signature = tr("\"A Short Song\" by Cao Cao");
    content.append(QString("<p align='right'><i>%1</i></p>").arg(signature));

    content.append(tr("This is the open source clone of the popular <b>Sanguosha</b> game,"
                      "totally written in C++ Qt GUI framework <br />"
                      "My Email: moligaloo@gmail.com <br/>"
                      "My QQ: 365840793 <br/>"
                      "My Weibo: http://weibo.com/moligaloo <br/>"
                      ));
/*
    QString config;

#ifdef QT_NO_DEBUG
    config = "release";
#else
    config = "debug";
#endif
*/
    content.append(tr("Current version: %1 %2<br/>")
                   .arg(Sanguosha->getVersion())
                   //.arg(config)
                   .arg(Sanguosha->getVersionName()));

    const char *date = __DATE__;
    const char *time = __TIME__;
    content.append(tr("Compilation time: %1 %2 <br/>").arg(date).arg(time));

    QString project_url = "http://github.com/Moligaloo/QSanguosha";
    content.append(tr("Project home: %1 <br/>").arg(project_url));
    //content.append(tr("Project home: <a href='%1'>%1</a> <br/>").arg(project_url));

    QString forum_url = "http://qsanguosha.org";
    content.append(tr("Forum: %1 <br/>").arg(forum_url));
    //content.append(tr("Forum: <a href='%1'>%1</a> <br/>").arg(forum_url));

    Window *window = new Window(tr("About QSanguosha"), QSize(425, 451));
    scene->addItem(window);

    window->addContent(content);
    window->addCloseButton(tr("OK"));
    window->shift();

    window->appear();
}

void MainWindow::setBackgroundBrush(){
    if(scene){
        QPixmap pixmap(":shuihu-cover.jpg");
        QBrush brush(pixmap);

        if(pixmap.width() > 100 && pixmap.height() > 100){
            qreal _width = width()/view->matrix().m11();
            qreal _height= height()/view->matrix().m22();

            qreal dx = -_width/2.0;
            qreal dy = -_height/2.0;
            qreal sx = _width / qreal(pixmap.width());
            qreal sy = _height / qreal(pixmap.height());


            QTransform transform;
            transform.translate(dx, dy);
            transform.scale(sx, sy);
            brush.setTransform(transform);
        }

        scene->setBackgroundBrush(brush);
    }
}

void MainWindow::changeBackground(){
    setBackgroundBrush();

    if(scene->inherits("RoomScene")){
        RoomScene *room_scene = qobject_cast<RoomScene *>(scene);
        room_scene->changeTextEditBackground();
    }else if(scene->inherits("StartScene")){
        StartScene *start_scene = qobject_cast<StartScene *>(scene);
        start_scene->setServerLogBackground();
    }
}

void MainWindow::on_actionFullscreen_triggered()
{
    if(isFullScreen())
        showNormal();
    else
        showFullScreen();
}

void MainWindow::on_actionShow_Hide_Menu_triggered()
{
    QMenuBar *menu_bar = menuBar();
    menu_bar->setVisible(! menu_bar->isVisible());
}

void MainWindow::on_actionMinimize_to_system_tray_triggered()
{
    if(systray == NULL){
        QIcon icon("image/system/magatamas/5.png");
        systray = new QSystemTrayIcon(icon, this);

        QAction *appear = new QAction(tr("Show main window"), this);
        connect(appear, SIGNAL(triggered()), this, SLOT(show()));

        QMenu *menu = new QMenu;
        menu->addAction(appear);
        menu->addMenu(ui->menuGame);
        menu->addMenu(ui->menuView);
        menu->addMenu(ui->menuOptions);
        menu->addMenu(ui->menuHelp);

        systray->setContextMenu(menu);

        systray->show();
        systray->showMessage(windowTitle(), tr("Game is minimized"));

        hide();
    }
}

void MainWindow::on_actionRole_assign_table_triggered()
{
    QString content;

    QStringList headers;
    headers << tr("Count") << tr("Lord") << tr("Loyalist") << tr("Rebel") << tr("Renegade");
    foreach(QString header, headers)
        content += QString("<th>%1</th>").arg(header);

    content = QString("<tr>%1</tr>").arg(content);

    QStringList rows;
    rows << "2 1 0 1 0" << "3 1 0 1 1" << "4 1 0 2 1"
            << "5 1 1 2 1" << "6 1 1 3 1" << "6d 1 1 2 2"
            << "7 1 2 3 1" << "8 1 2 4 1" << "8d 1 2 3 2"
            << "8z 1 3 4 0" << "9 1 3 4 1" << "10d 1 3 4 2"
            << "10s 1 4 4 1" << "10z 1 4 5 0";

    foreach(QString row, rows){
        QStringList cells = row.split(" ");
        QString header = cells.takeFirst();
        if(header.endsWith("d")){
            header.chop(1);
            header += tr(" (double renegade)");
        }
        else if(header.endsWith("s")){
            header.chop(1);
            header += tr(" (single renegade)");
        }
        else if(header.endsWith("z")){
            header.chop(1);
            header += tr(" (no renegade)");
        }

        QString row_content;
        row_content = QString("<td>%1</td>").arg(header);
        foreach(QString cell, cells){
            row_content += QString("<td>%1</td>").arg(cell);
        }

        content += QString("<tr>%1</tr>").arg(row_content);
    }

    content = QString("<table border='1'>%1</table").arg(content);

    Window *window = new Window(tr("Role assign table"), QSize(280, 380));
    scene->addItem(window);

    window->addContent(content);
    window->addCloseButton(tr("OK"));
    window->shift();

    window->appear();
}

void MainWindow::on_actionScenario_Overview_triggered()
{
    ScenarioOverview *dialog = new ScenarioOverview(this);
    dialog->show();
}

BroadcastBox::BroadcastBox(Server *server, QWidget *parent)
    :QDialog(parent), server(server)
{
    setWindowTitle(tr("Broadcast"));

    QVBoxLayout *layout = new QVBoxLayout;
    layout->addWidget(new QLabel(tr("Please input the message to broadcast")));

    text_edit = new QTextEdit;
    layout->addWidget(text_edit);

    QHBoxLayout *hlayout = new QHBoxLayout;
    hlayout->addStretch();
    QPushButton *ok_button = new QPushButton(tr("OK"));
    hlayout->addWidget(ok_button);

    layout->addLayout(hlayout);

    setLayout(layout);

    connect(ok_button, SIGNAL(clicked()), this, SLOT(accept()));
}

void BroadcastBox::accept(){
    QDialog::accept();

    server->broadcast(text_edit->toPlainText());
}

void MainWindow::on_actionBroadcast_triggered()
{
    Server *server = findChild<Server *>();
    if(server == NULL){
        QMessageBox::warning(this, tr("Warning"), tr("Server is not started yet!"));
        return;
    }

    BroadcastBox *dialog = new BroadcastBox(server, this);
    dialog->exec();
}


void MainWindow::on_actionAcknowledgement_triggered()
{
    AcknowledgementScene* ack = new AcknowledgementScene;
    connect(ack,SIGNAL(go_back()),this,SLOT(on_actionReturn_main_triggered()));
    gotoScene(ack);
}

void MainWindow::on_actionScript_editor_triggered()
{
    QMessageBox::information(this, tr("Warning"), tr("This function is not implemented yet!"));
}

void MainWindow::on_actionDraw_indicator_toggled(bool checked)
{
    if(Config.value("UI/NoIndicator").toBool() == checked)
        Config.setValue("UI/NoIndicator", !checked);
}

void MainWindow::on_actionDraw_cardname_toggled(bool checked)
{
    if(Config.value("UI/DrawCardName").toBool() != checked)
        Config.setValue("UI/DrawCardName", checked);
}

void MainWindow::on_actionFit_in_view_toggled(bool checked)
{
    if(Config.FitInView != checked)
        Config.FitInView = checked;
        Config.setValue("UI/FitInView", checked);
}

void MainWindow::on_actionAuto_select_toggled(bool checked)
{
    if(Config.AutoSelect != checked){
        Config.AutoSelect = checked;
        Config.setValue("AutoSelect", checked);
    }
}

void MainWindow::on_actionAuto_target_toggled(bool checked)
{
    if(Config.AutoTarget != checked){
        Config.AutoTarget = checked;
        Config.setValue("AutoTarget", checked);
    }
}

void MainWindow::on_actionEnable_Lua_triggered()
{
    QMessageBox::StandardButton result =
            QMessageBox::question(this,
                                  tr("LUA derail"),
                                  tr("Enable or disable Lua need to restart, are you sure?"),
                                  QMessageBox::Ok | QMessageBox::Cancel);
    if(result == QMessageBox::Ok){
        close();
        //qApp->quit();
        QProcess::startDetached(qApp->applicationFilePath(), QStringList());
        //http://blog.csdn.net/dbzhang800/article/details/6906743
    }
}

void MainWindow::on_actionEnable_Lua_toggled(bool checked)
{
    if(Config.EnableLua != checked){
        Config.EnableLua = checked;
        Config.setValue("EnableLua", checked);
    }
}

void MainWindow::on_actionButton_style_toggled(bool checked)
{
    if(Config.value("UI/ButtonStyle").toBool() != checked)
        Config.setValue("UI/ButtonStyle", checked);
}

void MainWindow::on_actionEquip_style_toggled(bool checked)
{
    if(Config.value("UI/EquipStyle").toBool() != checked)
        Config.setValue("UI/EquipStyle", checked);
}

#include <QGroupBox>
#include <QToolButton>
#include <QCommandLinkButton>
#include <QFormLayout>

MeleeDialog::MeleeDialog(QWidget *parent)
    :QDialog(parent)
{
    server = NULL;
    room_count = 0;
    stage_count = 0;

    setWindowTitle(tr("AI Melee"));
    setSizeGripEnabled(true);
    setMaximumHeight(550);
//    setMinimumSize(200, 200);

    general_box = createGeneralBox();
    result_box = createResultBox();
    server_log = new QTextEdit;
    QGraphicsView *record_view = new QGraphicsView;
    record_view->setMinimumWidth(300);

    record_scene = new QGraphicsScene;
    record_view->setScene(record_scene);

    general_box->setMaximumWidth(250);
    result_box->setMaximumWidth(250);
    server_log->setMinimumWidth(300);
    server_log->setReadOnly(true);
    server_log->setFrameStyle(QFrame::Box);
    server_log->setProperty("type", "description");
    server_log->setFont(QFont("Verdana", 12));

    QVBoxLayout *vlayout = new QVBoxLayout;
    vlayout->addWidget(general_box);
    vlayout->addWidget(result_box);

    QHBoxLayout *layout = new QHBoxLayout;
    layout->addLayout(vlayout);
    layout->addWidget(record_view);
    layout->addWidget(server_log);
    setLayout(layout);

    setGeneral(Config.value("MeleeGeneral", "wusong").toString());
}

QGroupBox *MeleeDialog::createGeneralBox(){
    QGroupBox *box = new QGroupBox(tr("General"));

    avatar_button = new QToolButton;
    avatar_button->setIconSize(QSize(200, 290));
    avatar_button->setObjectName("avatar");

    connect(avatar_button, SIGNAL(clicked()), this, SLOT(selectGeneral()));

    QFormLayout *form_layout = new QFormLayout;
    spinbox = new QSpinBox;
    spinbox->setRange(1, 50);
    spinbox->setValue(1);

    stagebox = new QSpinBox;
    stagebox->setRange(1, 100);
    stagebox->setValue(20);
    //stagebox->setEnabled(false);

    start_button = new QPushButton(tr("Start"));
    connect(start_button, SIGNAL(clicked()), this, SLOT(startTest()));

    loop_checkbox = new QCheckBox(tr("LOOP"));
    loop_checkbox->setObjectName("loop_checkbox");
    connect(loop_checkbox, SIGNAL(toggled(bool)), stagebox, SLOT(setDisabled(bool)));

    form_layout->addRow(tr("Num of rooms"), spinbox);
    form_layout->addRow(tr("Num of stages"), stagebox);
    form_layout->addRow(loop_checkbox, start_button);

    QVBoxLayout *layout = new QVBoxLayout;
    layout->addWidget(avatar_button);
    layout->addLayout(form_layout);

    box->setLayout(layout);

    return box;
}

class RoomItem: public Pixmap{
public:
    RoomItem(Room *room){
        changePixmap("image/system/frog/playing.png");

        const qreal radius = 50;
        const qreal pi = 3.1415926;

        QList<const ServerPlayer *> players = room->findChildren<const ServerPlayer *>();
        int n = players.length();
        qreal angle = 2 * pi / n;

        foreach(const ServerPlayer *player, players){
            qreal theta = (player->getSeat() -1) * angle;
            qreal x = radius * cos(theta) + 5;
            qreal y = radius * sin(theta) + 5;

            qreal role_x = (radius + 30) * cos(theta) + 5;
            qreal role_y = (radius + 30) * sin(theta) + 5;

            QGraphicsPixmapItem *avatar = new QGraphicsPixmapItem(this);
            avatar->setPixmap(QPixmap(player->getGeneral()->getPixmapPath("tiny")));
            avatar->setPos(x, y);

            QGraphicsPixmapItem *role = new QGraphicsPixmapItem(this);
            role->setPixmap(QString("image/system/roles/small-%1.png").arg(player->getRole()));
            role->setPos(role_x, role_y);
        }

        setFlag(ItemIsMovable);
    }

    virtual void mouseDoubleClickEvent(QGraphicsSceneMouseEvent *){
        foreach(QGraphicsItem *item, childItems())
            item->setVisible(! item->isVisible());
    }
};

typedef RoomItem *RoomItemStar;
Q_DECLARE_METATYPE(RoomItemStar);

void MeleeDialog::startTest(){
    foreach(RoomItemStar room_item, room_items)
        if(room_item) delete room_item;

    room_items.clear();

    if(server)
        server->gamesOver();
    else{
        server = new Server(this->parentWidget());
        server->listen();
        connect(server, SIGNAL(server_message(QString)), server_log,SLOT(append(QString)));
    }
    Config.AIDelay = 0;
    room_count = spinbox->value();
    for(int i=0;i<room_count;i++){
        Room *room = server->createNewRoom();
        connect(room, SIGNAL(game_start()), this, SLOT(onGameStart()));
        connect(room, SIGNAL(game_over(QString)), this, SLOT(onGameOver(QString)));

        room->startTest(avatar_button->property("to_test").toString());
    }
}

void MeleeDialog::onGameStart(){
    if(room_count>10) return;
    Room *room = qobject_cast<Room *>(sender());

    RoomItemStar room_item = new RoomItem(room);
    room->setTag("RoomItem", QVariant::fromValue(room_item));

    room_items << room_item;
    record_scene->addItem(room_item);
}

void MeleeDialog::onGameOver(const QString &winner){
    Room *room = qobject_cast<Room *>(sender());
    RoomItemStar room_item = room->getTag("RoomItem").value<RoomItemStar>();
    QString to_test = room->property("to_test").toString();

    QList<const ServerPlayer *> players = room->findChildren<const ServerPlayer *>();

    QStringList winners, losers;
    foreach(const ServerPlayer *p, players){
        bool won = winner.contains(p->getRole()) || winner.contains(p->objectName());
        if(won)
            winners << Sanguosha->translate(p->getGeneralName());
        else
            losers << Sanguosha->translate(p->getGeneralName());

        if(p->getGeneralName() == to_test){
            if(won){
                if(room_item) room_item->changePixmap("image/system/frog/good.png");
                updateResultBox(p->getRole(),1);
            }
            else{
                if(room_item) room_item->changePixmap("image/system/frog/bad.png");
                updateResultBox(p->getRole(),0);
            }
        }
    }

    QString tooltip = tr("Winner(s): %1 <br/> Losers: %2 <br /> Shuffle times: %3")
                      .arg(winners.join(","))
                      .arg(losers.join(","))
                      .arg(room->getTag("SwapPile").toInt());

    if(room_item) room_item->setToolTip(tooltip);
    stage_count ++;
    if(loop_checkbox->isChecked() || stage_count < stagebox->value()){
        if(room_item){
            room_items.removeOne(room_item);
            delete room_item;
        }
        Room *room = server->createNewRoom();
        connect(room, SIGNAL(game_start()), this, SLOT(onGameStart()));
        connect(room, SIGNAL(game_over(QString)), this, SLOT(onGameOver(QString)));

        room->startTest(avatar_button->property("to_test").toString());
    }
    //stagebox->setValue(stage_count);
}

QGroupBox *MeleeDialog::createResultBox(){
    QGroupBox *box = new QGroupBox(tr("Winning result"));

    QFormLayout *layout = new QFormLayout;

    QLineEdit *lord_edit = new QLineEdit;
    QLineEdit *loyalist_edit = new QLineEdit;
    QLineEdit *rebel_edit = new QLineEdit;
    QLineEdit *renegade_edit = new QLineEdit;
    QLineEdit *total_edit = new QLineEdit;

    lord_edit->setReadOnly(true);
    loyalist_edit->setReadOnly(true);
    rebel_edit->setReadOnly(true);
    renegade_edit->setReadOnly(true);
    total_edit->setReadOnly(true);

    lord_edit->setObjectName("lord_edit");;
    loyalist_edit->setObjectName("loyalist_edit");
    rebel_edit->setObjectName("rebel_edit");
    renegade_edit->setObjectName("renegade_edit");
    total_edit->setObjectName("total_edit");

    layout->addRow(tr("Lord"), lord_edit);
    layout->addRow(tr("Loyalist"), loyalist_edit);
    layout->addRow(tr("Rebel"), rebel_edit);
    layout->addRow(tr("Renegade"), renegade_edit);
    layout->addRow(tr("Total"), total_edit);

    box->setLayout(layout);

    return box;
}

#include "choosegeneraldialog.h"

void MeleeDialog::selectGeneral(){
    FreeChooseDialog *dialog = new FreeChooseDialog(this);
    connect(dialog, SIGNAL(general_chosen(QString)), this, SLOT(setGeneral(QString)));

    dialog->exec();
}

void MeleeDialog::setGeneral(const QString &general_name){
    const General *general = Sanguosha->getGeneral(general_name);

    if(general){
        avatar_button->setIcon(QIcon(general->getPixmapPath("card")));
        avatar_button->setToolTip(general->getSkillDescription());
        Config.setValue("MeleeGeneral", general_name);
        avatar_button->setProperty("to_test", general_name);
    }
}

AcknowledgementScene::AcknowledgementScene(QObject *parent) :
    QGraphicsScene(parent)
{
    view = new QDeclarativeView;
    view->setSource(QUrl::fromLocalFile("acknowledgement/main.qml"));
    addWidget(view);
    view->move( - width()/2, - height()/2);
    view->setStyleSheet(QString("background: transparent"));

    QObject *item = view->rootObject();

    connect(item,SIGNAL(go_back()),this,SIGNAL(go_back()));
}

void MainWindow::on_actionAI_Melee_triggered()
{
    MeleeDialog *dialog = new MeleeDialog(this);
    dialog->exec();
}

#include "recorder.h"

void MainWindow::on_actionReplay_file_convert_triggered()
{
    QString filename = QFileDialog::getOpenFileName(
            this, tr("Please select a replay file"),
            Config.value("LastReplayDir").toString(),
            tr("Pure text replay file (*.txt);; Image replay file (*.png)"));

    if(filename.isEmpty())
        return;

    QFile file(filename);
    if(file.open(QIODevice::ReadOnly)){
        QFileInfo info(filename);
        QString tosave = info.absoluteDir().absoluteFilePath(info.baseName());

        if(filename.endsWith(".txt")){
            tosave.append(".png");

            // txt to png
            Recorder::TXT2PNG(file.readAll()).save(tosave);

        }else if(filename.endsWith(".png")){
            tosave.append(".txt");

            // png to txt
            QByteArray data = Replayer::PNG2TXT(filename);

            QFile tosave_file(tosave);
            if(tosave_file.open(QIODevice::WriteOnly))
                tosave_file.write(data);
        }
    }
}

void MainWindow::on_actionRecord_analysis_triggered(){
    QString location = Config.value("AutoSavePath", "save").toString();
    //QString location = QDesktopServices::storageLocation(QDesktopServices::HomeLocation);
    QString filename = QFileDialog::getOpenFileName(this,
                                                    tr("Load replay record"),
                                                    location,
                                                    tr("Pure text replay file (*.txt);; Image replay file (*.png)"));

    if(filename.isEmpty())
        return;

    QDialog *rec_dialog = new QDialog(this);
    rec_dialog->setWindowTitle(tr("Record analysis"));
    rec_dialog->resize(800, 500);
    QTableWidget *table = new QTableWidget;

    RecAnalysis *record = new RecAnalysis(filename);
    QMap<QString, PlayerRecordStruct *> record_map = record->getRecordMap();
    table->setColumnCount(11);
    table->setRowCount(record_map.keys().length());
    table->setEditTriggers(QAbstractItemView::NoEditTriggers);

    static QStringList labels;
    if(labels.isEmpty()){
        labels << tr("ScreenName") << tr("General") << tr("Role") << tr("Living") << tr("WinOrLose")
               << tr("Recover") << tr("Damage") << tr("Damaged") << tr("Save") << tr("Kill") << tr("Cheat")
               //<< tr("Designation")
                  ;
    }
    table->setHorizontalHeaderLabels(labels);
    table->setSelectionBehavior(QTableWidget::SelectRows);

    int i = 0;
    foreach(PlayerRecordStruct *rec, record_map.values()){
        QTableWidgetItem *item = new QTableWidgetItem;
        QString screen_name = Sanguosha->translate(rec->m_screenName);
        if(rec->m_statue == "robot")
            screen_name += "(" + Sanguosha->translate("robot") + ")";

        item->setText(screen_name);
        table->setItem(i, 0, item);

        item = new QTableWidgetItem;
        QString generals = Sanguosha->translate(rec->m_generalName);
        if(!rec->m_general2Name.isEmpty())
            generals += "+" + Sanguosha->translate(rec->m_general2Name) + tr("(General2)");
        item->setText(generals);
        table->setItem(i, 1, item);

        item = new QTableWidgetItem;
        item->setText(Sanguosha->translate(rec->m_role));
        table->setItem(i, 2, item);

        item = new QTableWidgetItem;
        item->setText(rec->m_isAlive ? tr("Alive") : tr("Dead"));
        table->setItem(i, 3, item);

        item = new QTableWidgetItem;
        bool is_win = record->getRecordWinners().contains(rec->m_role) ||
                        record->getRecordWinners().contains(record_map.key(rec));
        item->setText(is_win ? tr("Win") : tr("Lose"));
        table->setItem(i, 4, item);

        item = new QTableWidgetItem;
        item->setText(QString::number(rec->m_recover));
        table->setItem(i, 5, item);

        item = new QTableWidgetItem;
        item->setText(QString::number(rec->m_damage));
        table->setItem(i, 6, item);

        item = new QTableWidgetItem;
        item->setText(QString::number(rec->m_damaged));
        table->setItem(i, 7, item);

        item = new QTableWidgetItem;
        item->setText(QString::number(rec->m_save));
        table->setItem(i, 8, item);

        item = new QTableWidgetItem;
        item->setText(QString::number(rec->m_kill));
        table->setItem(i, 9, item);

        item = new QTableWidgetItem;
        item->setText(QString::number(rec->m_cheat));
        table->setItem(i, 10, item);
/*
        item = new QTableWidgetItem;
        item->setText(rec->m_designation.join(", "));
        table->setItem(i, 11, item);
*/
        i++;
    }
    for (int i = 2; i <= 11; i++)
        table->resizeColumnToContents(i);

    table->resizeColumnsToContents();

    QLabel *mode = new QLabel;
    mode->setText(tr("Mode:") + record->getRecordGameMode());

    QLabel *label = new QLabel;
    label->setText(tr("Packages:") + record->getRecordPackages().join(","));

    QLabel *label_options = new QLabel;
    label_options->setText(tr("GameMode:") + record->getRecordGameModes().join(","));

    QTextEdit *chat_info = new QTextEdit;
    chat_info->setReadOnly(chat_info);
    chat_info->setProperty("type", "border");
    chat_info->setText(record->getRecordChat());
    chat_info->setVerticalScrollBarPolicy(Qt::ScrollBarAsNeeded);

    QLabel *table_chat_title = new QLabel;
    table_chat_title->setText(tr("Chat Infomation:"));

    QVBoxLayout *layout = new QVBoxLayout;
    layout->addWidget(mode);
    layout->addWidget(label);
    layout->addWidget(label_options);
    layout->addWidget(table);
    layout->addSpacing(15);
    layout->addWidget(table_chat_title);
    layout->addWidget(chat_info);
    rec_dialog->setLayout(layout);

    rec_dialog->exec();
}

void MainWindow::sendLowLevelCommand()
{
    QString command = QInputDialog::getText(this, tr("Send low level command"), tr("Please input the raw low level command"));
    if(!command.isEmpty())
        ClientInstance->request(command);
}

void MeleeDialog::updateResultBox(QString role, int win){    
    QLineEdit *edit = result_box->findChild<QLineEdit *>(role + "_edit");
    double roleCount = ++(this->roleCount[role]);
    double winCount = (this->winCount[role] += win);
    double rate = winCount / roleCount * 100;
    edit->setText(QString("%1 / %2 = %3 %").arg(winCount).arg(roleCount).arg(rate));

    stage_count = 0;
    double totalWinCount = 0;

    foreach(int count, this->roleCount.values())
        stage_count += count;

    foreach(int count, this->winCount.values())
        totalWinCount += count;

    QLineEdit *total_edit = result_box->findChild<QLineEdit *>("total_edit");
    total_edit->setText(QString("%1 / %2 = %3 %").arg(totalWinCount).arg(stage_count).arg(totalWinCount/stage_count*100));

    server_log->append(tr("End of game %1").arg(stage_count));
}

void MainWindow::on_actionView_ban_list_triggered()
{
    BanlistDialog *dialog = new BanlistDialog(this, true);
    dialog->exec();
}

#include "audio.h"

void MainWindow::on_actionAbout_fmod_triggered()
{
    QString content = tr("FMOD is a proprietary audio library made by Firelight Technologies");
    content.append("<p align='center'> <img src='image/logo/fmod.png' /> </p> <br/>");

    QString address = "http://www.fmod.org";
    content.append(tr("Official site: <a href='%1' style = \"color:#0072c1; \">%1</a> <br/>").arg(address));

#ifdef AUDIO_SUPPORT
    content.append(tr("Current versionn %1 <br/>").arg(Audio::getVersion()));
#endif

    Window *window = new Window(tr("About fmod"), QSize(500, 259));
    scene->addItem(window);

    window->addContent(content);
    window->addCloseButton(tr("OK"));
    window->shift();

    window->appear();
}

#include "lua.hpp"

void MainWindow::on_actionAbout_Lua_triggered()
{
    QString content = tr("Lua is a powerful, fast, lightweight, embeddable scripting language.");
    content.append("<p align='center'> <img src='image/logo/lua.png' /> </p> <br/>");

    QString address = "http://www.lua.org";
    content.append(tr("Official site: <a href='%1' style = \"color:#0072c1; \">%1</a> <br/>").arg(address));

    content.append(tr("Current versionn %1 <br/>").arg(LUA_RELEASE));
    content.append(LUA_COPYRIGHT);

    Window *window = new Window(tr("About Lua"), QSize(500, 500));
    scene->addItem(window);

    window->addContent(content);
    window->addCloseButton(tr("OK"));
    window->shift();

    window->appear();
}

void MainWindow::on_actionCrypto_audio_triggered(){
    QStringList filenames = QFileDialog::getOpenFileNames(
            this, tr("Please select audio files"),
            QString(),
            tr("OGG Audio files (*.ogg)"));

    if(filenames.isEmpty())
        return;
    Crypto cry;
    int count = 0;
    foreach(QString filename, filenames){
        if(!cry.encryptMusicFile(filename))
            QMessageBox::warning(this, tr("Notice"), tr("Encrypt music file %1 failed!").arg(filename));
        else
            count++;
    }
    QMessageBox::information(this, tr("Notice"), tr("Encrypt %1 music files done!").arg(QString::number(count)));
    if(QMessageBox::question(this, tr("Warning"), tr("Delete all old files?"),
                             QMessageBox::StandardButtons(QMessageBox::Yes | QMessageBox::No), QMessageBox::No)
        == QMessageBox::Yes){
        foreach(QString filename, filenames)
            QFile::remove(filename);
    }
}

void MainWindow::on_actionDecrypto_audio_triggered(){
    QStringList filenames = QFileDialog::getOpenFileNames(
            this, tr("Please select crypto files"),
            QString(),
            tr("Crypto files (*.dat)"));

    if(filenames.isEmpty())
        return;

    QString key = QInputDialog::getText(this, tr("The key for decrypt"), tr("Please input the key"));
    if(!key.isEmpty()){
        Crypto cry;
        int count = 0;
        foreach(QString filename, filenames){
            if(!cry.decryptMusicFile(filename, key))
                QMessageBox::warning(this, tr("Notice"), tr("Decrypt music file %1 failed!").arg(filename));
            else
                count++;
        }
        QMessageBox::information(this, tr("Notice"), tr("Decrypt %1 music files done!").arg(QString::number(count)));
    }
}
