module("modules.logic.versionactivity2_8.molideer.view.game.MoLiDeErEventView", package.seeall)

local var_0_0 = class("MoLiDeErEventView", BaseView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._btnCloseBg = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#btn_CloseBg")
	arg_1_0._simagePanelBG = gohelper.findChildSingleImage(arg_1_0.viewGO, "#simage_PanelBG")
	arg_1_0._simagePic = gohelper.findChildSingleImage(arg_1_0.viewGO, "#simage_Pic")
	arg_1_0._txtTitle = gohelper.findChildText(arg_1_0.viewGO, "#txt_Title")
	arg_1_0._scrollDesc = gohelper.findChildScrollRect(arg_1_0.viewGO, "#scroll_Desc")
	arg_1_0._txtDesc = gohelper.findChildText(arg_1_0.viewGO, "#scroll_Desc/Viewport/Content/#txt_Desc")
	arg_1_0._goBtn = gohelper.findChild(arg_1_0.viewGO, "Btns/#go_Btn")
	arg_1_0._goBG1 = gohelper.findChild(arg_1_0.viewGO, "Btns/#go_Btn/#go_BG1")
	arg_1_0._goBG2 = gohelper.findChild(arg_1_0.viewGO, "Btns/#go_Btn/#go_BG2")
	arg_1_0._txtName = gohelper.findChildText(arg_1_0.viewGO, "Btns/#go_Btn/#txt_Name")
	arg_1_0._txtDescr = gohelper.findChildText(arg_1_0.viewGO, "Btns/#go_Btn/#txt_Descr")
	arg_1_0._txtNum = gohelper.findChildText(arg_1_0.viewGO, "Btns/#go_Btn/image_Icon/#txt_Num")
	arg_1_0._gooptions = gohelper.findChild(arg_1_0.viewGO, "Btns/#go_options")
	arg_1_0._btnClose = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#btn_Close")
	arg_1_0._btnSkip = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#btn_Skip")
	arg_1_0._goDispatchParent = gohelper.findChild(arg_1_0.viewGO, "#go_DispatchParent")

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0._btnCloseBg:AddClickListener(arg_2_0._btnCloseBgOnClick, arg_2_0)
	arg_2_0._btnClose:AddClickListener(arg_2_0._btnCloseOnClick, arg_2_0)
	arg_2_0._btnSkip:AddClickListener(arg_2_0._btnSkipOnClick, arg_2_0)
	arg_2_0:addEventCb(MoLiDeErGameController.instance, MoLiDeErEvent.GameOptionSelect, arg_2_0.onOptionSelect, arg_2_0)
	arg_2_0:addEventCb(MoLiDeErGameController.instance, MoLiDeErEvent.GameTeamSelect, arg_2_0.onTeamSelect, arg_2_0)
	arg_2_0:addEventCb(MoLiDeErGameController.instance, MoLiDeErEvent.GameDispatchTeam, arg_2_0.onDispatchTeam, arg_2_0)
	arg_2_0:addEventCb(MoLiDeErGameController.instance, MoLiDeErEvent.GameWithdrawTeam, arg_2_0.onWithdrawTeam, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	arg_3_0._btnCloseBg:RemoveClickListener()
	arg_3_0._btnClose:RemoveClickListener()
	arg_3_0._btnSkip:RemoveClickListener()
	arg_3_0:removeEventCb(MoLiDeErGameController.instance, MoLiDeErEvent.GameOptionSelect, arg_3_0.onOptionSelect, arg_3_0)
	arg_3_0:removeEventCb(MoLiDeErGameController.instance, MoLiDeErEvent.GameTeamSelect, arg_3_0.onTeamSelect, arg_3_0)
	arg_3_0:removeEventCb(MoLiDeErGameController.instance, MoLiDeErEvent.GameDispatchTeam, arg_3_0.onDispatchTeam, arg_3_0)
	arg_3_0:removeEventCb(MoLiDeErGameController.instance, MoLiDeErEvent.GameWithdrawTeam, arg_3_0.onWithdrawTeam, arg_3_0)
end

function var_0_0._btnCloseBgOnClick(arg_4_0)
	arg_4_0:closeThis()
end

function var_0_0._btnCloseOnClick(arg_5_0)
	arg_5_0:closeThis()
end

function var_0_0._btnSkipOnClick(arg_6_0)
	arg_6_0:onDescShowEnd()
end

function var_0_0._editableInitView(arg_7_0)
	local var_7_0 = arg_7_0.viewContainer._viewSetting.otherRes[1]
	local var_7_1 = arg_7_0:getResInst(var_7_0, arg_7_0._goDispatchParent)

	arg_7_0._dispatchItem, arg_7_0._goDispatch = MonoHelper.addNoUpdateLuaComOnceToGo(var_7_1, MoLiDeErDispatchItem), var_7_1
	arg_7_0._optionItemList = {}
	arg_7_0._optionParentPointList = {}

	local var_7_2 = arg_7_0._gooptions.transform.childCount

	for iter_7_0 = 1, var_7_2 do
		local var_7_3 = arg_7_0._gooptions.transform:GetChild(iter_7_0 - 1).gameObject

		table.insert(arg_7_0._optionParentPointList, var_7_3)
	end

	gohelper.setActive(arg_7_0._goBtn, false)
	gohelper.setActive(arg_7_0._goDispatch, false)

	arg_7_0._animator = gohelper.findChildComponent(arg_7_0.viewGO, "", gohelper.Type_Animator)
end

function var_0_0.onUpdateParam(arg_8_0)
	return
end

function var_0_0.onOpen(arg_9_0)
	local var_9_0 = arg_9_0.viewParam.eventId
	local var_9_1 = arg_9_0.viewParam.state
	local var_9_2 = arg_9_0.viewParam.optionId

	arg_9_0._eventId = var_9_0
	arg_9_0._state = var_9_1
	arg_9_0._optionId = var_9_2
	arg_9_0._eventConfig = MoLiDeErConfig.instance:getEventConfig(var_9_0)
	arg_9_0._eventInfo = MoLiDeErGameModel.instance:getCurGameInfo():getEventInfo(var_9_0)

	if var_9_1 == MoLiDeErEnum.DispatchState.Finish then
		AudioMgr.instance:trigger(AudioEnum2_8.MoLiDeEr.play_ui_molu_jlbn_open)
	end

	arg_9_0:refreshInfo()
end

function var_0_0.refreshUI(arg_10_0)
	arg_10_0:playAnim()
	arg_10_0:refreshState()
	arg_10_0:refreshOptions()
	arg_10_0:refreshDispatch()
end

function var_0_0.playAnim(arg_11_0)
	local var_11_0 = arg_11_0._state == MoLiDeErEnum.DispatchState.Finish and MoLiDeErEnum.AnimName.EventViewFinishOpen or MoLiDeErEnum.AnimName.EventViewSwitchOpen

	arg_11_0._animator:Play(var_11_0, 0, 0)
end

function var_0_0.refreshState(arg_12_0)
	local var_12_0 = arg_12_0._state

	gohelper.setActive(arg_12_0._gooptions, var_12_0 ~= MoLiDeErEnum.DispatchState.Finish)
	gohelper.setActive(arg_12_0._goDispatch, var_12_0 ~= MoLiDeErEnum.DispatchState.Finish)
end

function var_0_0.refreshOptions(arg_13_0)
	if arg_13_0._state ~= MoLiDeErEnum.DispatchState.Dispatch then
		gohelper.setActive(arg_13_0._gooptions, false)

		return
	end

	local var_13_0 = arg_13_0._eventInfo.options

	gohelper.setActive(arg_13_0._gooptions, var_13_0 ~= nil)

	if var_13_0 == nil then
		return
	end

	local var_13_1 = #var_13_0

	gohelper.setActive(arg_13_0._gooptions, var_13_1 > 0)

	if var_13_1 <= 0 then
		return
	end

	local var_13_2 = arg_13_0._optionItemList
	local var_13_3 = #var_13_2
	local var_13_4 = arg_13_0._optionParentPointList
	local var_13_5 = #arg_13_0._optionParentPointList

	for iter_13_0, iter_13_1 in ipairs(var_13_0) do
		local var_13_6

		if var_13_3 < iter_13_0 then
			if var_13_5 < iter_13_0 then
				logError("莫莉德尔角色活动 选项数量超过上限")
			else
				local var_13_7 = var_13_4[iter_13_0]
				local var_13_8 = gohelper.clone(arg_13_0._goBtn, var_13_7)

				var_13_6 = MonoHelper.addNoUpdateLuaComOnceToGo(var_13_8, MoLiDeErOptionItem)

				table.insert(var_13_2, var_13_6)
			end
		else
			var_13_6 = var_13_2[iter_13_0]
		end

		var_13_6:setActive(true)
		var_13_6:setData(iter_13_1)
	end

	if var_13_1 < var_13_3 then
		for iter_13_2 = var_13_1 + 1, var_13_3 do
			var_13_2[iter_13_2]:setActive(false)
		end
	end
end

function var_0_0.autoSpeak(arg_14_0)
	if not arg_14_0._curTxtData then
		return
	end

	local var_14_0 = (arg_14_0._curTxtData.index or 0) + 1

	arg_14_0._curTxtData.index = var_14_0
	arg_14_0._curTxtData.txt.text = table.concat(arg_14_0._curTxtData.chars, "", 1, var_14_0)
	arg_14_0._curTxtData.isEnd = var_14_0 >= arg_14_0._curTxtData.charCount

	if arg_14_0._curTxtData.isEnd then
		arg_14_0:onDescShowEnd()
	end
end

function var_0_0.onDescShowEnd(arg_15_0)
	if arg_15_0._curTxtData.isEnd == false then
		local var_15_0 = arg_15_0._eventConfig

		arg_15_0._txtDesc.text = var_15_0.desc
	end

	TaskDispatcher.cancelTask(arg_15_0.autoSpeak, arg_15_0)
	gohelper.setActive(arg_15_0._btnSkip, false)
	AudioMgr.instance:trigger(AudioEnum2_6.DiceHero.stop_ui_feichi_yure_caption)
	TaskDispatcher.runDelay(arg_15_0.onDescShowDelayTimEnd, arg_15_0, MoLiDeErEnum.DelayTime.DescBtnShowDelay)
	arg_15_0:_lockScreen(true)
end

function var_0_0.onDescShowDelayTimEnd(arg_16_0)
	TaskDispatcher.cancelTask(arg_16_0.onDescShowDelayTimEnd, arg_16_0)
	arg_16_0:_lockScreen(false)
	arg_16_0:refreshUI()
end

function var_0_0._lockScreen(arg_17_0, arg_17_1)
	if arg_17_1 then
		UIBlockMgrExtend.setNeedCircleMv(false)
		UIBlockMgr.instance:startBlock("MoLiDeErEventView")
	else
		UIBlockMgr.instance:endBlock("MoLiDeErEventView")
		UIBlockMgrExtend.setNeedCircleMv(true)
	end
end

function var_0_0.refreshDispatch(arg_18_0)
	local var_18_0 = arg_18_0._state
	local var_18_1 = var_18_0 == MoLiDeErEnum.DispatchState.Dispatch or var_18_0 == MoLiDeErEnum.DispatchState.Dispatching

	gohelper.setActive(arg_18_0._goDispatch, var_18_1)

	if not var_18_1 then
		return
	end

	arg_18_0._dispatchItem:setData(arg_18_0._state, arg_18_0._eventId, arg_18_0._optionId)
end

function var_0_0.refreshInfo(arg_19_0)
	local var_19_0 = arg_19_0._eventConfig
	local var_19_1 = arg_19_0._optionId and arg_19_0._optionId ~= 0 and arg_19_0._state == MoLiDeErEnum.DispatchState.Finish

	gohelper.setActive(arg_19_0._btnSkip, arg_19_0._state == MoLiDeErEnum.DispatchState.Dispatch)

	if var_19_1 then
		local var_19_2 = arg_19_0._optionId
		local var_19_3 = MoLiDeErConfig.instance:getOptionConfig(var_19_2)
		local var_19_4 = MoLiDeErConfig.instance:getOptionResultConfig(var_19_3.optionResultId)
		local var_19_5 = MoLiDeErHelper.getOptionResultEffectParamList(var_19_3.optionResultId)

		arg_19_0._txtTitle.text = var_19_4.name
		arg_19_0._txtDesc.text = GameUtil.getSubPlaceholderLuaLang(var_19_4.desc, var_19_5)

		arg_19_0:refreshUI()
	else
		arg_19_0._txtTitle.text = var_19_0.name

		if arg_19_0._state == MoLiDeErEnum.DispatchState.Dispatch then
			local var_19_6 = GameUtil.getUCharArrWithoutRichTxt(var_19_0.desc)

			arg_19_0._curTxtData = {
				isEnd = false,
				txt = arg_19_0._txtDesc,
				chars = var_19_6,
				charCount = #var_19_6
			}

			TaskDispatcher.runRepeat(arg_19_0.autoSpeak, arg_19_0, MoLiDeErEnum.DelayTime.DescTextShowDelay)
		else
			arg_19_0._txtDesc.text = var_19_0.desc

			arg_19_0:refreshUI()
		end
	end
end

function var_0_0.onOptionSelect(arg_20_0, arg_20_1)
	if arg_20_1 == arg_20_0._selectOptionId then
		return
	end

	arg_20_0._selectOptionId = arg_20_1

	for iter_20_0, iter_20_1 in ipairs(arg_20_0._optionItemList) do
		iter_20_1:setSelect(arg_20_1)
	end
end

function var_0_0.onTeamSelect(arg_21_0, arg_21_1)
	if arg_21_1 == nil then
		return
	end

	if arg_21_0._state == MoLiDeErEnum.DispatchState.Dispatch then
		arg_21_0:refreshOptions()
	end
end

function var_0_0.onDispatchTeam(arg_22_0)
	if arg_22_0._state == MoLiDeErEnum.DispatchState.Dispatch then
		arg_22_0:closeThis()
	end
end

function var_0_0.onWithdrawTeam(arg_23_0)
	if arg_23_0._state == MoLiDeErEnum.DispatchState.Dispatching then
		arg_23_0:closeThis()
	end
end

function var_0_0.onClose(arg_24_0)
	MoLiDeErGameModel.instance:resetSelect()
	TaskDispatcher.cancelTask(arg_24_0._autoSpeak, arg_24_0)
end

function var_0_0.onDestroyView(arg_25_0)
	return
end

return var_0_0
