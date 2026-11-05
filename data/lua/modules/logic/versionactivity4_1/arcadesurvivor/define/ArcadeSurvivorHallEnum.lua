-- chunkname: @modules/logic/versionactivity4_1/arcadesurvivor/define/ArcadeSurvivorHallEnum.lua

module("modules.logic.versionactivity4_1.arcadesurvivor.define.ArcadeSurvivorHallEnum", package.seeall)

local ArcadeSurvivorHallEnum = _M

ArcadeSurvivorHallEnum.Const = {
	GridSize = 0.813,
	PrefsOld = 1,
	StartY = -4.4,
	DelayShowCharacterTime = 0.5,
	GameSceneName = "ArcadeSurvivorHallScene",
	StartX = -4.4,
	Unknown = "???",
	SceneUrl = "scenes/v3a3_m_s12_bf/prefab/v3a3_m_s12_background_a_p.prefab",
	PrefsNew = 0,
	MinTalentLevel = 1,
	DefaultTalentIcon = "v4a1_eliminate_skillicon_1_1",
	LongPressArr = {
		0.3,
		0.3
	}
}
ArcadeSurvivorHallEnum.RewardItemStatus = {
	Gained = 2,
	CanGet = 1,
	Normal = 0
}
ArcadeSurvivorHallEnum.PlayerPrefsKey = {
	DifficultyFinishAnim = "DifficultyFinishAnim",
	HallNPCFirst = "HallNPCFirst",
	DevelopHeroPlayUnlockAnim = "DevelopHeroPlayUnlockAnim",
	DevelopHeroNew = "DevelopHeroNew"
}
ArcadeSurvivorHallEnum.ReddotType = {
	Normal = 1,
	New = 2,
	None = -1
}
ArcadeSurvivorHallEnum.TalkConditionType = {
	Trigger = "2",
	First = "1"
}
ArcadeSurvivorHallEnum.TalentType = {
	Simple = "simple",
	Complicated = "complicated"
}
ArcadeSurvivorHallEnum.HallInteractiveUnitId = {
	Difficulty1 = 107,
	Task = 106,
	Difficulty2 = 108,
	NPC = 103,
	Develop = 105,
	Difficulty3 = 109,
	HandBook = 104
}
ArcadeSurvivorHallEnum.ShowInfoUIType = {
	UITalk = 2,
	UIName = 1
}
ArcadeSurvivorHallEnum.ShowInfoUITypeRes = {
	[ArcadeSurvivorHallEnum.ShowInfoUIType.UIName] = "ui/viewres/versionactivity_3_3/v3a3_eliminate/v3a3_eliminate_building_info.prefab",
	[ArcadeSurvivorHallEnum.ShowInfoUIType.UITalk] = "ui/viewres/versionactivity_3_3/v3a3_eliminate/v3a3_eliminate_hero_talk.prefab"
}
ArcadeSurvivorHallEnum.ShowInfoUITypeComp = {
	[ArcadeSurvivorHallEnum.ShowInfoUIType.UIName] = ArcadeSurvivorBuildingUIItem,
	[ArcadeSurvivorHallEnum.ShowInfoUIType.UITalk] = ArcadeSurvivorHeroTalkItem
}
ArcadeSurvivorHallEnum.HandBookType = {
	Floor = 4,
	Item = 3,
	Monster = 2,
	Character = 1
}
ArcadeSurvivorHallEnum.HandBookTypeCls = {
	[ArcadeSurvivorHallEnum.HandBookType.Character] = ArcadeSurvivorHandBookCharacterMO,
	[ArcadeSurvivorHallEnum.HandBookType.Monster] = ArcadeSurvivorHandBookMonsterMO,
	[ArcadeSurvivorHallEnum.HandBookType.Item] = ArcadeSurvivorHandBookItemMO,
	[ArcadeSurvivorHallEnum.HandBookType.Floor] = ArcadeSurvivorHandBookFloorMO
}
ArcadeSurvivorHallEnum.EntityType2HandBookType = {
	[ArcadeSurvivorEnum.EntityType.Character] = ArcadeSurvivorHallEnum.HandBookType.Character,
	[ArcadeSurvivorEnum.EntityType.Monster] = ArcadeSurvivorHallEnum.HandBookType.Monster,
	[ArcadeSurvivorEnum.EntityType.Floor] = ArcadeSurvivorHallEnum.HandBookType.Floor
}
ArcadeSurvivorHallEnum.HandBookItemParams = {
	MinSize = 128,
	RowCount = 3,
	StartY = 6,
	StartX = 16,
	SpaceY = 100,
	MaxWidth = 580,
	DiffY = 100,
	DiffX = 30,
	SpaceX = 22
}

return ArcadeSurvivorHallEnum
