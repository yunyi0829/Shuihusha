#include "standard.h"
#include "standard-equips.h"

Slash::Slash(Suit suit, int number): BasicCard(suit, number)
{
    setObjectName("slash");
    nature = DamageStruct::Normal;
}

DamageStruct::Nature Slash::getNature() const{
    return nature;
}

void Slash::setNature(DamageStruct::Nature nature){
    this->nature = nature;
}

bool Slash::IsAvailable(const Player *player){
    int slash_residue = Sanguosha->correctClient("residue", player);
    return slash_residue > 0;
}

bool Slash::isAvailable(const Player *player) const{
    return IsAvailable(player);
}

QString Slash::getSubtype() const{
    return "attack_card";
}

void Slash::use(Room *room, ServerPlayer *source, const QList<ServerPlayer *> &targets) const{
    BasicCard::use(room, source, targets);

    if(source->hasFlag("drank")){
        LogMessage log;
        log.type = "#UnsetDrank";
        log.from = source;
        room->sendLog(log);
    }
}

void Slash::onEffect(const CardEffectStruct &card_effect) const{
    Room *room = card_effect.from->getRoom();
    if(card_effect.from->hasFlag("drank")){
        room->setCardFlag(this, "drank");
        room->setPlayerFlag(card_effect.from, "-drank");
    }

    SlashEffectStruct effect;
    effect.from = card_effect.from;
    effect.nature = nature;
    effect.slash = this;

    effect.to = card_effect.to;
    effect.drank = this->hasFlag("drank");

    room->slashEffect(effect);
}

bool Slash::targetsFeasible(const QList<const Player *> &targets, const Player *Self) const{
    if(Self->hasFlag("zhusha_effect"))
        return targets.isEmpty();
    else
        return !targets.isEmpty();
}

bool Slash::targetFilter(const QList<const Player *> &targets, const Player *to_select, const Player *Self) const{
    int slash_targets = 1 + Sanguosha->correctClient("extragoals", Self, to_select, this);
    bool distance_limit = Sanguosha->correctClient("attackrange", Self, to_select, this) < 50;

    if(targets.length() >= slash_targets)
        return false;
    return Self->canSlash(to_select, this, distance_limit);
}

Jink::Jink(Suit suit, int number):BasicCard(suit, number){
    setObjectName("jink");

    target_fixed = true;
}

QString Jink::getSubtype() const{
    return "defense_card";
}

bool Jink::isAvailable(const Player *) const{
    return false;
}

Peach::Peach(Suit suit, int number):BasicCard(suit, number){
    setObjectName("peach");
    target_fixed = true;
}

QString Peach::getSubtype() const{
    return "recover_card";
}

QString Peach::getEffectPath(bool ) const{
    return Card::getEffectPath();
}

void Peach::use(Room *room, ServerPlayer *source, const QList<ServerPlayer *> &targets) const{
    if(targets.isEmpty())
        room->cardEffect(this, source, source);
    else
        foreach(ServerPlayer *tmp, targets)
            room->cardEffect(this, source, tmp);
}

void Peach::onEffect(const CardEffectStruct &effect) const{
    Room *room = effect.to->getRoom();

    if(effect.from == effect.to)
        room->setEmotion(effect.from, "peach");
    else{
        // do animation
        room->broadcastInvoke("animate", QString("peach:%1:%2")
                              .arg(effect.from->objectName())
                              .arg(effect.to->objectName()));
    }

    // recover hp
    RecoverStruct recover;
    recover.card = this;
    recover.who = effect.from;

    room->recover(effect.to, recover, false);
}

bool Peach::IsAvailable(const Player *player){
    if(player->hasFlag("%zhaoan"))
        return false;
    return player->isWounded();
}

bool Peach::isAvailable(const Player *player) const{
    return IsAvailable(player);
}

Crossbow::Crossbow(Suit suit, int number)
    :Weapon(suit, number, 1)
{
    setObjectName("crossbow");
}

class DoubleSwordSkill: public WeaponSkill{
public:
    DoubleSwordSkill():WeaponSkill("double_sword"){
        events << SlashEffect;
    }

