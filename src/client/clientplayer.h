#ifndef CLIENTPLAYER_H
#define CLIENTPLAYER_H

#include "player.h"
#include "clientstruct.h"

class Client;
class QTextDocument;

class ClientPlayer : public Player
{
    Q_OBJECT
    Q_PROPERTY(int handcard READ getHandcardNum WRITE setHandcardNum)

public:
    explicit ClientPlayer(Client *client);
    void handCardChange(int delta);
    QList<const Card *> getCards() const;
    void setCards(const QList<int> &card_ids);
    QTextDocument *getMarkDoc(bool dashboard = true) const;
    void changePile(const QString &name, bool add, int card_id);
    QString getDeathPixmapPath(bool isdash = true) const;
    void setHandcardNum(int n);
    virtual QString getGameMode() const;

    virtual void setFlags(const QString &flag);
    virtual int aliveCount() const;
    virtual int getHandcardNum() const;
    virtual void removeCard(const Card *card, Place place);
    virtual void addCard(const Card *card, Place place);
    virtual void addKnownHandCard(const Card *card);
    virtual bool isLastHandCard(const Card *card) const;
    virtual void setMark(const QString &mark, int value);

private:
    int handcard_num;
    QList<const Card *> known_cards;
    QTextDocument *mark_doc, *mark_doc_small;

signals:
    void pile_changed(const QString &name);
    void waked();
    void drank_changed();
    void ecst_changed();
    void poison_changed();
    void action_taken();
};

extern ClientPlayer *Self;

#endif // CLIENTPLAYER_H
