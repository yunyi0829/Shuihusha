-- QiluoFendai Shuihusha part plus.

return {
	["QLFD"] = "绮罗粉黛",

	["#_panjinlian"] = "墙头杏",
	["panjinlian"] = "潘金莲",
	["yushui"] = "鱼水",
	[":yushui"] = "出牌阶段，你可弃置一张红桃牌并指定一名已受伤的男性角色：你和该角色各回复1点体力，各摸两张牌并将各自的武将牌翻面。每回合限一次。",
	["zhensha"] = "鸩杀",
	[":zhensha"] = "限定技，当其他角色使用【酒】时（在结算前），你可以弃置一张黑桃手牌，令该角色立即死亡。",
	["#Zhensha"] = "%from 发动了技能【%arg】，%to 一命归西",
	["@zhensha"] = "%src 使用了【酒】，你可以趁机弃置一张黑桃手牌，将其毒死。",
	["@vi"] = "鸩酒",
	["shengui"] = "深闺",
	[":shengui"] = "锁定技，若你的武将牌背面朝上，你不能成为男性角色使用锦囊的目标。",
	["$zhensha"] = "永别了，亲爱的……",

	["#_panqiaoyun"] = "水性杨花",
	["panqiaoyun"] = "潘巧云",
	["cv:panqiaoyun"] = "梁小啾「御」",
	["designer:panqiaoyun"] = "烨子&大Ｒ",
	["fanwu"] = "反诬",
	[":fanwu"] = "每当你对其他角色造成伤害时，你可以交给任一男性角色一张牌，令该角色视为该伤害的来源。",
	["@fanwu"] = "你可以发动【反诬】，交给任一男性角色一张牌，令该角色视为本次伤害的来源。",
	["panxin"] = "叛心",
	[":panxin"] = "<font color=purple><b>限定技</b></font>，当其他角色死亡时，若你和该角色均不为主公，你可以和该角色交换身份牌，然后你摸一张牌。",
	["@pfxl"] = "水花",
	["foyuan"] = "佛缘",
	[":foyuan"] = "<b>锁定技</b>，装备区里没有牌的男性角色使用的【杀】和非延时类锦囊对你无效。",
	["#Foyuan"] = "%to 的锁定技【%arg2】被触发，%from 对 %to 的 %arg 无效",
	["$fanwu1"] = "你当他是正人君子？",
	["$fanwu2"] = "是叔叔轻薄了我。",
	["$panxin"] = "跟我师兄一夜，胜于跟你十年！",
	["$foyuan1"] = "待我血盆还愿。",
	["$foyuan2"] = "佛牙可否借妹妹一观。",
	["unknown"] = "未知",
	
	["#_wangpo"] = "枯藤蔓",
	["wangpo"] = "王婆",
	["cv:wangpo"] = "九辨（重华剧社）",
	["qianxian"] = "牵线",
	[":qianxian"] = "出牌阶段，你可以弃置一张黑色非延时锦囊，指定两名体力上限不相等的其他角色。若其交给你一张梅花手牌，则将其武将牌翻至正面向上，并重置之，否则将其武将牌翻至背面向上，并横置之。每回合限一次。",
	["@qianxian"] = "%src 对你发动了【牵线】，请给她一张梅花手牌",
	["meicha"] = "梅茶",
	[":meicha"] = "你可以将任一梅花手牌当【酒】使用。",
	["$qianxian1"] = "吃个‘和合汤’如何？",
	["$qianxian2"] = "这事交给干娘我了。",
	["$meicha1"] = "我这茶别有风味。",
	["$meicha2"] = "好个“宽煎叶儿茶”。",

	["#_linniangzi"] = "腊梅傲雪",
	["linniangzi"] = "林娘子",
	["cv:linniangzi"] = "蒲小猫",
	["shouwang"] = "守望",
	[":shouwang"] = "出牌阶段，你可以将一张【杀】交给任一男性角色，然后你摸一张牌或令该角色摸一张牌。每回合限一次。",
	["shouwang:tian"] = "心中有他~",
	["shouwang:zi"] = "做回自我~",
	["ziyi"] = "自缢",
	[":ziyi"] = "<font color=purple><b>限定技</b></font>，出牌阶段，若你已受伤，你可以令任一已受伤的男性角色回复2点体力，然后你立即死亡。",
	["@ziyi"] = "尼龙绳",
	["zhongzhen"] = "忠贞",
	[":zhongzhen"] = "每当你受到男性角色造成的伤害时，你可以和该角色拼点。若你赢，防止该伤害。",
	["#Zhongzhen"] = "%from 对 %to 造成的 %arg 点伤害被抵消",
	["$shouwang1"] = "官人（哭声）。",
	["$shouwang2"] = "待来年春时，与君一叙。",
	["$ziyi"] = "官人，恕我先走一步。",
	["$zhongzhen1"] = "怎可这般无礼？",
	["$zhongzhen2"] = "你若再上前一步，我便跳下去。",

	["#_duansanniang"] = "大虫窝",
	["duansanniang"] = "段三娘",
	["cv:duansanniang"] = "南宫泓「御」",
	["zishi"] = "自恃",
	[":zishi"] = "任意男性角色的摸牌阶段开始时，你可以弃置至多两张黑色牌，令该角色在其摸牌阶段多摸或少摸等量的牌。",
	["@zishi"] = "你可以弃置至多两张黑色牌来发动【自恃】，令 %src 多摸或少摸等量的牌。",
	["duo"] = "多摸",
	["shao"] = "少摸",
	["#Zishi"] = "%from 令 %to %arg2了 %arg 张牌",
	["$zishi1"] = "老娘替你做主了！",
	["$zishi2"] = "原银在此，将了去！",

	["#_baixiuying"] = "白罂粟",
	["baixiuying"] = "白秀英",
	["cv:baixiuying"] = "蒲小猫",
	["designer:baixiuying"] = "烨子&大Ｒ",
	["eyan"] = "恶言",
	[":eyan"] = "出牌阶段，你可以指定一名你在其攻击范围内的男性角色，该角色选择一项：1.对你使用一张【杀】；2.你可以对其使用任意数量的【杀】直到回合结束。",
	["@eyan"] = "%src 对你发动了【恶言】，你可以对其使用一张【杀】，否则 %src 可以对你使用不限次数的【杀】直到回合结束",
	["eyanslash"] = "骂街",
	[":eyanslash"] = "你可以对【恶言】目标使用任意张【杀】直到回合结束",
	["zhangshi"] = "仗势",
	[":zhangshi"] = "每当你需要使用或打出一张【杀】时，你可以令任意男性角色打出一张【杀】（视为由你使用或打出）。",
	["@zhangshi-slash"] = "%src 发动了【仗势】，请打出一张【杀】响应之",
	["$eyan1"] = "今天定要把你号令在勾栏门首！",
	["$eyan2"] = "好个不晓事的东西！",
	["$zhangshi1"] = "你要替我做主啊～",
	["$zhangshi2"] = "可不能轻饶了他！",

	["#_liruilan"] = "吊兰",
	["liruilan"] = "李瑞兰",
	["cv:liruilan"] = "鬼心（⑤品倦客）",
	["designer:liruilan"] = "烨子&大Ｒ",
	["chumai"] = "出卖",
	[":chumai"] = "你的回合外，每当一名男性角色的武器牌或防具牌因弃置进入弃牌堆时，你可以弃置一张黑色手牌，令该角色失去1点体力。",
	["@chumai"] = "你可以发动【出卖】，弃置一张黑色手牌令 %src 失去1点体力",
	["yinlang"] = "引郎",
	[":yinlang"] = "出牌阶段，你可以将你手牌中任意数量的装备牌交给任意男性角色，若你以此法给出的武器牌或防具牌张数达到一张或更多时，你回复1点体力。",
	["$chumai1"] = "奴家胆小，只得如此。",
	["$chumai2"] = "只有拿了你去，免的日后负累。",
	["$yinlang1"] = "恁久才来与我一会。",
	["$yinlang2"] = "大郎，近来可好？",

-- last words	
	["~panqiaoyun"] = "一了百了～",
	["~wangpo"] = "死到眼前，犹做发财梦～",
	["~linniangzi"] = "官人，就此～别过！",
	["~duansanniang"] = "大王！我，此生无悔！",
	["~baixiuying"] = "谁都帮不了我了～",
	["~liruilan"] = "虔～婆～害～我！",
}
