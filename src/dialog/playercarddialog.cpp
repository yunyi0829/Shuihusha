#include "playercarddialog.h"
#include "standard.h"
#include "engine.h"

#include <QCommandLinkButton>
#include <QVBoxLayout>
#include <QGroupBox>
#include <QLabel>
#include <QHBoxLayout>

MagatamaWidget::MagatamaWidget(int hp, Qt::Orientation orientation)
{
    QBoxLayout *layout = NULL;
    if(orientation == Qt::Vertical)
        layout = new QVBoxLayout;
    else
        layout = new QHBoxLayout;

    QPixmap pixmap = *GetMagatama(qMin(5, hp));
    if(!pixmap.isNull()){
        int i;
        for(i=0; i<hp; i++){
            QLabel *label = new QLabel;
            label->setPixmap(pixmap);

            layout->addWidget(label);
        }
    }

    setLayout(layout);
}

QPixmap *MagatamaWidget::GetMagatama(int index){
    if(index < 0)
        return new QPixmap();

    static QPixmap magatamas[6];
    if(magatamas[0].isNull()){
        int i;
        for(i=0; i<=5; i++)
            magatamas[i].load(QString("image/system/magatamas/%1.png").arg(i));
    }

    return &magatamas[index];
}

QPixmap *MagatamaWidget::GetSmallMagatama(int index){
    static QPixmap magatamas[6];
    if(magatamas[0].isNull()){
        int i;
        for(i=0; i<=5; i++)
            magatamas[i].load(QString("image/system/magatamas/small-%1.png").arg(i));
    }

    return &magatamas[index];
}

PlayerCardDialog::PlayerCardDialog(const ClientPlayer *player, const QString &flags)
    :player(player)
{
    QVBoxLayout *vlayout = new QVBoxLayout;
    QHBoxLayout *layout = new QHBoxLayout;

    static QChar handcard_flag('h');
    static QChar equip_flag('e');
    static QChar judging_flag('j');
    static QChar piles_flag('p');

    layout->addWidget(createAvatar());

    if(flags.contains(handcard_flag))
        vlayout->addWidget(createHandcardButton());

    if(flags.contains(equip_flag))
        vlayout->addWidget(createEquipArea());

    if(flags.contains(judging_flag))
        vlayout->addWidget(createJudgingArea());

    if(flags.contains(piles_flag)){
        bool show = false;
        foreach(QString pile_name, player->getPileNames()){
            if(!player->getPile(pile_name).isEmpty()){
                show = true;
                break;
            }
        }
        if(show)
            vlayout->addWidget(createPilesArea());
    }

    layout->addLayout(vlayout);

    setLayout(layout);
}

QWidget *PlayerCardDialog::createAvatar(){
    const General *general = player->getAvatarGeneral();
    QGroupBox *box = new QGroupBox(player->screenName());

    QLabel *avatar = new QLabel(box);
    avatar->setPixmap(QPixmap(general->getPixmapPath("big")));

    QVBoxLayout *layout = new QVBoxLayout;
    layout->addWidget(avatar);
    layout->addWidget(new MagatamaWidget(player->getHp(), Qt::Horizontal));

    box->setLayout(layout);

    return box;
}

QWidget *PlayerCardDialog::createHandcardButton(){
    QCommandLinkButton *button = new QCommandLinkButton(tr("Handcard"));
    button->setObjectName("handcard_button");
    int num = player->getHandcardNum();
    if(num == 0){
        button->setDescription(tr("This guy has no any hand cards"));
        button->setEnabled(false);
    }else{
        if(Self == player || (Self->hasSkill("dongcha") && player->hasFlag("dongchaee"))){
            QGroupBox *area = new QGroupBox(tr("Handcard area"));
            QVBoxLayout *layout =  new QVBoxLayout;
            QList<const Card *> cards = player->getCards();
            foreach(const Card *card, cards){
                QCommandLinkButton *button = new QCommandLinkButton(card->getFullName());
                button->setIcon(card->getSuitIcon());

                mapper.insert(button, card->getId());
                connect(button, SIGNAL(clicked()), this, SLOT(emitId()));
                layout->addWidget(button);
            }

            area->setLayout(layout);
            return area;
        }
        else{
            button->setDescription(tr("This guy has %1 hand card(s)").arg(num));

            mapper.insert(button, -1);
            connect(button, SIGNAL(clicked()), this, SLOT(emitId()));
        }

        if(Self->hasFlag("loot") && !player->getCards().isEmpty()){
            QGroupBox *area = new QGroupBox(tr("Handcard area"));
            QVBoxLayout *layout =  new QVBoxLayout;
            layout->addWidget(button);
            QList<const Card *> cards = player->getCards();
            foreach(const Card *card, cards){
                QCommandLinkButton *butt0n = new QCommandLinkButton(card->getFullName());
                butt0n->setIcon(card->getSuitIcon());

                mapper.insert(butt0n, card->getId());
                connect(butt0n, SIGNAL(clicked()), this, SLOT(emitId()));
                layout->addWidget(butt0n);
            }
            area->setLayout(layout);
            return area;
        }
    }

    return button;
}

