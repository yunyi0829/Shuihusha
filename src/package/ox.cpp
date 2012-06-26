#include "ox.h"
#include "general.h"
#include "skill.h"
#include "standard.h"
#include "client.h"
#include "carditem.h"
#include "engine.h"

LianmaCard::LianmaCard(){
    target_fixed = true;
    once = true;
}

void LianmaCard::use(Room *room, ServerPlayer *huyanzhuo, const QList<ServerPlayer *> &) const{
    QList<ServerPlayer *> players = room->getAlivePlayers();

    //room->broadcastSkillInvoke(objectName());
    QString choice = room->askForChoice(huyanzhuo, "lianma", "lian+ma");
    if(choice == "lian"){
        foreach(ServerPlayer *player, players){
            if(player->hasEquip("Horse", true)){
                if(!player->isChained()){
                    player->setChained(true);
                    room->broadcastProperty(player, "chained");
                    room->setEmotion(player, "chain");
                }
            }
        }
    }else{
        foreach(ServerPlayer *player, players){
            if(!player->hasEquip("Horse", true)){
                if(player->isChained())
                    room->setPlayerProperty(player, "chained", false);
            }
        }
    }
};

class Lianma: public ZeroCardViewAsSkill{
public:
    Lianma():ZeroCardViewAsSkill("lianma"){
        default_choice = "lian";
    }

    virtual const Card *viewAs() const{
        return new LianmaCard;
    }

    virtual bool isEnabledAtPlay(const Player *player) const{
        return !player->hasUsed("LianmaCard");
    }
};

class Zhongjia: public ClientSkill{
public:
    Zhongjia():ClientSkill("zhongjia"){
    }

    virtual int getExtra(const Player *target) const{
        if(!target->hasSkill(objectName()))
            return 0;
        else{
            int extra = target->isChained() ? 1 : 0;
            foreach(const Player *player, target->getSiblings()){
                if(player->isAlive() && player->isChained())
                    extra ++;
            }
            return extra;
        }
    }
};

SheruCard::SheruCard(){
    once = true;
}

bool SheruCard::targetFilter(const QList<const Player *> &targets, const Player *to_select, const Player *Self) const{
    if(!targets.isEmpty())
        return false;

    return to_select->isWounded() && to_select != Self;
}

void SheruCard::onEffect(const CardEffectStruct &effect) const{
    Room *room = effect.from->getRoom();
    //room->throwCard(this);
    QString choice = room->askForChoice(effect.from, "sheru", "she+ru");
    int x = effect.to->getLostHp();
    if(choice == "she"){
        effect.to->drawCards(x);
        room->loseHp(effect.to);
    }else{
        if(effect.to->getCardCount(true) <= x){
            effect.to->throwAllHandCards();
            effect.to->throwAllEquips();
        }else{
            int card_id = -1;
            for(int i=1; i<=x; i++){
                card_id = room->askForCardChosen(effect.from, effect.to, "he", "sheru");
                room->throwCard(card_id);
                if(effect.to->isNude())
                    break;
            }
        }
        RecoverStruct recover;
        recover.who = effect.from;
        room->recover(effect.to, recover, true);
    }
    //room->broadcastSkillInvoke("sheru");
}

class Sheru: public OneCardViewAsSkill{
public:
    Sheru():OneCardViewAsSkill("sheru"){

    }

    virtual bool isEnabledAtPlay(const Player *player) const{
        return ! player->hasUsed("SheruCard");
    }

    virtual bool viewFilter(const CardItem *to_select) const{
        const Card *card = to_select->getFilteredCard();
        return card->isBlack() && card->inherits("BasicCard");
    }

    virtual const Card *viewAs(CardItem *card_item) const{
        SheruCard *sheru_card = new SheruCard;
        sheru_card->addSubcard(card_item->getFilteredCard());

        return sheru_card;
    }
};

XunlieCard::XunlieCard(){
}

bool XunlieCard::targetFilter(const QList<const Player *> &targets, const Player *to_select, const Player *Self) const{
    int i = 0;
    foreach(const Player *player, Self->getSiblings()){
        if(player->getHandcardNum() >= i){
            i = player->getHandcardNum();
        }
    }
    return targets.isEmpty() && !to_select->isKongcheng() && to_select->getHandcardNum() == i && to_select != Self;
}

