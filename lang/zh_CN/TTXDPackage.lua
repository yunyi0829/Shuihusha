-- TitianXingDao Shuihusha part 3.

return {
	["TTXD"] = "替天行道",

	["#_songjiang"] = "呼保义",
	["songjiang"] = "宋江",
	["designer:songjiang"] = "烨子&凌天翼",
	["coder:songjiang"] = "宇文天启、凌天翼",
	["ganlin"] = "甘霖",
	[":ganlin"] = "出牌阶段，你可以将任意数量的手牌以任意分配方式交给其他角色。若如此做，你可以将手牌补至X张，X为你已损失的体力值(补牌之后,将不能再次发动本技能)",
	["juyi"] = "聚义",
	[":juyi"] = "主公技，其他寇势力角色可在他们各自的出牌阶段与你交换一次手牌（可拒绝）。",
	["jui"] = "聚义换牌",
	["$ganlin1"] = "扶危济困，急人所难。",
	["$ganlin2"] = "在下正是山东及时雨宋公明。",
	["$juyi1"] = "替天行道！",
	["$juyi2"] = "我等上应天星，合当聚义。",

	["#_lujunyi"] = "玉麒麟",
	["lujunyi"] = "卢俊义",
	["baoguo"] = "报国",
	[":baoguo"] = "每当其他角色受到伤害时,你可以弃置一张牌,将此伤害转移给你;你每受到一次伤害,可以摸X张牌,X为你已损失的体力值.",
	["$baoguo1"] = "大丈夫为国尽忠,死而无憾!",
	["$baoguo2"] = "与其坐拥金山,不如上阵杀敌!",

	["#_chaijin"] = "小旋风",
	["chaijin"] = "柴进",
	["designer:chaijin"] = "烨子&小花荣",
	["danshu"] = "丹书",
	[":danshu"] = "<b>锁定技</b>,当其他角色使用【杀】指定你为目标时,须额外弃置X张手牌,X为你已损失的体力值,否则该【杀】对你无效.",
	["haoshen"] = "豪绅",
	[":haoshen"] = "你可以跳过你的摸牌阶段,令任一其他角色将手牌补至其体力上限的张数;\
        你可以跳过你的出牌阶段,将一半的手牌（向上取整）交给任一其他角色.",
	["@haoshen"] = "请选择一半的手牌（向上取整）,然后点击[确定]",
	["$danshu1"] = "丹书铁券在此,刀斧不得加身!",
	["$danshu2"] = "御赐丹书铁券,可保祖孙三代!",
	["$haoshen1"] = "兄弟有难,必当拔刀相助！",
	["$haoshen2"] = "吾好结交天下各路英雄。",
	["$haoshen3"] = "碎银铺路,富贵如云。",
	["$haoshen4"] = "既是兄弟,理应有福同享。",

	["#_zhangqing"] = "没遇见",
	["zhangqing"] = "张清",
	["yinyu"] = "饮羽",
	["yinyu_heart"] = "石影",
	[":yinyu_heart"] = "<b>锁定技</b>,若“饮羽”的判定结果为<b><font color = 'red'>♥</font></b>,你的攻击范围无限.",
	[":yinyu"] = "—回合开始阶段,你可以进行一次判定,获得与判定结果对应的一项技能直到回合结束：\
	<b><font color = 'red'>♥</font></b>~攻击范围无限;\
	<b><font color = 'red'>♦</font></b>~使用的【杀】不可被闪避;\
	♠~可使用任意数量的【杀】;\
	♣~无视其他角色的防具.",
	["@yinyu_heart"] = "请使用一张【杀】",
	["@yinyu_spade"] = "请使用一张【杀】",
	["$yinyu1"] = "飞蝗如雨,看尔等翻成画饼!",
	["$yinyu2"] = "飞石连伤,休想逃跑!",
	["$yinyu3"] = "叫汝等饮羽沙场吧!",
	["$yinyu4"] = "此等破铜烂铁岂能挡我!",
	["$yinyu5"] = "看你马快,还是我飞石快!",

	["#_yuehe"] = "铁叫子",
	["yuehe"] = "乐和",
	["yueli"] = "乐理",
	[":yueli"] = "若你的判定牌为基本牌，在其生效后可以获得之。",
	["yueli:yes"] = "拿屎", 
	["yueli:no"] = "不拿屎", 
	["taohui"] = "韬晦",
	[":taohui"] = "回合结束阶段，你可以进行一次判定：若结果不为基本牌，你可以令任一角色摸一张牌，并可以再次使用“韬晦”，直到出现基本牌或你不想判定了为止.",
	["$yueli1"] = "呵呵～",
	["$yueli2"] = "且慢,音律有误。",
	["$taohui1"] = "白云起,郁披香;离复合,曲未央。",
	["$taohui2"] = "此曲只应天上有,人间哪得几回闻。",

	["#_muhong"] = "没遮拦",
	["muhong"] = "穆弘",
	["wuzu"] = "无阻",
	[":wuzu"] = "<b>锁定技</b>,你始终无视其他角色的防具.",
	["huqi"] = "虎骑",
	[":huqi"] = "<b>锁定技</b>,当你计算与其他角色的距离时,始终-1.",
	["$wuzu1"] = "谁敢拦我?",
	["$wuzu2"] = "游击部,冲!",

	["#_zhoutong"] = "小霸王",
	["zhoutong"] = "周通",
	["qiangqu"] = "强娶",
	[":qiangqu"] = "当你使用【杀】对已受伤的女性角色造成伤害时,你可以防止此伤害,改为获得该角色的一张牌若如此做,你和她各回复1点体力.",
	["#qiangqu"] = "%from硬是把%arg拉入了洞房",
	["huatianai"] = "花田·爱",
	[":huatianai"] = "你每受到1点伤害,可以令任一已受伤的其他角色回复1点体力.",
	["huatiancuo"] = "花田·错",
	[":huatiancuo"] = "你每回复1点体力,可以对任一其他角色造成1点伤害.",
	["#huatianai"] = "%from与%arg爱来爱去,死去活来",
	["#huatiancuo"] = "%arg嘤咛一声倒在了花田中,看样子是中了情毒",
	["$qiangqu1"] = "小娘子,春宵一刻值千金啊!",
	["$qiangqu2"] = "今夜,本大王定要做新郎!",
	["$huatianai1"] = "无妨,只当为汝披嫁纱！",
	["$huatianai2"] = "只要娘子开心,怎样都好！",
	["$huatiancuo1"] = "破晓之前,忘了此错。",
	["$huatiancuo2"] = "无心插柳,岂是花田之错？",

	["#_qiaodaoqing"] = "幻魔君",
	["qiaodaoqing"] = "乔道清",
	["huanshu"] = "幻术",
	[":huanshu"] = "你每受到1点伤害,可以令任一其他角色连续进行两次判定:\
        若结果均为<b><font color = 'red'>红色</font></b>,你对其造成2点火焰伤害;\
        若结果均为黑色,你对其造成2点雷电伤害.",
	["mozhang"] = "魔障",
	[":mozhang"] = "<b>锁定技</b>,你的回合结束时,若你未处于横置状态,你须横置你的武将牌.",
	["#huanshufire"] = "%arg受到%from的技能“<b><font color = 'red'>幻术</font></b>”的影响,仿佛置身于火海之中",
	["#huanshuthunder"] = "%arg受到%from的技能“<b><font color = 'red'>幻术</font></b>”的影响,尝到了五雷轰顶的滋味",
	["#huanshufailed"] = "%from发动了技能“<b><font color = 'red'>幻术</font></b>”,结果却连个屁声都听不到",
	["#mozhang"] = "%from的技能“<b><font color = 'yellow'>魔障</font></b>”被触发,%from进入连环状态",
	["$huanshu1"] = "沙石一起,真假莫辨!",
	["$huanshu2"] = "五行幻化,破!",
	["$huanshu3"] = "五雷天心,五雷天心,缘何不灵?",
	["$mozhang"] = "外道之法,也可乱心?",

	["#_andaoquan"] = "伪神医",
	["andaoquan"] = "安道全",
	["shsjishi"] = "济世",
	[":shsjishi"] = "任意角色的回合开始时,若该角色已受伤,你可以弃置一张手牌,令其回复1点体力.",
	["yanshou"] = "延寿",
	[":yanshou"] = "<b>限定技</b>,出牌阶段,你可以弃置两张<b><font color = 'red'>♥</font></b>牌,令任一角色增加1点体力上限.",
	["fengyue"] = "风月",
	[":fengyue"] = "回合结束阶段,你可以摸X张牌,X为场上存活的女性角色数且至多为2.每回合限一次.",
	["$yanshou"] = "助你延寿十年!",
	["$shsjishi1"] = "祖传内科外科尽皆医得。",
	["$shsjishi2"] = "回春之术!",
	["$fengyue1"] = "一生风月供惆怅。",
	["$fengyue2"] = "活色生香伴佳人。",

	["#_gongsunsheng"] = "入云龙",
	["gongsunsheng"] = "公孙胜",
	["yixing"] = "移星",
	[":yixing"] = "在任意角色的判定牌生效前,你可以用任一角色装备区里的一张牌替换之(替换后,该角色将获得该判定牌).",
	["qimen"] = "奇门",
	[":qimen"] = "任意角色的回合开始时,你可以令任一角色进行一次判定,若你弃置一张与该判定牌相同花色的手牌,则该角色不能发动当前的所有技能直到回合结束.",
	["@qimen"] = "请弃置一张与判定牌相同花色的手牌,然后点击[确定]",
	["#qimen"] = "%from的技能“<b><font color = 'blue'>奇门</font><b>”被触发,%arg不能发动当前的所有技能直到回合结束",
	["#qimenend"] = "“<b><font color = 'blue'>奇门</font><b>”的作用失效,%arg仿佛获得了重生",
	["$yixing1"] = "天命有旋转,地星而应之。",
	["$yixing2"] = "夜道极阴,昼道极阳。",
	["$qimen1"] = "汝逢大凶,不宜出兵再战。",
	["$qimen2"] = "小奇改门户,大奇变格局。",

	["#_gaoqiu"] = "球王",
	["gaoqiu"] = "高俅",
	["hengxing"] = "横行",
	[":hengxing"] = "摸牌阶段,若你未受伤,可以额外摸X张牌,X为已死亡的角色数且至多为2.",
	["cuju"] = "蹴鞠",
	[":cuju"] = "每当你受到伤害时,可以进行一次判定:若结果为♠或♣,你可以弃置一张手牌,将该伤害转移给任一其他角色.",
	["panquan"] = "攀权",
	[":panquan"] = "<b>主公技</b>,其他官势力角色每回复1点体力,可以让你摸两张牌,然后你将一张手牌置于牌堆顶.",
	["#hengxing"] = "%from的技能“<b><font color = 'red'>横行</font></b>”被触发,将额外摸%arg张牌",
	["#hengxingdeath"] = "%arg this",
	["#cuju"] = "%from将伤害踢给了%arg",
	["#cujufailed"] = "%from“<b><font color = 'red'>蹴鞠</font></b>”不赖,只可惜进了国家队,怎么都射不出来",
	["#panquan"] = "%arg发动技能“<b><font color = 'blue'>攀权</font><b>”,%from摸了2张牌",
	["@panquan"] = "请选择一张手牌,然后点击[确定],这张牌将被置于牌堆顶",
	["panquan:agree"] = "发动攀权,令高俅摸2张牌",
	["panquan:ignore"] = "放弃攀权",
	["$hengxing1"] = "安敢辄入白虎节堂,可知法度否?",
	["$hengxing2"] = "哼!不认得我?!",
	["$cuju1"] = "看我入那风流眼!",
	["$cuju2"] = "有此绝技,休想伤我!",
	["$panquan1"] = "圣上有旨!",
	["$panquan2"] = "共求富贵!",

	["#_husanniang"] = "一丈青",
	["husanniang"] = "扈三娘",
	["hongjin"] = "红锦",
	[":hongjin"] = "出牌阶段,你每对男性角色造成一次伤害,可以执行下列两项中的一项:\
        1.摸一张牌;\
        2.弃掉该角色的一张牌.",
	["hongjin:draw"] = "摸一张牌",
	["hongjin:discard"] = "弃掉该角色的一张牌",
	["hongjin:draw"] = "摸一张牌",
	["#hongjindiscard"] = "%from发动技能“<b><font color = 'red'>红锦</font><b>”,%from弃掉了%arg的1张牌",
	["#hongjindraw"] = "%from发动技能“<b><font color = 'red'>红锦</font><b>”,%from摸了1张牌",
	["wuji"] = "武姬",
	[":wuji"] = "出牌阶段,你可以弃置任意数量的【杀】,然后摸等量的牌.",
	["#wuji"] = "%from发动了技能“<b><font color = 'red'>武姬</font><b>”",
	["$hongjin1"] = "一击枫叶落!",
	["$hongjin2"] = "玉纤擒猛将,霜刀砍雄兵！",
	["$wuji1"] = "巾帼不让须眉!",
	["$wuji2"] = "连环铠甲衬红纱。",

-- last words
	["~songjiang"] = "何时方能报效朝廷？",
	["~lujunyi"] = "我、生为大宋人，死为大宋鬼！",
	["~chaijin"] = "辞官回乡罢了～",
	["~zhangqing"] = "一技之长，不足傍身啊！",
	["~yuehe"] = "叫子也难吹奏了。",
	["~muhong"] = "弟，兄先去矣。",
	["~zhoutong"] = "虽有霸王相，奈无霸王功啊!",
	["~qiaodaoqing"] = "这，就是五雷轰顶的滋味吗？",
	["~andaoquan"] = "救人易，救己难！",
	["~gongsunsheng"] = "天罡尽已归天界，地煞还应入地中。",
	["~gaoqiu"] = "报应啊～报应！",
	["~husanniang"] = "卿本佳人，奈何从贼？",
}