    virtual bool trigger(TriggerEvent, Room* room, ServerPlayer *player, QVariant &data) const{
        SlashEffectStruct effect = data.value<SlashEffectStruct>();

        if(effect.from->getGender() != effect.to->getGender()){
            if(effect.from->askForSkillInvoke(objectName())){
                bool draw_card = false;

                if(player->getGeneral()->isMale())
                    player->playCardEffect("Edouble_sword1", "weapon");
                else
                    player->playCardEffect("Edouble_sword2", "weapon");
                if(effect.to->isKongcheng())
                    draw_card = true;
                else{
                    QString prompt = "double-sword-card:" + effect.from->getGeneralName();
                    const Card *card = room->askForCard(effect.to, ".", prompt, data, CardDiscarded);
                    if(card)
                        room->throwCard(card, effect.to);
                    else
                        draw_card = true;
                }

                if(draw_card)
                    effect.from->drawCards(1);
            }
        }

        return false;
    }
};

DoubleSword::DoubleSword(Suit suit, int number)
    :Weapon(suit, number, 2)
{
    setObjectName("double_sword");
    skill = new DoubleSwordSkill;
}

class QinggangSwordSkill: public WeaponSkill{
public:
    QinggangSwordSkill():WeaponSkill("qinggang_sword"){
        events << SlashEffect;
    }

    virtual bool trigger(TriggerEvent, Room*, ServerPlayer *player, QVariant &data) const{
        SlashEffectStruct effect = data.value<SlashEffectStruct>();
        effect.to->addMark("qinggang");
        if(effect.to->getArmor() || (!effect.to->getArmor() && effect.to->hasSkill("jinjia")))
            player->playCardEffect("Eqinggang_sword", "weapon");

        return false;
    }
};

class QinggangSlash: public ClientSkill{
public:
    QinggangSlash():ClientSkill("#qinggang_slash"){
    }

    virtual bool isSlashPenetrate(const Player *, const Player *to, const Card *) const{
        return to->hasMark("qinggang");
        //return from->hasEquip("qinggang_sword") && card->isKindOf("Slash");
    }
};

QinggangSword::QinggangSword(Suit suit, int number)
    :Weapon(suit, number, 2)
{
    setObjectName("qinggang_sword");

    skill = new QinggangSwordSkill;
}

class BladeSkill : public WeaponSkill{
public:
    BladeSkill():WeaponSkill("blade"){
        events << SlashMissed;
    }

    virtual int getPriority(TriggerEvent) const{
        return -1;
    }

    virtual bool trigger(TriggerEvent, Room* room, ServerPlayer *player, QVariant &data) const{
        SlashEffectStruct effect = data.value<SlashEffectStruct>();

        if(!player->canSlash(effect.to, false))
            return false;
        if(player->hasFlag("triggered"))
            return false;

        const Card *card = room->askForCard(player, "slash", "blade-slash:" + effect.to->objectName(), QVariant(), NonTrigger);
        if(card){
            if(qrand() % 2 == 1)
                player->playCardEffect("Eblade2", "weapon");
            else
                player->playCardEffect("Eblade1", "weapon");

            // if player is drank, unset his flag
            if(player->hasFlag("drank"))
                room->setPlayerFlag(player, "-drank");

            CardUseStruct use;
            use.card = card;
            use.from = player;
            use.to << effect.to;
            use.mute = true;
            room->useCard(use, false);
        }

        return false;
    }
};

Blade::Blade(Suit suit, int number)
    :Weapon(suit, number, 3)
{
    setObjectName("blade");
    skill = new BladeSkill;
}

class SpearSkill: public ViewAsSkill{
public:
    SpearSkill():ViewAsSkill("spear"){
        equip_skill = true;
    }

    virtual bool isEnabledAtPlay(const Player *player) const{
        return Slash::IsAvailable(player);
    }

    virtual bool isEnabledAtResponse(const Player *, const QString &pattern) const{
        return pattern == "slash";
    }

    virtual bool viewFilter(const QList<CardItem *> &selected, const CardItem *to_select) const{
        return selected.length() < 2 && !to_select->isEquipped();
    }

    virtual const Card *viewAs(const QList<CardItem *> &cards) const{
        if(cards.length() != 2)
            return NULL;

        const Card *first = cards.at(0)->getFilteredCard();
        const Card *second = cards.at(1)->getFilteredCard();

        Card::Suit suit = Card::NoSuit;
        if(first->isBlack() && second->isBlack())
            suit = Card::Spade;
        else if(first->isRed() && second->isRed())
            suit = Card::Heart;

        Slash *slash = new Slash(suit, 0);
        slash->setSkillName(objectName());
        slash->addSubcard(first);
        slash->addSubcard(second);

        return slash;
    }
};

Spear::Spear(Suit suit, int number)
    :Weapon(suit, number, 3)
{
    setObjectName("spear");
    attach_skill = true;
}

class AxeViewAsSkill: public ViewAsSkill{
public:
    AxeViewAsSkill():ViewAsSkill("axe"){
        equip_skill = true;
    }

