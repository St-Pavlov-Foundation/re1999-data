﻿module("modules.logic.patface.define.PatFaceEnum", package.seeall)

local var_0_0 = _M

var_0_0.NoneNum = 0
var_0_0.patFaceType = {
	NewDay = 2,
	FuncUnlock = 3,
	Login = 1
}
var_0_0.patFace = {
	V2a8_NewCultivationDestiny = 20803,
	V2a6_Role_PanelSignView_Part1 = 20600,
	BPSkinFaceView = 20808,
	V2a5_Role_PanelSignView_Part1 = 20500,
	BPView = 20502,
	V2a4_Role_PanelSignView_Part1 = 20400,
	GoldenMilletPresent = 5,
	V2a3_Role_PanelSignView_Part1 = 20301,
	V1a8_Role_PanelSignView_Part1 = 13,
	V2a2_Role_PanelSignView_Part1 = 20200,
	LinkageActivity_Panelview = 20303,
	V2a1_Role_PanelSignView_Part1 = 20100,
	V2a8_DragonBoat = 20805,
	V2a0_Role_PanelSignView_Part1 = 20001,
	v2a2_Role_SummonNewCustom = 20202,
	LanternFestival = 12,
	V2a5_GoldenMilletPresentView = 20505,
	V1a8_Work_PanelSignView = 15,
	V1a9_Role_PanelSignView_Part1 = 10900,
	V1a9_SemmelWeisGift = 10904,
	V2a3_Special_PanelsView = 20304,
	V2a7_Labor_PanelSignView = 20702,
	V3a0_Role_PanelSignView_Part1 = 30000,
	V3a0_Role_PanelSignView_Part2 = 30001,
	V3a0_NeWCultivationGift = 30003,
	TurnBackView = 2,
	V2a8_Role_PanelSignView_Part1 = 20800,
	ShortenAct_PanelView = 20602,
	V2a8_WuErLiXiGift = 20802,
	TurnBackStory = 1,
	NewYearEve = 8,
	V2a8_Role_PanelSignView_Part2 = 20801,
	Activity136 = 3,
	V2a2_LimitDecorate_PanelView = 20205,
	V2a0_SummerSign_PanelView = 20000,
	V2a1_MoonFestival_PanelView = 20102,
	V1a8_Role_PanelSignView_Part2 = 14,
	V1a9_Role_PanelSignView_Part2 = 10901,
	V3a0_SummerSign_PanelView = 30002,
	V1a9_AnniversarySign_PanelSignView = 10905,
	V2a0_Role_PanelSignView_Part2 = 20002,
	V2a1_Role_PanelSignView_Part2 = 20101,
	V2a2_Role_PanelSignView_Part2 = 20201,
	V2a3_Role_PanelSignView_Part2 = 20302,
	V2a4_Role_PanelSignView_Part2 = 20401,
	V2a5_Role_PanelSignView_Part2 = 20501,
	V2a6_Role_PanelSignView_Part2 = 20601,
	V2a7_Role_PanelSignView_Part2 = 20701,
	V2a8_SelfSelectCharacterView = 20806,
	Activity2ndMailView = 20804,
	V1a7_Role_PanelSignView_Part2 = 11,
	V2a8_Matildagift = 12801,
	TowerGiftPanelView = 20706,
	V2a2_NeWCultivationGift_PanelView = 20300,
	BPSPView = 20203,
	V2a5_DecorateStoreView = 20504,
	V2a7_LinkageActivity_PanelView = 20703,
	V1a9_Matildagift = 10902,
	SpringSign = 7,
	V2a7_SelfSelectSix_PanelView1 = 20704,
	V2a2_RedLeafFestival_PanelView = 20204,
	Activity2ndShowSkinView = 20807,
	V2a7_SelfSelectSix_PanelView2 = 20705,
	DecalogPresent = 4,
	V1a7_Role_PanelSignView_Part1 = 10,
	WeekwalkHeart_PanelView = 20603,
	PanelSign = 6,
	DragonBoatFestival = 10903,
	V2a7_Role_PanelSignView_Part1 = 20700
}
var_0_0.CustomCheckCanPatFun = {
	[var_0_0.patFace.Activity136] = PatFaceCustomHandler.activity142CheckCanPat,
	[var_0_0.patFace.DecalogPresent] = PatFaceCustomHandler.decalogPresentCheckCanPat,
	[var_0_0.patFace.V2a5_GoldenMilletPresentView] = PatFaceCustomHandler.goldenMilletPresentCheckCanPat,
	[var_0_0.patFace.V1a9_SemmelWeisGift] = PatFaceCustomHandler.semmelWeisGiftCheckCanPat,
	[var_0_0.patFace.BPSPView] = PatFaceCustomHandler.bPSPViewCanPat,
	[var_0_0.patFace.BPView] = PatFaceCustomHandler.bPViewCanPat,
	[var_0_0.patFace.V2a2_LimitDecorate_PanelView] = PatFaceCustomHandler.limitDecorateCanPat,
	[var_0_0.patFace.V2a8_Matildagift] = PatFaceCustomHandler.matildaGiftCheckCanPat,
	[var_0_0.patFace.V2a8_WuErLiXiGift] = PatFaceCustomHandler.V2a8_WuErLiXiGiftCheckCanPat,
	[var_0_0.patFace.V2a8_SelfSelectCharacterView] = PatFaceCustomHandler.V2a8_SelfSelectCharacterViewCheckCanPat,
	[var_0_0.patFace.BPSkinFaceView] = PatFaceCustomHandler.V2a8_BPSkinFaceViewCanPat
}
var_0_0.CustomPatFun = {
	[var_0_0.patFace.DecalogPresent] = PatFaceCustomHandler.decalogPresentPat,
	[var_0_0.patFace.V1a9_SemmelWeisGift] = PatFaceCustomHandler.semmelWeisGiftPat,
	[var_0_0.patFace.V2a5_GoldenMilletPresentView] = PatFaceCustomHandler.goldenMilletPresentPat,
	[var_0_0.patFace.V2a8_Matildagift] = PatFaceCustomHandler.matildaGiftPat,
	[var_0_0.patFace.V2a8_WuErLiXiGift] = PatFaceCustomHandler.V2a8_WuErLiXiGiftPat,
	[var_0_0.patFace.V2a8_SelfSelectCharacterView] = PatFaceCustomHandler.V2a8_SelfSelectCharacterViewPat,
	[var_0_0.patFace.BPSkinFaceView] = PatFaceCustomHandler.V2a8_openBPSkinFaceViewPat
}
var_0_0.patFaceCustomWork = {
	[var_0_0.patFace.TurnBackStory] = TurnbackStoryPatFaceWork,
	[var_0_0.patFace.TurnBackView] = TurnbackViewPatFaceWork,
	[var_0_0.patFace.PanelSign] = ActivityRoleSignWork_1_6,
	[var_0_0.patFace.SpringSign] = Activity101SignPatFaceWork,
	[var_0_0.patFace.NewYearEve] = Activity152PatFaceWork,
	[var_0_0.patFace.V1a7_Role_PanelSignView_Part1] = Activity101SignPatFaceWork,
	[var_0_0.patFace.V1a7_Role_PanelSignView_Part2] = Activity101SignPatFaceWork,
	[var_0_0.patFace.LanternFestival] = LanternFestivalPatFaceWork,
	[var_0_0.patFace.V1a8_Role_PanelSignView_Part1] = Activity101SignPatFaceWork,
	[var_0_0.patFace.V1a8_Role_PanelSignView_Part2] = Activity101SignPatFaceWork,
	[var_0_0.patFace.V1a8_Work_PanelSignView] = Activity101SignPatFaceWork,
	[var_0_0.patFace.V1a9_Role_PanelSignView_Part1] = Activity101SignPatFaceWork,
	[var_0_0.patFace.V1a9_Role_PanelSignView_Part2] = Activity101SignPatFaceWork,
	[var_0_0.patFace.DragonBoatFestival] = DragonBoatFestivalPatFaceWork,
	[var_0_0.patFace.V1a9_AnniversarySign_PanelSignView] = Activity101SignPatFaceWork,
	[var_0_0.patFace.V2a0_SummerSign_PanelView] = Activity101SignPatFaceWork,
	[var_0_0.patFace.V2a0_Role_PanelSignView_Part1] = Activity101SignPatFaceWork,
	[var_0_0.patFace.V2a0_Role_PanelSignView_Part2] = Activity101SignPatFaceWork,
	[var_0_0.patFace.V2a1_Role_PanelSignView_Part1] = Activity101SignPatFaceWork,
	[var_0_0.patFace.V2a1_Role_PanelSignView_Part2] = Activity101SignPatFaceWork,
	[var_0_0.patFace.V2a1_MoonFestival_PanelView] = Activity101SignSpRewardPatFaceWork,
	[var_0_0.patFace.V2a2_Role_PanelSignView_Part1] = Activity101SignPatFaceWork,
	[var_0_0.patFace.V2a2_Role_PanelSignView_Part2] = Activity101SignPatFaceWork,
	[var_0_0.patFace.v2a2_Role_SummonNewCustom] = SummonNewCustomPickPatFaceWork,
	[var_0_0.patFace.V2a2_RedLeafFestival_PanelView] = Activity101SignPatFaceWork,
	[var_0_0.patFace.V2a2_NeWCultivationGift_PanelView] = NewCultivationGiftPatFaceWork,
	[var_0_0.patFace.V2a3_Role_PanelSignView_Part1] = Activity101SignPatFaceWork,
	[var_0_0.patFace.V2a3_Role_PanelSignView_Part2] = Activity101SignPatFaceWork,
	[var_0_0.patFace.LinkageActivity_Panelview] = Activity101SignPatFaceWork,
	[var_0_0.patFace.V2a3_Special_PanelsView] = Activity101SignPatFaceWork,
	[var_0_0.patFace.V2a4_Role_PanelSignView_Part1] = Activity101SignPatFaceWork,
	[var_0_0.patFace.V2a4_Role_PanelSignView_Part2] = Activity101SignPatFaceWork,
	[var_0_0.patFace.V2a5_Role_PanelSignView_Part1] = Activity101SignPatFaceWork,
	[var_0_0.patFace.V2a5_Role_PanelSignView_Part2] = Activity101SignPatFaceWork,
	[var_0_0.patFace.V2a5_DecorateStoreView] = Activity101SignPatFaceWork,
	[var_0_0.patFace.V2a6_Role_PanelSignView_Part1] = Activity101SignPatFaceWork,
	[var_0_0.patFace.V2a6_Role_PanelSignView_Part2] = Activity101SignPatFaceWork,
	[var_0_0.patFace.ShortenAct_PanelView] = ShortenAct_PanelViewPatFaceWork,
	[var_0_0.patFace.WeekwalkHeart_PanelView] = WeekwalkHeart_PanelViewPatFaceWork,
	[var_0_0.patFace.V2a7_Role_PanelSignView_Part1] = Activity101SignPatFaceWork,
	[var_0_0.patFace.V2a7_Role_PanelSignView_Part2] = Activity101SignPatFaceWork,
	[var_0_0.patFace.V2a7_Labor_PanelSignView] = Activity101SignPatFaceWork,
	[var_0_0.patFace.V2a7_SelfSelectSix_PanelView1] = Activity101SignPatFaceWork,
	[var_0_0.patFace.V2a7_LinkageActivity_PanelView] = Activity101SignPatFaceWork,
	[var_0_0.patFace.TowerGiftPanelView] = Activity101SignPatFaceWork,
	[var_0_0.patFace.V2a8_Role_PanelSignView_Part1] = Activity101SignPatFaceWork,
	[var_0_0.patFace.V2a8_Role_PanelSignView_Part2] = Activity101SignPatFaceWork,
	[var_0_0.patFace.V2a8_NewCultivationDestiny] = NewCultivationGiftPatFaceWork,
	[var_0_0.patFace.Activity2ndMailView] = Activity101SignPatFaceWork,
	[var_0_0.patFace.V2a8_DragonBoat] = Activity101SignSpRewardPatFaceWork,
	[var_0_0.patFace.Activity2ndShowSkinView] = Activity101SignPatFaceWork,
	[var_0_0.patFace.V3a0_NeWCultivationGift] = NewCultivationGiftPatFaceWork,
	[var_0_0.patFace.V3a0_Role_PanelSignView_Part1] = Activity101SignPatFaceWork,
	[var_0_0.patFace.V3a0_Role_PanelSignView_Part2] = Activity101SignPatFaceWork,
	[var_0_0.patFace.V3a0_SummerSign_PanelView] = Activity101SignPatFaceWork
}

return var_0_0
