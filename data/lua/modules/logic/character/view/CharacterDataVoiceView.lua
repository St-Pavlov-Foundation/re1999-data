module("modules.logic.character.view.CharacterDataVoiceView", package.seeall)

local var_0_0 = class("CharacterDataVoiceView", BaseView)
local var_0_1 = "RefreshVoiceListBlock"

function var_0_0.onInitView(arg_1_0)
	arg_1_0._simagebg = gohelper.findChildSingleImage(arg_1_0.viewGO, "bg/#simage_bg")
	arg_1_0._simagecentericon = gohelper.findChildSingleImage(arg_1_0.viewGO, "bg/#simage_centericon")
	arg_1_0._simagelefticon = gohelper.findChildSingleImage(arg_1_0.viewGO, "bg/#simage_lefticon")
	arg_1_0._simagerighticon = gohelper.findChildSingleImage(arg_1_0.viewGO, "bg/#simage_righticon")
	arg_1_0._simagerighticon2 = gohelper.findChildSingleImage(arg_1_0.viewGO, "bg/#simage_righticon2")
	arg_1_0._simagemask = gohelper.findChildSingleImage(arg_1_0.viewGO, "bg/#simage_mask")
	arg_1_0._simagevoicebg = gohelper.findChildSingleImage(arg_1_0.viewGO, "content/#simage_voicebg")
	arg_1_0._txtvoicecontent = gohelper.findChildText(arg_1_0.viewGO, "content/#txt_voicecontent")
	arg_1_0._txtvoiceengcontent = gohelper.findChildText(arg_1_0.viewGO, "content/#txt_voicecontent/#txt_voiceengcontent")
	arg_1_0._txtcast = gohelper.findChildText(arg_1_0.viewGO, "content/cast/#txt_cast")
	arg_1_0._gospine = gohelper.findChild(arg_1_0.viewGO, "content/#simage_characterbg/charactercontainer/#go_spine")
	arg_1_0._dropfilter = gohelper.findChildDropdown(arg_1_0.viewGO, "dropvoicelang")
	arg_1_0._goDropEffect = gohelper.findChild(arg_1_0.viewGO, "dropvoicelang/eff")
	arg_1_0._goarrowdown = gohelper.findChild(arg_1_0.viewGO, "dropvoicelang/arrow")
	arg_1_0._goarrowup = gohelper.findChild(arg_1_0.viewGO, "dropvoicelang/arrowUp")

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0._dropfilter:AddOnValueChanged(arg_2_0._onDropFilterValueChanged, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	arg_3_0._dropfilter:RemoveOnValueChanged()
end

function var_0_0._editableInitView(arg_4_0)
	arg_4_0._scroll = gohelper.findChild(arg_4_0.viewGO, "content/#scroll_vioce"):GetComponent(typeof(ZProj.LimitedScrollRect))

	arg_4_0._simagebg:LoadImage(ResUrl.getCommonIcon("full/bg_fmand2"))
	arg_4_0._simagecentericon:LoadImage(ResUrl.getCharacterDataIcon("bg_2_ciecle.png"))
	arg_4_0._simagelefticon:LoadImage(ResUrl.getCommonIcon("bg_leftdown"))
	arg_4_0._simagerighticon:LoadImage(ResUrl.getCommonIcon("bg_rightdown"))
	arg_4_0._simagerighticon2:LoadImage(ResUrl.getCommonIcon("bg_rightup"))
	arg_4_0._simagemask:LoadImage(ResUrl.getCommonIcon("full/bg_noise2"))
	arg_4_0._simagevoicebg:LoadImage(ResUrl.getCharacterDataIcon("bg_yuyingdizidi_035.png"))

	arg_4_0._curAudio = 0
	arg_4_0._uiSpine = GuiModelAgent.Create(arg_4_0._gospine, true)

	arg_4_0._uiSpine:openBloomView(CharacterVoiceEnum.UIBloomView.CharacterDataView)
	arg_4_0._uiSpine:setShareRT(CharacterVoiceEnum.RTShareType.BloomAuto)
	CharacterController.instance:registerCallback(CharacterEvent.PlayVoice, arg_4_0._onPlayVoice, arg_4_0)
	CharacterController.instance:registerCallback(CharacterEvent.StopVoice, arg_4_0._onStopVoice, arg_4_0)

	arg_4_0._animator = arg_4_0.viewGO:GetComponent(typeof(UnityEngine.Animator))
end

function var_0_0._onPlayVoice(arg_5_0, arg_5_1)
	arg_5_0._curAudio = arg_5_1

	local var_5_0 = CharacterDataConfig.instance:getCharacterVoiceCO(arg_5_0._heroId, arg_5_0._curAudio)

	arg_5_0._uiSpine:stopVoice()
	CharacterDataModel.instance:setCurHeroAudioPlaying(arg_5_1)

	if var_5_0.type == CharacterEnum.VoiceType.FightBehit then
		local var_5_1 = AudioMgr.instance:getIdFromString("Hitvoc")
		local var_5_2 = AudioMgr.instance:getIdFromString("Uihitvoc")

		arg_5_0._uiSpine:setSwitch(var_5_1, var_5_2)
	elseif var_5_0.type == CharacterEnum.VoiceType.FightCardStar12 or var_5_0.type == CharacterEnum.VoiceType.FightCardStar3 or var_5_0.type == CharacterEnum.VoiceType.FightCardUnique then
		local var_5_3 = AudioMgr.instance:getIdFromString("card_voc")
		local var_5_4 = AudioMgr.instance:getIdFromString("uicardvoc")

		arg_5_0._uiSpine:setSwitch(var_5_3, var_5_4)
	end

	arg_5_0._uiSpine:playVoice(var_5_0, function()
		CharacterDataModel.instance:setCurHeroAudioFinished(arg_5_0._curAudio)
		arg_5_0:_refreshVoice()
	end, arg_5_0._txtvoicecontent, arg_5_0._txtvoiceengcontent)
	arg_5_0:_refreshVoice()

	local var_5_5 = arg_5_0.viewParam and type(arg_5_0.viewParam) == "table" and arg_5_0.viewParam.fromHandbookView

	CharacterController.instance:statCharacterData(StatEnum.EventName.PlayerVoice, arg_5_0._heroId, arg_5_1, nil, var_5_5)
	arg_5_0:_setTextVisible(true)
end

function var_0_0._setTextVisible(arg_7_0, arg_7_1)
	gohelper.setActive(arg_7_0._txtvoicecontent.gameObject, arg_7_1)
	gohelper.setActive(arg_7_0._txtvoiceengcontent.gameObject, arg_7_1)
end

function var_0_0._onStopVoice(arg_8_0, arg_8_1, arg_8_2)
	if arg_8_2 then
		AudioMgr.instance:trigger(AudioEnum.UI.Stop_Hero_Voc_Bus)
	end

	CharacterDataModel.instance:setCurHeroAudioFinished(arg_8_1)
	arg_8_0._uiSpine:stopVoice()
	arg_8_0:_refreshVoice()
end

function var_0_0._disableClipAlpha(arg_9_0)
	UnityEngine.Shader.DisableKeyword("_CLIPALPHA_ON")
end

function var_0_0.onOpen(arg_10_0)
	UnityEngine.Shader.EnableKeyword("_CLIPALPHA_ON")
	arg_10_0._animator:Play("voiceview_in", 0, 0)
	CharacterVoiceModel.instance:setNeedItemAni(true)
	arg_10_0:_refreshUI()

	arg_10_0.filterDropExtend = DropDownExtend.Get(arg_10_0._dropfilter.gameObject)

	arg_10_0.filterDropExtend:init(arg_10_0.onFilterDropShow, arg_10_0.onFilterDropHide, arg_10_0)
	arg_10_0:initLanguageOptions()

	if not arg_10_0._uiSpine then
		return
	end

	arg_10_0:_setModelVisible(true)
	AudioMgr.instance:trigger(AudioEnum.UI.play_ui_role_voice_open)
end

function var_0_0._resetNeedItemAnimState(arg_11_0)
	CharacterVoiceModel.instance:setNeedItemAni(false)

	arg_11_0._scroll.vertical = true

	arg_11_0:_disableClipAlpha()
end

function var_0_0._refreshUI(arg_12_0)
	TaskDispatcher.cancelTask(arg_12_0._resetNeedItemAnimState, arg_12_0)
	TaskDispatcher.runDelay(arg_12_0._resetNeedItemAnimState, arg_12_0, 1.07)

	arg_12_0._scroll.vertical = false

	arg_12_0:_refreshVoice()

	if arg_12_0._heroId and arg_12_0._heroId == CharacterDataModel.instance:getCurHeroId() then
		return
	end

	arg_12_0._heroId = CharacterDataModel.instance:getCurHeroId()

	local var_12_0 = HeroModel.instance:getByHeroId(arg_12_0._heroId).config.signature

	arg_12_0:_refreshInfo()
	arg_12_0:_refreshSpine()
end

function var_0_0._refreshInfo(arg_13_0)
	arg_13_0._txtcast.text = HeroModel.instance:getByHeroId(arg_13_0._heroId).config.actor
end

function var_0_0._refreshSpine(arg_14_0)
	arg_14_0:_setTextVisible(false)

	local var_14_0 = HeroModel.instance:getByHeroId(arg_14_0._heroId)
	local var_14_1 = SkinConfig.instance:getSkinCo(var_14_0.skin)

	arg_14_0._uiSpine:setResPath(var_14_1, arg_14_0._onSpineLoaded, arg_14_0, CharacterVoiceEnum.FullScreenEffectCameraSize)

	local var_14_2 = var_14_1.characterDataVoiceViewOffset
	local var_14_3

	if string.nilorempty(var_14_2) then
		var_14_3 = SkinConfig.instance:getSkinOffset(var_14_1.characterViewOffset)
		var_14_3 = SkinConfig.instance:getAfterRelativeOffset(502, var_14_3)
	else
		var_14_3 = SkinConfig.instance:getSkinOffset(var_14_2)
	end

	recthelper.setAnchor(arg_14_0._gospine.transform, var_14_3[1], var_14_3[2])
	transformhelper.setLocalScale(arg_14_0._gospine.transform, var_14_3[3], var_14_3[3], var_14_3[3])
end

function var_0_0._onSpineLoaded(arg_15_0)
	return
end

function var_0_0._refreshVoice(arg_16_0)
	local var_16_0 = CharacterDataModel.instance:getCurHeroVoices()

	CharacterVoiceModel.instance:setVoiceList(var_16_0)
end

function var_0_0.initLanguageOptions(arg_17_0)
	arg_17_0._languageOptions = {
		LangSettings.en,
		LangSettings.zh
	}
	arg_17_0._optionsName = {}

	local var_17_0 = 1
	local var_17_1 = SettingsRoleVoiceModel.instance:getCharVoiceLangPrefValue(arg_17_0._heroId)

	for iter_17_0, iter_17_1 in ipairs(arg_17_0._languageOptions) do
		if var_17_1 == iter_17_1 then
			arg_17_0._curLanguageId = iter_17_1
			var_17_0 = iter_17_0
		end

		local var_17_2 = luaLang(LangSettings.shortcutTab[iter_17_1])

		arg_17_0._optionsName[#arg_17_0._optionsName + 1] = var_17_2
	end

	arg_17_0._dropfilter:ClearOptions()
	arg_17_0._dropfilter:AddOptions(arg_17_0._optionsName)
	arg_17_0._dropfilter:SetValue(var_17_0 - 1)
	gohelper.setActive(arg_17_0._goarrowup, false)
end

function var_0_0._onDropFilterValueChanged(arg_18_0, arg_18_1)
	arg_18_1 = arg_18_1 + 1

	if arg_18_0._languageOptions[arg_18_1] == arg_18_0._curLanguageId then
		return
	end

	local var_18_0 = LangSettings.shortcutTab[arg_18_0._languageOptions[arg_18_1]]
	local var_18_1 = SettingsVoicePackageModel.instance:getPackInfo(var_18_0)

	if var_18_1 and var_18_1:needDownload() then
		GameFacade.showToast(ToastEnum.CharVoiceLangLost)

		for iter_18_0, iter_18_1 in ipairs(arg_18_0._languageOptions) do
			if iter_18_1 == arg_18_0._curLanguageId then
				local var_18_2 = iter_18_0

				arg_18_0._dropfilter:SetValue(var_18_2 - 1)
			end
		end

		return
	end

	if arg_18_0._curAudio and arg_18_0._curAudio ~= 0 then
		arg_18_0:_onStopVoice(arg_18_0._curAudio, true)
	end

	arg_18_0._curLanguageId = arg_18_0._languageOptions[arg_18_1]

	SettingsRoleVoiceModel.instance:setCharVoiceLangPrefValue(arg_18_0._curLanguageId, arg_18_0._heroId)
	CharacterVoiceModel.instance:setNeedItemAni(true)
	CharacterController.instance:dispatchEvent(CharacterEvent.ChangeVoiceLang)
	UIBlockMgr.instance:startBlock(var_0_1)
	gohelper.setActive(arg_18_0._goDropEffect, false)
	gohelper.setActive(arg_18_0._goDropEffect, true)
	TaskDispatcher.runDelay(arg_18_0._refreshVoiceListEnd, arg_18_0, 0.6)
end

function var_0_0.onFilterDropShow(arg_19_0)
	AudioMgr.instance:trigger(AudioEnum.UI.Play_UI_Universal_Click)

	arg_19_0._isPopUpFilterList = true

	arg_19_0:refreshFilterDropDownArrow()

	local var_19_0 = gohelper.findChild(arg_19_0._dropfilter.gameObject, "Dropdown List/Viewport/Content").transform

	for iter_19_0, iter_19_1 in ipairs(arg_19_0._languageOptions) do
		local var_19_1 = var_19_0:GetChild(iter_19_0)
		local var_19_2 = gohelper.findChildText(var_19_1.gameObject, "Text")
		local var_19_3 = LangSettings.shortcutTab[iter_19_1]
		local var_19_4 = SettingsVoicePackageModel.instance:getPackInfo(var_19_3)

		if var_19_4 and var_19_4:needDownload() then
			local var_19_5 = gohelper.findChild(var_19_1.gameObject, "#btn_download")

			gohelper.setActive(var_19_5, true)

			var_19_2.alpha = 0.5
		end

		if iter_19_1 == arg_19_0._curLanguageId then
			var_19_2.text = string.format("<color=#efb785ff>%s</color>", arg_19_0._optionsName[iter_19_0])
		else
			var_19_2.text = string.format("<color=#c3beb6ff>%s</color>", arg_19_0._optionsName[iter_19_0])
		end
	end
end

function var_0_0.onFilterDropHide(arg_20_0)
	AudioMgr.instance:trigger(AudioEnum.UI.Play_UI_Universal_Click)

	arg_20_0._isPopUpFilterList = false

	arg_20_0:refreshFilterDropDownArrow()
end

function var_0_0._refreshVoiceListEnd(arg_21_0)
	CharacterVoiceModel.instance:setNeedItemAni(false)
	UIBlockMgr.instance:endBlock(var_0_1)
end

function var_0_0.refreshFilterDropDownArrow(arg_22_0)
	gohelper.setActive(arg_22_0._goarrowdown, not arg_22_0._isPopUpFilterList)
	gohelper.setActive(arg_22_0._goarrowup, arg_22_0._isPopUpFilterList)
end

function var_0_0.onUpdateParam(arg_23_0)
	arg_23_0:_refreshUI()
end

function var_0_0.onClose(arg_24_0)
	CharacterDataModel.instance:setPlayingInfo(nil, nil)
	CharacterVoiceModel.instance:setNeedItemAni(true)
	UIBlockMgr.instance:endBlock(var_0_1)

	if not arg_24_0._uiSpine then
		return
	end

	arg_24_0._uiSpine:stopVoice()
	arg_24_0:_setModelVisible(false)
end

function var_0_0._setModelVisible(arg_25_0, arg_25_1)
	TaskDispatcher.cancelTask(arg_25_0._delaySetModelHide, arg_25_0)

	if arg_25_1 then
		arg_25_0._uiSpine:setLayer(UnityLayer.Unit)
		arg_25_0._uiSpine:setModelVisible(arg_25_1)
	else
		arg_25_0._uiSpine:setLayer(UnityLayer.Water)
		arg_25_0._uiSpine:hideCamera()
		TaskDispatcher.runDelay(arg_25_0._delaySetModelHide, arg_25_0, 1)
	end
end

function var_0_0._delaySetModelHide(arg_26_0)
	if arg_26_0._uiSpine then
		arg_26_0._uiSpine:setModelVisible(false)
	end
end

function var_0_0.onDestroyView(arg_27_0)
	TaskDispatcher.cancelTask(arg_27_0._resetNeedItemAnimState, arg_27_0)
	TaskDispatcher.cancelTask(arg_27_0._refreshVoiceListEnd, arg_27_0)
	arg_27_0._simagebg:UnLoadImage()
	arg_27_0._simagecentericon:UnLoadImage()
	arg_27_0._simagelefticon:UnLoadImage()
	arg_27_0._simagerighticon:UnLoadImage()
	arg_27_0._simagerighticon2:UnLoadImage()
	arg_27_0._simagemask:UnLoadImage()
	arg_27_0._simagevoicebg:UnLoadImage()

	if arg_27_0._uiSpine then
		arg_27_0._uiSpine = nil
	end

	CharacterController.instance:unregisterCallback(CharacterEvent.PlayVoice, arg_27_0._onPlayVoice, arg_27_0)
	CharacterController.instance:unregisterCallback(CharacterEvent.StopVoice, arg_27_0._onStopVoice, arg_27_0)
	TaskDispatcher.cancelTask(arg_27_0._delaySetModelHide, arg_27_0)
end

return var_0_0