    virtual bool isEnabledAtPlay(const Player *) const{
        return false;
    }

    virtual bool isEnabledAtResponse(const Player *, const QString &pattern) const{
        return pattern == "@axe";
    }

    virtual bool viewFilter(const QList<CardItem *> &selected, const CardItem *to_select) const{
        if(selected.length() >= 2)
            return false;

        if(to_select->getCard() == Self->getWeapon())
            return false;

        return true;
    }

    virtual const Card *viewAs(const QList<CardItem *> &cards) const{
        if(cards.length() != 2)
            return NULL;

        DummyCard *card = new DummyCard;
        card->setSkillName(objectName());
        card->addSubcards(cards);
        return card;
    }
};

class AxeSkill: public WeaponSkill{
public:
    AxeSkill():WeaponSkill("axe"){
        events << SlashMissed;
    }

    virtual bool trigger(TriggerEvent, Room* room, ServerPlayer *player, QVariant &data) const{
        SlashEffectStruct effect = data.value<SlashEffectStruct>();

        if(player->hasFlag("triggered"))
            return false;
        CardStar card = room->askForCard(player, "@axe", "@axe:" + effect.to->objectName(), data, CardDiscarded);
        if(card){
            player->playCardEffect("Eaxe", "weapon");

            LogMessage log;
            log.type = "#AxeSkill";
            log.from = player;
            log.to << effect.to;
            log.arg = objectName();
            room->sendLog(log);

            room->slashResult(effect, NULL);
        }

        return false;
    }
};

Axe::Axe(Suit suit, int number)
    :Weapon(suit, number, 3)
{
    setObjectName("axe");
    skill = new AxeSkill;
    attach_skill = true;
}

class HalberdSkill: public WeaponSkill{
public:
    HalberdSkill():WeaponSkill("halberd"){
        events << SlashProceed;
        frequency = Compulsory;
    }

    virtual bool trigger(TriggerEvent, Room* room, ServerPlayer *player, QVariant &data) const{
        SlashEffectStruct effect = data.value<SlashEffectStruct>();
        if(player->isAlive()){
            ServerPlayer *target = effect.to;

            if(target->getHandcardNum() > target->getHp()){
                room->playSkillEffect(objectName());
                LogMessage log;
                log.type = "#Halberd";
                log.from = player;
                log.to << target;
                log.arg = objectName();
                room->sendLog(log);
                player->playCardEffect("Ehalberd", "weapon");

                room->slashResult(effect, NULL);
                return true;
            }
        }
        return false;
    }
};

Halberd::Halberd(Suit suit, int number)
    :Weapon(suit, number, 4)
{
    setObjectName("halberd");
    skill = new HalberdSkill;
}

class KylinBowSkill: public WeaponSkill{
public:
    KylinBowSkill():WeaponSkill("kylin_bow"){
        events << DamageProceed;
    }

    virtual bool trigger(TriggerEvent, Room* room, ServerPlayer *player, QVariant &data) const{
        DamageStruct damage = data.value<DamageStruct>();

        QStringList horses;
        if(damage.card && damage.card->inherits("Slash") && !damage.chain){
            if(damage.to->getDefensiveHorse(true))
                horses << "dhorse";
            if(damage.to->getOffensiveHorse(true))
                horses << "ohorse";

            if(horses.isEmpty())
                return false;

            if(!player->askForSkillInvoke(objectName(), data))
                return false;
            player->playCardEffect("Ekylin_bow", "weapon");

            QString horse_type;
            if(horses.length() == 2)
                horse_type = room->askForChoice(player, objectName(), horses.join("+"));
            else
                horse_type = horses.first();

            if(horse_type == "dhorse")
                room->throwCard(damage.to->getDefensiveHorse(), damage.to, player);
            else if(horse_type == "ohorse")
                room->throwCard(damage.to->getOffensiveHorse(), damage.to, player);
        }

        return false;
    }
};

KylinBow::KylinBow(Suit suit, int number)
    :Weapon(suit, number, 5)
{
    setObjectName("kylin_bow");
    skill = new KylinBowSkill;
}

