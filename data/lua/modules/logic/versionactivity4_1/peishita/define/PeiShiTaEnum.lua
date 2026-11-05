-- chunkname: @modules/logic/versionactivity4_1/peishita/define/PeiShiTaEnum.lua

module("modules.logic.versionactivity4_1.peishita.define.PeiShiTaEnum", package.seeall)

local PeiShiTaEnum = class("PeiShiTaEnum")

PeiShiTaEnum.BoardSize = {
	Row = 10,
	Column = 13,
	CellSize = 100
}
PeiShiTaEnum.Range = {
	HunterHitRange = 1,
	SchulzKillMinDist = 1,
	HunterAlertRange = 2
}
PeiShiTaEnum.UnitType = {
	Obstacle = 3,
	Schulz = 5,
	Player = 1,
	Drop = 4,
	Hunter = 2,
	Target = 6
}
PeiShiTaEnum.ToolId = {
	Axe = 401,
	Crossbow = 402
}
PeiShiTaEnum.Const = {
	HunterMoveTime = 2,
	SchulzMoveTime = 3,
	PlayerMoveTime = 1
}
PeiShiTaEnum.ConstValue = {
	ActorArcheryAnimTime = 0.5,
	HunterAlertAnimTime = 0.5,
	RemoveTreeAnimTime = 0.33,
	SchulzAlertAnimTime = 0.2
}
PeiShiTaEnum.UnitMoveTimeConstId = {
	[PeiShiTaEnum.UnitType.Player] = PeiShiTaEnum.Const.PlayerMoveTime,
	[PeiShiTaEnum.UnitType.Hunter] = PeiShiTaEnum.Const.HunterMoveTime,
	[PeiShiTaEnum.UnitType.Schulz] = PeiShiTaEnum.Const.SchulzMoveTime
}
PeiShiTaEnum.ResultType = {
	Fail = 2,
	Success = 1
}
PeiShiTaEnum.FailReason = {
	AbnormalExit = 3,
	HunterVision = 1,
	Stuck = 2
}
PeiShiTaEnum.Direction = {
	Down = 4,
	Up = 2,
	Right = 1,
	Left = 3
}
PeiShiTaEnum.CellType = {
	Default = 1,
	SchulzVision = 3,
	HunterVision = 2,
	ShootableRange = 4
}
PeiShiTaEnum.CellTypeIcon = {
	[PeiShiTaEnum.CellType.Default] = "v4a1_peishita_game_grid2",
	[PeiShiTaEnum.CellType.HunterVision] = "v4a1_peishita_game_grid3",
	[PeiShiTaEnum.CellType.SchulzVision] = "v4a1_peishita_game_grid4",
	[PeiShiTaEnum.CellType.ShootableRange] = "v4a1_peishita_game_grid5"
}
PeiShiTaEnum.WaitMoveAnimDoneKey = "PeiShiTaGameController;PeiShiTaEvent;OnMoveAnimDone;"
PeiShiTaEnum.WaitDieDoneKey = "PeiShiTaGameController;PeiShiTaEvent;OnUnitDieDone;"
PeiShiTaEnum.WaitLeaveAnimDoneKey = "PeiShiTaGameController;PeiShiTaEvent;OnLeaveAnimDone"
PeiShiTaEnum.WaitArcheryAnimDoneKey = "PeiShiTaGameController;PeiShiTaEvent;OnArcheryAnimDone"

return PeiShiTaEnum
