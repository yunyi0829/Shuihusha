-- The common
return {
	["Shuihusha"] = "水浒杀",
	["DefaultDesigner"] = "烨子",
	["DefaultCV"] = "佚名",
	["DefaultCoder"] = "宇文天启",
	["UnknowNick"] = "",
	["DefaultIllustrator"] = "",

	["Pairs"] = "双将",
	["spade"] = "黑桃",
	["club"] = "梅花",
	["heart"] = "红桃",
	["diamond"] = "方块",
	["no_suit"] = "无色",
	["basic"] = "基本牌",
	["trick"] = "锦囊牌",
	["equip"] = "装备牌",
	["ndtrick"] = "非延时锦囊",

	["lord"] = "主公",
	["loyalist"] = "忠臣",
	["rebel"] = "反贼",
	["renegade"] = "内奸",
	["spade_char"] = "♠",
	["club_char"] = "♣",
	["heart_char"] = "♥",
	["diamond_char"] = "♦",
	["no_suit_char"] = "无色",
	["start"] = "开始",
	["judge"] = "判定",
	["draw"] = "摸牌",
	["play"] = "出牌",
	["discard"] = "弃牌",
	["finish"] = "结束",
	["online"] = "在线",
	["offline"] = "离线",
	["robot"] = "电脑",
	["trust"] = "托管",
	["cheat"] = "作弊",
	["change"] = "变身",
	["free-discard"] = "自由弃牌",
	["yes"] = "是",
	["no"] = "否",
	["male"] = "男性",
	["female"] = "女性",

	["attack_card"] = "进攻牌",
	["defense_card"] = "防御牌",
	["recover_card"] = "恢复牌",
	["global_effect"] = "全局效果",
	["aoe"] = "范围效果",
	["single_target_trick"] = "单体锦囊",
	["delayed_trick"] = "延时锦囊",
	["buff_card"] = "辅助伤害卡",
	["damage_spread"] = "伤害传导",
	["weapon"] = "武器",
	["armor"] = "防具",
	["defensive_horse"] = "防御马",
	["offensive_horse"] = "进攻马",
	["disgusting_card"] = "恶心牌",

	["guan"] = "官",
	["jiang"] = "将",
	["min"] = "民",
	["kou"] = "寇",
	["god"] = "神",

	["#Murder"] = "%to【%arg】 挂了，凶手是 %from",
	["#Suicide"] = "%to【%arg】 自杀身亡",
	["#InvokeSkill"] = "%from 使用了技能【%arg】",
	["#TriggerSkill"] = "%from 的锁定技【%arg】被触发",
	["#UseSkill"] = "%from 发动了技能【%arg】，目标是 %to",
	["#WakeUp"] = "已满足触发条件，%from 的觉醒技【%arg】被触发",
	["#Pindian"] = "%from 向 %to 发起了拼点",
	["#PindianSuccess"] = "%from (对 %to) 拼点成功！\\(^o^)/",
	["#PindianFailure"] = "%from (对 %to) 拼点失败！-_-！",
	["#Damage"] = "%from 对 %to 造成了 %arg 点伤害[%arg2]",
	["#DamageNoSource"] = "%to 受到了 %arg 点伤害[%arg2]",
	["#Recover"] = "%from 恢复了 %arg 点体力",
	["#AskForPeaches"] = "%from 向 %to 求【肉】，一共需要 %arg 块【肉】",
	["#ChooseKingdom"] = "%from 选择了 %arg 作为他的势力",
	["#NullificationDetails"] = "%from 对 %to 的锦囊【%arg】被抵消",
	["#SkillAvoid"] = "%from 的 %arg 技能被触发，这张 %arg2 不能指定其作为目标",
	["#Transfigure"] = "%from 变身为 %arg",
	["#AcquireSkill"] = "%from 获得了技能 【%arg】",
	["#LoseSkill"] = "%from 失去了技能 【%arg】",
	["$InitialJudge"] = "%from 最初的判定结果为 %card",
	["$ChangedJudge"] = "%from 把 %to 的判定结果改判成了 %card",
	["$MoveCard"] = "%to 从 %from 处得到了 %card",
	["$PasteCard"] = "%from 给 %to 贴了张 %card",
	["$LightningMove"] = "%card 从 %from 移动到 %to",
	["$DiscardCard"] = "%from 弃置了 %card",
	["$RecycleCard"] = "%from 从弃牌堆回收了 %card",
	["$Dismantlement"] = "%from 被拆掉了 %card",
	["$ShowCard"] = "%from 展示了 %card",
	["$PutCard"] = "%from 的 %card 被放置在了摸牌堆",
	["normal_nature"] = "无属性",
	["fire_nature"] = "火焰属性",
	["thunder_nature"] = "雷电属性",
	["#Contingency"] = "%to【%arg】 挂了，死于天灾",
	["#DelayedTrick"] = "%from 的延时锦囊【%arg】开始判定",
	["#SkillNullify"] = "%from 的技能【%arg】被触发，【%arg2】对其无效",
	["#ComskillNullify"] = "%to 的锁定技【%arg2】被触发，%from 对 %to 的 %arg 无效",
	["#ArmorNullify"] = "%from 的防具【%arg】技能被触发，【%arg2】对其无效",
	["#DrawNCards"] = "%from 摸了 %arg 张牌",
	["#MoveNCards"] = "%to 从 %from 处得到 %arg 张牌",
	["$TakeAG"] = "%from 拿走了 %card",
	["$Install"] = "%from 装备了 %card",
	["$Uninstall"] = "%from 卸载了 %card",
	["$JudgeResult"] = "%from 最终判定结果为 %card",
	["$PindianResult"] = "%from 的拼点结果为 %card",
	["#ChooseSuit"] = "%from 选择了花色 %arg",
	["#DeclareSuit"] = "%from 声明的花色是 %arg",
	["#TurnOver"] = "%from 将自己的武将牌翻面，现在是 %arg",
	["face_up"] = "面朝上",
	["face_down"] = "面朝下",
	["#SkipPhase"] = "%from 跳过了 %arg 阶段",
	["#SkipAllPhase"] = "%from 中止了当前回合",
	["#IronChainDamage"] = "%from 处于铁锁连环状态，将受到铁锁的传导伤害",
	["#LoseHp"] = "%from 流失了 %arg 点体力",
	["#LoseMaxHp"] = "%from 流失了 %arg 点体力上限",
	["#LostMaxHpPlus"] = "%from 流失了 %arg 点体力上限，并同时流失了 %arg2 点体力",
	["#ChangeKingdom"] = "%from 把 %to 的国籍由原来的 %arg 改成了 %arg2",
	["#AnalepticBuff"] = "%from 喝了【%arg】，对 %to 造成的杀伤害 +1",
	["#GetMark"] = "%from 得到了 %arg2 枚 %arg 标记",
	["#LoseMark"] = "%from 失去了 %arg2 枚 %arg 标记",
	["#GuanxingUpOnly"] = "%from 将 %arg 张牌放到了牌堆顶",
	["#GuanxingResult"] = "%from 将 %arg 张牌放到了牌堆顶，将 %arg2 张牌放到了牌堆底",
	["@askforslash"] = "你可以对你攻击范围内的一名角色使用一张【杀】",
	["$CheatCard"] = "%from 使用了作弊，获得了 %card",

	-- askForChoice相关
	["draw1card"] = "摸1张牌",
	["draw2card"] = "摸2张牌",
	["recover1hp"] = "回复1点体力",
	["cancel"] = "不发动",

	["3v3:cw"] = "顺时针",
	["3v3:ccw"] = "逆时针",
	["cw"] = "顺时针",
	["ccw"] = "逆时针",
	["#TrickDirection"] = "%from 选择了 %arg 作为锦囊的顺序",

-- endless&custom
	["endlessmode"] = "无尽模式",
	["@endless"] = "铜板",
	["custom"] = "自定义模式",
	["custom_cards"] = "自定义卡牌包",

-- test
	["test"] = "测试",

	["sujiang"] = "稻草男",
	["sujiangf"] = "稻草女",
	["#sujiang"] = "金童",
	["#sujiangf"] = "玉女",
	["$sujiang"] = "T01",
	["$sujiangf"] = "T02",
	["illustrator:sujiang"] = "幻想春秋",
	["designer:sujiang"] = "游卡桌游",
	["cv:sujiang"] = "",
	["coder:sujiang"] = "",
	["illustrator:sujiangf"] = "幻想春秋",
	["designer:sujiangf"] = "游卡桌游",
	["cv:sujiangf"] = "",
	["coder:sujiangf"] = "",
	["~sujiang"] = "赤条条来去无牵挂！",
	["~sujiangf"] = "赤条条……流氓啊~!",

	["$ubuntenkei"] = "T03",
	["ubuntenkei"] = "宇文天启",
	["designer:ubuntenkei"] = "宇文天启",
	["cv:ubuntenkei"] = "佚名",
	["coder:ubuntenkei"] = "宇文天启 [测试专用]",
	["illustrator:ubuntenkei"] = "三国志大战",
	["ubuna"] = "超能",
	[":ubuna"] = "锁定技，你没有手牌上限",
	["ubunc"] = "鳞栉",
	[":ubunc"] = "出牌阶段，你可以更改一名角色的势力或交换两名角色的座次",
	["ubund"] = "复制",
	[":ubund"] = "出牌阶段，你可以获得一名其他角色的任一技能",
	["ubune"] = "分赃",
	[":ubune"] = "出牌阶段，你可以将装备牌放到任意角色的装备区内，将延时锦囊放到任意角色的判定区内。判定阶段判定前，你可以和一名其他角色交换判定区里的所有牌",
	["ubunf"] = "不灭",
	[":ubunf"] = "当你濒死时，可以原地复活状态全满。非正常死亡对你无效\
★非正常死亡，指的是被武魂、被鸩杀等",
	["qiapai"] = "卡位",
	[":qiapai"] = "利用BUG，卡住你的一张牌以达到无限使用的目的",
	["$ubunc1"] = "怎、怎么了吗？",
	["$ubunc2"] = "干嘛啦",
	["$ubund"] = "……不、不可以的……",
	["$ubune1"] = "去学习了吗，要用功啊",
	["$ubune2"] = "刚回家就玩电脑？",
	["$ubunf"] = "去死吧变态！",
	["$qiapai"] = "别碰人家的裙子……",
	["~ubuntenkei"] = "嗯？不要啊……",

	["$zhuanjia"] = "T04",
	["zhuanjia"] = "砖家叫兽",
	["designer:zhuanjia"] = "宇文天启",
	["coder:zhuanjia"] = "宇文天启 [测试专用]",
	["zhichi"] = "支持",
	[":zhichi"] = "出牌阶段，你可以将一张手牌置于任意一名武将牌上，并指定pile名。",
	["fandui"] = "反对",
	[":fandui"] = "出牌阶段，你可以获得任意角色移出游戏的一张牌。",

	["#jiuweigui"] = "",
	["jiuweigui"] = "九尾龟",
	["coder:jiuweigui"] = "宇文天启 [测试专用]",
	["qiaog"] = "初代巧工",
	[":qiaog"] = "<b>锁定技</b>，若某一种类的装备牌只有一张在场上，则视为你装备着该装备。\
★警告：因初代巧工技能有严重的bug，极容易导致程序崩溃，所以此武将仅供测试和学习",
}