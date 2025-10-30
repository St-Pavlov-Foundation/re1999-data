﻿-- chunkname: @modules/logic/defines/ItemEnum.lua

module("modules.logic.defines.ItemEnum", package.seeall)

local ItemEnum = _M

ItemEnum.SubType = {
	RandomGift = 49,
	CommonItem = 14,
	PlayerBg = 21,
	UtmStickers = 33,
	UdimoBgItem = 37,
	SpecifiedGift = 48,
	SkinTicket = 61,
	UdimoItem = 36,
	RoomTicket = 60,
	MainSceneSkin = 24,
	RoomManufactureAccelerateItem = 26,
	MultipleCoupon = 16,
	UdimoDecorationItem = 38,
	CritterAccelerateItem = 34,
	ResonanceItem = 12,
	SummonSimulationPick = 54,
	Portrait = 17,
	SkinSelelctGift = 71,
	SelfSelectSix = 65,
	FightCard = 67,
	FightFloatType = 68,
	InsightItem = 11,
	RoomBlockGift = 66,
	AdventureItem = 15,
	EquipSelectGift = 75,
	OptionalGift = 53,
	BreachItem = 13,
	CritterIncubate = 30,
	OptionalHeroGift = 52,
	UnlimitedPower = 32,
	DecorateDiscountTicket = 63,
	CritterTrain = 28,
	EquipBreak = 18,
	CommonGift = 50,
	LimitPower = 31,
	RoomManufactureItem = 25,
	RoomBlockGiftNew = 69,
	CritterFood = 27,
	RoomBlockColorGift = 70,
	CritterSummon = 29,
	MainUISkin = 35,
	DestinyStoneUp = 64
}
ItemEnum.CategoryType = {
	All = 1,
	Equip = 4,
	Antique = 5,
	Material = 2,
	UseType = 3
}
ItemEnum.Color = {
	2,
	3,
	4,
	5,
	6
}
ItemEnum.ItemIconEffect = {
	["2#1401"] = 1
}
ItemEnum.RoomBackpackPropSubType = {
	[ItemEnum.SubType.RoomManufactureItem] = true,
	[ItemEnum.SubType.RoomManufactureAccelerateItem] = true,
	[ItemEnum.SubType.CritterFood] = true,
	[ItemEnum.SubType.CritterTrain] = true,
	[ItemEnum.SubType.CritterSummon] = true,
	[ItemEnum.SubType.CritterIncubate] = true,
	[ItemEnum.SubType.CritterAccelerateItem] = true
}
ItemEnum.NewbiePackGiftId = 520010
ItemEnum.NoExpiredNum = 70128
ItemEnum.Tag = {
	PackageSkin = 2,
	SummonSkin = 1
}
ItemEnum.GetApproach2Tag = {
	[MaterialEnum.GetApproach.MonthCard] = 1
}

return ItemEnum
