-- TitianXingDao Shuihusha part 4.

return {
	["BWQZ"] = "博闻强识",

	["#_houjian"] = "通臂猿",
	["houjian"] = "侯健",
	["designer:houjian"] = "宇文天启",
	["yuanyin"] = "援引",
	[":yuanyin"] = "你可以将其他角色装备区里的武器当【杀】、非武器当【闪】使用或打出",
	["yuanyin:slash"] = "你想发动技能【援引·杀】吗？",
	["yuanyin:jink"] = "你想发动技能【援引·闪】吗？",

	["#_mengkang"] = "玉幡竿",
	["mengkang"] = "孟康",
	["zaochuan"] = "造船",
	[":zaochuan"] = "出牌阶段，你可以将你的任一锦囊牌当【铁索连环】使用或重铸。",
	["mengchong"] = "艨艟",
	[":mengchong"] = "<b>锁定技</b>，武将牌未处于横置状态的角色计算与武将牌处于横置状态的角色的距离时，始终+1。",
	["$zaochuan1"] = "能攀强弩冲头阵，善造艨艟越大江。",
	["$zaochuan2"] = "楼船林立，可挡朝廷千军万马。",

	["#_jiaoting"] = "没面目",
	["jiaoting"] = "焦挺",
	["designer:jiaoting"] = "宇文天启",
	["qinlong"] = "擒龙",
	[":qinlong"] = "若你的装备区没牌：你使用【杀】时可以额外指定一名其他角色；出牌阶段可以使用任意数量的【杀】",
	["$qinlong1"] = "都出局吧！",
	["$qinlong2"] = "三十六路擒龙手！",

	["#_shantinggui"] = "圣水将",
	["shantinggui"] = "单廷珪",
	["designer:shantinggui"] = "宇文天启",
	["xiaofang"] = "消防",
	[":xiaofang"] = "当场上出现火焰伤害时，你可以弃掉一张手牌，将其改为无属性伤害",
	["#Xiaofang"] = "%from 发动了技能【%arg】，消除了 %to 受到伤害的火焰属性",
	["shuizhan"] = "水战",
	[":shuizhan"] = "锁定技，其他角色计算相互距离时，跳过你",

	["#_qingzhang"] = "菜园子",
	["qingzhang"] = "张青",
	["shouge"] = "收割",
	[":shouge"] = "出牌阶段，你可以将一张【肉】或【酒】置于你的武将牌上，称为“菜”；你的回合外，你每失去一张手牌或流失1点体力，可以将一张“菜”移入弃牌堆，然后摸三张牌。",
	["vege"] = "菜",
	["qiongtu"] = "穷途",
	[":qiongtu"] = "其他角色的回合结束时，若该角色的手牌数不大于1，你可以获得该角色的一张牌。",
	["$shouge1"] = "没有耕耘，哪来收获？",
	["$shouge2"] = "一粒种子，就是一个春天。",
	["$shouge3"] = "又是一年秋收时节。",
	["$shouge4"] = "好一片麦田！", 
	["$qiongtu1"] = "哼，你这穷鬼，还要这些作甚？",
	["$qiongtu2"] = "这里就是张家店，客官，里边请！",

	["#_kongliang"] = "独火星",
	["kongliang"] = "孔亮",
	["designer:kongliang"] = "烨子&凌天翼",
	["nusha"] = "怒杀",
	[":nusha"] = "出牌阶段，你可以弃置一张【杀】，对除你以外手牌数最多的一名角色造成1点伤害。每回合限一次。",
	["wanku"] = "纨绔",
	[":wanku"] = "回合结束阶段，你可以将手牌补至你当前体力值的张数。每回合限一次。",
	["$nusha1"] = "你这厮是吃了熊心豹子胆了！",
	["$nusha2"] = "家财万贯安能保住你性命？！",
	["$wanku1"] = "吾出身富家，性喜玩乐。",
	["$wanku2"] = "鼠目寸光，如何了却我的心思？！",

	["#_jiashi"] = "毒蔷薇",
	["jiashi"] = "贾氏",
	["cv:jiashi"] = "呼呼",
	["coder:jiashi"] = "凌天翼",
	["banzhuang"] = "半妆",
	[":banzhuang"] = "出牌阶段，你可以将你的任一红桃手牌当【无中生有】使用",
	["$banzhuang1"] = "一顾倾人城，再顾倾人国。",
	["$banzhuang2"] = "虚事难入公门，实事难以抵对。",
	["zhuying"] = "朱樱",
	[":zhuying"] = "<b>锁定技</b>，你的【酒】均视为【肉】。",
	["$zhuying1"] = "奴家这厢有礼了～",
	["$zhuying2"] = "奴家不胜酒力，浅饮一杯，聊表敬意。",

	["#_taozongwang"] = "九尾龟",
	["taozongwang"] = "陶宗旺",
	["qiaogong"] = "巧工",
	[":qiaogong"] = "出牌阶段，你可以选择两名角色，交换他们装备区里的所有牌。以此法交换的装备牌数差不能超过X（X为你已损失的体力值）。每回合限一次。",
	["#QiaogongSwap"] = "%from 交换了 %to 之间的装备",
	["manli"] = "蛮力",
	[":manli"] = "出牌阶段，当你使用【杀】或【决斗】对其他角色造成伤害时，若你已装备了武器和防具，则你可以令该伤害+1。",
	["#ManliBuff"] = "%from【蛮力】爆发，对 %to 的伤害从 %arg 点上升至 %arg2 点",

-- last words
	["~mengkang"] = "火炮突袭，快撤！",
	["~jiaoting"] = "绝技不复代代相传矣！",
	["~jiashi"] = "员外，饶了奴家吧～",
	["~qingzhang"] = "日头落了。",
	["~kongliang"] = "吾不识水性啊！",

	["#_guansheng"] = "大刀",
	["guansheng"] = "关胜",
}
