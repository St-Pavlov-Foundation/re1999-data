﻿module("modules.logic.gm.view.GMToolView", package.seeall)

local var_0_0 = class("GMToolView", BaseView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._btnClose = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "btnClose")
	arg_1_0._btnOK1 = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "viewport/content/item1/btnOK")
	arg_1_0._btnCommand = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "viewport/content/item1/btnCommand")
	arg_1_0._inp1 = gohelper.findChildInputField(arg_1_0.viewGO, "viewport/content/item1/inpText")
	arg_1_0._inp21 = gohelper.findChildTextMeshInputField(arg_1_0.viewGO, "viewport/content/item2/inpItem")
	arg_1_0._inp22 = gohelper.findChildTextMeshInputField(arg_1_0.viewGO, "viewport/content/item2/inpNum")
	arg_1_0._btnOK2 = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "viewport/content/item2/btnOK")
	arg_1_0._txtServerTime = gohelper.findChildText(arg_1_0.viewGO, "viewport/content/item3/txtServerTime")
	arg_1_0._txtLocalTime = gohelper.findChildText(arg_1_0.viewGO, "viewport/content/item3/txtLocalTime")
	arg_1_0._scroll = gohelper.findChildScrollRect(arg_1_0.viewGO, "viewport")
	arg_1_0._btnOK4 = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "viewport/content/item4/btnOK")
	arg_1_0._toggleEar = gohelper.findChildToggle(arg_1_0.viewGO, "viewport/content/item4/earToggle")
	arg_1_0._btnQualityLow = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "viewport/content/item5/btnQualityLow")
	arg_1_0._btnQualityMid = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "viewport/content/item5/btnQualityMid")
	arg_1_0._btnQualityHigh = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "viewport/content/item5/btnQualityHigh")
	arg_1_0._btnQualityNo = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "viewport/content/item5/btnQualityNo")
	arg_1_0._btnPP = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "viewport/content/item5/btnPP")
	arg_1_0._btnSetting = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "viewport/content/item5/btnSetting")
	arg_1_0._txtBtnPP = gohelper.findChildText(arg_1_0.viewGO, "viewport/content/item5/btnPP/Text")
	arg_1_0._txtAccountId = gohelper.findChildText(arg_1_0.viewGO, "viewport/content/item40/Text")
	arg_1_0._btnNewbiePrepare = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "viewport/content/item40/btnNewbiePrepare")
	arg_1_0._imgQualitys = {
		arg_1_0._btnQualityNo.gameObject:GetComponent(gohelper.Type_Image),
		arg_1_0._btnQualityHigh.gameObject:GetComponent(gohelper.Type_Image),
		arg_1_0._btnQualityMid.gameObject:GetComponent(gohelper.Type_Image),
		arg_1_0._btnQualityLow.gameObject:GetComponent(gohelper.Type_Image)
	}
	arg_1_0._txtSpeed = gohelper.findChildText(arg_1_0.viewGO, "viewport/content/item6/Text")
	arg_1_0._sliderSpeed = gohelper.findChildSlider(arg_1_0.viewGO, "viewport/content/item6/Slider")
	arg_1_0._btnClearPlayerPrefs = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "viewport/content/item7/btnClearPlayerPrefs")
	arg_1_0._btnBlockLog = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "viewport/content/item7/btnBlockLog")
	arg_1_0._btnProtoTestView = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "viewport/content/item8/Button")
	arg_1_0._btnfastaddhero = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "viewport/content/item8/#btn_addhero")
	arg_1_0._inpTestFight = gohelper.findChildTextMeshInputField(arg_1_0.viewGO, "viewport/content/item9/inpText")
	arg_1_0._btnTestFight = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "viewport/content/item9/btnTestFight")
	arg_1_0._btnTestFightId = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "viewport/content/item9/btnTestFightId")
	arg_1_0._btnPostProcess = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "viewport/content/item10/Button")
	arg_1_0._btnEffectStat = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "viewport/content/item10/btnEffectStat")
	arg_1_0._btnIgnoreSomeMsgLog = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "viewport/content/item11/Button")
	arg_1_0._btnFightJoin = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "viewport/content/item11/btnFightJoin")
	arg_1_0._inpSpeed1 = gohelper.findChildTextMeshInputField(arg_1_0.viewGO, "viewport/content/item11/inpSpeed1")
	arg_1_0._inpSpeed2 = gohelper.findChildTextMeshInputField(arg_1_0.viewGO, "viewport/content/item11/inpSpeed2")
	arg_1_0._btnCurSpeed = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "viewport/content/item11/btnCurSpeed")
	arg_1_0._btnHideDebug = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "viewport/content/item12/Button")
	arg_1_0._btnShowError = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "viewport/content/item12/btnError")
	arg_1_0._inpJump = gohelper.findChildTextMeshInputField(arg_1_0.viewGO, "viewport/content/item13/inpText")
	arg_1_0._btnJumpOK = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "viewport/content/item13/btnOK")
	arg_1_0._inpGuide = gohelper.findChildTextMeshInputField(arg_1_0.viewGO, "viewport/content/item14/inpText")
	arg_1_0._btnGuideStart = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "viewport/content/item14/btnStart")
	arg_1_0._btnGuideFinish = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "viewport/content/item14/btnFinish")
	arg_1_0._btnGuideForbid = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "viewport/content/item14/btnForbid")
	arg_1_0._btnGuideReset = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "viewport/content/item14/btnReset")
	arg_1_0._inpStory = gohelper.findChildTextMeshInputField(arg_1_0.viewGO, "viewport/content/item15/inpstorytxt")
	arg_1_0._btnStorySkip = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "viewport/content/item15/btnstoryskip")
	arg_1_0._btnStoryOK = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "viewport/content/item15/btnstoryok")
	arg_1_0._inpEpisode = gohelper.findChildTextMeshInputField(arg_1_0.viewGO, "viewport/content/item18/inpText")
	arg_1_0._btnEpisodeOK = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "viewport/content/item18/btnOK")
	arg_1_0._btnSkinOffsetAdjust = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "viewport/content/item20/Button")
	arg_1_0._btnFightFocusAdjust = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "viewport/content/item20/Button1")
	arg_1_0._toggleSkipPatFace = gohelper.findChildToggle(arg_1_0.viewGO, "viewport/content/skipPatFace/toggleSkipPatFace")
	arg_1_0._btnGuideEditor = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "viewport/content/guideEditor/Button")
	arg_1_0._btnHelpViewBrowse = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "viewport/content/guideEditor/btnHelpViewBrowse")
	arg_1_0._btnGuideStatus = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "viewport/content/item14/btnGuideStatus")
	arg_1_0._inpScreenWidth = gohelper.findChildTextMeshInputField(arg_1_0.viewGO, "viewport/content/item24/inpTextWidth")
	arg_1_0._inpScreenHeight = gohelper.findChildTextMeshInputField(arg_1_0.viewGO, "viewport/content/item24/inpTextHeight")
	arg_1_0._btnConfirm = gohelper.getClick(gohelper.findChild(arg_1_0.viewGO, "viewport/content/item24/btnConfirm"))
	arg_1_0._dropSkinGetView = gohelper.findChildDropdown(arg_1_0.viewGO, "viewport/content/item25/Dropdown")
	arg_1_0._btnOpenSeasonView = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "viewport/content/item27/ButtonSeason")
	arg_1_0._btnOpenHuaRongView = gohelper.getClick(gohelper.findChild(arg_1_0.viewGO, "viewport/content/item27_2/huarong"))
	arg_1_0._inpChangeColor = gohelper.findChildTextMeshInputField(arg_1_0.viewGO, "viewport/content/item27_2/changecolor/inpchangecolortxt")
	arg_1_0._btnChangeColorOK = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "viewport/content/item27_2/changecolor/btnchangecolorok")
	arg_1_0._btnFightSimulate = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "viewport/content/item333/btnOK")
	arg_1_0._btnResetCards = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "viewport/content/item333/btnOK2")
	arg_1_0._btnFightEntity = gohelper.getClick(gohelper.cloneInPlace(arg_1_0._btnFightSimulate.gameObject))
	gohelper.findChildText(arg_1_0._btnFightEntity.gameObject, "Text").text = "战中外挂"

	recthelper.setWidth(arg_1_0._btnFightEntity.transform, 200)
	recthelper.setWidth(arg_1_0._btnFightSimulate.transform, 200)
	recthelper.setWidth(arg_1_0._btnResetCards.transform, 200)
	recthelper.setAnchorX(arg_1_0._btnFightEntity.transform, 0)
	recthelper.setAnchorX(arg_1_0._btnFightSimulate.transform, -220)
	recthelper.setAnchorX(arg_1_0._btnResetCards.transform, 220)

	arg_1_0._dropHeroFaith = gohelper.findChildDropdown(arg_1_0.viewGO, "viewport/content/item34/Dropdown")
	arg_1_0._btnHeroFaith = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "viewport/content/item34/btnOK")
	arg_1_0._dropHeroLevel = gohelper.findChildDropdown(arg_1_0.viewGO, "viewport/content/item36/Dropdown")
	arg_1_0._btnHeroLevel = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "viewport/content/item36/btnOK")
	arg_1_0._inpHeroLevel = gohelper.findChildTextMeshInputField(arg_1_0.viewGO, "viewport/content/item36/inpNum")
	arg_1_0._dropWeather = gohelper.findChildDropdown(arg_1_0.viewGO, "viewport/content/item38/Dropdown")
	arg_1_0._btnGetAllHero = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "viewport/content/item35/Button1")
	arg_1_0._btnDeleteAllHeroInfo = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "viewport/content/item35/Button2")
	arg_1_0._btnHideGM = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "viewport/content/item37/Button1")
	arg_1_0._txtGM = gohelper.findChildText(arg_1_0.viewGO, "viewport/content/item37/Button1/Text")
	arg_1_0._btnUnLockAllEpisode = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "viewport/content/item37/Button2")
	arg_1_0._btnExplore = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "viewport/content/item39/Button1")
	arg_1_0._inpExplore = gohelper.findChildInputField(arg_1_0.viewGO, "viewport/content/item39/inpText")
	arg_1_0._btnshowHero = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "viewport/content/item40/Button1")
	arg_1_0._btnshowUI = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "viewport/content/item40/Button2")
	arg_1_0._btnshowId = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "viewport/content/item42/btn_userid")
	arg_1_0._btnwatermark = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "viewport/content/item42/btn_watermark")
	arg_1_0._txtshowHero = gohelper.findChildText(arg_1_0.viewGO, "viewport/content/item40/Button1/Text")
	arg_1_0._txtshowUI = gohelper.findChildText(arg_1_0.viewGO, "viewport/content/item40/Button2/Text")
	arg_1_0._txtshowId = gohelper.findChildText(arg_1_0.viewGO, "viewport/content/item42/btn_userid/Text")
	arg_1_0._txtwatermark = gohelper.findChildText(arg_1_0.viewGO, "viewport/content/item42/btn_watermark/Text")
	arg_1_0._btncopytalentdata = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "viewport/content/item41/btn_copy_talent_data")
	arg_1_0._btnprintallentitybuff = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "viewport/content/item41/btn_print_all_entity_buff")
	arg_1_0._btnReplaceSummonHero = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "viewport/content/item46/Button1")
	arg_1_0._inpHeroList = gohelper.findChildInputField(arg_1_0.viewGO, "viewport/content/item46/inpText")

	arg_1_0._inpHeroList:SetText("3039;3052;3017;3010;3015;3013;3031;3006;3040;3012")

	arg_1_0._btnCrash1 = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "viewport/content/crash/btnCrash1")
	arg_1_0._btnCrash2 = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "viewport/content/crash/btnCrash2")
	arg_1_0._btnCrash3 = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "viewport/content/crash/btnCrash3")
	arg_1_0._btnEnterView = gohelper.findChildButton(arg_1_0.viewGO, "viewport/content/item50/Button")
	arg_1_0._inpViewName = gohelper.findChildTextMeshInputField(arg_1_0.viewGO, "viewport/content/item50/InputField (TMP)")
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0._scroll:AddOnValueChanged(arg_2_0._onScrollValueChanged, arg_2_0)
	arg_2_0._btnClose:AddClickListener(arg_2_0.closeThis, arg_2_0)
	arg_2_0._btnOK1:AddClickListener(arg_2_0._onClickBtnOK1, arg_2_0)
	arg_2_0._btnCommand:AddClickListener(arg_2_0._onClickBtnCommand, arg_2_0)
	arg_2_0._btnOK2:AddClickListener(arg_2_0._onClickBtnOK2, arg_2_0)
	arg_2_0._btnOK4:AddClickListener(arg_2_0._onClickBtnOK4, arg_2_0)
	arg_2_0._toggleEar:AddOnValueChanged(arg_2_0._onEarToggleValueChange, arg_2_0)
	arg_2_0._btnQualityLow:AddClickListener(arg_2_0._onClickBtnQualityLow, arg_2_0)
	arg_2_0._btnQualityMid:AddClickListener(arg_2_0._onClickBtnQualityMid, arg_2_0)
	arg_2_0._btnQualityHigh:AddClickListener(arg_2_0._onClickBtnQualityHigh, arg_2_0)
	arg_2_0._btnQualityNo:AddClickListener(arg_2_0._onClickBtnQualityNo, arg_2_0)
	arg_2_0._btnPP:AddClickListener(arg_2_0._onClickBtnPP, arg_2_0)
	arg_2_0._btnSetting:AddClickListener(arg_2_0._onClickBtnSetting, arg_2_0)
	SLFramework.UGUI.UIClickListener.Get(arg_2_0._txtSpeed.gameObject):AddClickListener(arg_2_0._onClickSpeedText, arg_2_0)

	if arg_2_0._btnNewbiePrepare then
		arg_2_0._btnNewbiePrepare:AddClickListener(arg_2_0._onClickBtnNewbiePrepare, arg_2_0)
	end

	arg_2_0._sliderSpeed:AddOnValueChanged(arg_2_0._onSpeedChange, arg_2_0)
	arg_2_0._btnClearPlayerPrefs:AddClickListener(arg_2_0._onClickBtnClearPlayerPrefs, arg_2_0)
	arg_2_0._btnBlockLog:AddClickListener(arg_2_0._onClickBtnBlockLog, arg_2_0)
	arg_2_0._btnProtoTestView:AddClickListener(arg_2_0._onClickBtnProtoTestView, arg_2_0)
	arg_2_0._btnfastaddhero:AddClickListener(arg_2_0._onClickBtnFastAddHero, arg_2_0)
	arg_2_0._btnTestFight:AddClickListener(arg_2_0._onClickTestFight, arg_2_0)
	arg_2_0._btnTestFightId:AddClickListener(arg_2_0._onClickTestFightId, arg_2_0)
	arg_2_0._btnPostProcess:AddClickListener(arg_2_0._onClickPostProcess, arg_2_0)
	arg_2_0._btnEffectStat:AddClickListener(arg_2_0._onClickEffectStat, arg_2_0)
	arg_2_0._btnIgnoreSomeMsgLog:AddClickListener(arg_2_0._onClickIgnoreSomeMsgLog, arg_2_0)
	arg_2_0._btnFightJoin:AddClickListener(arg_2_0._onClickFightJoin, arg_2_0)
	arg_2_0._btnHideDebug:AddClickListener(arg_2_0._onClickHideBug, arg_2_0)
	arg_2_0._btnShowError:AddClickListener(arg_2_0._onClickShowError, arg_2_0)
	arg_2_0._btnSkinOffsetAdjust:AddClickListener(arg_2_0._onClickSkinOffsetAdjust, arg_2_0)
	arg_2_0._btnFightFocusAdjust:AddClickListener(arg_2_0._onClickFightFocusAdjust, arg_2_0)

	if arg_2_0._toggleSkipPatFace then
		arg_2_0._toggleSkipPatFace:AddOnValueChanged(arg_2_0._onSkipPatFaceToggleValueChange, arg_2_0, "123")
	end

	arg_2_0._btnGuideEditor:AddClickListener(arg_2_0._onClickGuideEditor, arg_2_0)
	arg_2_0._btnHelpViewBrowse:AddClickListener(arg_2_0._onClickHelpViewBrowse, arg_2_0)
	arg_2_0._btnGuideStatus:AddClickListener(arg_2_0._onClickGuideStatus, arg_2_0)
	arg_2_0._btnJumpOK:AddClickListener(arg_2_0._onClickJumpOK, arg_2_0)
	arg_2_0._btnEpisodeOK:AddClickListener(arg_2_0._onClickEpisodeOK, arg_2_0)
	arg_2_0._btnGuideStart:AddClickListener(arg_2_0._onClickGuideStart, arg_2_0)
	arg_2_0._btnGuideFinish:AddClickListener(arg_2_0._onClickGuideFinish, arg_2_0)
	arg_2_0._btnGuideForbid:AddClickListener(arg_2_0._onClickGuideForbid, arg_2_0)
	arg_2_0._btnGuideReset:AddClickListener(arg_2_0._onClickGuideReset, arg_2_0)
	arg_2_0._btnStorySkip:AddClickListener(arg_2_0._onClickStorySkip, arg_2_0)
	arg_2_0._btnStoryOK:AddClickListener(arg_2_0._onClickStoryOK, arg_2_0)
	arg_2_0._btnChangeColorOK:AddClickListener(arg_2_0._onClickChangeColorOK, arg_2_0)
	arg_2_0._btnFightSimulate:AddClickListener(arg_2_0._onClickFightSimulate, arg_2_0)
	arg_2_0._btnFightEntity:AddClickListener(arg_2_0._onClickFightEntity, arg_2_0)
	arg_2_0._btnResetCards:AddClickListener(arg_2_0._onClickResetCards, arg_2_0)
	arg_2_0._btnHeroFaith:AddClickListener(arg_2_0._onClickHeroFaithOk, arg_2_0)
	arg_2_0._btnHeroLevel:AddClickListener(arg_2_0._onClickHeroLevelOk, arg_2_0)
	arg_2_0._dropSkinGetView:AddOnValueChanged(arg_2_0._onSkinGetValueChanged, arg_2_0)
	arg_2_0._dropHeroFaith:AddOnValueChanged(arg_2_0._onHeroFaithSelectChanged, arg_2_0)
	arg_2_0._dropHeroLevel:AddOnValueChanged(arg_2_0._onHeroLevelSelectChanged, arg_2_0)
	arg_2_0._btnGetAllHero:AddClickListener(arg_2_0._onClickGetAllHeroBtn, arg_2_0)
	arg_2_0._btnDeleteAllHeroInfo:AddClickListener(arg_2_0._onClickDeleteAllHeroInfoBtn, arg_2_0)
	arg_2_0._btnHideGM:AddClickListener(arg_2_0._onClickHideGMBtn, arg_2_0)
	arg_2_0._btnUnLockAllEpisode:AddClickListener(arg_2_0._onClickUnLockAllEpisode, arg_2_0)
	arg_2_0._btnOpenHuaRongView:AddClickListener(arg_2_0._onClickOpenHuaRongViewBtn, arg_2_0)
	arg_2_0._btnOpenSeasonView:AddClickListener(arg_2_0._onClickOpenSeasonViewBtn, arg_2_0)

	if not SLFramework.FrameworkSettings.IsEditor and BootNativeUtil.isWindows() then
		arg_2_0._btnConfirm:AddClickListener(arg_2_0._onClickScreenSize, arg_2_0)
	end

	arg_2_0._btnExplore:AddClickListener(arg_2_0._onClickExplore, arg_2_0)
	arg_2_0._inpSpeed1:AddOnEndEdit(arg_2_0._onEndEdit1, arg_2_0)
	arg_2_0._inpSpeed2:AddOnEndEdit(arg_2_0._onEndEdit2, arg_2_0)
	arg_2_0._btnshowHero:AddClickListener(arg_2_0._onClickShowHero, arg_2_0)
	arg_2_0._btnshowUI:AddClickListener(arg_2_0._onClickShowUI, arg_2_0)
	arg_2_0._btnshowId:AddClickListener(arg_2_0._onClickShowID, arg_2_0)
	arg_2_0._btnwatermark:AddClickListener(arg_2_0._onClickWaterMark, arg_2_0)
	arg_2_0._btnCurSpeed:AddClickListener(arg_2_0._onClickCurSpeed, arg_2_0)
	arg_2_0._btncopytalentdata:AddClickListener(arg_2_0._onBtnCopyTalentData, arg_2_0)
	arg_2_0._btnReplaceSummonHero:AddClickListener(arg_2_0._OnBtnReplaceSummonHeroClick, arg_2_0)

	if arg_2_0._btnprintallentitybuff then
		arg_2_0._btnprintallentitybuff:AddClickListener(arg_2_0._onBtnPrintAllEntityBuff, arg_2_0)
	end

	arg_2_0:_AddClickListener(arg_2_0._btnCrash1, arg_2_0._testJavaCrash, arg_2_0)
	arg_2_0:_AddClickListener(arg_2_0._btnCrash2, arg_2_0._testOcCrash, arg_2_0)
	arg_2_0:_AddClickListener(arg_2_0._btnCrash3, arg_2_0._testNativeCrash, arg_2_0)
	arg_2_0._btnEnterView:AddClickListener(arg_2_0._onClickEnterView, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	arg_3_0._scroll:RemoveOnValueChanged()
	arg_3_0._btnClose:RemoveClickListener()
	arg_3_0._btnOK1:RemoveClickListener()
	arg_3_0._btnCommand:RemoveClickListener()
	arg_3_0._btnOK2:RemoveClickListener()
	arg_3_0._btnOK4:RemoveClickListener()
	arg_3_0._toggleEar:RemoveOnValueChanged()
	arg_3_0._btnQualityLow:RemoveClickListener()
	arg_3_0._btnQualityMid:RemoveClickListener()
	arg_3_0._btnQualityHigh:RemoveClickListener()
	arg_3_0._btnQualityNo:RemoveClickListener()
	arg_3_0._btnPP:RemoveClickListener()

	if arg_3_0._btnNewbiePrepare then
		arg_3_0._btnNewbiePrepare:RemoveClickListener()
	end

	arg_3_0._btnSetting:RemoveClickListener()
	SLFramework.UGUI.UIClickListener.Get(arg_3_0._txtSpeed.gameObject):RemoveClickListener()
	arg_3_0._sliderSpeed:RemoveOnValueChanged()
	arg_3_0._btnClearPlayerPrefs:RemoveClickListener()
	arg_3_0._btnBlockLog:RemoveClickListener()
	arg_3_0._btnProtoTestView:RemoveClickListener()
	arg_3_0._btnfastaddhero:RemoveClickListener()
	arg_3_0._btnTestFight:RemoveClickListener()
	arg_3_0._btnTestFightId:RemoveClickListener()
	arg_3_0._btnPostProcess:RemoveClickListener()
	arg_3_0._btnEffectStat:RemoveClickListener()
	arg_3_0._btnIgnoreSomeMsgLog:RemoveClickListener()
	arg_3_0._btnFightJoin:RemoveClickListener()
	arg_3_0._btnHideDebug:RemoveClickListener()
	arg_3_0._btnShowError:RemoveClickListener()
	arg_3_0._btnSkinOffsetAdjust:RemoveClickListener()
	arg_3_0._btnFightFocusAdjust:RemoveClickListener()

	if arg_3_0._toggleSkipPatFace then
		arg_3_0._toggleSkipPatFace:RemoveOnValueChanged()
	end

	arg_3_0._btnGuideEditor:RemoveClickListener()
	arg_3_0._btnHelpViewBrowse:RemoveClickListener()
	arg_3_0._btnGuideStatus:RemoveClickListener()
	arg_3_0._btnJumpOK:RemoveClickListener()
	arg_3_0._btnGuideStart:RemoveClickListener()
	arg_3_0._btnGuideFinish:RemoveClickListener()
	arg_3_0._btnGuideForbid:RemoveClickListener()
	arg_3_0._btnGuideReset:RemoveClickListener()
	arg_3_0._btnStorySkip:RemoveClickListener()
	arg_3_0._btnStoryOK:RemoveClickListener()
	arg_3_0._btnChangeColorOK:RemoveClickListener()
	arg_3_0._btnFightSimulate:RemoveClickListener()
	arg_3_0._btnFightEntity:RemoveClickListener()
	arg_3_0._btnResetCards:RemoveClickListener()
	arg_3_0._btnEpisodeOK:RemoveClickListener()
	arg_3_0._btnHeroFaith:RemoveClickListener()
	arg_3_0._btnHeroLevel:RemoveClickListener()
	arg_3_0._dropSkinGetView:RemoveOnValueChanged()
	arg_3_0._dropHeroFaith:RemoveOnValueChanged()
	arg_3_0._dropHeroLevel:RemoveOnValueChanged()
	arg_3_0._dropWeather:RemoveOnValueChanged()
	arg_3_0._btnGetAllHero:RemoveClickListener()
	arg_3_0._btnDeleteAllHeroInfo:RemoveClickListener()
	arg_3_0._btnHideGM:RemoveClickListener()
	arg_3_0._btnUnLockAllEpisode:RemoveClickListener()
	arg_3_0._btnOpenHuaRongView:RemoveClickListener()
	arg_3_0._btnOpenSeasonView:RemoveClickListener()

	if not SLFramework.FrameworkSettings.IsEditor and BootNativeUtil.isWindows() then
		arg_3_0._btnConfirm:RemoveClickListener()
	end

	arg_3_0._btnExplore:RemoveClickListener()
	arg_3_0._inpSpeed1:RemoveOnEndEdit()
	arg_3_0._inpSpeed2:RemoveOnEndEdit()
	arg_3_0._btnshowHero:RemoveClickListener()
	arg_3_0._btnshowUI:RemoveClickListener()
	arg_3_0._btnshowId:RemoveClickListener()
	arg_3_0._btnwatermark:RemoveClickListener()
	arg_3_0._btnCurSpeed:RemoveClickListener()
	arg_3_0._btncopytalentdata:RemoveClickListener()
	arg_3_0._btnReplaceSummonHero:RemoveClickListener()

	if arg_3_0._btnprintallentitybuff then
		arg_3_0._btnprintallentitybuff:RemoveClickListener()
	end

	arg_3_0:_RemoveClickListener(arg_3_0._btnCrash1)
	arg_3_0:_RemoveClickListener(arg_3_0._btnCrash2)
	arg_3_0:_RemoveClickListener(arg_3_0._btnCrash3)
	arg_3_0._btnEnterView:RemoveClickListener()
end

function var_0_0._AddClickListener(arg_4_0, arg_4_1, arg_4_2, arg_4_3)
	if arg_4_1 then
		arg_4_1:AddClickListener(arg_4_2, arg_4_3)
	end
end

function var_0_0._RemoveClickListener(arg_5_0, arg_5_1)
	if arg_5_1 then
		arg_5_1:RemoveClickListener()
	end
end

function var_0_0._AddOnValueChanged(arg_6_0, arg_6_1, arg_6_2, arg_6_3)
	if arg_6_1 then
		arg_6_1:AddOnValueChanged(arg_6_2, arg_6_3)
	end
end

function var_0_0._RemoveOnValueChanged(arg_7_0, arg_7_1)
	if arg_7_1 then
		arg_7_1:RemoveOnValueChanged()
	end
end

function var_0_0.onDestroyView(arg_8_0)
	return
end

function var_0_0.onOpen(arg_9_0)
	arg_9_0.initDone = false
	arg_9_0.selectHeroLevelId = 0
	arg_9_0.selectHeroFaithId = 0
	arg_9_0._prePlayingAudioId = 0
	arg_9_0.showHero = PlayerPrefsHelper.getNumber(PlayerPrefsKey.ShowHeroKey, 1) == 1 and true or false
	arg_9_0.showUI = PlayerPrefsHelper.getNumber(PlayerPrefsKey.ShowUIKey, 1) == 1 and true or false
	arg_9_0.showID = PlayerPrefsHelper.getNumber(PlayerPrefsKey.ShowIDKey, 1) == 1 and true or false
	arg_9_0.showWaterMark = OpenConfig.instance:isShowWaterMarkConfig()

	arg_9_0:_showHero()
	arg_9_0:_showUI()
	arg_9_0:_showID()
	arg_9_0:_showWaterMark()

	arg_9_0._txtAccountId.text = "账号:" .. (LoginModel.instance.userName or "nil")
	arg_9_0._scroll.verticalNormalizedPosition = PlayerPrefsHelper.getNumber(PlayerPrefsKey.GMToolViewScroll, 1)

	arg_9_0._inp1:SetText(PlayerPrefsHelper.getString(PlayerPrefsKey.GMToolViewGeneral, ""))
	arg_9_0._inpViewName:SetText(PlayerPrefsHelper.getString(PlayerPrefsKey.GMToolViewOpenView, ""))
	arg_9_0._inp21:SetText(PlayerPrefsHelper.getString(PlayerPrefsKey.GMToolViewAddItem1, ""))
	arg_9_0._inp22:SetText(PlayerPrefsHelper.getString(PlayerPrefsKey.GMToolViewAddItem2, ""))
	arg_9_0._inpTestFight:SetText(PlayerPrefsHelper.getString(PlayerPrefsKey.GMToolViewTestFight, ""))
	arg_9_0._inpJump:SetText(PlayerPrefsHelper.getString(PlayerPrefsKey.GMToolViewJump, ""))
	arg_9_0._inpGuide:SetText(PlayerPrefsHelper.getString(PlayerPrefsKey.GMToolViewGuide, ""))
	arg_9_0._inpEpisode:SetText(PlayerPrefsHelper.getString(PlayerPrefsKey.GMToolViewEpisode, ""))
	arg_9_0._inpStory:SetText(PlayerPrefsHelper.getString(PlayerPrefsKey.GMToolViewStory, ""))

	local var_9_0 = SDKMgr.instance:isEarphoneContact()

	arg_9_0._toggleEar.isOn = var_9_0

	if arg_9_0._toggleSkipPatFace then
		local var_9_1 = PatFaceModel.instance:getIsSkipPatFace()

		arg_9_0._toggleSkipPatFace.isOn = var_9_1
	end

	TaskDispatcher.runRepeat(arg_9_0._updateServerTime, arg_9_0, 0.2)
	arg_9_0:_updateQualityBtn()
	arg_9_0:_updateSpeedText()
	arg_9_0:_refreshPP()
	arg_9_0:_updateHeartBeatLogText()
	arg_9_0:_updateLogStateText()
	arg_9_0:_initScreenSize()
	arg_9_0:_initSkinViewSelect()
	arg_9_0:_initHeroFaithSelect()
	arg_9_0:_initHeroLevelSelect()
	arg_9_0:_initWeatherSelect()
	arg_9_0:_refreshGMBtnText()

	arg_9_0.initDone = true

	arg_9_0:_updateFightJoinText()
	arg_9_0:_updateFightSpeedText()
end

function var_0_0.onClose(arg_10_0)
	TaskDispatcher.cancelTask(arg_10_0._updateServerTime, arg_10_0, 0.2)
end

function var_0_0._onScrollValueChanged(arg_11_0, arg_11_1, arg_11_2)
	PlayerPrefsHelper.setNumber(PlayerPrefsKey.GMToolViewScroll, arg_11_2)
end

function var_0_0._updateServerTime(arg_12_0)
	local var_12_0 = os.date("!*t", ServerTime.now() + ServerTime.serverUtcOffset())

	arg_12_0._txtServerTime.text = string.format("%04d-%02d-%02d %02d:%02d:%02d", var_12_0.year, var_12_0.month, var_12_0.day, var_12_0.hour, var_12_0.min, var_12_0.sec)
	arg_12_0._txtLocalTime.text = os.date("%Y-%m-%d %H:%M:%S", os.time())
end

function var_0_0._onClickBtnOK1(arg_13_0)
	local var_13_0 = arg_13_0._inp1:GetText()

	PlayerPrefsHelper.setString(PlayerPrefsKey.GMToolViewGeneral, var_13_0)

	local var_13_1 = 0
	local var_13_2

	for iter_13_0 in var_13_0:gmatch("[^\r\n]+") do
		if not string.nilorempty(iter_13_0) then
			if string.find(iter_13_0, "set dungeon") then
				var_13_2 = iter_13_0
			else
				if var_13_1 == 0 then
					arg_13_0:_sendGM(iter_13_0)
				else
					TaskDispatcher.runDelay(function()
						arg_13_0:_sendGM(iter_13_0)
					end, nil, var_13_1)
				end

				var_13_1 = var_13_1 + 0.1
			end
		end
	end

	if var_13_2 then
		if var_13_1 == 0 then
			arg_13_0:_sendGM(var_13_2)
		else
			TaskDispatcher.runDelay(function()
				arg_13_0:_sendGM(var_13_2)
			end, nil, var_13_1)
		end
	end
end

function var_0_0._sendGM(arg_16_0, arg_16_1)
	GameFacade.showToast(ToastEnum.IconId, arg_16_1)

	if arg_16_1:find("bossrush") then
		BossRushController_Test.instance:_test(arg_16_1)

		return
	end

	GMCommandHistoryModel.instance:addCommandHistory(arg_16_1)

	if string.find(arg_16_1, "#") == 1 then
		local var_16_0 = string.split(arg_16_1, " ")

		arg_16_0:_clientGM(var_16_0)

		return
	end

	GMRpc.instance:sendGMRequest(arg_16_1)
	arg_16_0:_onServerGM(arg_16_1)
end

function var_0_0._onServerGM(arg_17_0, arg_17_1)
	if string.find(arg_17_1, "delete%sexplore") then
		PlayerPrefsHelper.deleteKey(PlayerPrefsKey.ExploreRedDotData .. PlayerModel.instance:getMyUserId())
		ExploreSimpleModel.instance:reInit()
		ExploreRpc.instance:sendGetExploreSimpleInfoRequest()
	end

	if string.find(arg_17_1, "diceFightWin") then
		TaskDispatcher.runDelay(function()
			if DiceHeroFightModel.instance.finishResult ~= DiceHeroEnum.GameStatu.None then
				ViewMgr.instance:openView(ViewName.DiceHeroResultView, {
					status = DiceHeroFightModel.instance.finishResult
				})
				DiceHeroStatHelper.instance:sendFightEnd(DiceHeroFightModel.instance.finishResult, DiceHeroFightModel.instance.isFirstWin)

				DiceHeroFightModel.instance.finishResult = DiceHeroEnum.GameStatu.None
			end
		end, arg_17_0, 0.5)
	end
end

function var_0_0._clientGM(arg_19_0, arg_19_1)
	local var_19_0 = arg_19_1[1]:sub(2)

	GMCommand.processCmd(var_19_0, unpack(arg_19_1, 2))
end

function var_0_0._onClickBtnCommand(arg_20_0)
	if UnityEngine.Input.GetKey(UnityEngine.KeyCode.LeftControl) then
		UnityEngine.Application.OpenURL("http://doc.sl.com/pages/viewpage.action?pageId=3342342")

		return
	end

	GMController.instance:dispatchEvent(GMCommandView.OpenCommand)
end

function var_0_0._onClickBtnOK2(arg_21_0)
	local var_21_0 = arg_21_0._inp21:GetText()
	local var_21_1 = arg_21_0._inp22:GetText()
	local var_21_2 = string.split(var_21_0, "#")
	local var_21_3 = var_21_2[1]
	local var_21_4 = tonumber(var_21_2[2])
	local var_21_5 = 1

	if not string.nilorempty(var_21_1) then
		var_21_5 = tonumber(var_21_1)
	end

	if var_21_5 and var_21_5 < 0 then
		GameFacade.showToast(ToastEnum.GMTool1, var_21_4)
		GMRpc.instance:sendGMRequest(string.format("delete material %d#%d#%d", var_21_3, var_21_4, -var_21_5))

		return
	end

	if tonumber(var_21_3) == MaterialEnum.MaterialType.Hero then
		GameFacade.showToast(ToastEnum.GMTool2, var_21_4)
		GMRpc.instance:sendGMRequest(string.format("add material %d#%d#%d", MaterialEnum.MaterialType.Hero, var_21_4, var_21_5))
	elseif var_21_3 == GMAddItemView.LevelType then
		GameFacade.showToast(ToastEnum.GMTool3, var_21_5)
		GMRpc.instance:sendGMRequest(string.format("set level %d", var_21_5))
	elseif tonumber(var_21_3) == MaterialEnum.MaterialType.Exp then
		GameFacade.showToast(ToastEnum.GMTool4, var_21_5)
		GMRpc.instance:sendGMRequest(string.format("add material 3#0#%d", var_21_5))
	elseif var_21_2[1] == GMAddItemView.HeroAttr then
		local var_21_6 = string.splitToNumber(var_21_1, "#")
		local var_21_7 = var_21_6[1] or 1
		local var_21_8 = var_21_6[2] or 100
		local var_21_9 = var_21_6[3] or 100
		local var_21_10 = var_21_6[4] or 2

		GameFacade.showToast(ToastEnum.GMToolFastAddHero, string.format(" 等级%d 洞悉%d 共鸣%d 塑造%d", var_21_7, var_21_8, var_21_9, var_21_10))
		GMRpc.instance:sendGMRequest(string.format("add heroAttr %d#%d#%d#%d#%d", var_21_4, var_21_7, var_21_8, var_21_9, var_21_10))
	else
		GameFacade.showToast(ToastEnum.GMTool5, var_21_4)
		GMRpc.instance:sendGMRequest(string.format("add material %d#%d#%d", var_21_3, var_21_4, var_21_5))
	end

	PlayerPrefsHelper.setString(PlayerPrefsKey.GMToolViewAddItem1, var_21_0)
	PlayerPrefsHelper.setString(PlayerPrefsKey.GMToolViewAddItem2, var_21_1)
end

function var_0_0._onClickBtnOK4(arg_22_0)
	LoginController.instance:logout()
end

function var_0_0._updateQualityBtn(arg_23_0)
	local var_23_0 = PlayerPrefsHelper.getNumber(PlayerPrefsKey.GMToolViewQuality, ModuleEnum.Performance.Undefine)

	for iter_23_0, iter_23_1 in ipairs(arg_23_0._imgQualitys) do
		iter_23_1.color = iter_23_0 == var_23_0 + 1 and Color.green or Color.white
	end
end

function var_0_0._onClickBtnQualityLow(arg_24_0)
	PlayerPrefsHelper.setNumber(PlayerPrefsKey.GMToolViewQuality, ModuleEnum.Performance.Low)
	GameGlobalMgr.instance:getScreenState():setLocalQuality(ModuleEnum.Performance.Low)
	FightEffectPool.dispose()
	arg_24_0:_updateQualityBtn()
end

function var_0_0._onClickBtnQualityMid(arg_25_0)
	PlayerPrefsHelper.setNumber(PlayerPrefsKey.GMToolViewQuality, ModuleEnum.Performance.Middle)
	GameGlobalMgr.instance:getScreenState():setLocalQuality(ModuleEnum.Performance.Middle)
	FightEffectPool.dispose()
	arg_25_0:_updateQualityBtn()
end

function var_0_0._onClickBtnQualityHigh(arg_26_0)
	PlayerPrefsHelper.setNumber(PlayerPrefsKey.GMToolViewQuality, ModuleEnum.Performance.High)
	GameGlobalMgr.instance:getScreenState():setLocalQuality(ModuleEnum.Performance.High)
	FightEffectPool.dispose()
	arg_26_0:_updateQualityBtn()
end

function var_0_0._onClickBtnQualityNo(arg_27_0)
	PlayerPrefsHelper.setNumber(PlayerPrefsKey.GMToolViewQuality, ModuleEnum.Performance.Undefine)
	GameGlobalMgr.instance:getScreenState():setLocalQuality(ModuleEnum.Performance.Undefine)
	FightEffectPool.dispose()
	arg_27_0:_updateQualityBtn()
end

function var_0_0._onClickBtnPP(arg_28_0)
	GMPostProcessModel.instance.ppType = (GMPostProcessModel.instance.ppType + 1) % 4

	arg_28_0:_refreshPP()
end

function var_0_0._onClickBtnSetting(arg_29_0)
	arg_29_0:addEventCb(ViewMgr.instance, ViewEvent.OnOpenViewFinish, arg_29_0._onOpenSettingFinish, arg_29_0)
	SettingsController.instance:openView()
end

function var_0_0._onClickBtnNewbiePrepare(arg_30_0)
	arg_30_0:_sendGM("gmSet onekey")
end

function var_0_0._onOpenSettingFinish(arg_31_0, arg_31_1)
	if arg_31_1 == ViewName.SettingsView then
		arg_31_0:removeEventCb(ViewMgr.instance, ViewEvent.OnOpenViewFinish, arg_31_0._onOpenSettingFinish, arg_31_0)
		ViewMgr.instance:getContainer(ViewName.SettingsView):switchTab(3)
	end
end

function var_0_0._refreshPP(arg_32_0)
	if GMPostProcessModel.instance.ppType == 0 then
		PostProcessingMgr.instance:setUIActive(false)
		PostProcessingMgr.instance:setUnitActive(false)

		arg_32_0._txtBtnPP.text = "OFF"
	elseif GMPostProcessModel.instance.ppType == 1 then
		PostProcessingMgr.instance:setUIActive(true)
		PostProcessingMgr.instance:setUnitActive(false)

		arg_32_0._txtBtnPP.text = "UI"
	elseif GMPostProcessModel.instance.ppType == 2 then
		PostProcessingMgr.instance:setUIActive(false)
		PostProcessingMgr.instance:setUnitActive(true)

		arg_32_0._txtBtnPP.text = "Unit"
	else
		PostProcessingMgr.instance:setUIActive(true)
		PostProcessingMgr.instance:setUnitActive(true)

		arg_32_0._txtBtnPP.text = "ALL"
	end
end

function var_0_0._updateSpeedText(arg_33_0)
	local var_33_0 = GameTimeMgr.instance:getTimeScale(GameTimeMgr.TimeScaleType.GM)

	arg_33_0._sliderSpeed:SetValue(var_33_0)

	arg_33_0._txtSpeed.text = string.format("Speed x%.2f", var_33_0)
end

function var_0_0._onClickSpeedText(arg_34_0)
	arg_34_0:_onSpeedChange(nil, 1)
end

function var_0_0._onSpeedChange(arg_35_0, arg_35_1, arg_35_2)
	arg_35_0._sliderSpeed:SetValue(arg_35_2)

	arg_35_0._txtSpeed.text = string.format("Speed x%.2f", arg_35_2)

	GameTimeMgr.instance:setTimeScale(GameTimeMgr.TimeScaleType.GM, arg_35_2)
end

function var_0_0._onClickBtnClearPlayerPrefs(arg_36_0)
	PlayerPrefsHelper.deleteAll()
	GameFacade.showToast(ToastEnum.GMToolClearPlayerPrefs)
end

function var_0_0._onClickBtnBlockLog(arg_37_0)
	local var_37_0 = not getGlobal("canLogNormal")

	setGlobal("canLogNormal", var_37_0)
	setGlobal("canLogWarn", var_37_0)
	setGlobal("canLogError", var_37_0)

	SLFramework.SLLogger.CanLogNormal = var_37_0
	SLFramework.SLLogger.CanLogWarn = var_37_0
	SLFramework.SLLogger.CanLogError = var_37_0
	GuideController.EnableLog = var_37_0

	arg_37_0:_updateLogStateText()
end

function var_0_0._updateLogStateText(arg_38_0)
	gohelper.findChildText(arg_38_0._btnBlockLog.gameObject, "Text").text = getGlobal("canLogNormal") and "屏蔽所有log" or "恢复所有log"
end

function var_0_0._onClickBtnProtoTestView(arg_39_0)
	arg_39_0:closeThis()
	ViewMgr.instance:openView(ViewName.ProtoTestView)
end

function var_0_0._onClickTestFight(arg_40_0)
	local var_40_0 = arg_40_0._inpTestFight:GetText()

	if not string.nilorempty(var_40_0) then
		local var_40_1 = string.splitToNumber(var_40_0, "#")

		if #var_40_1 > 0 then
			PlayerPrefsHelper.setString(PlayerPrefsKey.GMToolViewTestFight, var_40_0)
			HeroGroupModel.instance:setParam(nil, nil, nil)

			local var_40_2 = HeroGroupModel.instance:getCurGroupMO()

			if not var_40_2 then
				logError("current HeroGroupMO is nil")
				GameFacade.showMessageBox(MessageBoxIdDefine.HeroGroupPleaseAdd, MsgBoxEnum.BoxType.Yes)

				return
			end

			local var_40_3, var_40_4 = var_40_2:getMainList()
			local var_40_5, var_40_6 = var_40_2:getSubList()
			local var_40_7 = var_40_2:getAllHeroEquips()

			arg_40_0:closeThis()

			local var_40_8 = FightParam.New()

			var_40_8.monsterGroupIds = var_40_1
			var_40_8.isTestFight = true

			var_40_8:setSceneLevel(10601)
			var_40_8:setMySide(var_40_2.clothId, var_40_3, var_40_5, var_40_7)
			FightModel.instance:setFightParam(var_40_8)
			FightController.instance:sendTestFight(var_40_8)

			return
		end
	end

	logError("please input monsterGroupIds, split with '#'")
end

function var_0_0._onClickTestFightId(arg_41_0)
	local var_41_0 = arg_41_0._inpTestFight:GetText()
	local var_41_1 = tonumber(var_41_0)

	if var_41_1 and lua_battle.configDict[var_41_1] then
		local var_41_2 = FightController.instance:setFightParamByBattleId(var_41_1)

		HeroGroupModel.instance:setParam(var_41_1, nil, nil)

		local var_41_3 = HeroGroupModel.instance:getCurGroupMO()

		if not var_41_3 then
			logError("current HeroGroupMO is nil")
			GameFacade.showMessageBox(MessageBoxIdDefine.HeroGroupPleaseAdd, MsgBoxEnum.BoxType.Yes)

			return
		end

		local var_41_4, var_41_5 = var_41_3:getMainList()
		local var_41_6, var_41_7 = var_41_3:getSubList()
		local var_41_8 = var_41_3:getAllHeroEquips()

		PlayerPrefsHelper.setString(PlayerPrefsKey.GMToolViewTestFight, var_41_0)
		arg_41_0:closeThis()

		for iter_41_0, iter_41_1 in ipairs(lua_episode.configList) do
			if iter_41_1.battleId == var_41_1 then
				var_41_2.episodeId = iter_41_1.id
				FightResultModel.instance.episodeId = iter_41_1.id

				DungeonModel.instance:SetSendChapterEpisodeId(iter_41_1.chapterId, iter_41_1.id)

				break
			end
		end

		if not var_41_2.episodeId then
			var_41_2.episodeId = 10101
		end

		var_41_2:setMySide(var_41_3.clothId, var_41_4, var_41_6, var_41_8)
		FightController.instance:sendTestFightId(var_41_2)
	end
end

function var_0_0._onClickPostProcess(arg_42_0)
	arg_42_0:closeThis()
	ViewMgr.instance:openView(ViewName.GMPostProcessView)
end

function var_0_0._onClickEffectStat(arg_43_0)
	if ViewMgr.instance:isOpen(ViewName.SkillEffectStatView) then
		ViewMgr.instance:closeView(ViewName.SkillEffectStatView)
	else
		ViewMgr.instance:openView(ViewName.SkillEffectStatView)
	end
end

function var_0_0._onClickIgnoreSomeMsgLog(arg_44_0)
	if LuaSocketMgr.instance._ignoreSomeCmdLog then
		GMController.instance:resumeHeartBeatLog()
	else
		GMController.instance:ignoreHeartBeatLog()
	end

	arg_44_0:_updateHeartBeatLogText()
end

function var_0_0._updateHeartBeatLogText(arg_45_0)
	local var_45_0 = LuaSocketMgr.instance._ignoreSomeCmdLog and "恢复心跳打印" or "屏蔽心跳打印"

	gohelper.findChildText(arg_45_0.viewGO, "viewport/content/item11/Button/Text").text = var_45_0
end

function var_0_0._onClickFightJoin(arg_46_0)
	FightModel.instance:switchGMFightJoin()
	arg_46_0:_updateFightJoinText()
end

function var_0_0._updateFightJoinText(arg_47_0)
	local var_47_0 = FightModel.instance:isGMFightJoin() and "关闭战斗衔接" or "启用战斗衔接"

	gohelper.findChildText(arg_47_0.viewGO, "viewport/content/item11/btnFightJoin/Text").text = var_47_0
end

function var_0_0._onEndEdit1(arg_48_0, arg_48_1)
	arg_48_0:_setFightSpeed()
end

function var_0_0._onEndEdit2(arg_49_0, arg_49_1)
	arg_49_0:_setFightSpeed()
end

function var_0_0._onClickCurSpeed(arg_50_0)
	local var_50_0 = FightModel.instance._normalSpeed
	local var_50_1 = FightModel.instance._replaySpeed
	local var_50_2 = FightModel.instance._replayUISpeed

	logError("手动战斗速度：一倍" .. var_50_0[1] .. " 二倍" .. var_50_0[2])
	logError("战斗回溯速度：一倍" .. var_50_1[1] .. " 二倍" .. var_50_1[2])
	logError("战斗回溯UI速：一倍" .. var_50_2[1] .. " 二倍" .. var_50_2[2])
	logError("玩家选择速度：" .. FightModel.instance:getUserSpeed())
	logError("当前战斗速度：" .. FightModel.instance:getSpeed())
	logError("当前战斗UI速：" .. FightModel.instance:getUISpeed())
end

function var_0_0._setFightSpeed(arg_51_0)
	local var_51_0 = tonumber(arg_51_0._inpSpeed1:GetText()) or 1
	local var_51_1 = tonumber(arg_51_0._inpSpeed2:GetText()) or 1

	FightModel.instance:setGMSpeed(var_51_0, var_51_1)
	FightController.instance:dispatchEvent(FightEvent.OnUpdateSpeed)
end

function var_0_0._updateFightSpeedText(arg_52_0)
	local var_52_0 = FightModel.instance:getNormalSpeed()
	local var_52_1 = FightModel.instance:getReplaySpeed()

	arg_52_0._inpSpeed1:SetText(tostring(var_52_0))
	arg_52_0._inpSpeed2:SetText(tostring(var_52_1))
end

function var_0_0._onClickHideBug(arg_53_0)
	local var_53_0 = PlayerPrefsHelper.getNumber(PlayerPrefsKey.GMToolViewDebugView, 0) == 1

	PlayerPrefsHelper.setNumber(PlayerPrefsKey.GMToolViewDebugView, var_53_0 and 0 or 1)
	gohelper.setActive(GMController.debugViewGO, not var_53_0)
end

function var_0_0._onClickShowError(arg_54_0)
	GMLogController.instance:cancelBlock()
end

function var_0_0._onClickSkinOffsetAdjust(arg_55_0)
	if MainSceneSwitchModel.instance:getCurSceneId() ~= 1 then
		logError("请在箱中布景把主场景切换为《浪潮之初》才能调整皮肤偏移！")

		return
	end

	arg_55_0:closeThis()
	ViewMgr.instance:openView(ViewName.SkinOffsetAdjustView)
end

function var_0_0._onClickFightFocusAdjust(arg_56_0)
	if not ViewMgr.instance:isOpen(ViewName.FightFocusView) then
		return
	end

	arg_56_0:closeThis()
	ViewMgr.instance:openView(ViewName.FightFocusCameraAdjustView)
end

function var_0_0._onSkipPatFaceToggleValueChange(arg_57_0, arg_57_1, arg_57_2)
	if not arg_57_0.initDone then
		return
	end

	PatFaceModel.instance:setIsSkipPatFace(arg_57_2 and true or false)
end

function var_0_0._onClickGuideEditor(arg_58_0)
	arg_58_0:closeThis()
	ViewMgr.instance:openView(ViewName.GuideStepEditor)
end

function var_0_0._onClickHelpViewBrowse(arg_59_0)
	arg_59_0:closeThis()
	ViewMgr.instance:openView(ViewName.GMHelpViewBrowseView)
end

function var_0_0._onClickGuideStatus(arg_60_0)
	arg_60_0:closeThis()
	ViewMgr.instance:openView(ViewName.GMGuideStatusView)
end

function var_0_0._onClickJumpOK(arg_61_0)
	local var_61_0 = arg_61_0._inpJump:GetText()

	PlayerPrefsHelper.setString(PlayerPrefsKey.GMToolViewJump, var_61_0)
	arg_61_0:closeThis()

	local var_61_1 = tonumber(var_61_0)

	if var_61_1 then
		GameFacade.jump(var_61_1)
	else
		GameFacade.jumpByStr(var_61_0)
	end
end

function var_0_0._onClickEpisodeOK(arg_62_0)
	local var_62_0 = arg_62_0._inpEpisode:GetText()

	PlayerPrefsHelper.setString(PlayerPrefsKey.GMToolViewEpisode, var_62_0)

	local var_62_1 = string.splitToNumber(var_62_0, "#")
	local var_62_2 = tonumber(var_62_1[1])
	local var_62_3 = DungeonConfig.instance:getEpisodeCO(var_62_2)

	if var_62_3 then
		arg_62_0:closeThis()

		if DungeonModel.isBattleEpisode(var_62_3) then
			DungeonFightController.instance:enterFight(var_62_3.chapterId, var_62_3.id)
		else
			logError("GMToolView 不支持该类型的关卡" .. var_62_2)
		end
	else
		logError("GMToolView 关卡id不正确")
	end
end

function var_0_0._onClickGuideStart(arg_63_0)
	arg_63_0:closeThis()

	local var_63_0 = arg_63_0._inpGuide:GetText()

	PlayerPrefsHelper.setString(PlayerPrefsKey.GMToolViewGuide, var_63_0)

	local var_63_1 = string.splitToNumber(var_63_0, "#")
	local var_63_2 = tonumber(var_63_1[1])
	local var_63_3 = tonumber(var_63_1[2]) or 0

	print(string.format("input guideId:%s,guideStep:%s", var_63_2, var_63_3))

	local var_63_4 = GuideModel.instance:getById(var_63_2)

	GuideModel.instance:gmStartGuide(var_63_2, var_63_3)

	if var_63_4 then
		GuideStepController.instance:clearFlow(var_63_2)

		var_63_4.isJumpPass = false

		GMRpc.instance:sendGMRequest("delete guide " .. var_63_2)

		;({}).guideInfos = {
			{
				guideId = var_63_2,
				stepId = var_63_3
			}
		}

		GuideRpc.instance:sendFinishGuideRequest(var_63_2, var_63_3)
		logNormal(string.format("<color=#FFA500>set guideId:%s,guideStep:%s</color>", var_63_2, var_63_3))
	elseif var_63_2 then
		GuideController.instance:startGudie(var_63_2)
		logNormal("<color=#FFA500>start guide " .. var_63_2 .. "</color>")
	end
end

function var_0_0._onClickGuideFinish(arg_64_0)
	local var_64_0 = arg_64_0._inpGuide:GetText()

	PlayerPrefsHelper.setString(PlayerPrefsKey.GMToolViewGuide, var_64_0)

	if not string.nilorempty(var_64_0) then
		local var_64_1 = tonumber(var_64_0)

		if var_64_1 then
			local var_64_2 = GuideModel.instance:getById(var_64_1)

			arg_64_0:closeThis()
			logNormal("GM one key finish guide " .. var_64_1)

			local var_64_3 = GuideConfig.instance:getStepList(var_64_1)

			for iter_64_0 = #var_64_3, 1, -1 do
				local var_64_4 = var_64_3[iter_64_0]

				if var_64_4.keyStep == 1 then
					GuideRpc.instance:sendFinishGuideRequest(var_64_1, var_64_4.stepId)

					break
				end
			end
		else
			local var_64_5 = string.split(var_64_0, "#")

			logNormal("GM one key finish guide " .. var_64_0)
			GuideRpc.instance:sendFinishGuideRequest(tonumber(var_64_5[1]), tonumber(var_64_5[2]))
		end
	else
		logNormal("GM one key finish guides")
		GuideStepController.instance:clearStep()
		GuideController.instance:oneKeyFinishGuides()
	end
end

function var_0_0._onClickGuideForbid(arg_65_0)
	local var_65_0 = GuideController.instance:isForbidGuides()

	GuideController.instance:forbidGuides(not var_65_0)
end

function var_0_0._onClickGuideReset(arg_66_0)
	local var_66_0 = arg_66_0._inpGuide:GetText()

	PlayerPrefsHelper.setString(PlayerPrefsKey.GMToolViewGuide, var_66_0)

	local var_66_1 = string.splitToNumber(var_66_0, "#")
	local var_66_2 = tonumber(var_66_1[1])
	local var_66_3 = GuideConfig.instance:getGuideCO(var_66_2)

	if var_66_3 then
		print(string.format("reset guideId:%s", var_66_2))
		GuideStepController.instance:clearFlow(var_66_2)
		GMRpc.instance:sendGMRequest("delete guide " .. var_66_2)

		local var_66_4 = string.split(var_66_3.trigger, "#")
		local var_66_5 = var_66_4[1]

		arg_66_0:_resetEpisode(var_66_4[1], var_66_4[2])

		local var_66_6 = GameUtil.splitString2(var_66_3.invalid, false, "|", "#")

		if not var_66_6 then
			return
		end

		for iter_66_0, iter_66_1 in ipairs(var_66_6) do
			-- block empty
		end
	end
end

function var_0_0._resetEpisode(arg_67_0, arg_67_1, arg_67_2)
	if arg_67_1 == "EpisodeFinish" or arg_67_1 == "EnterEpisode" then
		arg_67_0:_doResetEpisode(tonumber(arg_67_2))

		return
	end

	local var_67_0 = lua_open.configDict[tonumber(arg_67_2)]

	if var_67_0 then
		arg_67_0:_doResetEpisode(var_67_0.episodeId)
	end
end

function var_0_0._doResetEpisode(arg_68_0, arg_68_1)
	local var_68_0 = lua_episode.configDict[arg_68_1]

	if not var_68_0 then
		return
	end

	GMRpc.instance:sendGMRequest(string.format("set dungeon %s 0", arg_68_1))

	if var_68_0.beforeStory > 0 then
		print(arg_68_1 .. " delete beforeStory")
		GMRpc.instance:sendGMRequest(string.format("delete story %s", var_68_0.beforeStory))
	end

	if var_68_0.afterStory > 0 then
		print(arg_68_1 .. " delete afterStory")
		GMRpc.instance:sendGMRequest(string.format("delete story %s", var_68_0.afterStory))
	end
end

function var_0_0._onClickStoryOK(arg_69_0)
	arg_69_0:closeThis()

	local var_69_0 = arg_69_0._inpStory:GetText()

	if not string.nilorempty(var_69_0) then
		local var_69_1 = string.splitToNumber(var_69_0, "#")
		local var_69_2 = var_69_1[1]
		local var_69_3 = var_69_1[2]

		if var_69_2 then
			PlayerPrefsHelper.setString(PlayerPrefsKey.GMToolViewStory, var_69_2)

			if var_69_3 then
				StoryController.instance:playStoryByStartStep(var_69_2, var_69_3)
			else
				local var_69_4 = {}

				var_69_4.isReplay = true
				var_69_4.mark = false

				StoryController.instance:playStory(var_69_2, var_69_4)
			end
		end
	end
end

function var_0_0._onClickStorySkip(arg_70_0)
	if ViewMgr.instance:isOpen(ViewName.StoryView) then
		StoryController.instance:playFinished()
	end
end

function var_0_0._onClickChangeColorOK(arg_71_0)
	arg_71_0:closeThis()

	local var_71_0 = arg_71_0._inpChangeColor:GetText()

	if not string.nilorempty(var_71_0) then
		local var_71_1 = tonumber(var_71_0)

		if var_71_1 then
			DungeonPuzzleChangeColorController.instance:enterDecryptChangeColor(var_71_1)
		end
	end
end

function var_0_0._onClickFightSimulate(arg_72_0)
	arg_72_0:closeThis()
	ViewMgr.instance:openView(ViewName.GMFightSimulateView)
end

function var_0_0._onClickFightEntity(arg_73_0)
	arg_73_0:closeThis()
	ViewMgr.instance:openView(ViewName.GMFightEntityView)
end

function var_0_0._onClickResetCards(arg_74_0)
	if GameSceneMgr.instance:getCurSceneType() == SceneType.Fight then
		arg_74_0:closeThis()
		ViewMgr.instance:openView(ViewName.GMResetCardsView)
	else
		GameFacade.showToast(ToastEnum.IconId, "not in fight")
	end
end

function var_0_0._initScreenSize(arg_75_0)
	if BootNativeUtil.isWindows() then
		arg_75_0._inpScreenWidth:SetText(SettingsModel.instance._screenWidth)
		arg_75_0._inpScreenHeight:SetText(SettingsModel.instance._screenHeight)
	else
		gohelper.setActive(arg_75_0._inpScreenWidth.gameObject.transform.parent.gameObject, false)
	end
end

function var_0_0._formatSize(arg_76_0, arg_76_1, arg_76_2)
	local var_76_0 = tonumber(arg_76_1)

	if not var_76_0 then
		return arg_76_2
	end

	if var_76_0 < 1 then
		return arg_76_2
	end

	return var_76_0
end

function var_0_0._onClickExplore(arg_77_0)
	local var_77_0 = arg_77_0._inpExplore:GetText() or ""
	local var_77_1 = string.match(var_77_0, "(%d+)$")
	local var_77_2 = tonumber(var_77_1) or 101

	if not ExploreSimpleModel.instance:getMapIsUnLock(var_77_2) then
		local var_77_3
		local var_77_4 = 5
		local var_77_5 = 3
		local var_77_6 = DungeonConfig.instance:getChapterCOListByType(DungeonEnum.ChapterType.Normal)

		if var_77_6[var_77_4] then
			local var_77_7 = DungeonConfig.instance:getChapterNonSpEpisodeCOList(var_77_6[var_77_4].id)

			var_77_3 = var_77_7 and var_77_7[var_77_5] and var_77_7[var_77_5].id
		end

		if var_77_3 then
			GMRpc.instance:sendGMRequest(string.format("set dungeon %d", var_77_3))
		end

		if not DungeonMapModel.instance:elementIsFinished(1050302) then
			DungeonRpc.instance:sendMapElementRequest(1050302)
		end

		GMRpc.instance:sendGMRequest("set explore")
		ExploreRpc.instance:sendGetExploreSimpleInfoRequest()
	end

	ExploreController.instance:enterExploreScene(var_77_2)

	local var_77_8 = ExploreConfig.instance:getMapIdConfig(var_77_2)

	if var_77_8 then
		ExploreSimpleModel.instance:setLastSelectMap(var_77_8.chapterId, var_77_8.episodeId)
	end
end

function var_0_0._onClickScreenSize(arg_78_0)
	local var_78_0 = arg_78_0._inpScreenWidth:GetText()
	local var_78_1 = arg_78_0._inpScreenHeight:GetText()
	local var_78_2 = arg_78_0:_formatSize(var_78_0, SettingsModel.instance._screenWidth)
	local var_78_3 = arg_78_0:_formatSize(var_78_1, SettingsModel.instance._screenHeight)

	arg_78_0._inpScreenWidth:SetText(var_78_2)
	arg_78_0._inpScreenHeight:SetText(var_78_3)
	SettingsModel.instance:_setScreenWidthAndHeight(string.format("%d * %d", var_78_2, var_78_3))
end

function var_0_0._initHaveHeroNameList(arg_79_0)
	if arg_79_0.haveHeroList then
		return
	end

	arg_79_0.haveHeroList = {}

	table.insert(arg_79_0.haveHeroList, "英雄选择")

	for iter_79_0, iter_79_1 in ipairs(HeroModel.instance:getList()) do
		local var_79_0 = iter_79_1.config.name .. "#" .. tostring(iter_79_1.heroId)

		table.insert(arg_79_0.haveHeroList, var_79_0)
	end
end

function var_0_0._initSkinViewSelect(arg_80_0)
	arg_80_0:_initHaveHeroNameList()
	arg_80_0._dropSkinGetView:ClearOptions()
	arg_80_0._dropSkinGetView:AddOptions(arg_80_0.haveHeroList)
end

function var_0_0._initHeroFaithSelect(arg_81_0)
	arg_81_0:_initHaveHeroNameList()
	arg_81_0._dropHeroFaith:ClearOptions()
	arg_81_0._dropHeroFaith:AddOptions(arg_81_0.haveHeroList)
end

function var_0_0._initHeroLevelSelect(arg_82_0)
	arg_82_0:_initHaveHeroNameList()
	arg_82_0._dropHeroLevel:ClearOptions()
	arg_82_0._dropHeroLevel:AddOptions(arg_82_0.haveHeroList)
end

function var_0_0._onSkinGetValueChanged(arg_83_0, arg_83_1)
	if not arg_83_0.haveHeroList then
		return
	end

	if arg_83_1 == 0 then
		return
	end

	local var_83_0 = string.split(arg_83_0.haveHeroList[arg_83_1 + 1], "#")[2]

	if not var_83_0 then
		logError("not found : " .. arg_83_0.haveHeroList[arg_83_1 + 1])
	end

	local var_83_1 = {
		heroId = tonumber(var_83_0)
	}

	var_83_1.newRank = 3
	var_83_1.isRank = true

	PopupController.instance:addPopupView(PopupEnum.PriorityType.GainCharacterView, ViewName.CharacterGetView, var_83_1)
end

function var_0_0._onHeroFaithSelectChanged(arg_84_0, arg_84_1)
	if not arg_84_0.haveHeroList then
		return
	end

	if arg_84_1 == 0 then
		return
	end

	local var_84_0 = string.split(arg_84_0.haveHeroList[arg_84_1 + 1], "#")[2]

	if not var_84_0 then
		logError("not found : " .. arg_84_0.haveHeroList[arg_84_1 + 1])
	end

	arg_84_0.selectHeroFaithId = tonumber(var_84_0)
end

function var_0_0._onHeroLevelSelectChanged(arg_85_0, arg_85_1)
	if not arg_85_0.haveHeroList then
		return
	end

	if arg_85_1 == 0 then
		return
	end

	local var_85_0 = string.split(arg_85_0.haveHeroList[arg_85_1 + 1], "#")[2]

	if not var_85_0 then
		logError("not found : " .. arg_85_0.haveHeroList[arg_85_1 + 1])
	end

	arg_85_0.selectHeroLevelId = tonumber(var_85_0)
end

function var_0_0._onClickHeroFaithOk(arg_86_0)
	if arg_86_0.selectHeroFaithId == 0 then
		return
	end

	GameFacade.showToast(ToastEnum.GMTool5, arg_86_0.selectHeroFaithId)
	GMRpc.instance:sendGMRequest(string.format("add material %d#%d#%d", 6, arg_86_0.selectHeroFaithId, HeroConfig.instance.maxFaith))
end

function var_0_0._onClickHeroLevelOk(arg_87_0)
	if arg_87_0.selectHeroLevelId == 0 then
		return
	end

	local var_87_0 = arg_87_0._inpHeroLevel:GetText()

	GameFacade.showToast(ToastEnum.GMToolFastAddHero, string.format(" 等级%d 洞悉%d 共鸣%d 塑造%d", var_87_0, 100, 100, 2))
	GMRpc.instance:sendGMRequest(string.format("add heroAttr %d#%d#%d#%d#%d", arg_87_0.selectHeroLevelId, var_87_0, 100, 100, 2))
end

function var_0_0._initWeatherSelect(arg_88_0)
	arg_88_0.weatherReportIdList = {}

	for iter_88_0, iter_88_1 in ipairs(lua_weather_report.configList) do
		local var_88_0 = BGMSwitchProgress.WeatherLight[iter_88_1.lightMode]
		local var_88_1 = BGMSwitchProgress.WeatherEffect[iter_88_1.effect]
		local var_88_2 = string.format("%d %s-%s", iter_88_1.id, var_88_0, var_88_1)

		table.insert(arg_88_0.weatherReportIdList, var_88_2)
	end

	arg_88_0._dropWeather:ClearOptions()
	arg_88_0._dropWeather:AddOptions(arg_88_0.weatherReportIdList)

	if WeatherController.instance._curReport then
		arg_88_0._dropWeather:SetValue(WeatherController.instance._curReport.id - 1)
	end

	arg_88_0._dropWeather:AddOnValueChanged(arg_88_0._onWeatherChange, arg_88_0)
end

function var_0_0._onWeatherChange(arg_89_0, arg_89_1)
	WeatherController.instance:setReportId(arg_89_1 + 1)
end

function var_0_0._onClickGetAllHeroBtn(arg_90_0)
	HeroRpc.instance.preventGainView = true

	GMRpc.instance:sendGMRequest("add hero all 1")
	GameFacade.showToast(ToastEnum.IconId, "获取所有上线角色")
	TaskDispatcher.runDelay(function()
		HeroRpc.instance.preventGainView = nil
	end, nil, 5)
end

function var_0_0._onClickDeleteAllHeroInfoBtn(arg_92_0)
	MessageBoxController.instance:showMsgBoxByStr("确定要删除账号吗？", MsgBoxEnum.BoxType.Yes_No, function()
		GMRpc.instance:sendGMRequest("delete account", function()
			LoginController.instance:logout()
		end)
	end)
end

function var_0_0._refreshGMBtnText(arg_95_0)
	if not arg_95_0.showGMBtn then
		arg_95_0.showGMBtn = PlayerPrefsHelper.getNumber(PlayerPrefsKey.GMToolViewShowGMBtn, 1)
	end

	if arg_95_0.showGMBtn == 1 then
		arg_95_0._txtGM.text = "隐藏GM按钮"
	else
		arg_95_0._txtGM.text = "显示GM按钮"
	end
end

function var_0_0._onClickHideGMBtn(arg_96_0)
	arg_96_0.showGMBtn = arg_96_0.showGMBtn == 1 and 0 or 1

	arg_96_0:_refreshGMBtnText()
	PlayerPrefsHelper.setNumber(PlayerPrefsKey.GMToolViewShowGMBtn, arg_96_0.showGMBtn)
	MainController.instance:dispatchEvent(MainEvent.OnChangeGMBtnStatus)
end

function var_0_0._onClickUnLockAllEpisode(arg_97_0)
	GMRpc.instance:sendGMRequest("set dungeon all")
end

function var_0_0._onClickOpenHuaRongViewBtn(arg_98_0)
	ViewMgr.instance:openView(ViewName.DungeonHuaRongView)
end

function var_0_0._onClickOpenSeasonViewBtn(arg_99_0)
	local var_99_0 = FeiLinShiDuoConfig.instance:getGameEpisode(1251301)
	local var_99_1 = {
		mapId = FeiLinShiDuoEnum.TestMapId,
		gameConfig = var_99_0
	}

	FeiLinShiDuoGameController.instance:openGameView(var_99_1)
end

function var_0_0._onEarToggleValueChange(arg_100_0)
	if not arg_100_0.initDone then
		return
	end

	local var_100_0 = SDKMgr.instance:isEarphoneContact()

	arg_100_0._toggleEar.isOn = var_100_0
end

function var_0_0._onClickShowHero(arg_101_0)
	if not ViewMgr.instance:isOpen(ViewName.MainView) then
		return
	end

	arg_101_0.showHero = not arg_101_0.showHero

	arg_101_0:_showHero()
end

function var_0_0._showHero(arg_102_0)
	if not ViewMgr.instance:isOpen(ViewName.MainView) then
		return
	end

	if not arg_102_0.heroNodes then
		local var_102_0 = ViewMgr.instance:getContainer(ViewName.MainView)

		arg_102_0.heroNodes = {}

		table.insert(arg_102_0.heroNodes, gohelper.findChild(var_102_0.viewGO, "#go_spine_scale"))
		table.insert(arg_102_0.heroNodes, gohelper.findChild(var_102_0.viewGO, "#go_lightspinecontrol"))
	end

	for iter_102_0, iter_102_1 in pairs(arg_102_0.heroNodes) do
		gohelper.setActive(iter_102_1, arg_102_0.showHero)
	end

	arg_102_0._txtshowHero.text = arg_102_0.showHero and "隐藏主界面角色" or "显示主界面角色"

	PlayerPrefsHelper.setNumber(PlayerPrefsKey.ShowHeroKey, arg_102_0.showHero and 1 or 0)
end

function var_0_0._onClickShowUI(arg_103_0)
	if not ViewMgr.instance:isOpen(ViewName.MainView) then
		return
	end

	arg_103_0.showUI = not arg_103_0.showUI

	arg_103_0:_showUI()
end

function var_0_0._showUI(arg_104_0)
	if not ViewMgr.instance:isOpen(ViewName.MainView) then
		return
	end

	if not arg_104_0.uiNodes then
		arg_104_0.uiNodes = {}

		table.insert(arg_104_0.uiNodes, arg_104_0:getIDCanvasNode())

		local var_104_0 = ViewMgr.instance:getContainer(ViewName.MainView)

		table.insert(arg_104_0.uiNodes, gohelper.findChild(var_104_0.viewGO, "left"))
		table.insert(arg_104_0.uiNodes, gohelper.findChild(var_104_0.viewGO, "left_top"))
		table.insert(arg_104_0.uiNodes, gohelper.findChild(var_104_0.viewGO, "#go_righttop"))
		table.insert(arg_104_0.uiNodes, gohelper.findChild(var_104_0.viewGO, "right"))
		table.insert(arg_104_0.uiNodes, gohelper.findChild(var_104_0.viewGO, "bottom"))
	end

	for iter_104_0, iter_104_1 in pairs(arg_104_0.uiNodes) do
		gohelper.setActive(iter_104_1, arg_104_0.showUI)
	end

	arg_104_0._txtshowUI.text = arg_104_0.showUI and "隐藏主界面UI" or "显示主界面UI"

	PlayerPrefsHelper.setNumber(PlayerPrefsKey.ShowUIKey, arg_104_0.showUI and 1 or 0)

	arg_104_0.showID = arg_104_0.showUI

	arg_104_0:_showID()
end

function var_0_0._onClickShowID(arg_105_0)
	arg_105_0.showID = not arg_105_0.showID

	arg_105_0:_showID()
end

function var_0_0._showID(arg_106_0)
	gohelper.setActive(arg_106_0:getIDCanvasNode(), arg_106_0.showID)

	arg_106_0._txtshowId.text = arg_106_0.showID and "隐藏左下角ID" or "显示左下角ID"

	PlayerPrefsHelper.setNumber(PlayerPrefsKey.ShowIDKey, arg_106_0.showID and 1 or 0)
end

function var_0_0._onClickWaterMark(arg_107_0)
	arg_107_0.showWaterMark = not arg_107_0.showWaterMark

	arg_107_0:_showWaterMark()
end

function var_0_0._showWaterMark(arg_108_0)
	local var_108_0 = ViewMgr.instance:getContainer(ViewName.WaterMarkView)

	if var_108_0 then
		if arg_108_0.showWaterMark then
			var_108_0.waterMarkView:showWaterMark()
		else
			var_108_0.waterMarkView:hideWaterMark()
		end

		arg_108_0._txtwatermark.text = arg_108_0.showWaterMark and "隐藏水印" or "显示水印"
	end
end

function var_0_0.getIDCanvasNode(arg_109_0)
	if not arg_109_0.goIDRoot then
		arg_109_0.goIDRoot = gohelper.find("IDCanvas")
	end

	if not arg_109_0.goIDPopup then
		arg_109_0.goIDPopup = gohelper.findChild(arg_109_0.goIDRoot, "POPUP")
	end

	return arg_109_0.goIDPopup
end

function var_0_0._onBtnCopyTalentData(arg_110_0)
	CharacterController.instance:dispatchEvent(CharacterEvent.CopyTalentData)
end

function var_0_0._onBtnPrintAllEntityBuff(arg_111_0)
	logError("打印角色的当前buffid~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~")

	local var_111_0 = FightHelper.getAllEntitys()

	for iter_111_0, iter_111_1 in ipairs(var_111_0) do
		local var_111_1 = iter_111_1:getMO()

		logError("角色id或者怪物id: " .. var_111_1.modelId)

		local var_111_2 = var_111_1:getBuffList()

		for iter_111_2, iter_111_3 in ipairs(var_111_2) do
			logError("携带buffid: " .. iter_111_3.buffId)
		end
	end
end

function var_0_0._onClickBtnFastAddHero(arg_112_0)
	arg_112_0:closeThis()
	ViewMgr.instance:openView(ViewName.GMToolFastAddHeroView)
end

function var_0_0._OnBtnReplaceSummonHeroClick(arg_113_0)
	local var_113_0 = arg_113_0._inpHeroList:GetText()

	if string.nilorempty(var_113_0) then
		return
	end

	local var_113_1 = string.splitToNumber(var_113_0, ";")
	local var_113_2 = {}
	local var_113_3

	for iter_113_0, iter_113_1 in ipairs(var_113_1) do
		local var_113_4 = {
			isNew = true,
			duplicateCount = 1,
			heroId = iter_113_1
		}

		table.insert(var_113_2, var_113_4)
	end

	local var_113_5 = SummonController.summonSuccess

	function SummonController.summonSuccess(arg_114_0, arg_114_1)
		var_113_5(arg_114_0, var_113_2)
	end
end

function var_0_0._testJavaCrash(arg_115_0)
	CrashSightAgent.TestJavaCrash()
end

function var_0_0._testOcCrash(arg_116_0)
	CrashSightAgent.TestOcCrash()
end

function var_0_0._testNativeCrash(arg_117_0)
	CrashSightAgent.TestNativeCrash()
end

function var_0_0._onClickEnterView(arg_118_0)
	local var_118_0 = arg_118_0._inpViewName:GetText()

	if string.nilorempty(var_118_0) then
		GameFacade.showToastString("请输入界面名字")
	elseif ViewName[var_118_0] then
		arg_118_0:closeThis()
		ViewMgr.instance:openView(ViewName[var_118_0])
		PlayerPrefsHelper.setString(PlayerPrefsKey.GMToolViewOpenView, var_118_0)
	else
		GameFacade.showToastString(string.format("界面%s不存在", var_118_0))
	end
end

return var_0_0