void XunlieCard::onEffect(const CardEffectStruct &effect) const{
    Room *room = effect.from->getRoom();
    int i = 0;
    const Card *card = effect.to->getRandomHandCard();
    effect.from->obtainCard(card, false);
    i ++;
    if(!effect.to->isKongcheng() && room->askForChoice(effect.from, "xuelie", "get+cancel") == "get"){
        card = effect.to->getRandomHandCard();
        effect.from->obtainCard(card, false);
        i ++;
    }
    if(i == 1)
        effect.from->drawCards(1);
    room->setEmotion(effect.to, "bad");
    room->setEmotion(effect.from, "good");
}

class XunlieViewAsSkill: public OneCardViewAsSkill{
public:
    XunlieViewAsSkill():OneCardViewAsSkill("xunlie"){
    }

    virtual const Card *viewAs(CardItem *card_item) const{
        XunlieCard *card = new XunlieCard;
        card->addSubcard(card_item->getCard()->getId());
        return card;
    }

    virtual bool viewFilter(const CardItem *to_selec) const{
        return to_selec->getCard()->inherits("EquipCard");
    }

    virtual bool isEnabledAtResponse(const Player *player, const QString &pattern) const{
        return pattern == "@@xunlie";
    }

    virtual bool isEnabledAtPlay(const Player *player) const{
        return false;
    }
};

class Xunlie:public PhaseChangeSkill{
public:
    Xunlie():PhaseChangeSkill("xunlie"){
        view_as_skill = new XunlieViewAsSkill;
    }

    virtual bool onPhaseChange(ServerPlayer *xiezhen) const{
        if(xiezhen->getPhase() == Player::Draw){
            Room *room = xiezhen->getRoom();
            bool can_invoke = false;
            QList<ServerPlayer *> other_players = room->getOtherPlayers(xiezhen);
            foreach(ServerPlayer *player, other_players){
                if(!player->isKongcheng()){
                    can_invoke = true;
                    break;
                }
            }
            if(!can_invoke)
                return false;
            QList<const Card *> cards = xiezhen->getCards("he");
            foreach(const Card *cd, cards){
                if(cd->inherits("EquipCard")){
                    if(room->askForUseCard(xiezhen, "@@xunlie", "@xunlie"))
                        return true;
                    break;
                }
            }
        }
        return false;
    }
};

LianzhuCard::LianzhuCard(){
    once = true;
    target_fixed = true;
}

void LianzhuCard::onUse(Room *room, const CardUseStruct &card_use) const{
    card_use.from->turnOver();
    ArcheryAttack *ar = new ArcheryAttack(Card::NoSuit, 0);
    ar->setSkillName("lianzhu");
    CardUseStruct use;
    use.card = ar;
    use.from = card_use.from;
    use.to = card_use.to;
    room->useCard(use);
}

class Lianzhu: public ZeroCardViewAsSkill{
public:
    Lianzhu():ZeroCardViewAsSkill("lianzhu"){
    }

    virtual bool isEnabledAtPlay(const Player *player) const{
        return !player->hasUsed("LianzhuCard");
    }

    virtual const Card *viewAs() const{
        return new LianzhuCard;
    }
};

