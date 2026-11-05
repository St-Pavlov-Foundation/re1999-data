-- chunkname: @modules/logic/versionactivity4_1/enter/define/VersionActivity4_1Enum.lua

module("modules.logic.versionactivity4_1.enter.define.VersionActivity4_1Enum", package.seeall)

local VersionActivity4_1Enum = _M

VersionActivity4_1Enum.ActivityId = {
	Act248 = 14104,
	GuessGameNew = 14113,
	PeiShiTa = 14121,
	Season = 14105,
	ArcadeSurvivor = 14109,
	RoleStory = 14127,
	DungeonStore = 14103,
	Evelyn = 14120,
	Dungeon = 14102,
	SeasonStore = 14106,
	EnterView = 14101
}
VersionActivity4_1Enum.EnterViewActSetting = {
	{
		actId = VersionActivity4_1Enum.ActivityId.Dungeon,
		actLevel = VersionActivityEnterViewEnum.ActLevel.First,
		actType = VersionActivityEnterViewEnum.ActType.Single,
		storeId = VersionActivity4_1Enum.ActivityId.DungeonStore
	},
	{
		actId = BossRushConfig.instance:getActivityId(),
		actLevel = VersionActivityEnterViewEnum.ActLevel.Second,
		actType = VersionActivityEnterViewEnum.ActType.Single
	},
	{
		actId = VersionActivity4_1Enum.ActivityId.ArcadeSurvivor,
		actLevel = VersionActivityEnterViewEnum.ActLevel.Second,
		actType = VersionActivityEnterViewEnum.ActType.Single
	},
	{
		actId = VersionActivity4_1Enum.ActivityId.Evelyn,
		actLevel = VersionActivityEnterViewEnum.ActLevel.Second,
		actType = VersionActivityEnterViewEnum.ActType.Single
	},
	{
		actId = VersionActivity4_1Enum.ActivityId.PeiShiTa,
		actLevel = VersionActivityEnterViewEnum.ActLevel.Second,
		actType = VersionActivityEnterViewEnum.ActType.Single
	},
	{
		actId = VersionActivity4_1Enum.ActivityId.Season,
		actLevel = VersionActivityEnterViewEnum.ActLevel.Second,
		actType = VersionActivityEnterViewEnum.ActType.Single,
		storeId = VersionActivity4_1Enum.ActivityId.SeasonStore
	},
	{
		actId = VersionActivity4_1Enum.ActivityId.RoleStory,
		actLevel = VersionActivityEnterViewEnum.ActLevel.Second,
		actType = VersionActivityEnterViewEnum.ActType.Single
	},
	{
		actId = ActivityEnum.Activity.WeekWalkDeepShow,
		actLevel = VersionActivityEnterViewEnum.ActLevel.Second,
		actType = VersionActivityEnterViewEnum.ActType.Single,
		redDotUid = ActivityEnum.Activity.WeekWalkDeepShow
	},
	{
		actId = ActivityEnum.Activity.Tower,
		actLevel = VersionActivityEnterViewEnum.ActLevel.Second,
		actType = VersionActivityEnterViewEnum.ActType.Single
	},
	{
		actId = ActivityEnum.Activity.WeekWalkHeartShow,
		actLevel = VersionActivityEnterViewEnum.ActLevel.Second,
		actType = VersionActivityEnterViewEnum.ActType.Single,
		redDotUid = ActivityEnum.Activity.WeekWalkHeartShow
	},
	{
		actId = AbyssConfig.instance:getActivityId(),
		actLevel = VersionActivityEnterViewEnum.ActLevel.Second,
		actType = VersionActivityEnterViewEnum.ActType.Single
	}
}
VersionActivity4_1Enum.CharacterActId = {
	[VersionActivity4_1Enum.ActivityId.Evelyn] = true,
	[VersionActivity4_1Enum.ActivityId.PeiShiTa] = true
}
VersionActivity4_1Enum.EnterViewActIdListWithRedDot = {
	VersionActivity4_1Enum.ActivityId.Dungeon
}
VersionActivity4_1Enum.TabSetting = {
	select = {
		fontSize = 30,
		cnColor = "#FAF9E6",
		enFontSize = 14,
		enColor = "#144844",
		act2TabImg = {
			[VersionActivity4_1Enum.ActivityId.Dungeon] = "singlebg_lang/txt_V4a1_mainactivity_singlebg/v4a1_enterview_itemtitleselected.png"
		}
	},
	unselect = {
		fontSize = 30,
		cnColor = "#857d71",
		enFontSize = 14,
		enColor = "#144844",
		act2TabImg = {
			[VersionActivity4_1Enum.ActivityId.Dungeon] = "singlebg_lang/txt_V4a1_mainactivity_singlebg/v4a1_enterview_itemtitleselected.png"
		}
	}
}
VersionActivity4_1Enum.MaxShowTimeOffset = 3 * TimeUtil.OneDaySecond
VersionActivity4_1Enum.RedDotOffsetY = 56
VersionActivity4_1Enum.RedDotOffsetX = 10
VersionActivity4_1Enum.EnterLoopVideoName = "v4a1_kv_loop"
VersionActivity4_1Enum.EnterAnimVideoName = "v4a1_kv_open"
VersionActivity4_1Enum.EnterVideoDayKey = "V4a1_EnterVideoDayKey"
VersionActivity4_1Enum.EnterVideoFirstKey = "V4a1_EnterVideoFirstKey"
VersionActivity4_1Enum.OpenAnimDelayTime = 8.4
VersionActivity4_1Enum.KV_VIDEO_DURATION = 10
VersionActivity4_1Enum.ScriptSuffix = 1

return VersionActivity4_1Enum
