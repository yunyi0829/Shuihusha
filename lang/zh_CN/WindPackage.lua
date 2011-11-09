-- translation for WindPackage

return {
	["wind"] = "其疾如风",
	
	["kisakieri"] = "妃英理",
	["bianhu"] = "辩护",
	[":bianhu"] = "在任意角色的锦囊生效前，你可以打出一张相同花色的手牌，来改变这张锦囊的目标",
	["@bianhu"] = "%src 使用了花色为 %arg 的锦囊，你可以弃掉一张同花色手牌来发动【辩护】", 
	["fenju"] = "分居",
	[":fenju"] = "弃牌阶段弃牌后，你可以指定一名男性角色，摸取和你弃牌数相同数量的手牌",
	
	["kujoureiko"] = "九条玲子",
	["fating"] = "法庭",
	[":fating"] = "任意一名角色的判定牌生效前，你可以用自己的一张基本牌替换之",
	["rougu"] = "柔骨",
	[":rougu"] = "锁定技，当你的手牌数不大于体力上限时，自动跳过弃牌阶段；当手牌数小于体力上限时，不能成为【顺手牵羊】和【过河拆桥】的目标；当手牌数大于体力上限时，你不能成为【乐不思蜀】和【兵粮寸断】的目标",
	
	["kojimagenta"] = "小岛元太",
	["manyu"] = "鳗鱼",
	[":manyu"] = "回合开始阶段，若你已受伤，可以从牌堆里抽出一张牌，若为黑桃，你回复一点体力，否则将其交给其他角色",
	["bantu"] = "斑秃",
	[":bantu"] = "锁定技，你的【杀】必须打出一张非基本牌才能抵消",
	["#BantuEffect"] = "%from 的锁定技【%arg】生效，%to 必须用非基本牌来响应",
	["bantu-jink"] = "%src 拥有【斑秃】技能，您必须打出一张非基本牌来抵消这张【杀】", 
	["tuanzhang"] = "团长",
	[":tuanzhang"] = "主公技，少势力角色可以随时对任意少势力角色使用【桃】\
★团长是场景效果，回合外可以用桃给非濒死角色加一点体力",
	["tuanzhangv"] = "团长令",

	["heiji"] = "服部平次",
	["nijian"] = "逆剑",
	[":nijian"] = "当你因【杀】或【决斗】受到伤害时，可以弃一张和该伤害牌相同花色的手牌，视为将此次伤害转移给【杀】或【决斗】的伤害来源",
	["@nijian"] = "你可以发动【逆剑】弃掉一张 %arg 花色的手牌，将这次伤害转移给 %src", 

	["okidasouji"] = "冲田总司",
	["zhenwu"] = "真武",
	[":zhenwu"] = "若你选择跳过摸牌阶段或出牌阶段，可以规定在你下个回合开始之前：（二选一）1.所有人不能使用黑色【杀】；2.所有人不能使用黑色非延时锦囊",
	["zhenwu:slash"] = "封印黑色的【杀】",
	["zhenwu:ndtrick"] = "封印黑色的非延时锦囊",

	["suzukisonoko"] = "铃木园子",
	["huachi"] = "花痴",
	[":huachi"] = "弃牌阶段弃牌前，若你的手牌数不小于3，可以指定一名男性角色，将所有手牌交给对方，此时开始直到目标角色下次行动结束时，称为花痴有效期",
	["@huachi"] = "你可以发动【花痴】，请指定一名男性角色",
	["huhua"] = "护花",
	[":huhua"] = "锁定技，在花痴指定后的有效期内，对自己的一切伤害都由对方承担",
	["@flower"] = "花",
	["#Huhua"] = "%from 的技能【护花】生效，护花使者 %to 为 %from 承担了 %arg 点伤害[%arg2]",

	["okinoyouko"] = "冲野洋子",
	["ouxiang"] = "偶像",
	[":ouxiang"] = "回合开始阶段，你可以选择摸X张牌，X为你当前体力值，若如此做，立刻中止本回合",
	["#SkipAllPhase"] = "%from 中止了当前回合",
	["qingchun"] = "青春",
	[":qingchun"] = "觉醒技，回合结束阶段，你获得一枚青春标记；当你的青春标记达到5个时，永久失去偶像和青春技能",
	["@qingchun"] = "青春",
	["#Qingchun"] = "%from 的青春标记达到了 %arg 个，觉醒技【%arg2】触发，以后将无法发动【偶像】和【青春】技能",

	["hattoriheizou"] = "服部平藏",
	["yunchou"] = "运筹",
	[":yunchou"] = "单发技，你给其他角色一张牌，到你下回合开始时，该角色使用和此牌同类型的牌（基本、装备、锦囊）时无效",
	["#YunchouEffect"] = "%from 受到【%arg】影响，结算被中止",
	["#Yunchou"] = "%from 使用了【%arg2】，%to 的 %arg 统统变成了废牌",
	["weiwo"] = "帷幄",
	[":weiwo"] = "回合外，你每失去一张手牌，可以做一次判定，若判定牌和你失去的牌是同一类型，你获得此判定牌",
	["lingjia"] = "凌驾",
	[":lingjia"] = "主公技，当场上有人使用【桃】且无人濒死，在生效前，你可以用相同点数的手牌替换之，并交给其他警势力或侦势力角色",
	["@lingjia"] = "%src 使用了【桃】，你可以弃掉一张 %arg 点数的手牌获得这张【桃】",

	["touyamaginshirou"] = "远山银司郎",
	["yinsi"] = "银司",
	[":yinsi"] = "在场上发生伤害事件时，你可以选择：1.对受到伤害的角色使用【桃】；2.若在攻击范围内，你可以弃一张装备牌，视为对受到伤害的角色使用了一张【火杀】",
	["yinsi:friend"] = "对受伤角色使用桃",
	["yinsi:enemy"] = "对受伤角色落井下石",
	["yinsi:cancel"] = "不发动",
	["@yinsi-friend"] = "%src 受到了伤害，你可以立即送一个【桃】给他吃",
	["@yinsi-enemy"] = "%src 受到了伤害，你可以弃掉一张装备牌，视为对其使用一张【火杀】",

	["nakamoriginzou"] = "中森银三",
	["weijiao"] = "围剿",
	[":weijiao"] = "判定阶段，你可以放弃判定，指定两名角色拼点，成功一方对失败一方造成一点伤害",
	["@weijiao-card"] = "你可以发动【围剿】，指定两名角色进行拼点",
	["@weijiao-ask"] = "你即将和 %src 拼点，请展示一张手牌",
	["shiyi"] = "拾遗",
	[":shiyi"] = "发动围剿后，可以选择跳过摸牌阶段，从弃牌堆回收那两张拼点牌",

	["vermouth"] = "贝尔摩德",
	["weixiao"] = "微笑",
	[":weixiao"] = "单发技，你可以弃掉一张牌并指定一名男性角色，该角色在其下个回合内对其他角色使用【杀】或【决斗】造成的伤害+1",
	["kuai"] = "苦艾",
	[":kuai"] = "主公技，黑势力角色每造成一点伤害，你可以摸一张牌",

	["jodie"] = "茱蒂",
	["araidetomoaki"] = "新出智明",
	["tomesan"] = "登米",
	
	["buqu"] = "不屈", 
	[":buqu"] = "任何时候，当你的体力被扣减到0或更低时，每扣减1点体力：从牌堆亮出一张牌放在你的武将牌上，若该牌的点数与你武将牌上已有的任何一张牌都不同，你可以不死。此牌亮出的时刻为你的濒死状态", 
	["buqu:alive"] = "我还想活",
	["buqu:dead"] = "我不想活了",
	
	["jushou:yes"] = "摸三张牌，若如此做，并将你的武将翻面", 
	["@shensu1"] = "跳过该回合的判定阶段和摸牌阶段, 视为对任意一名角色使用了一张【杀】", 
	["@shensu2"] = "跳过该回合出牌阶段并弃一张装备牌视为对任意一名角色使用了一张【杀】", 
	["$huangtian1"] = "苍天已死，黄天当立", 
	["$huangtian2"] = "岁在甲子，天下大吉", 
	["$jushou1"] = "我先休息一会", 
	["$jushou2"] = "尽管来吧", 
	["$leiji1"] = "以我之真气，合天地之造化", 
	["$leiji2"] = "雷公助我", 
	["$liegong1"] = "百步穿杨", 
	["$liegong2"] = "中！", 
	["$shensu1"] = "吾善于千里袭人", 
	["$shensu2"] = "取汝首级犹如探囊取物", 
	["$buqu1"] = "还不够！", 
	["$buqu2"] = "我绝不会倒下！", 
	["$kuanggu"] = "哈哈",
	["shensu"] = "神速", 
	[":shensu"] = "你可以分别作出下列选择：\
1、跳过该回合的判定阶段和摸牌阶段\
2、跳过该回合出牌阶段并弃一张装备牌\
你每做出上述之一项选择，视为对任意一名角色使用了一张【杀】", 
	[":jushou"] = "回合结束阶段，你可以摸三张牌，若如此做，将你的武将翻面", 
	[":liegong"] = "出牌阶段，以下两种情况，你可以令你使用的【杀】不可被闪避：1、目标角色的手牌数大于或等于你的体力值。2、目标角色的手牌数小于或等于你的攻击范围\
★攻击范围计算只和武器有关，与+1马-1马无关", 
	[":kuanggu"] = "锁定技，任何时候，你每对与你距离1以内的一名角色造成1点伤害，你回复1点体力", 
	[":guidao"] = "在任意一名角色的判定牌生效前，你可以用自己的一张【黑桃】或【梅花】牌替换之", 
	[":leiji"] = "每当你使用或打出一张【闪】时（在结算前），可令任意一名角色判定，若为【黑桃】，你对该角色造成2点雷电伤害", 
	[":huangtian"] = "主公技，群雄角色可在他们各自的回合里给你一张【闪】或【闪电】", 
	["liegong:yes"] = "此【杀】不可闪避", 
	
	["@guidao-card"] = "请使用【鬼道】技能来修改 %src 的 %arg 判定",
	["#BuquDuplicate"] = "%from 不屈失败，因为其不屈牌中有 %arg 组重复点数",
	["#BuquDuplicateGroup"] = "第 %arg 组重复点数为 %arg2",
	["$BuquDuplicateItem"] = "不屈重复牌: %card",	
	
	-- last words
	["~caoren"] = "实在是守不住了……",
	["~xiahouyuan"] = "竟然比我还……快……",
	["~huangzhong"] = "不得不服老了……",
	["~weiyan"] = "谁敢杀我！啊……",
	["~xiaoqiao"] = "公瑾……我先走一步……",
	["~zhoutai"] = "已经尽力了……",
	["~zhangjiao"] = "黄天…也死了……",
}
