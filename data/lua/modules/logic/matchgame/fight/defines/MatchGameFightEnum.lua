-- chunkname: @modules/logic/matchgame/fight/defines/MatchGameFightEnum.lua

module("modules.logic.matchgame.fight.defines.MatchGameFightEnum", package.seeall)

local MatchGameFightEnum = _M

MatchGameFightEnum.activityId = 14012
MatchGameFightEnum.planeSizeNum = 7
MatchGameFightEnum.planeItemWidth = 100
MatchGameFightEnum.planeItemHeight = 100
MatchGameFightEnum.planeItemSpace = 14
MatchGameFightEnum.BeadTypeCount = 6
MatchGameFightEnum.MinMatchCount = 3
MatchGameFightEnum.MaxSkillIndex = 4
MatchGameFightEnum.MinEnergyFillAmount = 0.44
MatchGameFightEnum.MaxEnergyFillAmount = 0.87
MatchGameFightEnum.DragAdsorbPower = 1.5
MatchGameFightEnum.HeroHeavyDamage = 1000
MatchGameFightEnum.EnemyHeavyDamage = 500
MatchGameFightEnum.ElementMoveTime = 0.02
MatchGameFightEnum.HurtTxtTime = 0.2
MatchGameFightEnum.DebuffHurtTime = 0.33
MatchGameFightEnum.HeroAttackToEnemyAttackTime = 0.2
MatchGameFightEnum.MatchMoveFillDoneTime = 0.05
MatchGameFightEnum.MatchTime = 0.1
MatchGameFightEnum.ClickToCreateTime = 0.1
MatchGameFightEnum.MatchSelectItemToCreateTime = 0.1
MatchGameFightEnum.FeverBarChangeTime = 0.1
MatchGameFightEnum.PlayNextBombRoundTime = 0.25
MatchGameFightEnum.GameTimeCountInterval = 0.1
MatchGameFightEnum.NotMatchConvertTime = 0.2
MatchGameFightEnum.HideChainNumUITime = 0.167
MatchGameFightEnum.DoMultiHeroChainAttackTime = 1.167
MatchGameFightEnum.WaitHeroAttackTime = 0.3
MatchGameFightEnum.EachHeroAttackTime = 0.5
MatchGameFightEnum.HpBarChangeTime = 0.1
MatchGameFightEnum.SkillDescShowTime = 2
MatchGameFightEnum.ScoreRate = {
	MaxChain = 100,
	SkillUse = 500,
	WeakAttack = 500,
	Cure = 100
}
MatchGameFightEnum.TestHeroInfoIds = {
	1001,
	1002,
	1008,
	1015
}
MatchGameFightEnum.TestLevelId = 117403101
MatchGameFightEnum.TestEpisodeId = 14010101
MatchGameFightEnum.TestHeroLevel = 1
MatchGameFightEnum.CareerColor = {
	"#955a00",
	"#104c8a",
	"#003603",
	"#a92728",
	"#854e91",
	"#c8870a"
}
MatchGameFightEnum.MemberInfoTag = {
	Enemy = 2,
	Hero = 1
}
MatchGameFightEnum.ConstId = {
	CureElementCureRate = 6,
	HeroGroupUnlockCondition = 4,
	PlaneWidthNum = 1,
	PlaneHeightNum = 2,
	ChainRate = 5,
	SnapShotSize = 3
}
MatchGameFightEnum.ElementItemType = {
	Cure = 3,
	Bead = 1,
	Box = 4,
	Bomb = 2,
	Empty = 0
}
MatchGameFightEnum.BeadType = {
	Career5 = 5,
	Career3 = 3,
	Career6 = 6,
	Career2 = 2,
	Career1 = 1,
	Career4 = 4
}
MatchGameFightEnum.ElementStateType = {
	Poison = 2,
	Lock = 3,
	Normal = 1
}
MatchGameFightEnum.ItemRoot = {
	[MatchGameFightEnum.ElementItemType.Bead] = "go_bead",
	[MatchGameFightEnum.ElementItemType.Bomb] = "go_bomb",
	[MatchGameFightEnum.ElementItemType.Cure] = "go_cure",
	[MatchGameFightEnum.ElementItemType.Box] = "go_box"
}
MatchGameFightEnum.EightRangeOffsetList = {
	{
		-1,
		1
	},
	{
		0,
		1
	},
	{
		1,
		1
	},
	{
		-1,
		0
	},
	{
		1,
		0
	},
	{
		-1,
		-1
	},
	{
		0,
		-1
	},
	{
		1,
		-1
	}
}
MatchGameFightEnum.FourRangeOffsetList = {
	{
		0,
		1
	},
	{
		-1,
		0
	},
	{
		1,
		0
	},
	{
		0,
		-1
	}
}
MatchGameFightEnum.FightTargetType = {
	MatchElementNum = 3,
	RoundNum = 2,
	KillAll = 1
}
MatchGameFightEnum.FightResult = {
	Succ = 1,
	Fail = 2,
	None = 0
}
MatchGameFightEnum.TargetGoalTypeNode = {
	[MatchGameFightEnum.FightTargetType.KillAll] = "go_killAll",
	[MatchGameFightEnum.FightTargetType.RoundNum] = "go_roundNum",
	[MatchGameFightEnum.FightTargetType.MatchElementNum] = "go_match"
}
MatchGameFightEnum.SkillUserType = {
	Enemy = 2,
	Hero = 1
}
MatchGameFightEnum.SkillConditionType = {
	OnBattleStart = 4,
	OnTurnEnd = 6,
	OnFeverEnter = 3,
	OnSkillCast = 1,
	OnMatchCountMoreThan = 2,
	OnTurnStart = 5,
	None = 0
}
MatchGameFightEnum.SkillRangeType = {
	Bomb = 2,
	Skill = 1
}
MatchGameFightEnum.SkillBeadType = {
	Buff = 2,
	Bead = 1
}
MatchGameFightEnum.SkillActiveType = {
	Passive = 1,
	Active = 0,
	None = -1
}
MatchGameFightEnum.BuffType = {
	AttrUp = 8,
	HeroSick = 3,
	MatchTimeChange = 5,
	Poison = 1,
	BeadRateChange = 4,
	FeverTimeChange = 6,
	AttrDown = 9,
	Seal = 2,
	FeverCostChange = 7,
	None = 0
}
MatchGameFightEnum.BuffEffectType = {
	FeverTime = "FeverTime",
	AttackRate = "AttackRate",
	FeverCost = "FeverCost",
	Giddy = "Giddy",
	Seal = "Seal",
	GemProbability = "GemProbability",
	MatchTime = "MatchTime",
	Poison = "Poison"
}
MatchGameFightEnum.BuffDurationType = {
	Round = 1,
	Second = 3,
	Match = 2,
	Forever = 0
}
MatchGameFightEnum.SkillTargetType = {
	Range = 101,
	BuffType = 105,
	CharacterAll = 202,
	RoundTime = 111,
	Neighbor4 = 107,
	FeverCost = 112,
	CharacterSingle = 201,
	DropRate = 110,
	Board = 100,
	RandomColor = 103,
	GemType = 102,
	MonsterSingle = 301,
	Neighbor8 = 108,
	RandomCount = 106,
	LastClear = 109
}
MatchGameFightEnum.SkillEffectType = {
	Generate = 1009,
	BombSkillRange = 1010,
	RemoveBuffType = 1006,
	Remove = 1011,
	Heal = 1003,
	AddBuff = 1004,
	Attr = 1008,
	Convert = 1002,
	Attack = 1007,
	RemoveBuff = 1005,
	Destory = 1001
}
MatchGameFightEnum.SkillAttrType = {
	Heal = 4,
	Attack = 1,
	Hp = 3,
	Def = 2
}
MatchGameFightEnum.SkillToastType = {
	SkillDesc = 2,
	DropRate = 1
}
MatchGameFightEnum.RoleEffectType = {
	Clean = "Clean",
	NormalDamage = "NormalDamage",
	HeavyDamage = "HeavyDamage",
	Heal = "Heal",
	Lock = "Lock",
	Poison = "Poison"
}
MatchGameFightEnum.ItemMatchEffect = {
	MatchNormal = "matchNormal",
	MatchLine = "matchLine",
	MatchAoe = "matchAoe",
	Cleanse = "cleanse",
	Bomb = "bomb",
	Heal = "heal"
}

return MatchGameFightEnum
