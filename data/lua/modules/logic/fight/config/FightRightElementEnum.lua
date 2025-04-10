module("modules.logic.fight.config.FightRightElementEnum", package.seeall)

slot0 = _M
slot1 = 0

function slot2()
	uv0 = uv0 + 1

	return uv0
end

slot0.Elements = {
	BossRush = slot2(),
	CharSupport = slot2(),
	MelodyLevel = slot2(),
	MelodySkill = slot2(),
	RougeCoin = slot2(),
	RougeGongMing = slot2(),
	RougeTongPin = slot2(),
	AssistBoss = slot2(),
	AssistBossScore = slot2(),
	DoomsdayClock = slot2(),
	Dice = slot2(),
	DouQuQuCoin = slot2(),
	DouQuQuHunting = slot2()
}
slot0.Priority = {
	slot0.Elements.Dice,
	slot0.Elements.BossRush,
	slot0.Elements.MelodyLevel,
	slot0.Elements.MelodySkill,
	slot0.Elements.AssistBossScore,
	slot0.Elements.AssistBoss,
	slot0.Elements.DoomsdayClock,
	slot0.Elements.DouQuQuCoin,
	slot0.Elements.DouQuQuHunting,
	slot0.Elements.RougeCoin,
	slot0.Elements.RougeGongMing,
	slot0.Elements.RougeTongPin,
	slot0.Elements.CharSupport
}
slot0.ElementsSizeDict = {
	[slot0.Elements.Dice] = Vector2(540, 150),
	[slot0.Elements.BossRush] = Vector2(200, 135),
	[slot0.Elements.CharSupport] = Vector2(200, 130),
	[slot0.Elements.MelodyLevel] = Vector2(300, 50),
	[slot0.Elements.MelodySkill] = Vector2(200, 175),
	[slot0.Elements.RougeCoin] = Vector2(220, 84),
	[slot0.Elements.RougeGongMing] = Vector2(327, 111),
	[slot0.Elements.RougeTongPin] = Vector2(412.9, 111),
	[slot0.Elements.AssistBoss] = Vector2(200, 200),
	[slot0.Elements.AssistBossScore] = Vector2(200, 100),
	[slot0.Elements.DoomsdayClock] = Vector2(200, 350),
	[slot0.Elements.DouQuQuCoin] = Vector2(400, 80),
	[slot0.Elements.DouQuQuHunting] = Vector2(220, 148)
}
slot0.ElementsNodeName = {
	[slot0.Elements.BossRush] = "bossrush_score",
	[slot0.Elements.CharSupport] = "#go_charsupport",
	[slot0.Elements.MelodyLevel] = "melody_level",
	[slot0.Elements.MelodySkill] = "melody_skill",
	[slot0.Elements.RougeCoin] = "rougeCoin",
	[slot0.Elements.RougeGongMing] = "rougeGongMing",
	[slot0.Elements.RougeTongPin] = "rougeTongPin",
	[slot0.Elements.AssistBoss] = "assistboss",
	[slot0.Elements.AssistBossScore] = "assistbossscore",
	[slot0.Elements.DoomsdayClock] = "doomsdayclock",
	[slot0.Elements.Dice] = "dice",
	[slot0.Elements.DouQuQuCoin] = "douququCoin",
	[slot0.Elements.DouQuQuHunting] = "douququHunting"
}
slot0.AnchorTweenDuration = 0.2

return slot0
