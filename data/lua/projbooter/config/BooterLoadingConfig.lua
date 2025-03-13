module("projbooter.config.BooterLoadingConfig", package.seeall)

function booterLoadingConfig()
	return uv0
end

setGlobal("booterLoadingConfig", booterLoadingConfig)

return {
	{
		titleen = "The Storm",
		bg = "originbg1",
		id = 1,
		title = "暴雨",
		weight = 100,
		desc = "它的到来让时间变得无足轻重。时而回到过去，时而重返未来。又或是一无所有，又或是浴火重生。"
	},
	{
		titleen = "Storm Syndrome",
		bg = "originbg2",
		id = 2,
		title = "暴雨症候/时代病",
		weight = 100,
		desc = "它是荒谬而可笑，不可言说的癔症。\n世界的秩序在暴雨冲刷之下难以辨认，一切都开始趋于疯狂，走向陌生。\n生吞黄金、痛饮石油，歌舞于炙热的铁板之上。病人们总是不知道自己病了，任何时候都一样。"
	},
	{
		titleen = "Modern era",
		bg = "originbg3",
		id = 3,
		title = "1999年",
		weight = 100,
		desc = "归根结底，是一个很好的年份。有聚会、倒计时、千禧虫、15寸彩色显示器，和一场无眠之夜。\n尽管向后展望吧，我们有取之不竭的过去呢！你想买黄金吗？"
	},
	{
		titleen = "Arcanum",
		bg = "originbg4",
		id = 4,
		title = "神秘学",
		weight = 100,
		desc = "与生俱来的才能，可被消磨却永不会消失的辉光。\n它具有神奇效用，功率因人而异，用处可大可小，有时带来便利，有时带来漫长的苦果与不间断的麻烦。"
	},
	{
		titleen = "Arcanist",
		bg = "originbg5",
		id = 5,
		title = "神秘学家",
		weight = 100,
		desc = "一个种族，因天赋被世界所遗忘，好与其他忙碌的人们区分开来。\n没有人知道神秘学家是为什么成为神秘学家的，他们曾经昌盛过，如今已然衰落。"
	},
	{
		titleen = "Laplace Scientific Computing Center",
		bg = "originbg6",
		id = 6,
		title = "拉普拉斯科算中心",
		weight = 100,
		desc = "灵感？还是逻辑？这对拉普拉斯来说不是问题。\n凡存在的东西，必是无尽未来方程的一部分。"
	},
	{
		titleen = "Zeno Armaments Engineering and Technology Academy",
		bg = "originbg7",
		id = 7,
		title = "芝诺军备学院",
		weight = 100,
		desc = [[
服从，坚定，从不退怯。
以优补优，主张融合神秘学界武装力量与人类社会武装力量的组织。
作为鸽子屋的常备军队活动于世界各地，同时担负着筛选与培育下一代战斗力量的责任。
在《视界线公约》签署后陆续与各国签订引渡条约，接收来自于不同国家的适龄儿童，进行系统战术训练。]]
	}
}
