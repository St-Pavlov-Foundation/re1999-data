-- chunkname: @modules/logic/versionactivity4_1/guessgamenew/define/GuessGameNewEnum.lua

module("modules.logic.versionactivity4_1.guessgamenew.define.GuessGameNewEnum", package.seeall)

local GuessGameNewEnum = _M

GuessGameNewEnum.ConstId = {
	AggressivePlayCountWeightGte2 = 19,
	AggressivePlayCountWeightLt2 = 16,
	FirstWildCardWeight = 5,
	AggressiveTrustProbability = 20,
	LogicalMaxFakeCount = 25,
	CautiousTrustProbability = 13,
	GameBaseScore = 3,
	GuideTimes = 2,
	AggressiveLastFakeTrustReduce = 22,
	AggressiveLastRealTrustAdd = 21,
	WinAddScore = 6,
	NpcGiftCount = 4,
	CautiousDoubtStreakPreferReal = 12,
	LogicalPlayCountWeightGte2 = 26,
	CautiousPlayCountWeightLt2 = 8,
	LogicalTrustProbability = 27,
	LogicalTrustAddEq3 = 30,
	AggressiveAllRealCardProbability = 17,
	LogicalTrustReduceEq1 = 29,
	LoseReduceScore = 7,
	CautiousAllRealCardProbability = 9,
	CautiousLastRealTrustAdd = 14,
	CautiousLastFakeTrustReduce = 15,
	LogicalAllRealCardProbability = 24,
	LogicalTrustReduceLe0 = 28,
	LogicalTrustAddGe4 = 31,
	CautiousTruthStreakNoFakeReduce = 11,
	CautiousMaxFakeCount = 32,
	LogicalPlayCountWeightLt2 = 23,
	CautiousPlayCountWeightGte2 = 10,
	AggressiveMaxFakeCount = 18,
	LifeValue = 1
}
GuessGameNewEnum.GiftType = {
	Wild = 2,
	Normal = 1
}
GuessGameNewEnum.lineCardCount = 6
GuessGameNewEnum.NpcCount = 2
GuessGameNewEnum.SelectType = {
	Doubt = 2,
	Trust = 1
}
GuessGameNewEnum.RoleType = {
	Npc1 = 1,
	Npc2 = 3,
	Player = 2
}
GuessGameNewEnum.ChooseType = {
	Trust = 1,
	Doubt = 2,
	None = 0
}
GuessGameNewEnum.TemperType = {
	Cautious = 1,
	Logical = 3,
	Radical = 2
}

return GuessGameNewEnum
