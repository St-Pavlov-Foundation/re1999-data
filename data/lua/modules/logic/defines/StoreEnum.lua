module("modules.logic.defines.StoreEnum", package.seeall)

slot0 = _M
slot0.ChargeStoreTabId = 410
slot0.LimitType = {
	Default = 1,
	Currency = 3,
	CurrencyChanged = 4,
	BuyLimit = 2
}
slot0.Discount = {
	Recommend = "101",
	Activity = "103",
	Hot = "102",
	RoomTheme = "106",
	Discount = "3",
	Flash = "104",
	Super = "105"
}
slot0.RefreshTime = {
	Day = 1,
	Week = 2,
	Month = 3,
	Forever = 0
}
slot0.ChargeRefreshTime = {
	Day = 3,
	Week = 4,
	Month = 5,
	Forever = 1,
	MonthCard = 2,
	Level = 7,
	None = 0
}
slot0.LittleMonthCardGoodsId = 811450
slot0.WeekWalkTabId = 160
slot0.SummonExchange = 110
slot0.SummonEquipExchange = 150
slot0.SummonCost = 118
slot0.Room = 170
slot0.SubRoomNew = 171
slot0.SubRoomOld = 172
slot0.RecommendStore = 700
slot0.DefaultTabId = slot0.RecommendStore
slot0.StoreId = {
	DecorateStore = 800,
	OldRoomStore = 172,
	NewRoomStore = 171,
	CritterStore = 173,
	Charge = 410,
	OneTimePackage = 613,
	RecommendPackage = 611,
	Summon = 130,
	VersionPackage = 612,
	LimitStore = 112,
	Package = 610,
	NormalPackage = 614,
	NewDecorateStore = 801,
	PubbleCharge = 411,
	OldDecorateStore = 802,
	Skin = 510,
	GlowCharge = 412
}
slot0.RecommendSubStoreId = {
	StoreRoleSkinView = 801,
	GiftrecommendView1 = 803,
	MonthCardId = 711,
	GiftrecommendView2 = 804,
	BpEnterView = 714,
	StoreBlockPackageView = 802,
	StoreSkinBagView = 721,
	GiftPacksView = 713,
	ChargeView = 712
}
slot0.RecommendRelationType = {
	OtherRecommendClose = 3,
	PackageStoreGoodsNoBuy = 6,
	StoreGoods = 5,
	BattlePass = 4,
	Summon = 1,
	PackageStoreGoods = 2
}
slot0.AdjustOrderType = {
	MonthCard = 1,
	BattlePass = 2,
	Normal = 0
}
slot0.GroupOrderType = {
	GroupC = 3,
	GroupA = 1,
	GroupD = 4,
	GroupB = 2
}
slot0.MonthCardGoodsId = 610001
slot0.SeasonCardGoodsId = 811467
slot0.NewbiePackId = 811422
slot0.NormalRoomTicket = 600001
slot0.TopRoomTicket = 600002
slot0.SummonSimulationPick = "v2a2_03"
slot0.MonthCardStatus = {
	NotEnoughOneDay = 0,
	NotEnoughThreeDay = 3,
	NotPurchase = -1
}
slot0.Need4RDEpisodeId = 9999
slot0.StoreChargeType = {
	DailyReleasePackage = 4,
	Optional = 5,
	MonthCard = 2
}
slot0.Prefab = {
	RoomStore = 6,
	ChargeStore = 2,
	PackageStore = 4,
	NormalStore = 1,
	SkinStore = 3
}
slot0.BossRushStore = {
	NormalStore = 901,
	ManeTrust = 900,
	UpdateStore = 902
}

return slot0