class EightDiagramSkill: public ArmorSkill{
private:
    EightDiagramSkill():ArmorSkill("eight_diagram"){
        events << CardAsked;
    }

public:
    static EightDiagramSkill *GetInstance(){
        static EightDiagramSkill *instance = NULL;
        if(instance == NULL)
            instance = new EightDiagramSkill;

        return instance;
    }
/*
    virtual int getPriority(TriggerEvent) const{
        return 2;
    }
*/
    virtual bool trigger(TriggerEvent, Room* room, ServerPlayer *player, QVariant &data) const{
        QString asked = data.toString();
        if(asked == "jink"){
            if(room->askForSkillInvoke(player, objectName())){
                JudgeStruct judge;
                judge.pattern = QRegExp("(.*):(heart|diamond):(.*)");
                judge.good = true;
                judge.reason = objectName();
                judge.who = player;

                room->judge(judge);
                if(judge.isGood()){
                    Jink *jink = new Jink(Card::NoSuit, 0);
                    jink->setSkillName(objectName());
                    room->provide(jink);
                    player->playCardEffect("Eeight_diagram1");
                }else
                    player->playCardEffect("Eeight_diagram2");
            }
        }
        return false;
    }
};

EightDiagram::EightDiagram(Suit suit, int number)
    :Armor(suit, number){
    setObjectName("eight_diagram");
    skill = EightDiagramSkill::GetInstance();
}

AmazingGrace::AmazingGrace(Suit suit, int number)
    :GlobalEffect(suit, number)
{
    setObjectName("amazing_grace");
}

void AmazingGrace::use(Room *room, ServerPlayer *source, const QList<ServerPlayer *> &targets) const{
    QList<ServerPlayer *> players = targets.isEmpty() ? room->getAllPlayers() : targets;
    QList<int> card_ids = room->getNCards(players.length());
    room->fillAG(card_ids);

    QVariantList ag_list;
    foreach(int card_id, card_ids){
        room->setCardFlag(card_id, "visible");
        ag_list << card_id;
    }
    room->setTag("AmazingGrace", ag_list);

    GlobalEffect::use(room, source, players);

    ag_list = room->getTag("AmazingGrace").toList();

    // throw the rest cards
    foreach(QVariant card_id, ag_list)
        room->takeAG(NULL, card_id.toInt());

    room->broadcastInvoke("clearAG");
    room->removeTag("Jiayao");
}

void AmazingGrace::onEffect(const CardEffectStruct &effect) const{
    Room *room = effect.from->getRoom();
    QVariantList ag_list = room->getTag("AmazingGrace").toList();
    QList<int> card_ids;
    foreach(QVariant card_id, ag_list)
        card_ids << card_id.toInt();

    int card_id = room->askForAG(effect.to, card_ids, false, objectName());
    card_ids.removeOne(card_id);

    room->takeAG(effect.to, card_id);
    ag_list.removeOne(card_id);

    room->setTag("AmazingGrace", ag_list);
}

GodSalvation::GodSalvation(Suit suit, int number)
    :GlobalEffect(suit, number)
{
    setObjectName("god_salvation");
}

bool GodSalvation::isCancelable(const CardEffectStruct &effect) const{
    return effect.to->isWounded();
}

void GodSalvation::onEffect(const CardEffectStruct &effect) const{
    Room *room = effect.to->getRoom();

    RecoverStruct recover;
    recover.card = this;
    recover.who = effect.from;
    room->recover(effect.to, recover, false);
}

SavageAssault::SavageAssault(Suit suit, int number)
    :AOE(suit, number)
{
    setObjectName("savage_assault");
}

void SavageAssault::onEffect(const CardEffectStruct &effect) const{
    Room *room = effect.to->getRoom();
    const Card *slash = room->askForCard(effect.to, "slash", "savage-assault-slash:" + effect.from->objectName(), QVariant::fromValue(effect));
    if(slash)
        room->setEmotion(effect.to, "killer");
    else{
        DamageStruct damage;
        damage.card = this;
        damage.damage = 1;
        damage.to = effect.to;
        damage.nature = DamageStruct::Normal;

        if(effect.from->isAlive())
            damage.from = effect.from;
        else
            damage.from = NULL;

        room->damage(damage);
    }
}

ArcheryAttack::ArcheryAttack(Card::Suit suit, int number)
    :AOE(suit, number)
{
    setObjectName("archery_attack");
}

CardStar ArcheryAttack::doLianzhu(Room *room, CardEffectStruct effect) const{
    const Card *first_jink = NULL, *second_jink = NULL;
    LogMessage log;
    log.type = "#Lianzhu";
    log.from = effect.from;
    log.arg = "lianzhu";
    log.to << effect.to;
    room->sendLog(log);
    first_jink = room->askForCard(effect.to, "jink", "archery-attack-jink:" + effect.from->objectName(), QVariant::fromValue(effect));
    if(first_jink)
        second_jink = room->askForCard(effect.to, "jink", "@lianzhu2jink:" + effect.from->objectName(), QVariant::fromValue(effect));

    if(first_jink && second_jink)
        return first_jink;
    else
        return NULL;
}

