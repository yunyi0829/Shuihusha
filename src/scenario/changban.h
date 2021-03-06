#ifndef CHANGBANSCENARIO_H
#define CHANGBANSCENARIO_H

#include "scenario.h"

class ChangbanScenario: public Scenario{
    Q_OBJECT

public:
    ChangbanScenario();

    virtual void run(Room *room) const;
    virtual bool exposeRoles() const;
    virtual void assign(QStringList &generals, QStringList &roles) const;
    virtual int getPlayerCount() const;
    virtual void getRoles(char *roles) const;
    virtual bool lordWelfare(const ServerPlayer *player) const;
    virtual bool generalSelection(Room *room) const;
};

class CBLongNuCard: public SkillCard{
    Q_OBJECT

public:
    Q_INVOKABLE CBLongNuCard();

    virtual void use(Room *room, ServerPlayer *source, const QList<ServerPlayer *> &targets) const;
};

class CBYuXueCard: public SkillCard{
    Q_OBJECT

public:
    Q_INVOKABLE CBYuXueCard();

    virtual void onUse(Room *room, const CardUseStruct &card_use) const;
};

class CBJuWuCard: public SkillCard{
    Q_OBJECT

public:
    Q_INVOKABLE CBJuWuCard();

    virtual bool targetFilter(const QList<const Player *> &targets, const Player *to_select, const Player *Self) const;
    virtual void onEffect(const CardEffectStruct &effect) const;
};

class CBChanSheCard: public SkillCard{
    Q_OBJECT

public:
    Q_INVOKABLE CBChanSheCard();

    virtual bool targetFilter(const QList<const Player *> &targets, const Player *to_select, const Player *Self) const;
    virtual void onUse(Room *room, const CardUseStruct &card_use) const;
};

class CBShiShenCard: public SkillCard{
    Q_OBJECT

public:
    Q_INVOKABLE CBShiShenCard();

    virtual bool targetFilter(const QList<const Player *> &targets, const Player *to_select, const Player *Self) const;
    virtual void use(Room *room, ServerPlayer *source, const QList<ServerPlayer *> &targets) const;
};

#endif // CHANGBANSCENARIO_H
