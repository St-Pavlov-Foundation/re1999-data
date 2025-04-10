module("modules.logic.versionactivity2_7.lengzhou6.define.EliminateEnum_2_7", package.seeall)

slot0 = class("EliminateEnum_2_7", EliminateEnum)
slot0.MaxBuffCount = 50
slot0.ChessType = {
	beast = "beast",
	cliff = "cliff",
	stone = "stone",
	tree = "tree",
	star = "star"
}
slot0.ChessIndexToType = {
	nil,
	nil,
	nil,
	nil,
	nil,
	"beast",
	"tree",
	"cliff",
	[9.0] = "star",
	[10.0] = "stone"
}
slot0.ChessTypeToIndex = {
	beast = 6,
	cliff = 8,
	stone = 10,
	tree = 7,
	star = 9
}
slot0.eliminateType = {
	five = "five",
	three = "three",
	base = "base",
	four = "four",
	cross = "cross"
}
slot0.AllChessType = {
	"beast",
	"tree",
	"cliff",
	"star"
}
slot0.AllChessID = {
	6,
	7,
	8,
	9
}
slot0.ChessWidth = 120
slot0.ChessHeight = 122
slot0.ChessIntervalX = 2
slot0.ChessIntervalY = 2
slot0.MaxRow = 6
slot0.MaxCol = 6
slot0.AssessShowTime = LengZhou6Config.instance:getEliminateBattleCost(26) / 1000
slot0.UpdateDamageStepTime = 1
slot0.DieStepTime = 0.3
slot0.AssessLevel = {
	3,
	5,
	7,
	10
}
slot0.AssessLevelToImageName = {
	"v2a7_hissabeth_game_paneltips3",
	"v2a7_hissabeth_game_paneltips4",
	"v2a7_hissabeth_game_paneltips5",
	"v2a7_hissabeth_game_paneltips6"
}
slot0.SpecialChessImage = {
	frost = LengZhou6Config.instance:getEliminateBattleCostStr(23),
	pollution = LengZhou6Config.instance:getEliminateBattleCostStr(22),
	beast = LengZhou6Config.instance:getEliminateBattleCostStr(18),
	tree = LengZhou6Config.instance:getEliminateBattleCostStr(19),
	cliff = LengZhou6Config.instance:getEliminateBattleCostStr(21),
	star = LengZhou6Config.instance:getEliminateBattleCostStr(20)
}
slot0.ChessEffect = {
	frost = "frost",
	pollution = "pollution"
}
slot0.SpecialChessAni = {
	frost = "freeze",
	pollution = "glitch"
}
slot0.InitDropTime = 0.1

return slot0
