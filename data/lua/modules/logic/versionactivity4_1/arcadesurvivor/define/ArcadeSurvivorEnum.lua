-- chunkname: @modules/logic/versionactivity4_1/arcadesurvivor/define/ArcadeSurvivorEnum.lua

module("modules.logic.versionactivity4_1.arcadesurvivor.define.ArcadeSurvivorEnum", package.seeall)

local ArcadeSurvivorEnum = _M

ArcadeSurvivorEnum.ConstId = {
	HpColorList = 15,
	HpItemSpace = 14,
	LoperaLevelFinishTip = 45,
	DefaultEquipHero = 1,
	LevelFinishTip = 44,
	GameBaseUIGridSize = 41,
	NextStepTimeMS = 5,
	MaxShowHpCount = 13,
	HpBarScale = 16,
	TargetScore = 52,
	FirstGameGuideId = 36,
	BossFinishTip = 48,
	FightFloatDamageThresholds = 50,
	DangerWarningKeepTime = 47,
	TalkIntervalTime = 35,
	HurtDeduct = 54,
	BattleStartTip = 46,
	GameBaseGridSize = 27,
	HurtScore = 53,
	KillScore = 51,
	GameBaseViewSize = 6,
	LoperaBossFinishTip = 49,
	HallGridSize = 4,
	DefaultHallHeroPos = 3
}
ArcadeSurvivorEnum.Const = {
	HeroMoveSpeed = 0.2,
	PermillageBase = 1000,
	CollectionTagRareBg = "v4a1_eliminate_shop_tag%s",
	TimeFrameBg = "v4a1_eliminate_frame%s",
	MinimumEntitySize = 1,
	HeartIcon = "v4a1_eliminate_heart_%s",
	ShopCollectionBg = "v4a1_eliminate_shop_bg%s",
	CollectionFrame = "v4a1_eliminate_handbook_bg%s",
	PositionEPS = 0.01,
	CollectionRareBg = "v4a1_eliminate_main_collectionbg%s",
	PercentBase = 100,
	MapCameraSize = 5,
	SceneAnimController = "v4a1_m_s12_arcade_game_scene.controller",
	HpItemResName = "v3a3_m_s12_dj_a01"
}
ArcadeSurvivorEnum.ResDir = {
	ScenePrefab = "scene_prefabs",
	SceneRes = "modules/arcade_survivor/scene",
	VX = "vx/v4a1",
	EntityPrefab = "prefabs"
}
ArcadeSurvivorEnum.BlockKey = {
	ResultView = "ArcadeSurvivorResultViewBlockKey",
	LoadHallScene = "ArcadeSurvivorLoadHallSceneBlockKey",
	SelectedEvent = "ArcadeSurvivorSelectEvent",
	ShopOnBuy = "ArcadeSurvivorShopOnBuy",
	LoadGameScene = "ArcadeSurvivorLoadGameSceneBlockKey",
	Opening = "ArcadeSurvivorOpeningBlockKey",
	DangerWarning = "ArcadeSurvivorDangerWarningBlockKey",
	ChoicePackCollection = "ArcadeSurvivorChoicePackCollection"
}
ArcadeSurvivorEnum.Currency = {
	Coin = 1,
	Diamond = 2,
	Cassette = 3
}
ArcadeSurvivorEnum.SettleCurrency = {
	ArcadeSurvivorEnum.Currency.Diamond,
	ArcadeSurvivorEnum.Currency.Cassette
}
ArcadeSurvivorEnum.EffectType = {
	Weapon = 1,
	Collection = 2
}
ArcadeSurvivorEnum.EntityType = {
	Floor = "floor",
	Grid = "grid",
	Character = "character",
	Ally = "ally",
	Monster = "monster"
}
ArcadeSurvivorEnum.MonsterType = {
	Neutral = "neutral",
	Boss = "boss",
	Elite = "elite",
	Normal = "normal"
}
ArcadeSurvivorEnum.Attribute = {
	hpCap = 2,
	atkWidth = 5,
	hp = 1,
	criDmgRate = 10,
	dodgeRate = 11,
	respawnTimes = 12,
	atkCount = 7,
	criRate = 9,
	atkInterval = 6,
	atk = 3,
	atkLength = 4,
	dmgAddRate = 8
}
ArcadeSurvivorEnum.ActionShowId = {
	Born = 1,
	Respawn = 5,
	DropCoin = 6,
	Alert = 3,
	Duel = 4,
	Move = 2
}
ArcadeSurvivorEnum.StateShowId = {
	Idle = 1,
	Dead = 2
}
ArcadeSurvivorEnum.GridShowMode = {
	Afterimage = 3,
	GroupBullet = 2,
	Grayscale = 4,
	Area = 1,
	Normal = 0
}
ArcadeSurvivorEnum.BulletShowParam = {
	GroupBulletWithStartPos = "2",
	BulletShow = "1"
}
ArcadeSurvivorEnum.Direction = {
	Down = 2,
	Up = 1,
	Right = 4,
	LeftUp = 7,
	RightDown = 6,
	RightUp = 5,
	Left = 3,
	LeftDown = 8
}
ArcadeSurvivorEnum.AxisDirection = {
	ArcadeSurvivorEnum.Direction.Up,
	ArcadeSurvivorEnum.Direction.Down,
	ArcadeSurvivorEnum.Direction.Left,
	ArcadeSurvivorEnum.Direction.Right
}
ArcadeSurvivorEnum.DirChangeGridX = {
	[ArcadeSurvivorEnum.Direction.Up] = 0,
	[ArcadeSurvivorEnum.Direction.Down] = 0,
	[ArcadeSurvivorEnum.Direction.Left] = -1,
	[ArcadeSurvivorEnum.Direction.Right] = 1,
	[ArcadeSurvivorEnum.Direction.RightUp] = 1,
	[ArcadeSurvivorEnum.Direction.RightDown] = 1,
	[ArcadeSurvivorEnum.Direction.LeftUp] = -1,
	[ArcadeSurvivorEnum.Direction.LeftDown] = -1
}
ArcadeSurvivorEnum.DirChangeGridY = {
	[ArcadeSurvivorEnum.Direction.Up] = 1,
	[ArcadeSurvivorEnum.Direction.Down] = -1,
	[ArcadeSurvivorEnum.Direction.Left] = 0,
	[ArcadeSurvivorEnum.Direction.Right] = 0,
	[ArcadeSurvivorEnum.Direction.RightUp] = 1,
	[ArcadeSurvivorEnum.Direction.RightDown] = -1,
	[ArcadeSurvivorEnum.Direction.LeftUp] = 1,
	[ArcadeSurvivorEnum.Direction.LeftDown] = -1
}
ArcadeSurvivorEnum.Dir2RotationVal = {
	[ArcadeSurvivorEnum.Direction.Up] = 90,
	[ArcadeSurvivorEnum.Direction.Down] = 270,
	[ArcadeSurvivorEnum.Direction.Left] = 180,
	[ArcadeSurvivorEnum.Direction.Right] = 0,
	[ArcadeSurvivorEnum.Direction.RightUp] = 45,
	[ArcadeSurvivorEnum.Direction.RightDown] = -45,
	[ArcadeSurvivorEnum.Direction.LeftUp] = 135,
	[ArcadeSurvivorEnum.Direction.LeftDown] = 225
}
ArcadeSurvivorEnum.DirectionHexPointDict = {
	[ArcadeSurvivorEnum.Direction.Up] = {
		x = 0,
		y = 1
	},
	[ArcadeSurvivorEnum.Direction.Down] = {
		x = 0,
		y = -1
	},
	[ArcadeSurvivorEnum.Direction.Left] = {
		x = -1,
		y = 0
	},
	[ArcadeSurvivorEnum.Direction.Right] = {
		x = 1,
		y = 0
	}
}
ArcadeSurvivorEnum.TipType = {
	Weapon = 4,
	Building = 1,
	Hero = 3,
	Collection = 2,
	Event = 6,
	Currency = 5
}
ArcadeSurvivorEnum.TipTypeView = {
	[ArcadeSurvivorEnum.TipType.Building] = ArcadeSurvivorBuildingTipsView,
	[ArcadeSurvivorEnum.TipType.Collection] = ArcadeSurvivorCollectionTipsView,
	[ArcadeSurvivorEnum.TipType.Hero] = ArcadeSurvivorHeroTipsView,
	[ArcadeSurvivorEnum.TipType.Weapon] = ArcadeSurvivorWeaponTipsView,
	[ArcadeSurvivorEnum.TipType.Currency] = ArcadeSurvivorCurrencyTipsView,
	[ArcadeSurvivorEnum.TipType.Event] = ArcadeSurvivorEventTipView
}
ArcadeSurvivorEnum.TipTypeRes = {
	[ArcadeSurvivorEnum.TipType.Building] = "modules/arcade_survivor/ui/viewres/tips/arcade_survivor_buildingtipsview.prefab",
	[ArcadeSurvivorEnum.TipType.Collection] = "modules/arcade_survivor/ui/viewres/tips/arcade_survivor_collectiontipsview.prefab",
	[ArcadeSurvivorEnum.TipType.Hero] = "modules/arcade_survivor/ui/viewres/tips/arcade_survivor_herotipsview.prefab",
	[ArcadeSurvivorEnum.TipType.Weapon] = "modules/arcade_survivor/ui/viewres/tips/arcade_survivor_weapontipsview.prefab",
	[ArcadeSurvivorEnum.TipType.Currency] = "modules/arcade_survivor/ui/viewres/tips/arcade_survivor_currencytipsview.prefab",
	[ArcadeSurvivorEnum.TipType.Event] = "modules/arcade_survivor/ui/viewres/tips/arcade_survivor_eventtipsview.prefab"
}

return ArcadeSurvivorEnum
