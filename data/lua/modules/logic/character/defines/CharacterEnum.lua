module("modules.logic.character.defines.CharacterEnum", package.seeall)

slot0 = _M
slot0.VoiceType = {
	FightBehit = 6,
	Skill = 18,
	FightCardStar12 = 3,
	MainViewSpecialTouch = 12,
	EnterFight = 2,
	BreakThrough = 10,
	SpecialIdle1 = 20,
	LimitedEntrance = 22,
	HeroGroup = 1,
	MainViewNoInteraction = 16,
	MainViewDragSpecialRespond = 25,
	FightCardUnique = 5,
	Summon = 11,
	FightDie = 8,
	GetSkin = 9,
	SpecialIdle2 = 21,
	FightResult = 7,
	MultiVoice = 26,
	MainViewSpecialInteraction = 23,
	WeatherChange = 14,
	MainViewNormalTouch = 13,
	GreetingInThumbnail = 19,
	FightCardStar3 = 4,
	MainViewSpecialRespond = 24,
	Greeting = 17,
	MainViewWelcome = 15
}
slot0.AttrDarkColor = GameUtil.parseColor("#736e6a")
slot0.AttrLightColor = GameUtil.parseColor("#efece6")
slot0.MaxSkillExLevel = 5
slot0.DrawingState = {
	Dynamic = 0,
	Static = 1
}
slot0.CharacterSwitchViewOffsetX = -108
slot0.SkinOpen = true
slot0.TalentOpen = false
slot0.Star = {
	2,
	3,
	4,
	5,
	6
}
slot0.Color = {
	2,
	3,
	4,
	5,
	6
}
slot0.LevelUpGuideId = 108
slot0.MaxRare = 5
slot0.CareerType = {
	Shou = 4,
	Zhi = 6,
	Ling = 5,
	Xing = 2,
	Mu = 3,
	Yan = 1
}
slot0.DamageType = {
	Real = 1,
	Spirit = 2
}
slot0.TalentRank = 2
slot0.showAttributeOption = {
	ShowCurrent = 0,
	ShowMax = 1,
	ShowMin = -1
}
slot0.CharacterDataItemType = {
	Culture = 3,
	Item = 2,
	Title = 1
}
slot0.CharacterDataUnLockType = {
	Faith = 1,
	TalentLevel = 5,
	RankLevel = 2,
	Level = 3,
	Episode = 6,
	SkillLevel = 4
}
slot0.SkinGainApproach = {
	Activity = 3,
	Store = 2,
	Rank = 1,
	BPReward = 4,
	Permanent = 5,
	Init = 0
}
slot0.FilterType = {
	HeroGroup = 2,
	BackpackHero = 1,
	AdventureCharacter = 4,
	SkinOffsetAdjust = 5,
	ShowCharacter = 3,
	CharVoiceSetting = 7,
	WeekWalk = 6
}
slot0.AttrId = {
	Cri = 201,
	Absorb = 210,
	Recri = 202,
	DefenseIgnore = 213,
	Heal = 212,
	ReboundDmg = 218,
	Attack = 102,
	DefenseBase = 603,
	CriDmg = 203,
	MdefenseBase = 604,
	DropDmg = 206,
	HpBase = 601,
	Technic = 105,
	CriDef = 204,
	Mdefense = 104,
	Clutch = 211,
	MdefensePercent = 608,
	AttackBase = 602,
	Revive = 209,
	CurrentHp = 100,
	HpPercent = 605,
	ReuseDmg = 220,
	PoisonAddRate = 301,
	ExtraDmg = 219,
	DefensePercent = 607,
	PlayAddRate = 215,
	AddDmg = 205,
	PlayDropRate = 216,
	AttackPercent = 606,
	NormalSkillRate = 214,
	Hp = 101,
	LostHp = 99,
	Defense = 103
}
slot0.AttrIdToAttrName = {
	[slot0.AttrId.Hp] = "hp",
	[slot0.AttrId.Attack] = "atk",
	[slot0.AttrId.Defense] = "def",
	[slot0.AttrId.Mdefense] = "mdef",
	[slot0.AttrId.Technic] = "technic",
	[slot0.AttrId.Cri] = "cri",
	[slot0.AttrId.Recri] = "recri",
	[slot0.AttrId.CriDmg] = "cri_dmg",
	[slot0.AttrId.CriDef] = "cri_def",
	[slot0.AttrId.AddDmg] = "add_dmg",
	[slot0.AttrId.DropDmg] = "drop_dmg"
}
slot0.BaseAttrIdList = {
	slot0.AttrId.Attack,
	slot0.AttrId.Hp,
	slot0.AttrId.Defense,
	slot0.AttrId.Mdefense,
	slot0.AttrId.Technic
}
slot0.UpAttrIdList = {
	slot0.AttrId.Cri,
	slot0.AttrId.Recri,
	slot0.AttrId.CriDmg,
	slot0.AttrId.CriDef,
	slot0.AttrId.AddDmg,
	slot0.AttrId.DropDmg,
	slot0.AttrId.NormalSkillRate,
	slot0.AttrId.Clutch,
	slot0.AttrId.Revive,
	slot0.AttrId.Absorb,
	slot0.AttrId.Heal,
	slot0.AttrId.DefenseIgnore
}
slot0.ShowSkinEnum = {
	Static = 1,
	Dynamic = 2
}
slot0.OpenSkinViewEnum = {
	SkinStore = 2,
	SkinTip = 3,
	Normal = 1
}
slot0.TalentTxtByHeroType = {
	"1",
	"1",
	"1",
	"1",
	"1",
	"6"
}
slot0.skillIndex = {
	Skill2 = 2,
	SkillEx = 3,
	Skill1 = 1
}
slot0.DefaultSkinId = {
	DuDuGu = 310401
}

setmetatable(slot0.TalentTxtByHeroType, {
	__index = function (slot0, slot1)
		return "1"
	end
})

slot0.HumanHeroType = 6

return slot0
