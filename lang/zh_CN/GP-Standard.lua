-- translation for StandardGeneralPackage

return {
	["standard"] = "基础包",

	["$songjiang"] = "001",
	["#songjiang"] = "及时雨", -- kou 4hp (ttxd)
	["songjiang"] = "宋江",
	["illustrator:songjiang"] = "星魂",
	["designer:songjiang"] = "烨子&凌天翼",
	["cv:songjiang"] = "猎狐【天子会工作室】",
	["coder:songjiang"] = "宇文天启、凌天翼",
	["ganlin"] = "甘霖",
	[":ganlin"] = "出牌阶段，你可以将任意数量的手牌交给其他角色，然后你可以将手牌补至X张（X为你已损失的体力值）。额外的，你以此法补牌后，不能发动“甘霖”，直到回合结束。",
	["juyi"] = "聚义",
	[":juyi"] = "<font color=red><b>主公技</b></font>，其他寇势力角色可以在其出牌阶段与你交换手牌（你可以拒绝此交换）。每阶段限一次。",
	["jui"] = "聚换",
	[":jui"] = "你可以和拥有【聚义】技能的主公交换手牌，每回合限一次",
	["jui:agree"] = "莫和大哥客气～（同意）",
	["jui:deny"] = "你是～细作！（拒绝）",
	["#Juyi"] = "%from 和 %to 交换了手牌",
	["$ganlin1"] = "扶危济困，急人所难。",
	["$ganlin2"] = "在下正是山东及时雨宋公明！",
	["$ganlin3"] = "行云布雨，方能润泽四方。", -- 3和4补牌时播放
	["$ganlin4"] = "与人方便，自己方便。",
	["$juyi1"] = "我等上应天星，合当聚义！",
	["$juyi2"] = "替天行道！",
	["$juyi3"] = "不得无礼！", -- 3和4拒绝时播放
	["$juyi4"] = "如今，尚不是时候。",
	["~songjiang"] = "望天王降诏，早招安，心方足。",

	["$lujunyi"] = "002",
	["#lujunyi"] = "玉麒麟", -- guan 4hp (ttxd)
	["lujunyi"] = "卢俊义",
	["illustrator:lujunyi"] = "战火纷争",
	["cv:lujunyi"] = "猎狐【天子会工作室】",
	["coder:lujunyi"] = "roxiel",
	["baoguo"] = "报国",
	[":baoguo"] = "当其他角色受到伤害时，你可以弃置一张基本牌，将该伤害转移给你；你每受到一次伤害，可以摸X张牌（X为你已损失的体力值）。",
	["@baoguo"] = "你可以弃置一张基本牌发动【报国】，将 %src 受到的 %arg 点伤害转移给你",
	["#Baoguo"] = "%from 发动了技能【%arg】，将 %to 受到的 %arg2 点伤害转移给了自己",
	["$baoguo1"] = "大丈夫为国尽忠，死而无憾！", --1和2转伤害不播放，摸牌随机播放
	["$baoguo2"] = "但愿共存忠义于心，共著功勋于国！",
	["~lujunyi"] = "我，生为大宋人，死为大宋鬼！",

	["$wuyong"] = "003",
	["#wuyong"] = "智多星", -- kou 3hp (cgdk)
	["wuyong"] = "吴用",
	["illustrator:wuyong"] = "刘彤&赵鑫",
	["cv:wuyong"] = "鸢飞【天子会工作室】",
	["huace"] = "画策",
	[":huace"] = "出牌阶段，你可以将你的任一锦囊牌当任一非延时类锦囊使用。每阶段限一次。",
	["stt"] = "单目标锦囊",
	["mtt"] = "多目标锦囊",
	["yunchou"] = "运筹",
	[":yunchou"] = "当你使用一张非延时类锦囊时，（在结算前）你可以摸一张牌。",
	["$huace1"] = "力则力取，智则智取。",
	["$huace2"] = "兄长不必挂心，吴某自有措置。",
	["$yunchou1"] = "如此如此，这般这般。",
	["$yunchou2"] = "有了，有了！",
	["~wuyong"] = "八百里水泊，化作南柯一梦。",

	["$gongsunsheng"] = "004",
	["#gongsunsheng"] = "入云龙", -- kou 3hp (ttxd)
	["gongsunsheng"] = "公孙胜",
	["illustrator:gongsunsheng"] = "叶智成",
	["cv:gongsunsheng"] = "流岚【裔美声社】",
	["yixing"] = "移星",
	[":yixing"] = "在任一角色的判定牌生效前，你可以用任一角色装备区里的一张牌替换之。",
	["@yixing"] = "你可以发动【移星】技能来修改 %src 的 %arg 判定",
	["qimen"] = "奇门",
	[":qimen"] = "任一角色的回合开始时，你可以弃置一张手牌，令除你外的任一角色进行一次判定：若判定结果与你弃置的牌颜色相同，则该角色不能发动其当前的所有技能，直到回合结束。",
	["@qimen"] = "%src 的回合开始了，你可以弃一张手牌对除你之外的一名角色发动【奇门】",
--	["@qimen"] = "%src 判定牌的花色为 %arg，请弃置与其相同花色的牌",
	["#Qimen"] = "%from 的【%arg】发动成功，%to 不能发动当前的所有技能直到回合结束",
	["#QimenEnd"] = "%to 解除了【%arg】的影响",
	["#QimenClear"] = "%from 终于死了，【%arg】随之失效，%to 喜笑颜开",
	["@shut"] = "封印",
	["$yixing1"] = "天命有旋转，地星而应之。",
	["$yixing2"] = "夜道极阴，昼道极阳。",
	["$qimen1"] = "汝逢大凶，不宜出兵再战。",
	["$qimen2"] = "小奇改门户，大奇变格局。",
	["~gongsunsheng"] = "天罡尽已归天界，地煞还应入地中。",

	["$guansheng"] = "005",
	["#guansheng"] = "大刀", -- jiang 4hp (zcyn)
	["guansheng"] = "关胜",
	["illustrator:guansheng"] = "SAM.猩",
	["cv:guansheng"] = "鹏少",
	["huqi"] = "虎骑",
	[":huqi"] = "<b>锁定技</b>，当你计算与其他角色的距离时，始终-1。",
	["tongwu"] = "通武",
	[":tongwu"] = "当你使用的【杀】被【闪】抵消时，你可以将该【闪】交给除目标角色外的任一角色。",
	["wusheng"] = "武圣",
	[":wusheng"] = "你可以将一张♥或♦牌当【杀】使用或打出。",
	["$tongwu1"] = "攻敌，以长击短！克己，扬长避短！",
	["$tongwu2"] = "可胜者，攻也！不可胜者，守也！",
	["~guansheng"] = "武虽通，人难长。",

	["$linchong"] = "006",
	["#linchong"] = "豹子头", -- jiang 4hp (xzdd)
	["linchong"] = "林冲",
	["illustrator:linchong"] = "zhangjiang",
	["cv:linchong"] = "猎狐【天子会工作室】",
	["duijue"] = "对决",
	[":duijue"] = "你每使用【杀】造成一次伤害或受到一次其他角色使用【杀】造成的伤害，可以令除你外的任一角色进行一次判定：若结果不为♠，则视为你对其使用一张【决斗】（不能被【将计就计】和【无懈可击】响应）。",
	["@duijue"] = "你可以指定一名其他角色进行【对决】",
	["$duijue1"] = "吾乃八十万禁军教头，豹子头林冲是也！",
	["$duijue2"] = "一枪在手，试问天下英雄！",
	["~linchong"] = "神枪绕指柔，家恨何人报！",

	["$huarong"] = "009",
	["#huarong"] = "小李广", -- guan 4hp (qjwm)
	["huarong"] = "花荣",
	["illustrator:huarong"] = "刘彤&赵鑫",
	["cv:huarong"] = "烨子风暴【天子会工作室】",
	["jingzhun"] = "精准",
	[":jingzhun"] = "<b>锁定技</b>，当你使用【杀】指定一名其他角色为目标后，若你与其的距离等于你的攻击范围，则该【杀】不能被【闪】响应。",
	["#Jingzhun"] = "%from 的锁定技【%arg】被触发，%to 不可闪避",
	["kaixian"] = "开弦",
	[":kaixian"] = "回合开始时，你可以展示一张点数不大于5的手牌。若如此做，你的攻击范围视为该牌的点数，直到回合结束。",
	["@kaixian"] = "请展示一张点数不大于5的手牌，你的攻击范围将视为该牌的点数直到回合结束",
	["$Kaixian"] = "本回合 %from 的攻击范围视为 %card 的点数",
	["$jingzhun1"] = "百发百中！",
	["$jingzhun2"] = "教他认我一箭！",
	["$kaixian1"] = "弓开秋月分明。",
	["$kaixian2"] = "汝等可敢踏前一步？",
	["~huarong"] = "一腔义烈元相契，封树高悬两命亡。",

	["$chaijin"] = "010",
	["#chaijin"] = "小旋风", -- guan 3hp (ttxd)
	["chaijin"] = "柴进",
	["illustrator:chaijin"] = "刀剑英雄",
	["designer:chaijin"] = "烨子&小花荣",
	["cv:chaijin"] = "烨子风暴【天子会工作室】",
	["coder:chaijin"] = "roxiel、宇文天启",
	["danshu"] = "丹书",
	[":danshu"] = "<b>锁定技</b>，当其他角色使用【杀】指定你为目标时，需弃置X张手牌（X为你已损失的体力值），否则该【杀】对你无效。",
	["#Danshu"] = "%to 的锁定技【%arg】被触发， %from 必须再弃掉 %arg2 张手牌，否则该【杀】对 %to 无效",
	["haoshen"] = "豪绅",
	[":haoshen"] = "你可以跳过你的摸牌阶段，令任一角色将手牌补至其体力上限的张数（至多五张）；你可以跳过你的出牌阶段，将一半的手牌（向上取整）交给任意其他角色。",
	["@haoshen-draw"] = "你可以发动【豪绅】跳过摸牌阶段，令一名角色将手牌补至其体力上限的张数",
	["@haoshen-play"] = "你可以发动【豪绅】跳过出牌阶段，选择将一半的手牌交给一名其他角色",
	["$danshu1"] = "丹书铁券在此，谁敢不敬？",
	["$danshu2"] = "御赐丹书铁券，可保祖孙三代！",
	["$haoshen1"] = "以吾万贯家财，助你一臂之力。", --1和2是第一项效果
	["$haoshen2"] = "碎银铺路，富贵如云。",
	["$haoshen3"] = "既是兄弟，理应有福同享。", --3和4是第二项效果
	["$haoshen4"] = "客气什么，拿去便是。",
	["~chaijin"] = "难道～这先朝之物，没用了？",

	["$zhutong"] = "012",
	["#zhutong"] = "美髯公", -- guan 4hp (xzdd)
	["zhutong"] = "朱仝",
	["illustrator:zhutong"] = "刘彤&赵鑫",
	["designer:zhutong"] = "烨子&喀什葛尔胡杨",
	["cv:zhutong"] = "爪子【天子会工作室】",
	["sijiu"] = "私救",
	[":sijiu"] = "出牌阶段，你可以弃置一张【肉】，令任一已受伤的其他角色回复1点体力。",
	["yixian"] = "义先",
	[":yixian"] = "当你对其他角色造成伤害时，你可以防止该伤害，弃掉该角色区域内的一张牌。若如此做，你摸一张牌。",
	["$Yixian"] = "%from 弃掉了 %to 的 %card，抵消了 %to 受到的伤害",
	["$sijiu1"] = "你见我闪开条路让你过去。",
	["$sijiu2"] = "我自替你吃这官司。",
	["$yixian1"] = "事不宜迟，兄弟，快走！",
	["$yixian2"] = "此地虽好，也不是安身之处。",
	["~zhutong"] = "可恨这黑厮～",

	["$luzhishen"] = "013",
	["#luzhishen"] = "花和尚", -- kou 4hp (qjwm)
	["luzhishen"] = "鲁智深",
	["illustrator:luzhishen"] = "刘彤&赵鑫",
	["cv:luzhishen"] = "东方胤弘【天子会工作室】",
	["liba"] = "力拔",
	[":liba"] = "当你使用【杀】对目标角色造成伤害时，你可以展示该角色的一张手牌：若为【肉】或【酒】，则你获得之；若不为基本牌，则你弃掉该牌并令该伤害+1。",
	["$ForceDiscardCard"] = "%from 弃掉了 %to 的 %card",
	["zuohua"] = "坐化",
	[":zuohua"] = "<b>锁定技</b>，杀死你的角色不能执行奖惩。",
	["#Zuohua"] = "%from 的锁定技【%arg】被触发，%to 不能执行奖惩",
	["$liba1"] = "哪用这般罗嗦，连根拔起便是！",
	["$liba2"] = "打甚鸟紧，看洒家的！",
	["$zuohua1"] = "钱塘江上潮信来，今日方知我是我。",
	["$zuohua2"] = "忽地随潮归去，果然无处跟寻。", -- 天灾死亡

	["$wusong"] = "014",
	["#wusong"] = "行者", -- kou 4hp (qjwm)
	["wusong"] = "武松",
	["fuhu"] = "伏虎",
	["illustrator:wusong"] = "麒麟水浒传",
	["cv:wusong"] = "猎狐【天子会工作室】",
	[":fuhu"] = "其他角色每使用【杀】造成一次伤害，你可以弃置一张♠或♣牌，视为你对该角色使用一张【杀】。额外的，若你弃置的牌为【酒】或武器牌，则该【杀】造成的伤害+1。",
	["@fuhu"] = "你可以弃置一张黑色牌，发动【伏虎】（视为对 %src 使用一张【杀】）",
	["$Fuhu"] = "%from 弃置了 %card，这张【杀】具有伤害+1的效果",
	["$fuhu1"] = "小小大虫，有何可惧？", --不管弃什么牌，1和2随机播放
	["$fuhu2"] = "哨棒断了，俺还有一双拳头！",
	["~wusong"] = "招安，招安，冷了兄弟们的心啊！",

	["$yangzhi"] = "017",
	["#yangzhi"] = "青面兽", -- guan 4hp (xzzd)
	["yangzhi"] = "杨志",
	["illustrator:yangzhi"] = "刘彤&赵鑫",
	["cv:yangzhi"] = "猎狐【天子会工作室】",
	["maidao"] = "卖刀",
	[":maidao"] = "出牌阶段，你可以将任意数量的武器牌置于你的武将牌上，称为“刀”；若“刀”的数量不少于1，则其他角色可以在其出牌阶段交给你三张手牌，获得任意一张“刀”。",
	["knife"] = "刀",
	["buyaknife"] = "买刀",
	[":buyaknife"] = "出牌阶段，交给杨志两张手牌，获得任意一张“刀”。",
	["fengmang"] = "锋芒",
	[":fengmang"] = "回合开始阶段，你可以将一张“刀”置入弃牌堆或弃置一张事件牌，对任一其他角色造成1点伤害。",
	["@fengmang"] = "你可以发动【锋芒】将一张“刀”或事件牌弃置，对任一其他角色造成1点伤害",
	["$maidao1"] = "何人能识此刀？",
	["$maidao2"] = "如今事急无措，卖刀求生。",
	["$maidao3"] = "这位买官好眼力！",  --3和4是买刀的
	["$maidao4"] = "祖上留下宝刀，要卖三千贯。",
	["$fengmang1"] = "砍铜剁铁，刀口不卷！", --1、2、3随机播放
	["$fengmang2"] = "吹毛得过！",
	["$fengmang3"] = "杀人不见血！", 
	["~yangzhi"] = "无颜面对～列祖列宗！",

	["$xuning"] = "018",
	["#xuning"] = "金枪手", -- jiang 4hp (ybyt)
	["xuning"] = "徐宁",
	["illustrator:xuning"] = "刘彤&赵鑫",
	["cv:xuning"] = "卡修【天子会工作室】",
	["coder:xuning"] = "战栗贵公子",
	["goulian"] = "钩镰",
	[":goulian"] = "你每使用【杀】或【决斗】对目标角色造成一次伤害，可以弃掉其装备区里的一张防具牌或坐骑牌。",
	["jinjia"] = "金甲",
	[":jinjia"] = "<b>锁定技</b>，当你没装备防具时，始终视为你装备着【赛唐猊】。\
<font size=2><br>★防具【赛唐猊】效果：锁定技，具属性伤害的【杀】对你无效；你每受到一次【杀】造成的伤害，伤害来源须弃置其装备区里的武器。</font>",
	["#JinjiaNullify"] = "%from 的【%arg】技能被触发，【%arg2】对其无效",
	["#ThrowJinjiaWeapon"] = "%from 的技能【%arg】生效",
	["$goulian1"] = "以巧破敌，四两拨千斤！",
	["$goulian2"] = "四拨三钩通七路，九变合神机！",
	["$jinjia1"] = "此甲又轻又稳，刀剑箭矢，急不能透！",
	["$jinjia2"] = "这便是赛唐猊了。",
	["~xuning"] = "刀枪入库，马放南山。",
--	["~xuning"] = "草！还我宝甲！",

	["$daizong"] = "020",
	["#daizong"] = "神行太保", -- jiang 3hp (fcdc)
	["daizong"] = "戴宗",
	["illustrator:daizong"] = "花狐貂",
	["cv:daizong"] = "莫名【忆昔端华工作室】",
	["coder:daizong"] = "宇文天启、Lycio",
	["mitan"] = "密探",
	[":mitan"] = "你可以将你的任一锦囊牌或事件牌当【探听】使用；当你使用【探听】观看目标角色的手牌时，你可以展示其中的任意一张牌。",
	["jibao"] = "急报",
	[":jibao"] = "回合结束时，若你的手牌数与你本回合开始时的手牌数相等，则你可以弃置一张手牌。若如此做，则回合结束后，你进行一个额外的回合。",
	["@jibao"] = "你已满足发动【急报】的条件，可以弃一张手牌开始一个新的回合",
	["#Jibao"] = "%from 使用了技能【%arg】，进行一个额外的回合",
	["$mitan1"] = "隔墙须有耳，窗外岂无人。", --使用锦囊当探听播放
	["$mitan2"] = "我已打探清楚！", --展示牌播放
	["$jibao1"] = "八百里加急，快！",
	["$jibao2"] = "日行八百，朝发夕至。",
	["~daizong"] = "消息有误，啊～",

	["$likui"] = "022",
	["#likui"] = "黑旋风", -- kou 4hp (xzdd)
	["likui"] = "李逵",
	["designer:likui"] = "凌天翼",
	["illustrator:likui"] = "刘彤&赵鑫",
	["cv:likui"] = "鹏少",
	["coder:likui"] = "凌天翼、宇文天启",
	["shalu"] = "杀戮",
	[":shalu"] = "出牌阶段，你每使用【杀】造成一次伤害，可以进行一次判定：若结果为♠或♣，则你获得该判定牌且本回合你可以额外使用一张【杀】。",
	["$shalu1"] = "吃俺一斧！", --1和2判定黑色播放
	["$shalu2"] = "寻那措鸟，一发杀了！",
	["$shalu3"] = "虽然没了功劳，也吃俺杀得快活。", --判定红色播放
	["~likui"] = "生时服侍哥哥，死了也只是哥哥部下一个小鬼。",

	["$ruanxiaoqi"] = "031",
	["#ruanxiaoqi"] = "活阎罗", -- min 4hp (cgdk)
	["ruanxiaoqi"] = "阮小七",
	["illustrator:ruanxiaoqi"] = "水浒无双",
	["cv:ruanxiaoqi"] = "小V【天子会工作室】",
	["jueming"] = "绝命",
	[":jueming"] = "<b>锁定技</b>，若你的当前体力值为1，则你不能成为【杀】、【决斗】和【行刺】的目标。",
	["jiuhan"] = "酒酣",
	[":jiuhan"] = "你在你濒死状态下使用【酒】时，可以扣减1点体力上限，然后将体力回复至等同于你的体力上限。",
	["#Jiuhan"] = "%from 发动了【%arg】，看见了春哥",
	["$jueming1"] = "绝处逢生！",
	["$jueming2"] = "这腔热血，只要卖与识货的！",
	["$jiuhan1"] = "啊！好酒！",
	["$jiuhan2"] = "不愧是御酒！",
	["~ruanxiaoqi"] = "爷爷生在天地间，不求富贵不做官。",

	["$yangxiong"] = "032",
	["#yangxiong"] = "病关索", -- jiang 4hp (zcyn)
	["yangxiong"] = "杨雄",
	["illustrator:yangxiong"] = "山海传奇",
	["designer:yangxiong"] = "裁之刃•散&宇文天启",
	["cv:yangxiong"] = "莫名【忆昔端华工作室】",
	["xingxing"] = "行刑",
	[":xingxing"] = "当你攻击范围内的任一其他角色进入濒死状态时，你可以弃置一张♠手牌，令其立即死亡。若如此做，则视为你杀死该角色。",
	["#Xingxing"] = "%from 发动了技能【%arg】，将 %to 拖出去宰掉了",
	["@xingxing"] = "%src 正在死亡线上挣扎，你可以发动【行刑】，弃一张黑桃手牌将其拖出去宰掉",
	["$xingxing1"] = "午时已到，行刑！",
	["$xingxing2"] = "斩！",
	["~yangxiong"] = "背疮疼痛，恨不能战死沙场～",

	["$yanqing"] = "036",
	["#yanqing"] = "浪子", -- min 3hp (qjwm)
	["yanqing"] = "燕青",
	["illustrator:yanqing"] = "大秦天下",
	["cv:yanqing"] = "烨子风暴【天子会工作室】",
	["dalei"] = "打擂",
	[":dalei"] = "出牌阶段，你可以和一名男性角色拼点。若你赢，则你获得以下技能，直到回合结束：你每对该角色造成1点伤害，可以令除该角色外的任一已受伤的角色回复1点体力。若你没赢，则其对你造成1点伤害。每阶段限一次。",
	["fuqin"] = "抚琴",
	[":fuqin"] = "你每受到一次伤害，可以选择一项：弃掉伤害来源的X张牌，或令任一角色摸X张牌（X为你已损失的体力值）。",
	["fuqin:yan"] = "弃掉伤害来源的X张牌",
	["fuqin:qing"] = "令任一角色摸X张牌",
	["fuqin:nil"] = "不发动",
	["#FuqinYan"] = "%from 发动了技能【%arg】，弃掉了 %to 的 %arg2 张牌",
	["#FuqinQin"] = "%from 发动了技能【%arg】，令 %to 摸了 %arg2 张牌",
	["$dalei2"] = "来，擂台上见真章！", --1和2发动技能播放
	["$dalei1"] = "梁山好汉只需一人，便可溃汝相扑天下！",
	["$dalei3"] = "有力使力，无力使智。",  --拼点赢播放
	["$dalei4"] = "随机应变，行不通了！",  --拼点输播放
	["$fuqin1"] = "听听最后的旋律吧！", --1和2弃牌播放
	["$fuqin2"] = "一曲穿云裂太清！",
	["$fuqin3"] = "一曲激昂助士气！",  --3和4摸牌播放
	["$fuqin4"] = "可长可短，见机而作。",
	["~yanqing"] = "时人苦把功名恋，只怕功名不到头。",

	["$andaoquan"] = "056",
	["#andaoquan"] = "神医", -- min 3hp (ttxd)
	["andaoquan"] = "安道全",
	["illustrator:andaoquan"] = "天龙八部",
	["cv:andaoquan"] = "澪乱の风【天子会工作室】",
	["jishi"] = "济世",
	[":jishi"] = "任一角色的回合开始时，若其已受伤，则你可以弃置一张基本牌或锦囊牌，令其回复1点体力。",
	["@jishi"] = "%src 受伤了，你可以发动【济世】，弃置一张基本牌或锦囊牌为 %src 回复1点体力。",
	["yanshou"] = "延寿",
	[":yanshou"] = "<font color=purple><b>限定技</b></font>，出牌阶段，你可以弃置两张♥牌，令任一角色增加1点体力上限。",
	["@relic"] = "舍利子",
	["#Yanshou"] = "%from 为 %to 增加了 %arg 点体力上限",
	["$xuming"] = "伏望天慈，延你之寿。",
	["fengyue"] = "风月",
	[":fengyue"] = "回合结束时，若场上现存女性角色数不少于1，则你可以摸一张牌。",
	["$jishi1"] = "祖传内科外科，尽皆医得。",
	["$jishi2"] = "药到病除！",
	["$yanshou"] = "助你延寿十年！", 
	["$fengyue1"] = "惹得烟花三两枝。",
	["$fengyue2"] = "活色生香伴佳人。",
	["~andaoquan"] = "救人易，救己难！",

	["$husanniang"] = "059",
	["#husanniang"] = "一丈青", -- jiang 3hp (ttxd)
	["husanniang"] = "扈三娘",
	["illustrator:husanniang"] = "水浒无双",
	["cv:husanniang"] = "蒲小猫【天子会工作室】",
	["hongjin"] = "红锦",
	[":hongjin"] = "你每对男性角色造成一次伤害，可以选择一项：摸一张牌，或弃掉该角色一张牌。",
	["hongjin:throw"] = "弃掉那臭男人的一张牌",
	["wuji"] = "武姬",
	[":wuji"] = "出牌阶段，你可以弃置任意数量的【杀】，然后摸等量的牌。",
	["$hongjin1"] = "天然美貌海棠花。",--1和2摸牌播放
	["$hongjin2"] = "还有后招！",
	["$hongjin3"] = "一击枫叶落！", --3和4弃牌播放
	["$hongjin4"] = "玉纤擒猛将，霜刀砍雄兵！",
	["$wuji1"] = "巾帼不让须眉！",
	["$wuji2"] = "连环铠甲衬红纱。",
	["~husanniang"] = "卿本佳人，奈何从贼？",

	["$sunerniang"] = "103",
	["#sunerniang"] = "母夜叉", -- kou 3hp (cgdk)
	["sunerniang"] = "孙二娘",
	["illustrator:sunerniang"] = "花狐貂",
	["cv:sunerniang"] = "南宫泓【「御」】",
	["heidian"] = "黑店",
	[":heidian"] = "<b>锁定技</b>，其他角色每对你造成一次伤害，须弃置一张手牌；当其他角色失去最后的手牌时，需交给你一张其装备区里的牌，否则失去1点体力。",
	["@heidian1"] = "受 %src 的技能【黑店】影响，你必须选一张手牌弃掉",
	["@heidian2"] = "受 %src 的技能【黑店】影响，你必须给 %src 一张装备区里的牌，否则失去一点体力",
	["renrou"] = "人肉",
	[":renrou"] = "你可以观看死亡角色的所有牌，然后以任意分配方式交给任意角色。", --遗计分牌
	["$heidian1"] = "由你奸似鬼，也吃老娘洗脚水！",
	["$heidian2"] = "这贼配军却不是作死！倒来戏弄老娘！",
	["$heidian3"] = "灯蛾扑火，惹焰烧身！", --3和4来源须弃牌时播放
	["$heidian4"] = "总得留下些物件再走！",
	["$renrou1"] = "给我活剥了！", --发动技能播放
	["$renrou2"] = "客官，这可是上好的黄牛肉！", --发牌播放
	["~sunerniang"] = "就让这仇怨～生根发芽吧。",

	["$gaoqiu"] = "109",
	["#gaoqiu"] = "殿帅府太尉", -- guan 3hp (ttxd)
	["gaoqiu"] = "高俅",
	["illustrator:gaoqiu"] = "大熊",
	["cv:gaoqiu"] = "爪子【天子会工作室】",
	["coder:gaoqiu"] = "roxiel、宇文天启",
	["hengxing"] = "横行",
	[":hengxing"] = "摸牌阶段，若你未受伤，则你可以额外摸X张牌（X为已死亡角色数且至多为2）。",
	["cuju"] = "蹴鞠",
	[":cuju"] = "当你受到伤害时，可以进行一次判定：若结果为♠或♣，则你可以弃置一张手牌，将该伤害转移给任一其他角色。",
	["panquan"] = "攀权",
	[":panquan"] = "<font color=red><b>主公技</b></font>，其他官势力角色每回复1点体力，可以令你摸两张牌，然后你将你的任一手牌置于牌堆顶。",
	["@cuju-card"] = "你可以弃置一张手牌，将该伤害转移给任一其他角色",
	["$hengxing1"] = "安敢辄入白虎节堂，可知法度否？",
	["$hengxing2"] = "哼！不认得我？",
	["$cuju1"] = "看我入那风流眼！",
	["$cuju2"] = "有此绝技，休想伤我！",
	["$panquan1"] = "圣上有旨！",
	["$panquan2"] = "共求富贵！",
	["~gaoqiu"] = "报应啊～报应！",

	["$caijing"] = "110",
	["#caijing"] = "奸相", -- guan 4hp (fcdc)
	["caijing"] = "蔡京",
	["illustrator:caijing"] = "侠客行",
	["cv:caijing"] = "东方胤弘【天子会工作室】",
	["coder:caijing"] = "宇文天启、安歧大小姐",
	["jiashu"] = "家书",
	[":jiashu"] = "出牌阶段，你可以将一张手牌交给任一其他角色并声明一种花色。然后若该角色交给你一张你所声明花色的手牌，则其摸一张牌，否则其失去1点体力。每阶段限一次。",
	["@jiashu"] = "%src 发动了【家书】，声明的花色为 %arg，请交出一张与其相同花色的手牌",
	["duoquan"] = "夺权",
	[":duoquan"] = "<font color=purple><b>限定技</b></font>，当任一其他角色死亡时，若杀死该角色的不为你，则你可以获得该角色的所有牌和一项技能（主公技、限定技和觉醒技除外）。",
	["@power"] = "宝石",
	["$jiashu1"] = "信中所言你可知晓？",
	["$jiashu2"] = "有为父在朝堂，尔等大可放心行事！",
	["$duoquan"] = "这朝事还不由我说了算！",
	["~caijing"] = "时至今日，方知百姓之恨！",

	["$fangla"] = "112",
	["#fangla"] = "永乐圣公", -- jiang 4hp (bwqz)
	["fangla"] = "方腊",
	["illustrator:fangla"] = "黄玉郎",
	["cv:fangla"] = "谈笑",
	["yongle"] = "永乐",
	[":yongle"] = "出牌阶段，你可以分别获得至多X名其他角色的一张手牌（X为场上现存势力数），然后你分别交给这些角色一张手牌。每阶段限一次。",
	["zhiyuan"] = "支援",
	[":zhiyuan"] = "<font color=red><b>主公技</b></font>，当你失去最后的手牌时，其他将势力角色可以交给你一张手牌。",
	["@zhiyuan"] = "%src 失去了最后一张手牌，你可以【支援】其一张手牌",
	["$yongle1"] = "人人为公，天下大同！",
	["$yongle2"] = "有福同享，有难同当！",
	["$zhiyuan1"] = "再续钱粮！", --1和2失去最后的手牌播放，别人给牌不播放
	["$zhiyuan2"] = "吾大军援兵何在？",
	["~fangla"] = "打虎武松，不过如此。",

	["$wangqing"] = "114",
	["#wangqing"] = "楚王", -- min 4hp (qjwm)
	["wangqing"] = "王庆",
	["illustrator:wangqing"] = "黄玉郎",
	["cv:wangqing"] = "猎狐【天子会工作室】",
	["qibing"] = "起兵",
	[":qibing"] = "<b>锁定技</b>，锁定技，摸牌阶段，你摸X张牌（X为你的当前体力值且至多为4）。",
	["jiachu"] = "假楚",
	[":jiachu"] = "<font color=red><b>主公技</b></font>，其他民势力角色每受到一次伤害，可以弃置一张♥手牌，令你回复1点体力。",
	["@jiachu"] = "你可以发动【假楚】，弃置一张红桃手牌，令 %src 回复1点体力",
	["$qibing1"] = "吾军势大，霸业可成！",
	["$qibing2"] = "有此八州，天子可推，天下可得！",
	["$qibing3"] = "兵势已衰，只得固守。",  --3和4是摸2牌或1牌时播放
	["$qibing4"] = "只剩下两州之地了。",
	["$jiachu1"] = "江山已固。",
	["$jiachu2"] = "好一片繁华景象！",
	["~wangqing"] = "来世再不渡清江。",

	["$panjinlian"] = "126",
	["#panjinlian"] = "墙头杏", -- min 3hp (qlfd)
	["panjinlian"] = "潘金莲",
	["illustrator:panjinlian"] = "hs8887",
	["designer:panjinlian"] = "烨子&凌天翼",
	["cv:panjinlian"] = "小酒【天子会工作室】",
	["meihuo"] = "魅惑",
	[":meihuo"] = "出牌阶段，你可以弃置一张♥手牌并指定一名已受伤的男性角色，令你与其各回复1点体力。每阶段限一次。",
	["zhensha"] = "鸩杀",
	[":zhensha"] = "<font color=purple><b>限定技</b></font>，当其他角色使用【酒】时，（在结算前）若其已受伤，则你可以弃置一张♠手牌，令其将体力上限扣减至等同于其当前体力值。",
	["@zhensha"] = "%src 喝了【酒】，你可以趁机弃置一张黑桃手牌，毒不死也要毒残他！",
	["@methanol"] = "鸩酒",
	["shengui"] = "深闺",
	[":shengui"] = "<b>锁定技</b>，若你的装备区里没有防具牌，则男性角色使用的非延时类锦囊对你无效。",
	["$meihuo1"] = "叔叔，饮个成双杯吧！",
	["$meihuo2"] = "你若有心，吃了我这半盏儿残酒。",
	["$zhensha"] = "大郎，都喝了吧！",
	["$shengui1"] = "小女子从未踏出家门半步。",
	["$shengui2"] = "奴家有夫家了。",
	["~panjinlian"] = "大错铸成两命丧，风吹败柳赴黄泉。",

	["$lishishi"] = "128",
	["#lishishi"] = "绝色", -- min 3hp (fcdc)
	["lishishi"] = "李师师",
	["illustrator:lishishi"] = "热血水浒",
	["cv:lishishi"] = "空无的念【月玲珑】",
	["coder:lishishi"] = "Lycio",
	["qinxin"] = "沁心",
	[":qinxin"] = "回合开始时，你可以声明一种花色并进行一次判定：若结果为你所声明的花色，则你回复1点体力，否则你获得该判定牌。",
	["yinjian"] = "引荐",
	[":yinjian"] = "出牌阶段，你可以指定两名势力不同的男性角色。你交给其中一名角色两张手牌，然后该角色交给另一名角色一张手牌。每阶段限一次。",
	["$qinxin1"] = "芳蓉丽质更妖娆，秋水精神瑞雪标。", --判定时播放
	["$qinxin2"] = "白玉生香花解语，千金良夜实难消。",
	["$yinjian1"] = "请诸位到此，少叙三杯。", --1和2给牌时随机播放
	["$yinjian2"] = "今晚，教你见天子一面。",
	["~lishishi"] = "陛下，妾身去矣！",

	["$yanxijiao"] = "129",
	["#yanxijiao"] = "花魁女", -- min 3hp (qlfd)
	["yanxijiao"] = "阎婆惜",
	["illustrator:yanxijiao"] = "LIUQU",
	["cv:yanxijiao"] = "蒲小猫【天子会工作室】",
	["suocai"] = "索财",
	[":suocai"] = "出牌阶段，你可以和一名男性角色拼点。若你赢，则你获得双方拼点的牌。若你没赢，则该角色对你造成1点伤害。每阶段限一次。",
	["huakui"] = "花魁",
	[":huakui"] = "当距离1以内的任一角色受到一次伤害后，若其当前体力值小于其体力上限的一半（向上取整），则你可以摸一张牌。",
	["$suocai1"] = "速将百两黄金于我！", --1和2发动拼点播放
	["$suocai2"] = "今日撞在我手里了！",
	["$suocai3"] = "不还，再饶你一百个不还！", --拼点赢播放
	["$suocai4"] = "你竟敢勾结梁山贼寇！", --拼点输播放
	["$huakui1"] = "哼！尔等都是绿叶！",
	["$huakui2"] = "海棠花开，阵阵香。",
	["~yanxijiao"] = "宋三郎，你～",
	["~yanpoxi"] = "别管我，你快走……",

}