void ArcheryAttack::onEffect(const CardEffectStruct &effect) const{
    Room *room = effect.to->getRoom();
    const Card *jink = NULL;
    if(effect.card->getSkillName() == "lianzhu")
        jink = doLianzhu(room, effect);
    else
        jink = room->askForCard(effect.to, "jink", "archery-attack-jink:" + effect.from->objectName(), QVariant::fromValue(effect));
    if(jink)
        room->setEmotion(effect.to, "jink");
    else{
        DamageStruct damage;
        damage.card = this;
        damage.damage = 1;
        if(effect.from->isAlive())
            damage.from = effect.from;
        else
            damage.from = NULL;
        damage.to = effect.to;
        damage.nature = effect.card->getSkillName() == "lianzhu" ?
                        DamageStruct::Fire:
                        DamageStruct::Normal;

        room->damage(damage);
    }
}

void SingleTargetTrick::use(Room *room, ServerPlayer *source, const QList<ServerPlayer *> &targets) const{
    CardEffectStruct effect;
    effect.card = this;
    effect.from = source;
    if(!targets.isEmpty()){
        foreach(ServerPlayer *tmp, targets){
            effect.to = tmp;
            room->cardEffect(effect);
        }
    }
    else{
        effect.to = source;
        room->cardEffect(effect);
    }
}

Collateral::Collateral(Card::Suit suit, int number)
    :SingleTargetTrick(suit, number, false)
{
    setObjectName("collateral");
}

bool Collateral::isAvailable(const Player *player) const{
    foreach(const Player *p, player->getSiblings()){
        if(p->getWeapon() && p->isAlive())
            return true;
    }

    return false;
}

bool Collateral::targetsFeasible(const QList<const Player *> &targets, const Player *Self) const{
    return targets.length() == 2;
}

bool Collateral::targetFilter(const QList<const Player *> &targets, const Player *to_select, const Player *Self) const{
    if(targets.isEmpty()){
        if(to_select->hasSkill("weimu") && isBlack())
            return false;

        return to_select->getWeapon() && to_select != Self;
    }else if(targets.length() == 1){
        const Player *first = targets.first();
        return first != Self && first->getWeapon() && first->canSlash(to_select);
    }else
        return false;
}

void Collateral::use(Room *room, ServerPlayer *source, const QList<ServerPlayer *> &targets) const{
    ServerPlayer *killer = targets.at(0);
    QList<ServerPlayer *> victims = targets;
    if(victims.length() > 1)
        victims.removeAt(0);
    const Weapon *weapon = killer->getWeapon();

    if(weapon == NULL)
        return;

    bool on_effect = room->cardEffect(this, source, killer);
    if(on_effect){
        QString prompt = QString("collateral-slash:%1:%2")
                         .arg(source->objectName()).arg(victims.first()->objectName());
        const Card *slash = room->askForCard(killer, "slash", prompt, QVariant(), NonTrigger);
        if (victims.first()->isDead()){
            if (source->isDead()){
                if(killer->isAlive() && killer->getWeapon()){
                    int card_id = weapon->getId();
                    room->throwCard(card_id, killer);
                }
            }
            else{
                if(killer->isAlive() && killer->getWeapon())
                    source->obtainCard(weapon);
            }
        }
        if (source->isDead()){
            if (killer->isAlive()){
                if(slash){
                    CardUseStruct use;
                    use.card = slash;
                    use.from = killer;
                    use.to = victims;
                    room->useCard(use);
                }
                else{
                    if(killer->getWeapon()){
                        int card_id = weapon->getId();
                        room->throwCard(card_id, killer);
                    }
                }
            }
        }
        else{
            if(killer->isDead()) ;
            else{
                if(slash){
                    CardUseStruct use;
                    use.card = slash;
                    use.from = killer;
                    use.to = victims;
                    room->useCard(use);
                }
                else{
                    if(killer->getWeapon())
                        source->obtainCard(weapon);
                }
            }
        }
    }
}

Nullification::Nullification(Suit suit, int number)
    :SingleTargetTrick(suit, number, false)
{
    setObjectName("nullification");
}

void Nullification::use(Room *, ServerPlayer *, const QList<ServerPlayer *> &) const{
    // does nothing, just throw it
}

bool Nullification::isAvailable(const Player *) const{
    return false;
}

ExNihilo::ExNihilo(Suit suit, int number)
    :SingleTargetTrick(suit, number, false)
{
    setObjectName("ex_nihilo");
    target_fixed = true;
}

