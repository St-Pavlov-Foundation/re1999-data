module("modules.logic.versionactivity2_7.dungeon.define.VersionActivity2_7DungeonEnum", package.seeall)

slot0 = _M
slot0.DungeonChapterId = {
	ElementFight = 27102,
	Story = 27101,
	Hard = 27201,
	Story1 = 27101,
	Story2 = 27301,
	Story3 = 27401
}
slot0.EpisodeStarType = {
	[slot0.DungeonChapterId.Story1] = {
		empty = "v2a7_dungeon_star_1_locked",
		light = "v2a7_dungeon_star_1"
	},
	[slot0.DungeonChapterId.Story2] = {
		empty = "v2a7_dungeon_star_2_locked",
		light = "v2a7_dungeon_star_2"
	},
	[slot0.DungeonChapterId.Story3] = {
		empty = "v2a7_dungeon_star_3_locked",
		light = "v2a7_dungeon_star_3"
	},
	[slot0.DungeonChapterId.Hard] = {
		empty = "v2a7_dungeon_star_3_locked",
		light = "v2a7_dungeon_star_3"
	}
}
slot0.BlockKey = {
	MapLevelViewPlayUnlockAnim = "VersionActivity2_7_MapLevelViewPlayUnlockAnim",
	MapViewPlayCloseAnim = "VersionActivity2_7_MapViewPlayCloseAnim",
	MapViewPlayOpenAnim = "VersionActivity2_7_MapViewPlayOpenAnim",
	TaskGetReward = "VersionActivity2_7_TaskItemGetReward",
	OpenTaskView = "VersionActivity2_7_OpenTaskView",
	FocusNewElement = "VersionActivity2_7_FocusNewElement"
}
slot0.PlayerPrefsKey = {
	HasPlayedUnlockHardModeBtnAnim = "HasPlayedUnlockHardModeBtnAnim",
	OpenHardModeUnlockTip = "OpenHardModeUnlockTip",
	ActivityDungeonSpecialEpisodeLastUnLockMode = "ActivityDungeonSpecialEpisodeLastUnLockMode",
	ActivityDungeonSpecialEpisodeLastSelectMode = "ActivityDungeonSpecialEpisodeLastSelectMode"
}
slot0.SceneRootName = "VersionActivity2_7DungeonMapScene"
slot0.EpisodeItemMinWidth = 250
slot0.DungeonMapCameraSize = 5
slot0.MaxHoleNum = 5
slot0.HoleHalfWidth = 3.5
slot0.HoleHalfHeight = 1.75
slot0.HoleAnimDuration = 0.33
slot0.HoleAnimMaxZ = 3
slot0.HoleAnimMinZ = 0
slot0.OutSideAreaPos = {
	X = -1000,
	Y = -1000
}
slot0.SpaceSceneEpisodeIndexs = {
	18,
	19
}
slot0.SceneLoadObj = "ui/viewres/versionactivity_2_7/v2a7_enter/v2a7_m_s08_hddt.prefab"
slot0.SceneLoadAnim = "explore/camera_anim/hddt_camer.controller"
slot0.SpaceScene = "scenes/v2a7_m_s08_hddt/scenes_prefab/v2a7_m_s08_hddt_002_p.prefab"
slot0.GotoSpaceAnimName = "switch1"
slot0.returnAnimName = "switch2"
slot0.DragEndAnimTime = 1.2
slot0.DragSpeed = 1
slot0.SceneAnimType = {
	Normal = 3,
	ReturnEarth = 2,
	GotoSpace = 1
}

return slot0
