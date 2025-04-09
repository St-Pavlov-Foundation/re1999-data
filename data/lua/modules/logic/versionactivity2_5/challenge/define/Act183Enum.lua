module("modules.logic.versionactivity2_5.challenge.define.Act183Enum", package.seeall)

slot0 = _M
slot0.EpisodeType = {
	Sub = 2,
	Boss = 1
}
slot0.GroupType = {
	NormalMain = 2,
	Daily = 1,
	HardMain = 3
}
slot0.EpisodeClsType = {
	[Act183Helper.getEpisodeClsKey(slot0.GroupType.Daily, slot0.EpisodeType.Boss)] = Act183DailyEpisodeItem,
	[Act183Helper.getEpisodeClsKey(slot0.GroupType.Daily, slot0.EpisodeType.Sub)] = Act183DailyEpisodeItem,
	[Act183Helper.getEpisodeClsKey(slot0.GroupType.NormalMain, slot0.EpisodeType.Boss)] = Act183MainBossEpisodeItem,
	[Act183Helper.getEpisodeClsKey(slot0.GroupType.NormalMain, slot0.EpisodeType.Sub)] = Act183MainNormalEpisodeItem,
	[Act183Helper.getEpisodeClsKey(slot0.GroupType.HardMain, slot0.EpisodeType.Boss)] = Act183MainBossEpisodeItem,
	[Act183Helper.getEpisodeClsKey(slot0.GroupType.HardMain, slot0.EpisodeType.Sub)] = Act183MainNormalEpisodeItem
}
slot0.GroupCategoryClsType = {
	[slot0.GroupType.Daily] = Act183DungeonBaseGroupItem,
	[slot0.GroupType.NormalMain] = Act183DungeonBaseGroupItem,
	[slot0.GroupType.HardMain] = Act183DungeonHardMainGroupItem
}
slot0.EpisodeStatus = {
	Finished = 3,
	Locked = 1,
	Unlocked = 2
}
slot0.GroupStatus = {
	Finished = 3,
	Locked = 1,
	Unlocked = 2
}
slot0.RuleStatus = {
	Repress = 2,
	Enabled = 0,
	Escape = 1
}
slot0.TaskListItemType = {
	Head = 1,
	Task = 2,
	OneKey = 3
}
slot0.TaskItemHeightMap = {
	[slot0.TaskListItemType.Head] = 52,
	[slot0.TaskListItemType.Task] = 158,
	[slot0.TaskListItemType.OneKey] = 158
}
slot0.TaskType = {
	NormalMain = 2,
	Daily = 1,
	HardMain = 3
}
slot0.TaskSubType = {
	Core = 1,
	Addition = 2
}
slot0.GroupTypeToTaskType = {
	[slot0.GroupType.Daily] = slot0.TaskType.Daily,
	[slot0.GroupType.NormalMain] = slot0.TaskType.NormalMain,
	[slot0.GroupType.HardMain] = slot0.TaskType.HardMain
}
slot0.TaskNameLangId = {
	[slot0.TaskType.Daily] = "act183taskview_dailytask",
	[slot0.TaskType.NormalMain] = "act183taskview_normalmaintask",
	[slot0.TaskType.HardMain] = "act183taskview_hardmaintask"
}
slot0.HeroType = {
	Trial = 2,
	Normal = 1
}
slot0.MaxMainSubEpisodesNum = 4
slot0.MaxDailySubEpisodesNum = 3
slot0.MainGroupBossEpisodeNum = 1
slot0.BossEpisodeMaxHeroNum = 5
slot0.Const = {
	MaxBadgeNum = 1,
	BadgeItemId = 6,
	PlayerClothIds = 7,
	RoundStage = 5
}
slot0.RuleEscapeAnimType = {
	RightTop2Center = 10,
	RightTop2LeftBottom = 6,
	LeftTop2RightBottom = 5,
	LeftTop2Center = 9,
	LeftBottom2Center = 11,
	LeftBottom2RightTop = 7,
	Top2Bottom = 1,
	RightBottom2LeftTop = 8,
	RightBottom2Center = 12,
	Bottom2Top = 2,
	Right2Left = 4,
	Left2Right = 3
}
slot0.ConditionStatus = {
	Pass = 2,
	Pass_Unselect = 3,
	Pass_Select = 4,
	Unpass = 1
}
slot0.ConditionStarImgName = {
	[slot0.ConditionStatus.Unpass] = "v2a5_challenge_settlement_bossstar1",
	[slot0.ConditionStatus.Pass] = "v2a5_challenge_settlement_bossstar2",
	[slot0.ConditionStatus.Pass_Unselect] = "v2a5_challenge_settlement_bossstar3",
	[slot0.ConditionStatus.Pass_Select] = "v2a5_challenge_settlement_bossstar2"
}
slot0.BattleNumToSnapShotType = {
	Default = ModuleEnum.HeroGroupSnapshotType.Act183Boss,
	[4] = ModuleEnum.HeroGroupSnapshotType.Act183Normal,
	[5] = ModuleEnum.HeroGroupSnapshotType.Act183Boss
}
slot0.EpisodeMaxStarNum = 3
slot0.ActType = 183
slot0.StoreEntryPrefabUrl = "ui/viewres/versionactivity_2_5/challenge/v2a5_challenge_storeentry.prefab"

return slot0
