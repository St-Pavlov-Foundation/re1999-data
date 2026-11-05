-- chunkname: @modules/logic/versionactivity4_1/evelyn/define/EvelynEnum.lua

module("modules.logic.versionactivity4_1.evelyn.define.EvelynEnum", package.seeall)

local EvelynEnum = _M

EvelynEnum.LockScreenKey = "EvelynLockScreen"
EvelynEnum.PointType = {
	Origin = 1,
	Res = 3,
	End = 4,
	Tool = 2
}
EvelynEnum.MapBgScaleValue = 0.5
EvelynEnum.MapBgMoveValue = 0.5
EvelynEnum.FirstNodeId = 1
EvelynEnum.FirstSubType = 1
EvelynEnum.CompleteScale = 0.7
EvelynEnum.MapOriginSize = 0.2
EvelynEnum.CompleteScale = 0.7
EvelynEnum.AnimTime = {
	BeforeComplete = 1.5,
	PointDone = 1.33,
	CamMoveDuration = 0.2,
	Complete = 3,
	ToolStepInterval = 0.9,
	ToolDragSuccess = 0.5,
	GuideComplete = 1,
	ToolDragFail = 0.5,
	IntroZoomDuration = 0.5,
	IntroMoveDuration = 0.2,
	ToolToRes = 2,
	OpenAnimDuration = 1.1,
	ResetAnimDuration = 0.7
}
EvelynEnum.EdgeMoveDistance = 100
EvelynEnum.EdgeMoveSpeed = 500
EvelynEnum.PanelDefaultOffset = {
	X = 0,
	Y = 0
}
EvelynEnum.GuideTips = {
	[41402] = {
		nil,
		nil,
		"v4a1_evelyn_guide_tip1",
		"v4a1_evelyn_guide_tip1",
		"v4a1_evelyn_guide_tip2"
	}
}
EvelynEnum.GuideDisableScaleOperationBefore = 41402
EvelynEnum.PanelDefaultScale = 1
EvelynEnum.AnimatorName = {
	Finish = "finish",
	Reset = "reset",
	Idle = "idle",
	Close = "close",
	Done = "done",
	Unlock = "unlock",
	Open = "open"
}
EvelynEnum.CurveAngle = {
	Down = -65,
	Up = 65
}
EvelynEnum.BgOffsetLimit = 80
EvelynEnum.BgArrowDistance = 100
EvelynEnum.BaseAngleDistance = 200
EvelynEnum.DetailOffset = {
	X = 0,
	Y = 30
}
EvelynEnum.ToolDetailItemOffset = {
	X = 0,
	Y = 260
}
EvelynEnum.GameId2Guide = {
	[1003] = 41407,
	[1001] = 41403,
	[1002] = 41405,
	[1004] = 41409
}
EvelynEnum.Guide2GameId = {
	[41405] = 1002,
	[41403] = 1001,
	[41407] = 1003,
	[41409] = 1004
}
EvelynEnum.GuideFunctionState = {
	Enable = 1,
	Disable = 0
}
EvelynEnum.LevelBgDir = "singlebg/v4a1_yifulin_singlebg"
EvelynEnum.LevelBgName = "v4a1_yifulin_level_fullbg"
EvelynEnum.LevelBgDiffName = "v4a1_yifulin_level_fullbg2"
EvelynEnum.TaskBgName = "v4a1_yifulin_task_fullbg"
EvelynEnum.TaskBgDiffName = "v4a1_yifulin_task_fullbg2"

return EvelynEnum
