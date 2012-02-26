-- translation for StandardPackage

local t = {
	["standard_cards"] = "基础卡牌包",

	["slash"] = "杀",
	["jink"] = "闪",
	["peach"] = "肉",
	["crossbow"] = "飞燕弩",
	["double_sword"] = "日月霜刀",
	["qinggang_sword"] = "鱼肠剑",
	["blade"] = "青龙偃月刀",
	["spear"] = "丈八蛇矛",
	["axe"] = "战神斧",
	["halberd"] = "水磨禅杖",
	["kylin_bow"] = "钩镰枪",
	["eight_diagram"] = "甲马",
	["horse"] = "马",
	["lhh"] = "连环马",
	["kirin"] = "麒麟兽",
	["silver"] = "拳色银花",
	["chitu"] = "赤兔",
	["snow"] = "雪豹",
	["white"] = "雪白卷毛",
	["amazing_grace"] = "五谷丰登",
	["god_salvation"] = "梁山聚义",
	["savage_assault"] = "猛虎下山",
	["archery_attack"] = "万箭齐发",
	["collateral"] = "借刀杀人",
	["duel"] = "决斗",
	["ex_nihilo"] = "无中生有",
	["snatch"] = "顺手牵羊",
	["dismantlement"] = "过河拆桥",
	["nullification"] = "无懈可击",
	["indulgence"] = "画地为牢",
	["lightning"] = "闪电",
	["eight_diagram:yes"] = "进行一次判定，若判定结果为红色，则视为你打出了一张【闪】",
	["slash-jink"] = "%src 使用了【杀】，请打出一张【闪】",
	["duel-slash"] = "%src 向您决斗，您需要打出一张【杀】",
	["savage-assault-slash"] = "%src 使用了【猛虎下山】，请打出一张【杀】来响应",
	["archery-attack-jink"] = "%src 使用了【万箭齐发】，请打出一张【闪】以响应",
	["collateral-slash"] = "%src 使用了【借刀杀人】，目标是 %dest，请打出一张【杀】以响应",
	["blade-slash"] = "您可以再打出一张【杀】发动青龙偃月刀的追杀效果",
	["double-sword-card"] = "%src 发动了日月霜刀特效，您必须弃置一张手牌或让 %src 摸一张牌",
	["@axe"] = "你可再弃置两张牌（包括装备）使此【杀】强制命中",
	["double_sword:yes"] = "您可以让对方选择自己弃置一张手牌或让你摸一张牌",
	["kylin_bow:yes"] = "弃掉对方的一匹马",
	["kylin_bow:dhorse"] = "防御马(+1马)",
	["kylin_bow:ohorse"] = "进攻马(-1马)",
	["#Slash"] = "%from 对 %to 使用了【杀】",
	["#Jink"] = "%from 使用了【闪】",
	["#AxeSkill"] = "%from 发动了【战神斧】的技能，弃置了两张牌令该【杀】依然对 %to 造成伤害",
	[":slash"] = "出牌时机：出牌阶段\
使用目标：除你外，你攻击范围内的一名角色\
作用效果：对目标角色造成1点伤害",
	[":jink"] = "出牌时机：以你为目标的【杀】开始结算时\
使用目标：以你为目标的【杀】\
作用效果：抵消目标【杀】的效果",
	[":peach"] = "出牌时机：1、出牌阶段；2、有角色处于濒死状态时\
使用目标：1、你；2、处于濒死状态的一名角色\
作用效果：目标角色回复1点体力",
	[":duel"] = "出牌时机：出牌阶段\
使用目标：除你外，任意一名角色\
作用效果：由目标角色先开始，你和他（她）轮流打出一张【杀】，【决斗】对首先不出【杀】的一方造成1点伤害；另一方成为此伤害的来源",
	[":dismantlement"] = "出牌时机：出牌阶段\
使用目标：除你外，任意一名角色\
作用效果：你选择并弃掉目标角色手牌（随机选择）、装备区或判定区里的一张牌",
	[":snatch"] = "出牌时机：出牌阶段\
使用目标：除你外，与你距离1以内的一名角色\
作用效果：你选择并获得目标角色手牌（随机选择）、装备区或判定区里的一张牌",
	[":archery_attack"] = "出牌时机：出牌阶段\
使用目标：除你外的所有角色\
作用效果：按行动顺序结算，除非目标角色打出1张【闪】，否则该角色受到【万箭齐发】对其造成的1点伤害",
	[":savage_assault"] = "出牌时机：出牌阶段\
使用目标：除你外的所有角色\
作用效果：按行动顺序结算，除非目标角色打出1张【杀】，否则该角色受到【猛虎下山】对其造成的1点伤害",
	[":god_salvation"] = "出牌时机：出牌阶段\
使用目标：所有角色\
作用效果：按行动顺序结算，目标角色回复1点体力",
	[":ex_nihilo"] = "出牌时机：出牌阶段\
使用目标：你\
作用效果：摸两张牌",
	[":amazing_grace"] = "出牌时机：出牌阶段\
使用目标：所有角色\
作用效果：你从牌堆顶亮出等同于现存角色数量的牌，然后按行动顺序结算，目标角色选择并获得这些牌中的一张",
	[":collateral"] = "出牌时机：出牌阶段\
使用目标：除你以外，装备区里有武器牌的一名角色A（你需要选择另一名A使用【杀】能攻击到的角色B）\
作用效果：A需对B使用一张【杀】，否则A必须将其装备区里的武器牌交给你",
	[":indulgence"] = "出牌时机：出牌阶段\
使用目标：除你外，任意一名角色\
作用效果：将【画地为牢】横置于目标角色判定区里，目标角色回合判定阶段，进行判定；若判定结果不为红桃，则跳过目标角色的出牌阶段，将【画地为牢】弃置",
	[":lightning"] = "【闪电】出牌时机：出牌阶段\
使用目标：你\
作用效果：将【闪电】横置于目标角色判定区里，目标角色回合判定阶段，进行判定；若判定结果为黑桃2-9之间（包括黑桃2和9），则【闪电】对目标角色造成3点伤害，将闪电弃置。若判定结果不为黑桃2-9之间（包括黑桃2和9），将【闪电】移动到当前目标角色下家（【闪电】的目标变为该角色）的判定区",
	[":nullification"] = "出牌时机：目标锦囊对目标角色生效前\
使用目标：目标锦囊\
作用效果：抵消该锦囊对其指定的一名目标角色产生的效果",
	[":crossbow"] = "攻击范围：１\
武器特效：出牌阶段，你可以使用任意数量的【杀】",
	[":double_sword"] = "攻击范围：２\
武器特效：你使用【杀】时，指定了一名异性角色后，在【杀】结算前，你可以令对方选择一项：自己弃置一张手牌或令你摸一张牌",
	[":qinggang_sword"] = "攻击范围：２\
武器特效：锁定技，每当你使用【杀】时，无视目标角色的防具",
	[":blade"] = "攻击范围：３\
武器特效：当你使用的【杀】被【闪】抵消时，你可以立即对相同的目标再使用一张【杀】",
	[":spear"] = "攻击范围：３\
武器特效：当你需要使用（或打出）一张【杀】时，你可以将两张手牌当一张【杀】使用（或打出）",
	[":axe"] = "攻击范围：３\
武器特效：当你使用的【杀】被【闪】抵消时，你可以弃置两张牌，令该【杀】依然造成伤害",
	[":halberd"] = "攻击范围：４\
武器特效：当你使用的【杀】是你的最后一张手牌时，你可以为这张【杀】指定至多三名目标角色，然后按行动顺序依次结算之",
	[":kylin_bow"] = "攻击范围：５\
武器特效：你使用【杀】对目标角色造成伤害时，你可以弃掉其装备区里的一匹马",
	[":eight_diagram"] = "防具效果：每当你需要使用（或打出）一张【闪】时，你可以进行一次判定：若结果为红色，则视为你使用（或打出）了一张【闪】；若为黑色，则你仍可从手牌里使用（或打出）。",
	[":-1 horse"] = "你计算与其他角色的距离时，始终-1。（你可以理解为一种进攻上的优势）不同名称的-1马，其效果是相同的",
	[":+1 horse"] = "其他角色计算与你的距离时，始终+1。（你可以理解为一种防御上的优势）不同名称的+1马，其效果是相同的",
-- ex
	["ex_cards"] = "EX卡牌包",
	["ice_sword"] = "七星剑",
	[":ice_sword"] = "攻击范围：２\
武器特效：当你使用【杀】造成伤害时，你可以防止此伤害，改为弃掉目标角色的两张牌",
	["ice_sword:yes"] = "您可以弃掉其两张牌",
	["renwang_shield"] = "三重铠",
	[":renwang_shield"] = "防具效果：锁定技，黑色的【杀】对你无效",

-- test
	["#_ubuntenkei"] = "百撕不得",
	["ubuntenkei"] = "宇文天启",
	["designer:ubuntenkei"] = "宇文天启",
	["cv:ubuntenkei"] = "山新",
	["coder:ubuntenkei"] = "宇文天启 [测试专用]",
	["ubuna"] = "调参",
	[":ubuna"] = "出牌阶段，你可以重新设定自己的体力上限",
	["ubunb"] = "排次",
	[":ubunb"] = "出牌阶段，你可以交换两名角色的座次",
	["ubunc"] = "归类",
	[":ubunc"] = "出牌阶段，你可以更改一名角色的势力",
	["ubund"] = "复制",
	[":ubund"] = "出牌阶段，你可以获得一名其他角色的任一技能",
	["ubune"] = "分赃",
	[":ubune"] = "出牌阶段，你可以将装备牌放到任意角色的装备区内，将延时锦囊放到任意角色的判定区内。判定阶段判定前，你可以和一名其他角色交换判定区里的所有牌",
	["ubunf"] = "不灭",
	[":ubunf"] = "当你濒死时，可以原地复活状态全满。非正常死亡对你无效\
★非正常死亡，指的是被武魂、被鸩杀等",
	["ubuna:next"] = "增加1点体力上限",
	["ubuna:back"] = "减少1点体力上限",
	["qiapai"] = "卡位",
	[":qiapai"] = "利用BUG，卡住你的一张牌以达到无限使用的目的",
	["$ubuna"] = "怎、怎么了吗？",
	["$ubunc"] = "干嘛啦",
	["$ubund"] = "……不、不可以的……",
	["$ubune1"] = "去学习了吗，要用功啊",
	["$ubune2"] = "刚回家就玩电脑？",
	["$ubunf"] = "去死吧变态！",
	["~ubuntenkei"] = "嗯？不要啊……",

	["#_jiuweigui"] = "陶宗旺",
	["jiuweigui"] = "九尾龟",
	["qiaog"] = "初代巧工",
	[":qiaog"] = "<b>锁定技</b>，若某一种类的装备牌只有一张在场上，则视为你装备着该装备。\
★警告：因初代巧工技能有严重的bug，极容易导致程序崩溃，所以此武将仅供测试和学习",

	["#_zhuanjia"] = "纵横天下",
	["zhuanjia"] = "砖家叫兽",
	["fandui"] = "反对",
	[":fandui"] = "出牌阶段，你可以获得任意角色移出游戏的一张牌。",
}

local ohorses = {"chitu", "snow", "white", "brown"}
local dhorses = {"silver", "kirin", "lhh", "momohana", "jade"}

for _, horse in ipairs(ohorses) do
	t[":" .. horse] = t[":-1 horse"]
end

for _, horse in ipairs(dhorses) do
	t[":" .. horse] = t[":+1 horse"]
end

return t