void ExNihilo::onEffect(const CardEffectStruct &effect) const{
    effect.to->drawCards(2);
}

Duel::Duel(Suit suit, int number)
    :SingleTargetTrick(suit, number, true){
    setObjectName("duel");
}

void Duel::onEffect(const CardEffectStruct &effect) const{
    ServerPlayer *first = effect.to;
    ServerPlayer *second = effect.from;
    Room *room = first->getRoom();

    room->setEmotion(first, "duel");
    room->setEmotion(second, "duel");

    forever{
        if(second->hasSkill("wushuang")){
            room->playSkillEffect("wushuang");
            const Card *slash = room->askForCard(first, "slash", "@wushuang-slash-1:" + second->objectName());
            if(slash == NULL)
                break;

            slash = room->askForCard(first, "slash", "@wushuang-slash-2:" + second->objectName());
            if(slash == NULL)
                break;

        }else{
            const Card *slash = room->askForCard(first, "slash", "duel-slash:" + second->objectName());
            if(slash == NULL)
                break;
        }

        qSwap(first, second);
    }

    DamageStruct damage;
    damage.card = this;
    if(second->isAlive())
        damage.from = second;
    else
        damage.from = NULL;
    damage.to = first;

    room->damage(damage);
}

Snatch::Snatch(Suit suit, int number):SingleTargetTrick(suit, number, true) {
    setObjectName("snatch");
}

bool Snatch::targetFilter(const QList<const Player *> &targets, const Player *to_select, const Player *Self) const{
    if(!targets.isEmpty())
        return false;

    if(to_select->isAllNude())
        return false;

    if(to_select == Self)
        return false;

    if(Self->distanceTo(to_select) < 3 && Self->hasSkill("shentou"))
        return true;

    if(Self->distanceTo(to_select) > 1 && !Self->hasSkill("qicai"))
        return false;

    return true;
}

void Snatch::onEffect(const CardEffectStruct &effect) const{
    if(effect.from->isDead())
        return;
    if(effect.to->isAllNude())
        return;

    Room *room = effect.to->getRoom();
    int card_id = room->askForCardChosen(effect.from, effect.to, "hej", objectName());

    room->obtainCard(effect.from, card_id, room->getCardPlace(card_id) != Player::Hand);
}

Dismantlement::Dismantlement(Suit suit, int number)
    :SingleTargetTrick(suit, number, false) {
    setObjectName("dismantlement");
}

bool Dismantlement::targetFilter(const QList<const Player *> &targets, const Player *to_select, const Player *Self) const{
    if(!targets.isEmpty())
        return false;

    if(to_select->isAllNude())
        return false;

    if(to_select == Self)
        return false;

    return true;
}

void Dismantlement::onEffect(const CardEffectStruct &effect) const{
    if(effect.from->isDead())
        return;
    if(effect.to->isAllNude())
        return;

    Room *room = effect.to->getRoom();
    int card_id = room->askForCardChosen(effect.from, effect.to, "hej", objectName());
    ServerPlayer *from = room->getCardPlace(card_id) == Player::Judging ? NULL : effect.to;
    room->throwCard(card_id, from, from ? effect.from: NULL);
}

Indulgence::Indulgence(Suit suit, int number)
    :DelayedTrick(suit, number)
{
    setObjectName("indulgence");
    target_fixed = false;

    judge.pattern = QRegExp("(.*):(heart):(.*)");
    judge.good = true;
    judge.reason = objectName();
}

bool Indulgence::targetFilter(const QList<const Player *> &targets, const Player *to_select, const Player *Self) const
{
    if(!targets.isEmpty())
        return false;

    if(to_select->containsTrick(objectName()))
        return false;

    if(to_select == Self)
        return false;

    return true;
}

void Indulgence::takeEffect(ServerPlayer *target, bool good) const{
    target->clearHistory();
	if(!good)
        target->skip(Player::Play);
}

Disaster::Disaster(Card::Suit suit, int number)
    :DelayedTrick(suit, number, true)
{
    target_fixed = true;
}

bool Disaster::isAvailable(const Player *player) const{
    if(player->containsTrick(objectName()))
        return false;

    return ! player->isProhibited(player, this);
}

Lightning::Lightning(Suit suit, int number):Disaster(suit, number){
    setObjectName("lightning");

    judge.pattern = QRegExp("(.*):(spade):([2-9])");
    judge.good = false;
    judge.reason = objectName();
}

