module("modules.logic.settings.view.SettingsLanguageView", package.seeall)

local var_0_0 = class("SettingsLanguageView", BaseView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._btndownload = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "download/#btn_download")
	arg_1_0._godownload = gohelper.findChild(arg_1_0.viewGO, "download/#btn_download/#go_download")
	arg_1_0._godownloading = gohelper.findChild(arg_1_0.viewGO, "download/#btn_download/#go_downloading")
	arg_1_0._txtdownloadingprogress = gohelper.findChildText(arg_1_0.viewGO, "download/#btn_download/#go_downloading/#txt_downloadingprogress")
	arg_1_0._gotxtlang = gohelper.findChild(arg_1_0.viewGO, "#go_lang/#go_txtlang")
	arg_1_0._govoicelang = gohelper.findChild(arg_1_0.viewGO, "#go_lang/#go_voicelang")
	arg_1_0._godropnode = gohelper.findChild(arg_1_0.viewGO, "dropnode")
	arg_1_0._gostoryvoicelang = gohelper.findChild(arg_1_0.viewGO, "#go_lang/#go_storyvoicelang")
	arg_1_0._godesc = gohelper.findChild(arg_1_0.viewGO, "#go_lang/#go_voicelang/#go_desc")
	arg_1_0._txtdesc = gohelper.findChildText(arg_1_0.viewGO, "#go_lang/#go_voicelang/#go_desc/#txt_desc")
	arg_1_0._btncustomvoice = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#go_lang/#go_voicelang/#btn_go")

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0._btndownload:AddClickListener(arg_2_0._btndownloadOnClick, arg_2_0)
	arg_2_0._btncustomvoice:AddClickListener(arg_2_0._btnCustomRoleVoiceOnClick, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	arg_3_0._btndownload:RemoveClickListener()
	arg_3_0._btncustomvoice:RemoveClickListener()
end

function var_0_0._btndownloadOnClick(arg_4_0)
	SettingsVoicePackageController.instance:openVoicePackageView()
end

function var_0_0._btnCustomRoleVoiceOnClick(arg_5_0)
	SettingsRoleVoiceController.instance:openSettingRoleVoiceView()
end

function var_0_0._editableInitView(arg_6_0)
	arg_6_0._voiceDropDownGo = gohelper.findChild(arg_6_0._godropnode, "dropvoicelang")
	arg_6_0._txtvoiceDrop = gohelper.findChildText(arg_6_0._voiceDropDownGo, "Label")
	arg_6_0._voiceClick = gohelper.getClickWithAudio(arg_6_0._voiceDropDownGo, AudioEnum.UI.play_ui_set_click)

	arg_6_0._voiceClick:AddClickListener(arg_6_0._onvoiceClick, arg_6_0)

	arg_6_0._voiceDropDownItemListGo = gohelper.findChild(arg_6_0._voiceDropDownGo, "Template")
	arg_6_0._voiceDropDownItemContainer = gohelper.findChild(arg_6_0._voiceDropDownItemListGo, "Viewport/Content")
	arg_6_0._voiceItemGo = gohelper.findChild(arg_6_0._voiceDropDownItemContainer, "Item")

	gohelper.setActive(arg_6_0._voiceItemGo, false)

	arg_6_0._voiceDropDownTouchEventMgr = TouchEventMgrHepler.getTouchEventMgr(arg_6_0._voiceDropDownItemListGo)

	arg_6_0._voiceDropDownTouchEventMgr:SetIgnoreUI(true)
	arg_6_0._voiceDropDownTouchEventMgr:SetOnlyTouch(true)
	arg_6_0._voiceDropDownTouchEventMgr:SetOnClickCb(arg_6_0._hideVoice, arg_6_0)

	arg_6_0._voiceItemList = {}
	arg_6_0._langItemList = {}

	arg_6_0:_refreshVoiceDropDown()

	arg_6_0._langDropDownGo = gohelper.findChild(arg_6_0._godropnode, "droplang")
	arg_6_0._txtLangDrop = gohelper.findChildText(arg_6_0._langDropDownGo, "Label")
	arg_6_0._langClick = gohelper.getClickWithAudio(arg_6_0._langDropDownGo, AudioEnum.UI.play_ui_set_click)

	arg_6_0._langClick:AddClickListener(arg_6_0._onlangDropClick, arg_6_0)

	arg_6_0._langDropDownItemListGo = gohelper.findChild(arg_6_0._langDropDownGo, "Template")
	arg_6_0._langDropDownItemContainer = gohelper.findChild(arg_6_0._langDropDownItemListGo, "Viewport/Content")
	arg_6_0._langItemGo = gohelper.findChild(arg_6_0._langDropDownItemContainer, "Item")

	gohelper.setActive(arg_6_0._langItemGo, false)

	arg_6_0._langDropDownTouchEventMgr = TouchEventMgrHepler.getTouchEventMgr(arg_6_0._langDropDownItemListGo)

	arg_6_0._langDropDownTouchEventMgr:SetIgnoreUI(true)
	arg_6_0._langDropDownTouchEventMgr:SetOnlyTouch(true)
	arg_6_0._langDropDownTouchEventMgr:SetOnClickCb(arg_6_0._hideLang, arg_6_0)
	arg_6_0:_refreshLangDropDown()

	arg_6_0.trVoiceDropArrow = gohelper.findChildComponent(arg_6_0._voiceDropDownGo, "arrow", typeof(UnityEngine.Transform))
	arg_6_0.trLangDropArrow = gohelper.findChildComponent(arg_6_0._langDropDownGo, "arrow", typeof(UnityEngine.Transform))

	local var_6_0 = arg_6_0._allLangTypes[arg_6_0._curLangTxtIndex + 1]
	local var_6_1 = GameLanguageMgr.instance:getStoryIndexByShortCut(var_6_0)

	GameLanguageMgr.instance:setLanguageTypeByStoryIndex(var_6_1)
	PlayerPrefsHelper.setNumber("StoryTxtLanType", var_6_1 - 1)
end

function var_0_0._refreshVoiceDropDown(arg_7_0)
	arg_7_0._allVoiceTypes = {}
	arg_7_0._allStoryVoiceTypes = {}
	arg_7_0._allStoryVoiceTypesStr = {}

	local var_7_0 = GameConfig:GetCurVoiceShortcut()
	local var_7_1 = SettingsController.instance:getStoryVoiceType()

	arg_7_0._curVoiceIndex = 0
	arg_7_0._curStoryVoiceIndex = 0

	local var_7_2 = HotUpdateVoiceMgr.instance:getSupportVoiceLangs()
	local var_7_3 = GameConfig:GetDefaultVoiceShortcut()

	for iter_7_0 = 1, #var_7_2 do
		local var_7_4 = var_7_2[iter_7_0]

		if var_7_4 == var_7_3 then
			table.insert(arg_7_0._allVoiceTypes, 1, var_7_4)
		elseif OpenModel.instance:isFuncBtnShow(OpenEnum.UnlockFunc.AudioDownload) then
			table.insert(arg_7_0._allVoiceTypes, var_7_4)
		end
	end

	arg_7_0._curVoiceIndex = (tabletool.indexOf(arg_7_0._allVoiceTypes, var_7_0) or 1) - 1

	arg_7_0:_refreshVoiceDropDownStr()
end

function var_0_0._refreshLangDropDown(arg_8_0)
	local var_8_0 = GameConfig:GetSupportedLangShortcuts()

	arg_8_0._allLangTypes = {}
	arg_8_0._allLangTypesStr = {}

	local var_8_1 = GameConfig:GetCurLangShortcut()

	arg_8_0._curLangTxtIndex = 0

	for iter_8_0 = 0, var_8_0.Length - 1 do
		local var_8_2 = var_8_0[iter_8_0]

		if OpenConfig.instance:isOpenLangTxt(var_8_2) then
			table.insert(arg_8_0._allLangTypes, var_8_2)
			table.insert(arg_8_0._allLangTypesStr, SettingsConfig.instance:getSettingLang(var_8_2))

			if var_8_2 == var_8_1 then
				logNormal("cur lang index = " .. #arg_8_0._allLangTypes)

				arg_8_0._curLangTxtIndex = #arg_8_0._allLangTypes - 1
			end
		end
	end

	arg_8_0:_refreshLangDropDownStr()
end

function var_0_0._refreshLangDropDownStr(arg_9_0)
	local var_9_0 = GameConfig:GetCurLangShortcut()

	for iter_9_0, iter_9_1 in ipairs(arg_9_0._allLangTypes) do
		local var_9_1 = arg_9_0._allLangTypesStr[iter_9_0]

		if iter_9_1 == var_9_0 then
			arg_9_0._txtLangDrop.text = string.format("<color=#c3beb6ff>%s</color>", var_9_1)
			var_9_1 = string.format("<color=#efb785ff>%s</color>", var_9_1)
		else
			var_9_1 = string.format("<color=#c3beb6ff>%s</color>", var_9_1)
		end

		local var_9_2 = arg_9_0._langItemList[iter_9_0]

		if var_9_2 == nil then
			var_9_2 = arg_9_0:getUserDataTb_()
			var_9_2.go = gohelper.cloneInPlace(arg_9_0._langItemGo, "Item" .. iter_9_0)
			var_9_2.goselected = gohelper.findChild(var_9_2.go, "BG")
			var_9_2.goxian = gohelper.findChild(var_9_2.go, "xian")
			var_9_2.txt = gohelper.findChildText(var_9_2.go, "Text")
			var_9_2.btn = gohelper.getClickWithAudio(var_9_2.go, AudioEnum.UI.play_ui_plot_common)

			var_9_2.btn:AddClickListener(function(arg_10_0)
				transformhelper.setLocalScale(arg_9_0.trLangDropArrow, 1, 1, 1)
				arg_9_0:_onChangeLangTxtType(iter_9_0 - 1)
			end, var_9_2)

			arg_9_0._langItemList[iter_9_0] = var_9_2
		end

		var_9_2.txt.text = var_9_1

		gohelper.setActive(var_9_2.goselected, iter_9_1 == var_9_0)
		gohelper.setActive(var_9_2.go, true)
		gohelper.setActive(var_9_2.goxian, iter_9_0 ~= #arg_9_0._allLangTypes)
	end

	for iter_9_2 = #arg_9_0._allLangTypes + 1, #arg_9_0._allLangTypes do
		gohelper.setActive(arg_9_0._allLangTypes[iter_9_2].go, false)
	end

	local var_9_3 = #arg_9_0._allLangTypes * 84

	recthelper.setHeight(arg_9_0._langDropDownItemListGo.transform, var_9_3)
end

function var_0_0._refreshVoiceDropDownStr(arg_11_0)
	local var_11_0 = GameConfig:GetCurVoiceShortcut()

	for iter_11_0, iter_11_1 in ipairs(arg_11_0._allVoiceTypes) do
		local var_11_1 = luaLang(iter_11_1)
		local var_11_2 = SettingsVoicePackageModel.instance:getPackInfo(iter_11_1)

		if iter_11_1 == var_11_0 then
			arg_11_0._curVoiceIndex = iter_11_0 - 1
			arg_11_0._txtvoiceDrop.text = string.format("<color=#c3beb6ff>%s</color>", var_11_1)
			var_11_1 = string.format("<color=#efb785ff>%s</color>", var_11_1)
		elseif var_11_2 and var_11_2:needDownload() then
			local var_11_3, var_11_4, var_11_5 = var_11_2:getLeftSizeMBorGB()

			var_11_1 = string.format("<color=#c3beb666>%s%s</color>", var_11_1, string.format("(%.2f%s)", var_11_3, var_11_5))
		else
			var_11_1 = string.format("<color=#c3beb6ff>%s</color>", var_11_1)
		end

		local var_11_6 = arg_11_0._voiceItemList[iter_11_0]

		if var_11_6 == nil then
			var_11_6 = arg_11_0:getUserDataTb_()
			var_11_6.go = gohelper.cloneInPlace(arg_11_0._voiceItemGo, "Item" .. iter_11_0)
			var_11_6.goselected = gohelper.findChild(var_11_6.go, "BG")
			var_11_6.goxian = gohelper.findChild(var_11_6.go, "xian")
			var_11_6.txt = gohelper.findChildText(var_11_6.go, "Text")
			var_11_6.btn = gohelper.getClickWithAudio(var_11_6.go, AudioEnum.UI.play_ui_plot_common)

			var_11_6.btn:AddClickListener(function(arg_12_0)
				transformhelper.setLocalScale(arg_11_0.trVoiceDropArrow, 1, 1, 1)
				arg_11_0:_onChangeVoiceType(iter_11_0 - 1)
			end, var_11_6)

			arg_11_0._voiceItemList[iter_11_0] = var_11_6
		end

		var_11_6.txt.text = var_11_1

		gohelper.setActive(var_11_6.goselected, iter_11_1 == var_11_0)
		gohelper.setActive(var_11_6.go, true)
		gohelper.setActive(var_11_6.goxian, iter_11_0 ~= #arg_11_0._allVoiceTypes)
	end

	for iter_11_2 = #arg_11_0._allVoiceTypes + 1, #arg_11_0._voiceItemList do
		gohelper.setActive(arg_11_0._voiceItemList[iter_11_2].go, false)
	end

	local var_11_7 = #arg_11_0._allVoiceTypes * 84

	recthelper.setHeight(arg_11_0._voiceDropDownItemListGo.transform, var_11_7)
	arg_11_0:_updateVoiceTips()
end

function var_0_0._onChangeVoiceType(arg_13_0, arg_13_1)
	logNormal("_onChangeVoiceType index = " .. arg_13_1)

	if arg_13_0._curVoiceIndex == arg_13_1 then
		return
	end

	arg_13_0._toChangeVoiceTypeIdx = arg_13_1

	local var_13_0 = arg_13_0._allVoiceTypes[arg_13_1 + 1]
	local var_13_1 = luaLang(var_13_0)

	GameFacade.showMessageBox(MessageBoxIdDefine.SettingAllRoleVoice, MsgBoxEnum.BoxType.Yes_No, arg_13_0._doChangeVoiceTypeAction, nil, nil, arg_13_0, nil, nil, var_13_1)
end

function var_0_0._doChangeVoiceTypeAction(arg_14_0)
	local var_14_0 = arg_14_0._toChangeVoiceTypeIdx
	local var_14_1 = arg_14_0._allVoiceTypes[var_14_0 + 1]
	local var_14_2 = SettingsVoicePackageModel.instance:getPackInfo(var_14_1)

	if var_14_2 and var_14_2:needDownload() then
		SettingsVoicePackageController.instance:tryDownload(var_14_2, true)
	else
		arg_14_0:addEventCb(AudioMgr.instance, AudioMgr.Evt_ChangeFinish, arg_14_0._onChangeFinish, arg_14_0)

		arg_14_0._curVoiceIndex = var_14_0

		if var_14_1 then
			SettingsVoicePackageController.instance:switchVoiceType(var_14_1, "in_settings")
			arg_14_0:_refreshVoiceDropDownStr()

			local var_14_3 = HeroModel.instance:getAllHero()

			for iter_14_0, iter_14_1 in pairs(var_14_3) do
				local var_14_4 = iter_14_1.heroId
				local var_14_5, var_14_6, var_14_7 = SettingsRoleVoiceModel.instance:getCharVoiceLangPrefValue(var_14_4)

				if not var_14_7 then
					SettingsRoleVoiceModel.instance:setCharVoiceLangPrefValue(var_14_1, iter_14_1.heroId)
				end
			end
		else
			logError("_onChangeVoiceType error  index =" .. arg_14_0._curVoiceIndex)
		end
	end

	gohelper.setActive(arg_14_0._voiceDropDownItemListGo, false)
end

function var_0_0._updateVoiceTips(arg_15_0)
	local var_15_0 = GameConfig:GetCurVoiceShortcut()
	local var_15_1 = SettingsConfig.instance:getVoiceTips(var_15_0)

	arg_15_0._txtdesc.text = var_15_1

	gohelper.setActive(arg_15_0._godesc, string.nilorempty(var_15_1) == false)
end

function var_0_0._onChangeFinish(arg_16_0)
	arg_16_0:removeEventCb(AudioMgr.instance, AudioMgr.Evt_ChangeFinish, arg_16_0._onChangeFinish, arg_16_0)
	AudioMgr.instance:trigger(AudioEnum.UI.play_ui_set_select)
	GameFacade.showToast(ToastEnum.SettingCharVoiceLang)
end

function var_0_0._onChangeStoryVoiceType(arg_17_0, arg_17_1)
	logNormal("_onChangeStoryVoiceType index = " .. arg_17_1)

	if arg_17_0._curStoryVoiceIndex == arg_17_1 then
		return
	end

	AudioMgr.instance:trigger(AudioEnum.UI.play_ui_set_select)

	arg_17_0._curStoryVoiceIndex = arg_17_1

	local var_17_0 = arg_17_0._allStoryVoiceTypes[arg_17_0._curStoryVoiceIndex + 1]

	if var_17_0 then
		PlayerPrefsHelper.setString(PlayerPrefsKey.VoiceTypeKey_Story, var_17_0)

		local var_17_1 = GameLanguageMgr.instance:getStoryIndexByShortCut(var_17_0)

		PlayerPrefsHelper.setNumber("StoryAudioLanType", var_17_1 - 1)
		PlayerPrefsHelper.save()
		arg_17_0:_refreshLangDropDownStr()
	else
		logError("_onChangeVoiceType error  index =" .. arg_17_0._curStoryVoiceIndex)
	end
end

function var_0_0._onChangeLangTxtType(arg_18_0, arg_18_1)
	logNormal("_onChangeLangTxtType index = " .. arg_18_1)

	if arg_18_0._curLangTxtIndex == arg_18_1 then
		return
	end

	AudioMgr.instance:trigger(AudioEnum.UI.play_ui_set_select)

	arg_18_0._curLangTxtIndex = arg_18_1

	local var_18_0 = arg_18_0._allLangTypes[arg_18_0._curLangTxtIndex + 1]

	LangSettings.instance:SetCurLangType(var_18_0)

	local var_18_1 = GameLanguageMgr.instance:getStoryIndexByShortCut(var_18_0)

	GameLanguageMgr.instance:setLanguageTypeByStoryIndex(var_18_1)
	PlayerPrefsHelper.setNumber("StoryTxtLanType", var_18_1 - 1)
	arg_18_0:_refreshLangDropDownStr()
	SettingsController.instance:changeLangTxt()
end

function var_0_0.onUpdateParam(arg_19_0)
	return
end

function var_0_0.onOpen(arg_20_0)
	arg_20_0:addEventCb(SettingsVoicePackageController.instance, SettingsEvent.OnPackItemStateChange, arg_20_0._refreshVoiceDropDown, arg_20_0)
	arg_20_0:addEventCb(SettingsVoicePackageController.instance, SettingsEvent.OnDownloadPackSuccess, arg_20_0._refreshVoiceDropDown, arg_20_0)
	arg_20_0:addEventCb(SettingsVoicePackageController.instance, SettingsEvent.OnDownloadPackFail, arg_20_0._onPackItemStateChange, arg_20_0)
	arg_20_0:addEventCb(SettingsVoicePackageController.instance, SettingsEvent.OnChangeVoiceType, arg_20_0._refreshVoiceDropDownStr, arg_20_0)
	gohelper.setActive(arg_20_0._btndownload.gameObject, OpenModel.instance:isFuncBtnShow(OpenEnum.UnlockFunc.AudioDownload))
	gohelper.setActive(arg_20_0._govoicelang, OpenModel.instance:isFuncBtnShow(OpenEnum.UnlockFunc.SettingsVoiceLang))
	gohelper.setActive(arg_20_0._gotxtlang, OpenModel.instance:isFuncBtnShow(OpenEnum.UnlockFunc.SettingsTxtLang))
	gohelper.setActive(arg_20_0._gostoryvoicelang, false)
	gohelper.setActive(arg_20_0._godownload, true)
	gohelper.setActive(arg_20_0._godownloading, false)
end

function var_0_0._onPackItemStateChange(arg_21_0)
	arg_21_0:_refreshVoiceDropDownStr()
end

function var_0_0._onlangDropClick(arg_22_0)
	transformhelper.setLocalScale(arg_22_0.trLangDropArrow, 1, -1, 1)
	gohelper.setActive(arg_22_0._langDropDownItemListGo, true)
end

function var_0_0._onvoiceClick(arg_23_0)
	SettingsVoicePackageController.instance:onSettingVoiceDropDown()
	transformhelper.setLocalScale(arg_23_0.trVoiceDropArrow, 1, -1, 1)
	gohelper.setActive(arg_23_0._voiceDropDownItemListGo, true)
end

function var_0_0._hideVoice(arg_24_0)
	transformhelper.setLocalScale(arg_24_0.trVoiceDropArrow, 1, 1, 1)
	gohelper.setActive(arg_24_0._voiceDropDownItemListGo, false)
end

function var_0_0._hideLang(arg_25_0)
	transformhelper.setLocalScale(arg_25_0.trLangDropArrow, 1, 1, 1)
	gohelper.setActive(arg_25_0._langDropDownItemListGo, false)
end

function var_0_0._onstoryVoiceClick(arg_26_0)
	arg_26_0:_cleanXian(arg_26_0._storyVoiceDropDown)
end

function var_0_0._cleanXian(arg_27_0, arg_27_1)
	local var_27_0 = gohelper.findChild(arg_27_1.gameObject, "Dropdown List").transform
	local var_27_1 = gohelper.findChild(arg_27_1.gameObject, "Dropdown List/Viewport/Content").transform
	local var_27_2 = recthelper.getHeight(var_27_1)

	recthelper.setHeight(var_27_0, var_27_2)

	local var_27_3 = gohelper.findChild(arg_27_1.gameObject, "Dropdown List/Viewport/Content").transform

	if var_27_3 then
		local var_27_4 = var_27_3.childCount - 1
		local var_27_5 = var_27_3:GetChild(var_27_4).gameObject
		local var_27_6 = gohelper.findChild(var_27_5, "xian")

		gohelper.setActive(var_27_6, false)
	end
end

function var_0_0.onClose(arg_28_0)
	arg_28_0:removeEventCb(SettingsVoicePackageController.instance, SettingsEvent.OnPackItemStateChange, arg_28_0._refreshVoiceDropDown, arg_28_0)
	arg_28_0:removeEventCb(SettingsVoicePackageController.instance, SettingsEvent.OnDownloadPackSuccess, arg_28_0._refreshVoiceDropDown, arg_28_0)
	arg_28_0:removeEventCb(SettingsVoicePackageController.instance, SettingsEvent.OnDownloadPackFail, arg_28_0._refreshVoiceDropDownStr, arg_28_0)
	arg_28_0:removeEventCb(SettingsVoicePackageController.instance, SettingsEvent.OnChangeVoiceType, arg_28_0._refreshVoiceDropDownStr, arg_28_0)
end

function var_0_0.onDestroyView(arg_29_0)
	arg_29_0._voiceClick:RemoveClickListener()
	arg_29_0._langClick:RemoveClickListener()

	if not gohelper.isNil(arg_29_0._voiceDropDownTouchEventMgr) then
		TouchEventMgrHepler.remove(arg_29_0._voiceDropDownTouchEventMgr)
	end

	if not gohelper.isNil(arg_29_0._langDropDownTouchEventMgr) then
		TouchEventMgrHepler.remove(arg_29_0._langDropDownTouchEventMgr)
	end

	if arg_29_0._voiceItemList and #arg_29_0._voiceItemList > 0 then
		for iter_29_0 = 1, #arg_29_0._voiceItemList do
			arg_29_0._voiceItemList[iter_29_0].btn:RemoveClickListener()
		end
	end

	if arg_29_0._langItemList and #arg_29_0._langItemList > 0 then
		for iter_29_1 = 1, #arg_29_0._langItemList do
			arg_29_0._langItemList[iter_29_1].btn:RemoveClickListener()
		end
	end
end

return var_0_0
