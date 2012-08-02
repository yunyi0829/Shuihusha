#include "gift.h"
#include "skill.h"
#include "clientstruct.h"

Zongzi::Zongzi(Suit suit, int number):BasicCard(suit, number){
    setObjectName("zongzi");
    target_fixed = true;
}

QString Zongzi::getSubtype() const{
    return "gift_card";
}

QString Zongzi::getEffectPath(bool is_male) const{
    return "audio/card/common/zongzi.ogg";
}

bool Zongzi::isAvailable(const Player *quyuan) const{
    if(ServerInfo.GameMode != "dusong")
        return quyuan->getMark("HaveEaten") == 0;
    else
        return true;
}

void Zongzi::use(Room *room, ServerPlayer *source, const QList<ServerPlayer *> &targets) const{
    room->throwCard(this);
    int n = ServerInfo.GameMode != "dusong" ? 1 : -1;
    room->setPlayerProperty(source, "maxhp", source->getMaxHp() + n);
    room->setPlayerProperty(source, "hp", source->getHp() + n);
    room->acquireSkill(source, "lisao");
    room->setPlayerMark(source, "HaveEaten", 1);

    room->setEmotion(source, "zongzi");
}

class Lisao: public TriggerSkill{
public:
    Lisao():TriggerSkill("lisao"){
        events << Damaged;
        frequency = Compulsory;
    }

    virtual bool trigger(TriggerEvent , Room* room, ServerPlayer *player, QVariant &data) const{
        if(!player)
            return false;

        DamageStruct damage = data.value<DamageStruct>();
        if(damage.card && damage.card->inherits("Slash") && damage.card->isRed()){
            LogMessage log;
            log.type = "#TriggerSkill";
            log.from = player;
            log.arg = objectName();
            room->sendLog(log);

            room->playSkillEffect(objectName(), player->getGeneral()->isMale() ? qrand() % 2 + 1 : qrand() % 2 + 3);
            room->loseMaxHp(player);
        }
        return false;
    }
};

GiftPackage::GiftPackage()
    :Package("gift")
{
    skills << new Lisao;
    QList<Card *> cards;

    cards
            << new Zongzi(Card::Heart, 5)
            << new Zongzi(Card::Club, 5)
            << new Zongzi(Card::Diamond, 5)
            << new Zongzi(Card::Spade, 5)
            ;

    foreach(Card *card, cards)
        card->setParent(this);

    type = CardPack;
}

ADD_PACKAGE(Gift);