void Lightning::takeEffect(ServerPlayer *target, bool good) const{
    if(!good){
        DamageStruct damage;
        damage.card = this;
        damage.damage = 3;
        damage.from = NULL;
        damage.to = target;
        damage.nature = DamageStruct::Thunder;

        target->getRoom()->damage(damage);
    }
}


// EX cards

class IceSwordSkill: public WeaponSkill{
public:
    IceSwordSkill():WeaponSkill("ice_sword"){
        events << Predamage;
    }

    virtual bool trigger(TriggerEvent, Room* room, ServerPlayer *player, QVariant &data) const{
        DamageStruct damage = data.value<DamageStruct>();

        if(damage.card && damage.card->inherits("Slash") && !damage.to->isNude()
                && !damage.chain && player->askForSkillInvoke("ice_sword", data)){
            player->playCardEffect("Eice_sword", "weapon");
            int card_id = room->askForCardChosen(player, damage.to, "he", "ice_sword");
            room->throwCard(card_id, damage.to, player);

            if(!damage.to->isNude()){
                card_id = room->askForCardChosen(player, damage.to, "he", "ice_sword");
                room->throwCard(card_id, damage.to, player);
            }

            return true;
        }

        return false;
    }
};

IceSword::IceSword(Suit suit, int number)
    :Weapon(suit, number, 2)
{
    setObjectName("ice_sword");
    skill = new IceSwordSkill;
}

class RenwangShieldSkill: public ArmorSkill{
public:
    RenwangShieldSkill():ArmorSkill("renwang_shield"){
        events << SlashEffected;
    }

    virtual bool trigger(TriggerEvent, Room* room, ServerPlayer *player, QVariant &data) const{
        SlashEffectStruct effect = data.value<SlashEffectStruct>();
        if(effect.slash->isBlack()){
            player->playCardEffect("Erenwang_shield", "armor");

            LogMessage log;
            log.type = "#ArmorNullify";
            log.from = player;
            log.arg = objectName();
            log.arg2 = effect.slash->objectName();
            room->sendLog(log);

            return true;
        }else
            return false;
    }
};

RenwangShield::RenwangShield(Suit suit, int number)
    :Armor(suit, number)
{
    setObjectName("renwang_shield");
    skill = new RenwangShieldSkill;
}

class CrossbowSkill: public SlashSkill{
public:
    CrossbowSkill():SlashSkill("crossbow"){
    }

    virtual int getSlashResidue(const Player *target) const{
        if(target->hasWeapon("crossbow"))
            return 998;
        else
            return 0;
    }
};

class HorseSkill: public DistanceSkill{
public:
    HorseSkill(): DistanceSkill("horse"){
    }

    virtual int getCorrect(const Player *from, const Player *to) const{
        int correct = 0;
        if(from->getOffensiveHorse())
            correct += from->getOffensiveHorse()->getCorrect();
        if(to->getDefensiveHorse())
            correct += to->getDefensiveHorse()->getCorrect();

        return correct;
    }
};