QWidget *PlayerCardDialog::createEquipArea(){
    QGroupBox *area = new QGroupBox(tr("Equip area"));
    QVBoxLayout *layout = new QVBoxLayout;

    const Weapon *weapon = player->getWeapon();
    if(weapon){
        QCommandLinkButton *button = new QCommandLinkButton(weapon->getFullName());
        button->setIcon(weapon->getSuitIcon());

        mapper.insert(button, weapon->getId());
        connect(button, SIGNAL(clicked()), this, SLOT(emitId()));
        layout->addWidget(button);
    }

    const Armor *armor = player->getArmor();
    if(armor){
        QCommandLinkButton *button = new QCommandLinkButton(armor->getFullName());
        button->setIcon(armor->getSuitIcon());

        mapper.insert(button, armor->getId());
        connect(button, SIGNAL(clicked()), this, SLOT(emitId()));
        layout->addWidget(button);
    }

    const Horse *horse = player->getDefensiveHorse();
    if(horse){
        QCommandLinkButton *button = new QCommandLinkButton(horse->getFullName() + tr("(+1 horse)"));
        button->setIcon(horse->getSuitIcon());

        mapper.insert(button, horse->getId());
        connect(button, SIGNAL(clicked()), this, SLOT(emitId()));
        layout->addWidget(button);
    }

    horse = player->getOffensiveHorse();
    if(horse){
        QCommandLinkButton *button = new QCommandLinkButton(horse->getFullName() + tr("(-1 horse)"));
        button->setIcon(horse->getSuitIcon());

        mapper.insert(button, horse->getId());
        connect(button, SIGNAL(clicked()), this, SLOT(emitId()));
        layout->addWidget(button);
    }

    if(layout->count() == 0){
        QCommandLinkButton *no_equip = new QCommandLinkButton(tr("No equip"));
        no_equip->setEnabled(false);
        no_equip->setObjectName("noequip_button");
        return no_equip;
    }else{
        area->setLayout(layout);
        return area;
    }
}

QWidget *PlayerCardDialog::createJudgingArea(){
    QGroupBox *area = new QGroupBox(tr("Judging Area"));
    QVBoxLayout *layout = new QVBoxLayout;
    QList<const Card *> cards = player->getJudgingArea();
    foreach(const Card *card, cards){
        QCommandLinkButton *button = new QCommandLinkButton(card->getFullName());
        button->setIcon(card->getSuitIcon());
        layout->addWidget(button);

        mapper.insert(button, card->getId());
        connect(button, SIGNAL(clicked()), this, SLOT(emitId()));
    }

    if(layout->count() == 0){
        QCommandLinkButton *button = new QCommandLinkButton(tr("No judging cards"));
        button->setEnabled(false);
        button->setObjectName("nojuding_button");
        return button;
    }else{
        area->setLayout(layout);
        return area;
    }
}

void PlayerCardDialog::emitId(){
    int id = mapper.value(sender(), -2);
    if(id != -2)
        emit card_id_chosen(id);
}

QWidget *PlayerCardDialog::createPilesArea(){
    QGroupBox *area = new QGroupBox(tr("Piles Area"));
    QVBoxLayout *layout = new QVBoxLayout;
    foreach(QString pile_name, player->getPileNames()){
        if(!player->getPile(pile_name).isEmpty()){
            QGroupBox *pilesarea = new QGroupBox(Sanguosha->translate(pile_name));
            QVBoxLayout *layout2 = new QVBoxLayout;
            foreach(int card_id, player->getPile(pile_name)){
                const Card *card = Sanguosha->getCard(card_id);
                QCommandLinkButton *button = new QCommandLinkButton(card->getFullName());
                button->setIcon(card->getSuitIcon());
                layout2->addWidget(button);

                mapper.insert(button, card->getId());
                connect(button, SIGNAL(clicked()), this, SLOT(emitId()));
                pilesarea->setLayout(layout2);
            }
            layout->addWidget(pilesarea);
            area->setLayout(layout);
        }
    }

    return area;
}
