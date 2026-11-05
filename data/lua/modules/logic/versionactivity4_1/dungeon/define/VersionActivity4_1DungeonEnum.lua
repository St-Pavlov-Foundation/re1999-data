-- chunkname: @modules/logic/versionactivity4_1/dungeon/define/VersionActivity4_1DungeonEnum.lua

module("modules.logic.versionactivity4_1.dungeon.define.VersionActivity4_1DungeonEnum", package.seeall)

local VersionActivity4_1DungeonEnum = _M

VersionActivity4_1DungeonEnum.DungeonChapterId = {
	ElementFight = 41102,
	Story = 41101,
	Hard = 41201,
	Story1 = 41101,
	Story2 = 41301,
	Story3 = 41401
}
VersionActivity4_1DungeonEnum.EpisodeStarType = {
	[VersionActivity4_1DungeonEnum.DungeonChapterId.Story1] = {
		empty = "v3a2_dungeon_star_1_locked",
		light = "v3a2_dungeon_star_1"
	},
	[VersionActivity4_1DungeonEnum.DungeonChapterId.Story2] = {
		empty = "v3a2_dungeon_star_2_locked",
		light = "v3a2_dungeon_star_2"
	},
	[VersionActivity4_1DungeonEnum.DungeonChapterId.Story3] = {
		empty = "v3a2_dungeon_star_3_locked",
		light = "v3a2_dungeon_star_3"
	},
	[VersionActivity4_1DungeonEnum.DungeonChapterId.Hard] = {
		empty = "v3a2_dungeon_star_3_locked",
		light = "v3a2_dungeon_star_3"
	}
}
VersionActivity4_1DungeonEnum.BlockKey = {
	MapLevelViewPlayUnlockAnim = "VersionActivity4_1_MapLevelViewPlayUnlockAnim",
	MapViewPlayCloseAnim = "VersionActivity4_1_MapViewPlayCloseAnim",
	MapViewPlayOpenAnim = "VersionActivity4_1_MapViewPlayOpenAnim",
	TaskGetReward = "VersionActivity4_1_TaskItemGetReward",
	OpenTaskView = "VersionActivity4_1_OpenTaskView",
	FocusNewElement = "VersionActivity4_1_FocusNewElement"
}
VersionActivity4_1DungeonEnum.PlayerPrefsKey = {
	HasPlayedUnlockHardModeBtnAnim = "HasPlayedUnlockHardModeBtnAnim",
	OpenHardModeUnlockTip = "OpenHardModeUnlockTip",
	ActivityDungeonSpecialEpisodeLastUnLockMode = "ActivityDungeonSpecialEpisodeLastUnLockMode",
	ActivityDungeonSpecialEpisodeLastSelectMode = "ActivityDungeonSpecialEpisodeLastSelectMode"
}
VersionActivity4_1DungeonEnum.SceneRootName = "VersionActivity4_1DungeonMapScene"
VersionActivity4_1DungeonEnum.EpisodeItemMinWidth = 300
VersionActivity4_1DungeonEnum.DungeonMapCameraSize = 5
VersionActivity4_1DungeonEnum.MaxHoleNum = 5
VersionActivity4_1DungeonEnum.HoleHalfWidth = 3.5
VersionActivity4_1DungeonEnum.HoleHalfHeight = 1.75
VersionActivity4_1DungeonEnum.HoleAnimDuration = 0.33
VersionActivity4_1DungeonEnum.HoleAnimMaxZ = 3
VersionActivity4_1DungeonEnum.HoleAnimMinZ = 0
VersionActivity4_1DungeonEnum.OutSideAreaPos = {
	X = -1000,
	Y = -1000
}
VersionActivity4_1DungeonEnum.MapLevelCostPowerNormalColor = "#FFFFFF"

return VersionActivity4_1DungeonEnum
