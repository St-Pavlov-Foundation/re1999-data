-- chunkname: @modules/logic/versionactivity4_1/arcadesurvivor/define/ArcadeSurvivorGameEnum.lua

module("modules.logic.versionactivity4_1.arcadesurvivor.define.ArcadeSurvivorGameEnum", package.seeall)

local ArcadeSurvivorGameEnum = _M

ArcadeSurvivorGameEnum.Const = {
	RespawnTimesCost = -1,
	CharacterUid = 0,
	EffectZLevel = -0.15,
	DefaultConsumeBuffStack = 1,
	MinimumSize = 1,
	CustomSaveDisableVal = "",
	MaxBTNodeDepth = 64,
	EventCount = 3,
	MinimumCoordinate = 1,
	FightFloatWaitTime = 0.1,
	TileZLevel = -0.1,
	GuideDifficulty = 0,
	HpZLevel = -0.1,
	BossDeathFocusScale = 1.5,
	SPRarity = 3,
	LoperaHeroId = 104,
	DuelFireShowId = 4181007,
	DefaultCharacterTurnTime = 1.2,
	MaxSkillTriggerCount = 500,
	PrintLog = true,
	AlertBreakHideTime = 2,
	GameSceneName = "ArcadeSurvivorGameScene",
	CustomSaveEnableVal = "1",
	NoneSkillSourceId = 0,
	EntityZLevel = -0.2,
	TimeFrameBgCount = 6,
	EntityPrefabNode = "prefabs",
	RootNodeMaxChild = 1,
	BossDeathFocusTime = 0.25,
	BurnBuffDamage = 5,
	MonsterSpawnAreaWidth = 3,
	BurnBuffRange = "3,3",
	BossDeathShowId = 4181034,
	GameSceneContentNode = "content",
	DamageLock = 1,
	GameSceneResNode = "scene",
	GameSceneRoot = "root",
	DefaultDirection = ArcadeSurvivorEnum.Direction.Right
}
ArcadeSurvivorGameEnum.StopSource = {
	QuitTip = 3,
	Shop = 2,
	Opening = 9,
	GameTransfer = 4,
	BossDeath = 7,
	Respawn = 10,
	GMRuntimeMonitor = 11,
	DialogTalk = 6,
	DangerWarning = 5,
	ViewOverlay = 8,
	SelectEvent = 1
}
ArcadeSurvivorGameEnum.ShopGoodsType = {
	Pack = "pack",
	Collection = "collection"
}
ArcadeSurvivorGameEnum.ShopGoodsHandler = {
	[ArcadeSurvivorGameEnum.ShopGoodsType.Collection] = {
		priceFunc = ArcadeSurvivorGameHelper.getGoodsCollectionPrice,
		buyFunc = ArcadeSurvivorGameHelper.buyCollection
	},
	[ArcadeSurvivorGameEnum.ShopGoodsType.Pack] = {
		priceFunc = ArcadeSurvivorGameHelper.getGoodsPackPrice,
		buyFunc = ArcadeSurvivorGameHelper.buyPack
	}
}
ArcadeSurvivorGameEnum.CustomSaveInfoKey = {
	TotalScore = 8,
	KillMonsterNum = 4,
	RuleStates = 7,
	ShopRefreshCount = 9,
	LockGoodsDict = 11,
	PassLevelCount = 3,
	ShopStatus = 1,
	TotalGainCoin = 5,
	SelectEvent = 6,
	OpenEventSelect = 2
}
ArcadeSurvivorGameEnum.SkillSourceType = {
	Collection = 2,
	Buff = 3,
	Normal = 1
}
ArcadeSurvivorGameEnum.SkillSourceTypeValidDict = {
	[ArcadeSurvivorGameEnum.SkillSourceType.Normal] = true,
	[ArcadeSurvivorGameEnum.SkillSourceType.Collection] = true,
	[ArcadeSurvivorGameEnum.SkillSourceType.Buff] = true
}
ArcadeSurvivorGameEnum.CustomSaveResultStatisticsKeyDict = {
	[ArcadeSurvivorGameEnum.CustomSaveInfoKey.PassLevelCount] = true,
	[ArcadeSurvivorGameEnum.CustomSaveInfoKey.KillMonsterNum] = true,
	[ArcadeSurvivorGameEnum.CustomSaveInfoKey.TotalGainCoin] = true
}
ArcadeSurvivorGameEnum.SettleType = {
	Abandon = 1,
	Fail = 3,
	Win = 2
}
ArcadeSurvivorGameEnum.CharacterUnlockType = {
	PassDifficulty = 3,
	TotalKillMonsterCount = 2,
	UseCharacterWin = 4,
	KillMonster = 1
}
ArcadeSurvivorGameEnum.RuleType = {
	AttrConvert = "attrConvert",
	CollAttr = "collAttr",
	FreeRefresh = "freeRefresh",
	LaterQuality = "laterQuality",
	ShopWeight = "shopWeight",
	ShopDiscount = "shopDiscount",
	HpPurchase = "hpPurchase",
	MonsterSpawn = "monsterSpawn",
	LevelConst = "levelConst",
	SpendReward = "spendReward",
	RandomPack = "randomPack",
	DupReward = "dupReward",
	ExitCoin = "exitCoin",
	PackPick = "packPick",
	ReplaceShop = "replaceShop"
}
ArcadeSurvivorGameEnum.RuleTypeCls = {
	[ArcadeSurvivorGameEnum.RuleType.CollAttr] = ArcadeSurvivorGameCollAttrRule,
	[ArcadeSurvivorGameEnum.RuleType.AttrConvert] = ArcadeSurvivorGameAttrConvertRule,
	[ArcadeSurvivorGameEnum.RuleType.RandomPack] = ArcadeSurvivorGameRandomPackRule,
	[ArcadeSurvivorGameEnum.RuleType.FreeRefresh] = ArcadeSurvivorGameFreeRefreshRule,
	[ArcadeSurvivorGameEnum.RuleType.ReplaceShop] = ArcadeSurvivorGameReplaceShopRule,
	[ArcadeSurvivorGameEnum.RuleType.DupReward] = ArcadeSurvivorGameDupRewardRule,
	[ArcadeSurvivorGameEnum.RuleType.LaterQuality] = ArcadeSurvivorGameLaterQualityRule,
	[ArcadeSurvivorGameEnum.RuleType.ShopWeight] = ArcadeSurvivorGameShopWeightRule,
	[ArcadeSurvivorGameEnum.RuleType.ShopDiscount] = ArcadeSurvivorGameShopDiscountRule,
	[ArcadeSurvivorGameEnum.RuleType.ExitCoin] = ArcadeSurvivorGameExitCoinRule,
	[ArcadeSurvivorGameEnum.RuleType.SpendReward] = ArcadeSurvivorGameSpendRewardRule,
	[ArcadeSurvivorGameEnum.RuleType.HpPurchase] = ArcadeSurvivorGameHpPurchaseRule,
	[ArcadeSurvivorGameEnum.RuleType.PackPick] = ArcadeSurvivorGamePackPickRule,
	[ArcadeSurvivorGameEnum.RuleType.LevelConst] = ArcadeSurvivorGameLevelConstRule,
	[ArcadeSurvivorGameEnum.RuleType.MonsterSpawn] = ArcadeSurvivorGameMonsterSpawnRule
}
ArcadeSurvivorGameEnum.RuleTypeOnceApply = {
	[ArcadeSurvivorGameEnum.RuleType.CollAttr] = true,
	[ArcadeSurvivorGameEnum.RuleType.AttrConvert] = true,
	[ArcadeSurvivorGameEnum.RuleType.RandomPack] = true
}
ArcadeSurvivorGameEnum.RuleSourceType = {
	Event = 2,
	Collection = 1
}
ArcadeSurvivorGameEnum.DialogTalkCondition = {
	Hp = "hp",
	Intro = "intro"
}
ArcadeSurvivorGameEnum.DialogTalkConditionHandler = {
	[ArcadeSurvivorGameEnum.DialogTalkCondition.Intro] = {},
	[ArcadeSurvivorGameEnum.DialogTalkCondition.Hp] = {
		skipUnselectedCandidates = true,
		checkFunc = ArcadeSurvivorGameHelper.checkHpDialogFunc,
		pickFunc = ArcadeSurvivorGameHelper.pickHpDialogFunc
	}
}
ArcadeSurvivorGameEnum.BuffType = {
	ChangeAttr = "changeAttr",
	CritOverflow = "critOverflow",
	PoisonNoDecay = "poisonNoDecay",
	EmptyBuff = "",
	Immunity = "immunity",
	Poison = "poison",
	Evasion = "evasion",
	DamageLock = "damageLock",
	Burn = "burn",
	AddSkill = "addSkill",
	BurnSpread = "burnSpread"
}
ArcadeSurvivorGameEnum.BuffClsMap = {
	[ArcadeSurvivorGameEnum.BuffType.EmptyBuff] = ArcadeSurvivorGameBaseBuff,
	[ArcadeSurvivorGameEnum.BuffType.ChangeAttr] = ArcadeSurvivorGameChangeAttrBuff,
	[ArcadeSurvivorGameEnum.BuffType.Burn] = ArcadeSurvivorGameBurnBuff,
	[ArcadeSurvivorGameEnum.BuffType.Poison] = ArcadeSurvivorGamePoisonBuff,
	[ArcadeSurvivorGameEnum.BuffType.CritOverflow] = ArcadeSurvivorGameCritOverflowBuff,
	[ArcadeSurvivorGameEnum.BuffType.DamageLock] = ArcadeSurvivorGameDamageLockBuff,
	[ArcadeSurvivorGameEnum.BuffType.AddSkill] = ArcadeSurvivorGameSkillBuff,
	[ArcadeSurvivorGameEnum.BuffType.Evasion] = ArcadeSurvivorGameEvasionBuff,
	[ArcadeSurvivorGameEnum.BuffType.Immunity] = ArcadeSurvivorGameImmunityBuff,
	[ArcadeSurvivorGameEnum.BuffType.PoisonNoDecay] = ArcadeSurvivorGamePoisonNoDecayBuff,
	[ArcadeSurvivorGameEnum.BuffType.BurnSpread] = ArcadeSurvivorGameBurnSpreadBuff
}
ArcadeSurvivorGameEnum.BuffTickEvent = {
	BurnSpreadTick = "BurnSpreadTick",
	TurnEnd = "TurnEnd",
	BeforeDamage = "BeforeDamage",
	Crit = "Crit",
	PoisonNoDecayTick = "PoisonNoDecayTick"
}
ArcadeSurvivorGameEnum.BuffModifyValue = {
	CritDamageRate = "critDamageRate",
	PoisonBuffNotConsume = "poisonBuffNotConsume",
	Damage = "damage"
}
ArcadeSurvivorGameEnum.EntityTypeMOCls = {
	[ArcadeSurvivorEnum.EntityType.Monster] = ArcadeSurvivorGameMonsterMO,
	[ArcadeSurvivorEnum.EntityType.Ally] = ArcadeSurvivorGameAllyMO,
	[ArcadeSurvivorEnum.EntityType.Floor] = ArcadeSurvivorGameFloorMO
}
ArcadeSurvivorGameEnum.EntityTypeCls = {
	[ArcadeSurvivorEnum.EntityType.Monster] = ArcadeSurvivorGameBaseEntity,
	[ArcadeSurvivorEnum.EntityType.Ally] = ArcadeSurvivorGameBaseEntity,
	[ArcadeSurvivorEnum.EntityType.Floor] = ArcadeSurvivorGameBaseEntity
}
ArcadeSurvivorGameEnum.IconEntityTypes = {
	ArcadeSurvivorEnum.EntityType.Character,
	ArcadeSurvivorEnum.EntityType.Monster
}
ArcadeSurvivorGameEnum.EntityLayer = {
	Floor = 2,
	Normal = 1
}
ArcadeSurvivorGameEnum.EntityType2Layer = {
	[ArcadeSurvivorEnum.EntityType.Character] = ArcadeSurvivorGameEnum.EntityLayer.Normal,
	[ArcadeSurvivorEnum.EntityType.Monster] = ArcadeSurvivorGameEnum.EntityLayer.Normal,
	[ArcadeSurvivorEnum.EntityType.Ally] = ArcadeSurvivorGameEnum.EntityLayer.Normal,
	[ArcadeSurvivorEnum.EntityType.Floor] = ArcadeSurvivorGameEnum.EntityLayer.Floor
}
ArcadeSurvivorGameEnum.DelayHitResult = {
	Retry = "retry"
}
ArcadeSurvivorGameEnum.TriggerPoint = {
	DeathPlace = "deathPlace",
	Move = "move",
	Hurt = "hurt",
	Dodge = "dodge",
	Crit = "crit",
	CharTurnBegin = "charTurnBegin",
	BuffDown = "buffDown",
	Kill = "kill",
	SummonEnd = "summonEnd",
	BattleStart = "battleStart",
	MonTurnBegin = "monTurnBegin",
	Death = "death",
	BuffUp = "buffUp",
	MonTurnEnd = "monTurnEnd",
	Hit = "hit",
	CritOnce = "critOnce",
	Rebirth = "rebirth",
	CharTurnEnd = "charTurnEnd",
	GameStart = "gameStart",
	SummonBegin = "summonBegin",
	Duel = "duel",
	None = ""
}
ArcadeSurvivorGameEnum.ConditionType = {
	BuffLayer = "buffLayer",
	AnyBuff = "anyBuff",
	PreRound = "preRound"
}
ArcadeSurvivorGameEnum.EffectType = {
	DamageByBuff = "damage_by_buff",
	RemoveBuff = "removebuff",
	AddBuff = "addbuff",
	DamageLater = "damage_later",
	LeaveBoard = "leaveBoard",
	ReturnBoard = "returnBoard",
	Boom = "boom",
	Cure = "cure",
	Pushback = "pushback",
	Morph = "morph",
	AddBuffByCoin = "addbuff_by_coin",
	AddBuffByColl = "addbuff_by_coll",
	Dash = "dash",
	Summon = "summon",
	ChangePos = "changePos",
	Kill = "kill",
	Damage = "damage",
	ChangeGrid = "changeGrid",
	ReturnBoardLater = "returnBoard_later",
	ChangePosLater = "changePos_later",
	Flop = "flop"
}
ArcadeSurvivorGameEnum.ChangePosType = {
	PlayerOffsetGrid = 6,
	PlayerLocalGrid = 2,
	WorldGrid = 1,
	BoardEdge = 5,
	PassPlayerCorner = 4,
	PassPlayerAxis = 3
}
ArcadeSurvivorGameEnum.SelectorType = {
	Attacker = "attacker",
	Rect = "rect",
	Follow = "follow",
	CoordinateAbs = "coord_abs",
	RectRandom = "rect_random",
	SelfXY = "self_xy",
	Dynamic = "dynamic",
	CoordinateRel = "coord_rel",
	Hitter = "hitter",
	CoordinateRelRandom = "coord_rel_random",
	Owner = "owner"
}
ArcadeSurvivorGameEnum.CoordinateRefType = {
	Owner = 1,
	PlayerFixedXY = 4,
	Player = 2,
	OwnerFixedXY = 3
}
ArcadeSurvivorGameEnum.DynamicAxisType = {
	Corner = 2,
	Axis = 1
}
ArcadeSurvivorGameEnum.BTNodeStatus = {
	Failure = 2,
	Running = 3,
	Success = 1
}
ArcadeSurvivorGameEnum.BTNodeType = {
	Compare = "Compare",
	Rotator = "Rotator",
	StepSequence = "StepSequence",
	RandomSequence = "RandomSequence",
	WeightRandom = "WeightRandom",
	WaitTurns = "WaitTurns",
	UseSkill = "UseSkill",
	Sequence = "Sequence",
	Move = "Move",
	SetShowActive = "SetShowActive",
	Root = "Root",
	PlayerInRange = "PlayerInRange",
	Selector = "Selector",
	Calculate = "Calculate",
	RandomSelector = "RandomSelector"
}
ArcadeSurvivorGameEnum.BTNodeTypeCls = {
	[ArcadeSurvivorGameEnum.BTNodeType.Root] = ArcadeSurvivorEntityBTRootNode,
	[ArcadeSurvivorGameEnum.BTNodeType.Sequence] = ArcadeSurvivorEntityBTSequenceNode,
	[ArcadeSurvivorGameEnum.BTNodeType.StepSequence] = ArcadeSurvivorEntityBTStepSequenceNode,
	[ArcadeSurvivorGameEnum.BTNodeType.RandomSequence] = ArcadeSurvivorEntityBTRandomSequenceNode,
	[ArcadeSurvivorGameEnum.BTNodeType.Selector] = ArcadeSurvivorEntityBTSelectorNode,
	[ArcadeSurvivorGameEnum.BTNodeType.RandomSelector] = ArcadeSurvivorEntityBTRandomSelectorNode,
	[ArcadeSurvivorGameEnum.BTNodeType.Rotator] = ArcadeSurvivorEntityBTRotatorNode,
	[ArcadeSurvivorGameEnum.BTNodeType.WeightRandom] = ArcadeSurvivorEntityBTRandomNode,
	[ArcadeSurvivorGameEnum.BTNodeType.Compare] = ArcadeSurvivorEntityBTCompareNode,
	[ArcadeSurvivorGameEnum.BTNodeType.PlayerInRange] = ArcadeSurvivorEntityBTPlayerInRangeNode,
	[ArcadeSurvivorGameEnum.BTNodeType.Calculate] = ArcadeSurvivorEntityBTCalculateNode,
	[ArcadeSurvivorGameEnum.BTNodeType.WaitTurns] = ArcadeSurvivorEntityBTWaitTurnsNode,
	[ArcadeSurvivorGameEnum.BTNodeType.UseSkill] = ArcadeSurvivorEntityBTUseSkillNode,
	[ArcadeSurvivorGameEnum.BTNodeType.Move] = ArcadeSurvivorEntityBTMoveNode,
	[ArcadeSurvivorGameEnum.BTNodeType.SetShowActive] = ArcadeSurvivorEntityBTSetShowActiveNode
}
ArcadeSurvivorGameEnum.BTNodeParam = {
	ContinueOnSuccess = "continueOnSuccess",
	Turns = "turns",
	Active = "active",
	EffectId = "effectId",
	ExcludeLast = "excludeLast",
	ShowId = "showId",
	Op = "op",
	StoreKey = "storeKey",
	Right = "r",
	SkillId = "skillId",
	WeightMap = "weightMap",
	Left = "l"
}
ArcadeSurvivorGameEnum.BTVarName = {
	flowStep = "flowStep",
	moveLeft = "moveLeft",
	calcResult = "calcResult",
	specialRoundsLeft = "specialRoundsLeft",
	verticalDone = "verticalDone",
	horizontalDone = "horizontalDone",
	bossPhase = "bossPhase",
	reuseDone = "reuseDone",
	attackLeft = "attackLeft"
}
ArcadeSurvivorGameEnum.DefaultBTVarVal = {
	[ArcadeSurvivorGameEnum.BTVarName.calcResult] = 0,
	[ArcadeSurvivorGameEnum.BTVarName.bossPhase] = 1,
	[ArcadeSurvivorGameEnum.BTVarName.flowStep] = 0,
	[ArcadeSurvivorGameEnum.BTVarName.moveLeft] = 0,
	[ArcadeSurvivorGameEnum.BTVarName.attackLeft] = 0,
	[ArcadeSurvivorGameEnum.BTVarName.specialRoundsLeft] = 0,
	[ArcadeSurvivorGameEnum.BTVarName.horizontalDone] = 0,
	[ArcadeSurvivorGameEnum.BTVarName.verticalDone] = 0,
	[ArcadeSurvivorGameEnum.BTVarName.reuseDone] = 0
}

return ArcadeSurvivorGameEnum