/*
class Tiansuan: public TriggerSkill{
public:
    Tiansuan():TriggerSkill("tiansuan"){
        events << Pindian;
    }

    virtual bool triggerable(const ServerPlayer *target) const{
        return true;
    }

    virtual bool trigger(TriggerEvent, Room* room, ServerPlayer *, QVariant &data) const{
        ServerPlayer *pianzi = room->findPlayerBySkillName(objectName());
        if(!pianzi || !pianzi->askForSkillInvoke(objectName()))
            return false;
        PindianStar pindian = data.value<PindianStar>();
        QStringList choices;
        QString from_card = Sanguosha->translate(QString("@tiansuan:%1:%2:%3:%4").
                            arg(pindian->from->getGeneralName()).
                            arg(pindian->from_card->getSuitString()).
                            arg(pindian->from_card->getNumberString()).
                            arg(pindian->from_card->objectName()));
        QString to_card = Sanguosha->translate(QString("@tiansuan:%1:%2:%3:%4").
                          arg(pindian->to->getGeneralName()).
                          arg(pindian->to_card->getSuitString()).
                          arg(pindian->to_card->getNumberString()).
                          arg(pindian->to_card->objectName()));
        choices << from_card
                << to_card;
        QString choice = room->askForChoice(pianzi, objectName(), choices.join("+"));
        if(choice == from_card){
            int omiga = room->drawCard();
            //room->moveCardTo(Sanguosha->getCard(omiga), pindian->from, Player::Hand, false);
            room->moveCardTo(pindian->from_card, NULL, Player::DrawPile, true);
            pindian->from_card = Sanguosha->getCard(omiga);
        }
        else{
            int omiga = room->drawCard();
            //room->moveCardTo(Sanguosha->getCard(omiga), pindian->to, Player::Hand, false);
            room->moveCardTo(pindian->to_card, NULL, Player::DrawPile, true);
            pindian->to_card = Sanguosha->getCard(omiga);
        }
        data = QVariant::fromValue(pindian);
        return false;
    }
};

HuazhuCard::HuazhuCard(){
    once = true;
    will_throw = false;
}

bool HuazhuCard::targetFilter(const QList<const Player *> &targets, const Player *to_select, const Player *Self) const{
    return targets.isEmpty() && !to_select->isKongcheng() && to_select != Self;
}

void HuazhuCard::use(Room *, ServerPlayer *iszjj, const QList<ServerPlayer *> &targets) const{
    iszjj->pindian(targets.first(), "huazhu", this);
}

class HuazhuViewAsSkill: public OneCardViewAsSkill{
public:
    HuazhuViewAsSkill():OneCardViewAsSkill("huazhu"){

    }

    virtual bool isEnabledAtPlay(const Player *player) const{
        return !player->hasUsed("HuazhuCard") && !player->isKongcheng();
    }

    virtual bool viewFilter(const CardItem *to_select) const{
        return !to_select->isEquipped();
    }

    virtual const Card *viewAs(CardItem *card_item) const{
        Card *card = new HuazhuCard;
        card->addSubcard(card_item->getFilteredCard());
        return card;
    }
};

class Huazhu: public TriggerSkill{
public:
    Huazhu():TriggerSkill("huazhu"){
        events << Pindian;
        view_as_skill = new HuazhuViewAsSkill;
    }

    virtual int getPriority() const{
        return -1;
    }

    virtual bool triggerable(const ServerPlayer *target) const{
        return true;
    }

    virtual bool trigger(TriggerEvent, Room* room, ServerPlayer *, QVariant &data) const{
        PindianStar pindian = data.value<PindianStar>();
        if(pindian->reason != "huazhu" || !pindian->from->hasSkill(objectName()))
            return false;
        if(pindian->isSuccess()){
            int x = (pindian->from_card->getNumber() + 1) / 2;
            ServerPlayer *target = room->askForPlayerChosen(pindian->from, room->getAllPlayers(), objectName());
            if(target->getHandcardNum() > x)
                room->askForDiscard(target, objectName(), target->getHandcardNum() - x);
            else if(target->getHandcardNum() < x)
                target->drawCards(x - target->getHandcardNum());
        }
        return false;
    }
};

class Fengxing: public TriggerSkill{
public:
    Fengxing():TriggerSkill("fengxing"){
        events << PhaseChange << CardLost;
        frequency = Compulsory;
    }

    virtual bool trigger(TriggerEvent v, Room* room, ServerPlayer *player, QVariant &data) const{
        if(v == CardLost){
            CardMoveStar move = data.value<CardMoveStar>();
            if(move->from_place == Player::Hand && player->isAlive()){
                if(player->getHandcardNum() < player->getMaxHP()){
                    LogMessage log;
                    log.type = "#TriggerSkill";
                    log.from = player;
                    log.arg = objectName();
                    room->sendLog(log);
                    player->drawCards(1);
                }
            }
        }
        else{
            if(player->getPhase() == Player::Judge ||
               player->getPhase() == Player::Draw ||
               player->getPhase() == Player::Discard)
                return true;
        }
        return false;
    }
};
*/

OxPackage::OxPackage()
    :Package("ox")
{
    General *huyanzhuo = new General(this, "huyanzhuo", "guan");
    huyanzhuo->addSkill(new Lianma);
    huyanzhuo->addSkill(new Zhongjia);

    General *dongchaoxueba = new General(this, "dongchaoxueba", "jiang");
    dongchaoxueba->addSkill(new Sheru);

    General *pangwanchun = new General(this, "pangwanchun", "jiang");
    pangwanchun->addSkill(new Lianzhu);

    General *xiezhen = new General(this, "xiezhen", "min");
    xiezhen->addSkill(new Xunlie);
/*
    General *jiangjing = new General(this, "jiangjing", "jiang");
    jiangjing->addSkill(new Tiansuan);
    jiangjing->addSkill(new Huazhu);

    General *maling = new General(this, "maling", "jiang", 3);
    maling->addSkill(new Fengxing);
*/
    addMetaObject<LianmaCard>();
    addMetaObject<SheruCard>();
    addMetaObject<XunlieCard>();
    addMetaObject<LianzhuCard>();
}

ADD_PACKAGE(Ox);