StandardCardPackage::StandardCardPackage()
    :CardPackage("standard_cards")
{
    QList<Card*> cards;

    cards << new Slash(Card::Spade, 7)
          << new Slash(Card::Spade, 8)
          << new Slash(Card::Spade, 8)
          << new Slash(Card::Spade, 9)
          << new Slash(Card::Spade, 9)
          << new Slash(Card::Spade, 10)
          << new Slash(Card::Spade, 10)

          << new Slash(Card::Club, 2)
          << new Slash(Card::Club, 3)
          << new Slash(Card::Club, 4)
          << new Slash(Card::Club, 5)
          << new Slash(Card::Club, 6)
          << new Slash(Card::Club, 7)
          << new Slash(Card::Club, 8)
          << new Slash(Card::Club, 8)
          << new Slash(Card::Club, 9)
          << new Slash(Card::Club, 9)
          << new Slash(Card::Club, 10)
          << new Slash(Card::Club, 10)
          << new Slash(Card::Club, 11)
          << new Slash(Card::Club, 11)

          << new Slash(Card::Heart, 10)
          << new Slash(Card::Heart, 10)
          << new Slash(Card::Heart, 11)

          << new Slash(Card::Diamond, 6)
          << new Slash(Card::Diamond, 7)
          << new Slash(Card::Diamond, 8)
          << new Slash(Card::Diamond, 9)
          << new Slash(Card::Diamond, 10)
          << new Slash(Card::Diamond, 13)

          << new Jink(Card::Heart, 2)
          << new Jink(Card::Heart, 2)
          << new Jink(Card::Heart, 13)

          << new Jink(Card::Diamond, 2)
          << new Jink(Card::Diamond, 2)
          << new Jink(Card::Diamond, 3)
          << new Jink(Card::Diamond, 4)
          << new Jink(Card::Diamond, 5)
          << new Jink(Card::Diamond, 6)
          << new Jink(Card::Diamond, 7)
          << new Jink(Card::Diamond, 8)
          << new Jink(Card::Diamond, 9)
          << new Jink(Card::Diamond, 10)
          << new Jink(Card::Diamond, 11)
          << new Jink(Card::Diamond, 11)

          << new Peach(Card::Heart, 3)
          << new Peach(Card::Heart, 4)
          << new Peach(Card::Heart, 6)
          << new Peach(Card::Heart, 7)
          << new Peach(Card::Heart, 8)
          << new Peach(Card::Heart, 9)
          << new Peach(Card::Heart, 12)

          << new Peach(Card::Diamond, 12)

          << new Crossbow(Card::Club)
          << new Crossbow(Card::Diamond)
          << new DoubleSword
          << new QinggangSword
          << new Blade
          << new Spear
          << new Axe
          << new Halberd
          << new KylinBow

          << new EightDiagram(Card::Spade)
          << new EightDiagram(Card::Club);

    skills << EightDiagramSkill::GetInstance();
    skills << new CrossbowSkill;
    skills << new QinggangSlash;

    {
        QList<Card *> horses;
        horses << new DefensiveHorse(Card::Spade, 5)
               << new DefensiveHorse(Card::Club, 5)
               << new DefensiveHorse(Card::Heart, 13)
               << new OffensiveHorse(Card::Heart, 5)
               << new OffensiveHorse(Card::Spade, 13)
               << new OffensiveHorse(Card::Diamond, 13);

        horses.at(0)->setObjectName("lhh");
        horses.at(1)->setObjectName("kirin");
        horses.at(2)->setObjectName("white");
        horses.at(3)->setObjectName("chitu");
        horses.at(4)->setObjectName("snow");
        horses.at(5)->setObjectName("silver");

        cards << horses;

        skills << new HorseSkill;
    }

    cards << new AmazingGrace(Card::Heart, 3)
          << new AmazingGrace(Card::Heart, 4)
          << new GodSalvation(Card::Heart, 1)
          << new SavageAssault(Card::Spade, 7)
          << new SavageAssault(Card::Spade, 13)
          << new SavageAssault(Card::Club, 7)
          << new ArcheryAttack(Card::Heart, 1)
          << new Duel(Card::Spade, 1)
          << new Duel(Card::Club, 1)
          << new Duel(Card::Diamond, 1)
          << new ExNihilo(Card::Heart, 7)
          << new ExNihilo(Card::Heart, 8)
          << new ExNihilo(Card::Heart, 9)
          << new ExNihilo(Card::Heart, 11)
          << new Snatch(Card::Spade, 3)
          << new Snatch(Card::Spade, 4)
          << new Snatch(Card::Spade, 11)
          << new Snatch(Card::Diamond, 3)
          << new Snatch(Card::Diamond, 4)
          << new Dismantlement(Card::Spade, 3)
          << new Dismantlement(Card::Spade, 4)
          << new Dismantlement(Card::Spade, 12)
          << new Dismantlement(Card::Club, 3)
          << new Dismantlement(Card::Club, 4)
          << new Dismantlement(Card::Heart, 12)
          << new Collateral(Card::Club, 12)
          << new Collateral(Card::Club, 13)
          << new Nullification(Card::Spade, 11)
          << new Nullification(Card::Club, 12)
          << new Nullification(Card::Club, 13)
          << new Indulgence(Card::Spade, 6)
          << new Indulgence(Card::Club, 6)
          << new Indulgence(Card::Heart, 6)
          << new Lightning(Card::Spade, 1);

    foreach(Card *card, cards)
        card->setParent(this);

    skills << new SpearSkill << new AxeViewAsSkill;
}

#include "plough.h"
ExCardPackage::ExCardPackage()
    :CardPackage("ex_cards")
{
    QList<Card *> cards;
    cards
            << new IceSword(Card::Spade, 2)
            << new RenwangShield(Card::Club, 2)
            << new Lightning(Card::Heart, 12)
            << new Nullification(Card::Diamond, 12)
            << new Tsunami(Card::Diamond, 1)
            << new Inspiration(Card::Spade, 4)
            << new Haiqiu(Card::Club, 5);

    foreach(Card *card, cards)
        card->setParent(this);
}

ADD_PACKAGE(StandardCard)
ADD_PACKAGE(ExCard)
