module("modules.logic.settings.view.SettingsRoleVoiceView", package.seeall)

local var_0_0 = class("SettingsRoleVoiceView", BaseView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._gocharacterinfo = gohelper.findChild(arg_1_0.viewGO, "characterinfo/#go_characterinfo")
	arg_1_0._goops = gohelper.findChild(arg_1_0.viewGO, "characterinfo/#go_ops")
	arg_1_0._gononecharacter = gohelper.findChild(arg_1_0.viewGO, "characterinfo/#go_nonecharacter")
	arg_1_0._langInfoAnimator = gohelper.onceAddComponent(arg_1_0._gocharacterinfo, gohelper.Type_Animator)
	arg_1_0._selectCharInfoAnimator = gohelper.onceAddComponent(arg_1_0._gononecharacter, gohelper.Type_Animator)
	arg_1_0._btnbatchedit = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#go_rolecontainer/#go_rolesort/#btn_batchedit")
	arg_1_0._btnselectall = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#go_rolecontainer/#go_rolesort/#btn_selectall")
	arg_1_0._gobatcheditUnSelected = gohelper.findChild(arg_1_0.viewGO, "#go_rolecontainer/#go_rolesort/#btn_batchedit/btn1")
	arg_1_0._gobatcheditSelected = gohelper.findChild(arg_1_0.viewGO, "#go_rolecontainer/#go_rolesort/#btn_batchedit/btn2")
	arg_1_0._goselectAllBtn = gohelper.findChild(arg_1_0.viewGO, "#go_rolecontainer/#go_rolesort/#btn_selectall")
	arg_1_0._goselectAllUnSelected = gohelper.findChild(arg_1_0.viewGO, "#go_rolecontainer/#go_rolesort/#btn_selectall/btn1")
	arg_1_0._goselectAllSelected = gohelper.findChild(arg_1_0.viewGO, "#go_rolecontainer/#go_rolesort/#btn_selectall/btn2")
	arg_1_0._btnCN = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "characterinfo/#go_characterinfo/LangContainer/#go_lang2/click")
	arg_1_0._btnEN = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "characterinfo/#go_characterinfo/LangContainer/#go_lang1/click")
	arg_1_0._goCNUnSelected = gohelper.findChild(arg_1_0.viewGO, "characterinfo/#go_characterinfo/LangContainer/#go_lang2/unselected")
	arg_1_0._goCNSelected = gohelper.findChild(arg_1_0.viewGO, "characterinfo/#go_characterinfo/LangContainer/#go_lang2/selected")
	arg_1_0._goCNSelectPoint = gohelper.findChild(arg_1_0.viewGO, "characterinfo/#go_characterinfo/LangContainer/#go_lang2/selected/point")
	arg_1_0._goENUnSelected = gohelper.findChild(arg_1_0.viewGO, "characterinfo/#go_characterinfo/LangContainer/#go_lang1/unselected")
	arg_1_0._goENSelected = gohelper.findChild(arg_1_0.viewGO, "characterinfo/#go_characterinfo/LangContainer/#go_lang1/selected")
	arg_1_0._goENSelectPoint = gohelper.findChild(arg_1_0.viewGO, "characterinfo/#go_characterinfo/LangContainer/#go_lang1/selected/point")
	arg_1_0._btnconfirm = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "characterinfo/#go_ops/#btn_confirm")
	arg_1_0._btncancel = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "characterinfo/#go_ops/#btn_cancel")
	arg_1_0._txtchoose = gohelper.findChildText(arg_1_0.viewGO, "characterinfo/#go_characterinfo/#txt_choose")

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0._btnbatchedit:AddClickListener(arg_2_0._btnbatcheditOnClick, arg_2_0)
	arg_2_0._btnselectall:AddClickListener(arg_2_0._btnselectallOnClick, arg_2_0)
	arg_2_0._btnconfirm:AddClickListener(arg_2_0._btnconfirmOnClick, arg_2_0)
	arg_2_0._btncancel:AddClickListener(arg_2_0._btncancelOnClick, arg_2_0)
	arg_2_0._btnCN:AddClickListener(arg_2_0._btnCNOnClick, arg_2_0)
	arg_2_0._btnEN:AddClickListener(arg_2_0._btnENOnClick, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	arg_3_0._btnbatchedit:RemoveClickListener()
	arg_3_0._btnselectall:RemoveClickListener()
	arg_3_0._btnconfirm:RemoveClickListener()
	arg_3_0._btncancel:RemoveClickListener()
	arg_3_0._btnCN:RemoveClickListener()
	arg_3_0._btnEN:RemoveClickListener()
end

function var_0_0._btnbatcheditOnClick(arg_4_0)
	arg_4_0._batchEditMode = not arg_4_0._batchEditMode

	gohelper.setActive(arg_4_0._gobatcheditUnSelected, not arg_4_0._batchEditMode)
	gohelper.setActive(arg_4_0._gobatcheditSelected, arg_4_0._batchEditMode)
	gohelper.setActive(arg_4_0._goselectAllBtn, arg_4_0._batchEditMode)

	if not arg_4_0._batchEditMode then
		arg_4_0._selectAll = false

		arg_4_0:_refreshAllBtnState()
	end

	arg_4_0.viewContainer:clearSelectedItems()

	if not arg_4_0._voiceEnd then
		arg_4_0:_stopVoice()
	end

	arg_4_0:_onSelectedChar(false, false)
	arg_4_0.viewContainer:setBatchEditMode(arg_4_0._batchEditMode)
end

function var_0_0._btnselectallOnClick(arg_5_0)
	arg_5_0._selectAll = not arg_5_0._selectAll

	if arg_5_0._selectAll then
		arg_5_0.viewContainer:selectedAllItems()

		local var_5_0 = CharacterBackpackCardListModel.instance:getCharacterCardList()

		for iter_5_0, iter_5_1 in ipairs(var_5_0) do
			arg_5_0._selectedCharMos[#arg_5_0._selectedCharMos + 1] = iter_5_1
		end

		arg_5_0:_refreshOptionView(#arg_5_0._selectedCharMos > 0)
	else
		arg_5_0.viewContainer:clearSelectedItems()
		arg_5_0:_onSelectedChar(false, false)
	end

	arg_5_0:_refreshAllBtnState()
end

function var_0_0._btnCNOnClick(arg_6_0)
	if arg_6_0._curSelectLang == LangSettings.zh then
		return
	end

	local var_6_0 = LangSettings.shortcutTab[LangSettings.zh]
	local var_6_1 = SettingsVoicePackageModel.instance:getPackInfo(var_6_0)

	if var_6_1 and var_6_1:needDownload() then
		GameFacade.showToast(ToastEnum.CharVoiceLangLost)

		return
	end

	arg_6_0._curSelectLang = LangSettings.zh

	arg_6_0:_refreshLangMode(arg_6_0._curSelectLang)

	if not arg_6_0._batchEditMode then
		local var_6_2 = SettingsModel.instance:getVoiceValue()

		arg_6_0:_refreshLangOptionSelectState(arg_6_0._curSelectLang, var_6_2 == 0)
		arg_6_0:_playGreetingVoice()
	else
		arg_6_0:_refreshLangOptionSelectState(arg_6_0._curSelectLang, true)
	end
end

function var_0_0._btnENOnClick(arg_7_0)
	if arg_7_0._curSelectLang == LangSettings.en then
		return
	end

	local var_7_0 = LangSettings.shortcutTab[LangSettings.en]
	local var_7_1 = SettingsVoicePackageModel.instance:getPackInfo(var_7_0)

	if var_7_1 and var_7_1:needDownload() then
		GameFacade.showToast(ToastEnum.CharVoiceLangLost)

		return
	end

	arg_7_0._curSelectLang = LangSettings.en

	arg_7_0:_refreshLangMode(arg_7_0._curSelectLang)

	if not arg_7_0._batchEditMode then
		local var_7_2 = SettingsModel.instance:getVoiceValue()

		arg_7_0:_refreshLangOptionSelectState(arg_7_0._curSelectLang, var_7_2 == 0)
		arg_7_0:_playGreetingVoice()
	else
		arg_7_0:_refreshLangOptionSelectState(arg_7_0._curSelectLang, true)
	end
end

function var_0_0._btnconfirmOnClick(arg_8_0)
	local var_8_0 = false

	if arg_8_0._curSelectLang == 0 then
		var_8_0 = false
	else
		for iter_8_0, iter_8_1 in ipairs(arg_8_0._selectedCharMos) do
			local var_8_1 = iter_8_1.heroId
			local var_8_2, var_8_3 = SettingsRoleVoiceModel.instance:getCharVoiceLangPrefValue(var_8_1)

			if arg_8_0._curSelectLang ~= var_8_2 then
				var_8_0 = true

				break
			end
		end
	end

	if var_8_0 then
		SettingsRoleVoiceController.instance:setCharVoiceLangPrefValue(arg_8_0._selectedCharMos, arg_8_0._curSelectLang)
	end

	arg_8_0.viewContainer:clearSelectedItems()
	arg_8_0:_onSelectedChar(false, false)
end

function var_0_0._btncancelOnClick(arg_9_0)
	arg_9_0.viewContainer:clearSelectedItems()
	arg_9_0:_onSelectedChar(false, false)
end

function var_0_0._editableInitView(arg_10_0)
	arg_10_0._voiceEnd = true
	arg_10_0._imgBg = gohelper.findChildSingleImage(arg_10_0.viewGO, "bg/bgimg")
	arg_10_0._simageredlight = gohelper.findChildSingleImage(arg_10_0.viewGO, "bg/#simage_redlight")

	arg_10_0._imgBg:LoadImage(ResUrl.getCommonViewBg("full/biandui_di"))
	arg_10_0._simageredlight:LoadImage(ResUrl.getHeroGroupBg("guang_027"))
	gohelper.setActive(arg_10_0._gocharacterinfo, false)
end

function var_0_0.onOpen(arg_11_0)
	arg_11_0:addEventCb(SettingsRoleVoiceController.instance, SettingsEvent.OnSetVoiceRoleSelected, arg_11_0._onSelectedChar, arg_11_0)
	arg_11_0:addEventCb(SettingsRoleVoiceController.instance, SettingsEvent.OnSetVoiceRoleFiltered, arg_11_0._onCharFiltered, arg_11_0)
	arg_11_0:_refreshOptionView(false)
	arg_11_0:_refreshBtnStateView(false, false)
	arg_11_0:_refreshLangOptionDownloadState(LangSettings.zh, arg_11_0._goCNUnSelected)
	arg_11_0:_refreshLangOptionDownloadState(LangSettings.en, arg_11_0._goENUnSelected)
end

function var_0_0.onClose(arg_12_0)
	if not arg_12_0._voiceEnd then
		arg_12_0:_stopVoice()
	end

	TaskDispatcher.cancelTask(arg_12_0._playVoice, arg_12_0)
end

function var_0_0.onDestroyView(arg_13_0)
	return
end

function var_0_0._onSelectedChar(arg_14_0, arg_14_1, arg_14_2)
	if arg_14_0._selectAll and not arg_14_2 then
		arg_14_0._selectAll = false

		arg_14_0:_refreshAllBtnState()
	end

	if arg_14_0._batchEditMode then
		if not arg_14_1 then
			arg_14_0._selectedCharMos = {}
			arg_14_0._curSelectLang = 0
		elseif arg_14_2 then
			arg_14_0._selectedCharMos = arg_14_0._selectedCharMos or {}

			if #arg_14_0._selectedCharMos == 0 then
				arg_14_0._curSelectLang = 0
			end

			arg_14_0._selectedCharMos[#arg_14_0._selectedCharMos + 1] = arg_14_1
		else
			tabletool.removeValue(arg_14_0._selectedCharMos, arg_14_1)
		end
	else
		arg_14_0._selectedCharMos = arg_14_2 and {
			arg_14_1
		} or {}

		if not arg_14_2 and not arg_14_0._voiceEnd then
			arg_14_0:_stopVoice()
		end
	end

	arg_14_0:_refreshOptionView(#arg_14_0._selectedCharMos > 0)
end

function var_0_0._onCharFiltered(arg_15_0)
	if not arg_15_0._voiceEnd then
		arg_15_0:_stopVoice()
	end

	arg_15_0.viewContainer:clearSelectedItems()
	arg_15_0:_onSelectedChar(false, false)
end

function var_0_0._refreshOptionView(arg_16_0, arg_16_1)
	if arg_16_1 then
		gohelper.setActive(arg_16_0._gocharacterinfo, true)
	end

	arg_16_0._langInfoAnimator:Play(arg_16_1 and UIAnimationName.Open or UIAnimationName.Close)
	arg_16_0._selectCharInfoAnimator:Play(arg_16_1 and UIAnimationName.Close or UIAnimationName.Open)
	gohelper.setActive(arg_16_0._goops, arg_16_1)
	gohelper.setActive(arg_16_0._gononecharacter, not arg_16_1)

	if arg_16_0._batchEditMode then
		arg_16_0._txtchoose.text = luaLang("p_herovoiceedityiew_selectcharlistlang")

		arg_16_0:_refreshLangMode(arg_16_0._curSelectLang)
	elseif arg_16_1 then
		arg_16_0._curSelectLang = 0

		for iter_16_0, iter_16_1 in ipairs(arg_16_0._selectedCharMos) do
			if #arg_16_0._selectedCharMos == 1 then
				local var_16_0 = iter_16_1.heroId
				local var_16_1, var_16_2 = SettingsRoleVoiceModel.instance:getCharVoiceLangPrefValue(var_16_0)

				arg_16_0._curSelectLang = var_16_1
			end
		end

		local var_16_3 = arg_16_0._selectedCharMos[1]

		arg_16_0._txtchoose.text = GameUtil.getSubPlaceholderLuaLang(luaLang("p_herovoiceeditview_selectcharlang"), {
			var_16_3.config.name
		})

		local var_16_4 = SettingsModel.instance:getVoiceValue()

		arg_16_0:_refreshLangOptionSelectState(arg_16_0._curSelectLang, var_16_4 == 0)
		arg_16_0:_playGreetingVoice()
		arg_16_0:_refreshLangMode(arg_16_0._curSelectLang)
	end
end

function var_0_0._refreshBtnStateView(arg_17_0, arg_17_1, arg_17_2)
	gohelper.setActive(arg_17_0._gobatcheditUnSelected, not arg_17_1)
	gohelper.setActive(arg_17_0._gobatcheditSelected, arg_17_1)
	gohelper.setActive(arg_17_0._goselectAllBtn, arg_17_1)
	gohelper.setActive(arg_17_0._goselectAllSelected, arg_17_2)
	gohelper.setActive(arg_17_0._goselectAllUnSelected, not arg_17_2)
end

function var_0_0._refreshLangMode(arg_18_0, arg_18_1)
	gohelper.setActive(arg_18_0._goCNUnSelected, arg_18_1 ~= LangSettings.zh)
	gohelper.setActive(arg_18_0._goCNSelected, arg_18_1 == LangSettings.zh)
	gohelper.setActive(arg_18_0._goENUnSelected, arg_18_1 ~= LangSettings.en)
	gohelper.setActive(arg_18_0._goENSelected, arg_18_1 == LangSettings.en)
end

function var_0_0._refreshAllBtnState(arg_19_0)
	gohelper.setActive(arg_19_0._goselectAllSelected, arg_19_0._selectAll)
	gohelper.setActive(arg_19_0._goselectAllUnSelected, not arg_19_0._selectAll)
end

function var_0_0._refreshLangOptionSelectState(arg_20_0, arg_20_1, arg_20_2)
	if arg_20_1 == LangSettings.en then
		gohelper.setActive(arg_20_0._goENSelectPoint, arg_20_2)
	elseif arg_20_1 == LangSettings.zh then
		gohelper.setActive(arg_20_0._goCNSelectPoint, arg_20_2)
	end
end

function var_0_0._refreshLangOptionDownloadState(arg_21_0, arg_21_1, arg_21_2)
	local var_21_0 = LangSettings.shortcutTab[arg_21_1]
	local var_21_1 = SettingsVoicePackageModel.instance:getPackInfo(var_21_0)

	if var_21_1 and var_21_1:needDownload() then
		local var_21_2 = gohelper.findChildText(arg_21_2, "info1")
		local var_21_3 = gohelper.findChildImage(arg_21_2, "point")

		var_21_2.alpha = 0.4

		local var_21_4 = var_21_3.color

		var_21_4.a = 0.4
		var_21_3.color = var_21_4
	end
end

function var_0_0.isBatchEditMode(arg_22_0)
	return arg_22_0._batchEditMode
end

function var_0_0._playVoice(arg_23_0)
	local var_23_0 = LangSettings.shortcutTab[arg_23_0._curSelectLang]
	local var_23_1 = arg_23_0:_getVoiceEmitter()

	if not arg_23_0._voiceEnd then
		arg_23_0:_stopVoice()

		arg_23_0._voiceEarlyStop = true

		TaskDispatcher.runDelay(arg_23_0._playVoice, arg_23_0, 0.33)
	else
		arg_23_0._voiceBnkName = AudioConfig.instance:getAudioCOById(arg_23_0._curVoiceCfg.audio).bankName
		arg_23_0._voiceEnd = false

		if GameConfig:GetCurVoiceShortcut() == LangSettings.shortcutTab[LangSettings.zh] then
			ZProj.AudioManager.Instance:LoadBank(arg_23_0._voiceBnkName, var_23_0)
			var_23_1:Emitter(arg_23_0._curVoiceCfg.audio, var_23_0, arg_23_0._onEmitterCallback, arg_23_0)
			ZProj.AudioManager.Instance:UnloadBank(arg_23_0._voiceBnkName)
		else
			var_23_1:Emitter(arg_23_0._curVoiceCfg.audio, var_23_0, arg_23_0._onEmitterCallback, arg_23_0)
		end
	end
end

function var_0_0._playGreetingVoice(arg_24_0)
	if arg_24_0._selectedCharMos and #arg_24_0._selectedCharMos == 1 then
		local var_24_0 = CharacterDataConfig.instance:getCharacterVoicesCo(arg_24_0._selectedCharMos[1].heroId)
		local var_24_1

		for iter_24_0, iter_24_1 in pairs(var_24_0) do
			if iter_24_1.type == CharacterEnum.VoiceType.Greeting then
				var_24_1 = iter_24_1

				break
			end
		end

		arg_24_0._curVoiceCfg = var_24_1

		arg_24_0:_playVoice()
	end
end

function var_0_0._stopVoice(arg_25_0)
	AudioMgr.instance:trigger(AudioEnum.UI.Stop_Hero_Voc_Bus)

	arg_25_0._voiceEnd = true

	arg_25_0:_unloadBnk()
end

function var_0_0._getVoiceEmitter(arg_26_0)
	if not arg_26_0._emitter then
		arg_26_0._emitter = ZProj.AudioEmitter.Get(arg_26_0.viewGO)
	end

	return arg_26_0._emitter
end

function var_0_0._onEmitterCallback(arg_27_0, arg_27_1, arg_27_2)
	if arg_27_1 == AudioEnum.AkCallbackType.AK_Duration then
		-- block empty
	elseif arg_27_1 == AudioEnum.AkCallbackType.AK_EndOfEvent then
		arg_27_0:_emitterVoiceEnd()
	end
end

function var_0_0._emitterVoiceEnd(arg_28_0)
	if arg_28_0._voiceEarlyStop then
		arg_28_0._voiceEarlyStop = false
	else
		arg_28_0._voiceEnd = true

		arg_28_0:_unloadBnk()
		arg_28_0:_refreshLangOptionSelectState(arg_28_0._curSelectLang, true)
	end
end

function var_0_0._unloadBnk(arg_29_0)
	if arg_29_0._voiceBnkName then
		ZProj.AudioManager.Instance:UnloadBank(arg_29_0._voiceBnkName)
		AudioMgr.instance:clearUnusedBanks()
	end
end

return var_0_0
