﻿module("modules.logic.versionactivity1_5.aizila.define.AiZiLaEnum", package.seeall)

local var_0_0 = _M

var_0_0.AnimatorTime = {
	HandbookViewClose = 0.3,
	EpsiodeDetailViewClose = 0.3,
	EquipViewClose = 0.3,
	ViewClose = 0.01,
	TaskRewardMoveUp = 0.15,
	GameEventViewClose = 0.3,
	EffectViewOpen = 3.3,
	MapViewOpen = 1,
	ViewOpen = 1,
	TaskReward = 0.5,
	MapViewRise = 2.3,
	MapViewClose = 0.3
}
var_0_0.ComponentType = {
	Animator = typeof(UnityEngine.Animator)
}
var_0_0.RareIcon = {
	"v1a5_aizila_quality4",
	"v1a5_aizila_quality4",
	"v1a5_aizila_quality3",
	"v1a5_aizila_quality2",
	"v1a5_aizila_quality1"
}
var_0_0.TaskMOAllFinishId = -100
var_0_0.AllStoryEpisodeId = -100
var_0_0.OpenStoryEpisodeId = -1
var_0_0.EventType = {
	BranchLine = 1
}
var_0_0.UITaskItemHeight = {
	ItemTab = 67,
	ItemCell = 161
}
var_0_0.Guide = {
	FirstEnter = 15401
}

return var_0_0
