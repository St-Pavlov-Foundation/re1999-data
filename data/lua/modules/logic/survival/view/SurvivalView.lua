module("modules.logic.survival.view.SurvivalView", package.seeall)

local var_0_0 = class("SurvivalView", BaseView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._btnContinue = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "Right/#btn_Continue")
	arg_1_0._btnEnter = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "Right/#btn_Enter")
	arg_1_0._btnabort = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "Right/#btn_abort")
	arg_1_0._btnachievement = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "Right/#btn_achievement")
	arg_1_0._btnreward = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "Left/#btn_reward")
	arg_1_0._btntalent = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "Left/#btn_talent")
	arg_1_0._gotalentRed = gohelper.findChild(arg_1_0.viewGO, "Left/#btn_talent/#go_red")
	arg_1_0._imagetalentskill = gohelper.findChildSingleImage(arg_1_0.viewGO, "Left/#btn_talent/#image_skill")
	arg_1_0._gobooty = gohelper.findChild(arg_1_0.viewGO, "Left/#go_booty")
	arg_1_0._btnFold = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "Left/#go_booty/#btn_fold")
	arg_1_0._goImageUnFold = gohelper.findChild(arg_1_0.viewGO, "Left/#go_booty/#btn_fold/image_unfold")
	arg_1_0._goImageFold = gohelper.findChild(arg_1_0.viewGO, "Left/#go_booty/#btn_fold/image_fold")
	arg_1_0._btnCloseFold = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "Left/#go_booty/#go_fold/#btn_close")
	arg_1_0._goFold = gohelper.findChild(arg_1_0.viewGO, "Left/#go_booty/#go_fold")
	arg_1_0._gored = gohelper.findChild(arg_1_0.viewGO, "Left/#btn_reward/#go_reddot")
	arg_1_0._txtDifficulty = gohelper.findChildTextMesh(arg_1_0.viewGO, "Right/#btn_Continue/#go_difficult/#txt_difficult")
	arg_1_0._txtDay = gohelper.findChildTextMesh(arg_1_0.viewGO, "Right/#btn_Continue/#go_difficult/#txt_days")
	arg_1_0.bootyList = {}
	arg_1_0.goBootyContent = gohelper.findChild(arg_1_0.viewGO, "Left/#go_booty/#go_fold/Scroll/Viewport/Content")
	arg_1_0.goInfo = gohelper.findChild(arg_1_0.viewGO, "Left/goinfo")

	arg_1_0:setFoldVisible(true)
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0._btnContinue:AddClickListener(arg_2_0._onContinueClick, arg_2_0)
	arg_2_0._btnEnter:AddClickListener(arg_2_0._onEnterClick, arg_2_0)
	arg_2_0._btnabort:AddClickListener(arg_2_0._onAbortClick, arg_2_0)
	arg_2_0._btnachievement:AddClickListener(arg_2_0._onAchievementClick, arg_2_0)
	arg_2_0._btnreward:AddClickListener(arg_2_0._onRewardClick, arg_2_0)
	arg_2_0._btntalent:AddClickListener(arg_2_0._onTalentClick, arg_2_0)
	SurvivalController.instance:registerCallback(SurvivalEvent.OnOutInfoChange, arg_2_0._refreshView, arg_2_0)
	SurvivalController.instance:registerCallback(SurvivalEvent.OnTalentGroupBoxUpdate, arg_2_0.updateTalentRed, arg_2_0)
	arg_2_0:addClickCb(arg_2_0._btnFold, arg_2_0.onClickFold, arg_2_0)
	arg_2_0:addClickCb(arg_2_0._btnCloseFold, arg_2_0.onClickCloseFold, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	arg_3_0._btnContinue:RemoveClickListener()
	arg_3_0._btnEnter:RemoveClickListener()
	arg_3_0._btnabort:RemoveClickListener()
	arg_3_0._btnachievement:RemoveClickListener()
	arg_3_0._btnreward:RemoveClickListener()
	arg_3_0._btntalent:RemoveClickListener()
	SurvivalController.instance:unregisterCallback(SurvivalEvent.OnOutInfoChange, arg_3_0._refreshView, arg_3_0)
	SurvivalController.instance:unregisterCallback(SurvivalEvent.OnTalentGroupBoxUpdate, arg_3_0.updateTalentRed, arg_3_0)
	arg_3_0:removeClickCb(arg_3_0._btnFold)
	arg_3_0:removeClickCb(arg_3_0._btnCloseFold)
end

function var_0_0.onClickFold(arg_4_0)
	arg_4_0:setFoldVisible(not arg_4_0._foldVisible)
end

function var_0_0.onClickCloseFold(arg_5_0)
	arg_5_0:setFoldVisible(not arg_5_0._foldVisible)
end

function var_0_0.onOpen(arg_6_0)
	arg_6_0._imagetalentskill:LoadImage(ResUrl.getSurvivalTalentIcon("suit_01/icon_1"))
	RedDotController.instance:addRedDot(arg_6_0._gored, RedDotEnum.DotNode.V2a8Survival)
	TaskDispatcher.runRepeat(arg_6_0.everySecondCall, arg_6_0, 0, -1)
	arg_6_0:_refreshView()
end

function var_0_0.everySecondCall(arg_7_0)
	if arg_7_0._txtLimitTime then
		arg_7_0._txtLimitTime.text = ActivityHelper.getActivityRemainTimeStr(VersionActivity2_8Enum.ActivityId.Survival)
	end
end

function var_0_0._refreshView(arg_8_0)
	local var_8_0 = SurvivalModel.instance:getOutSideInfo()

	gohelper.setActive(arg_8_0._btnabort, var_8_0.inWeek)
	gohelper.setActive(arg_8_0._btnContinue, var_8_0.inWeek)
	gohelper.setActive(arg_8_0._btnEnter, not var_8_0.inWeek)

	if var_8_0.inWeek then
		local var_8_1 = SurvivalShelterModel.instance:getWeekInfo()
		local var_8_2 = var_8_1 and var_8_1.difficulty or var_8_0.currMod
		local var_8_3 = var_8_1 and var_8_1.day or var_8_0.currDay
		local var_8_4 = lua_survival_hardness_mod.configDict[var_8_2]

		arg_8_0._txtDifficulty.text = var_8_4 and var_8_4.name
		arg_8_0._txtDay.text = formatLuaLang("versionactivity_1_2_114daydes", var_8_3)
	end

	arg_8_0:refreshEndBg()
	arg_8_0:refreshBooty()
	arg_8_0:updateTalentRed()
end

function var_0_0.refreshEndBg(arg_9_0)
	if not arg_9_0.endPart then
		local var_9_0 = {
			view = arg_9_0
		}

		arg_9_0.endPart = MonoHelper.addNoUpdateLuaComOnceToGo(arg_9_0.viewGO, SurvivalEndPart, var_9_0)
	end

	arg_9_0.endPart:refreshView()
end

function var_0_0.refreshBooty(arg_10_0)
	local var_10_0 = SurvivalModel.instance:getOutSideInfo()

	if var_10_0.inWeek then
		gohelper.setActive(arg_10_0._gobooty, false)

		return
	end

	local var_10_1 = var_10_0:getBootyList()
	local var_10_2 = #var_10_1 == 0

	gohelper.setActive(arg_10_0._gobooty, not var_10_2)

	if var_10_2 then
		return
	end

	gohelper.setActive(arg_10_0._gobooty, true)

	local var_10_3 = arg_10_0.viewContainer:getSetting().otherRes.itemRes
	local var_10_4 = arg_10_0.goBootyContent

	for iter_10_0 = 1, math.max(#var_10_1, #arg_10_0.bootyList) do
		local var_10_5 = arg_10_0.bootyList[iter_10_0]

		if not var_10_5 then
			local var_10_6 = arg_10_0.viewContainer:getResInst(var_10_3, var_10_4, tostring(iter_10_0))

			var_10_5 = MonoHelper.addNoUpdateLuaComOnceToGo(var_10_6, SurvivalBagItem)

			var_10_5:setClickCallback(arg_10_0.onClickBootyItem, arg_10_0)

			arg_10_0.bootyList[iter_10_0] = var_10_5
		end

		var_10_5:updateMo(var_10_1[iter_10_0])
		var_10_5:setShowNum(false)
		var_10_5:setItemSize(100, 100)
	end
end

function var_0_0.updateTalentRed(arg_11_0)
	local var_11_0 = SurvivalModel.instance:getOutSideInfo()

	if not var_11_0 then
		return
	end

	gohelper.setActive(arg_11_0._gotalentRed, not var_11_0.talentBox:isEquipAll())
end

function var_0_0.onClickBootyItem(arg_12_0, arg_12_1)
	ViewMgr.instance:openView(ViewName.SurvivalItemInfoView, {
		itemMo = arg_12_1._mo,
		goPanel = arg_12_0.goInfo
	})
end

function var_0_0.setFoldVisible(arg_13_0, arg_13_1)
	if arg_13_0._foldVisible == arg_13_1 then
		return
	end

	arg_13_0._foldVisible = arg_13_1

	gohelper.setActive(arg_13_0._goFold, arg_13_1)
	gohelper.setActive(arg_13_0._goImageFold, not arg_13_1)
	gohelper.setActive(arg_13_0._goImageUnFold, arg_13_1)
end

function var_0_0._onContinueClick(arg_14_0)
	SurvivalController.instance:enterShelterMap()
	SurvivalStatHelper.instance:statBtnClick("_onContinueClick", "SurvivalView")
end

function var_0_0._onEnterClick(arg_15_0)
	local var_15_0 = SurvivalModel.instance:getOutSideInfo()

	if not var_15_0 then
		return
	end

	if not var_15_0.talentBox:isEquipAll() then
		GameFacade.showMessageBox(MessageBoxIdDefine.SurvivalHaveNoEquipTalent, MsgBoxEnum.BoxType.Yes_No, arg_15_0._enterSurvival, nil, nil, arg_15_0, nil, nil)
	else
		arg_15_0:_enterSurvival()
	end

	SurvivalStatHelper.instance:statBtnClick("_onEnterClick", "SurvivalView")
end

function var_0_0._enterSurvival(arg_16_0)
	if SurvivalModel.instance:getOutSideInfo():isFirstPlay() then
		SurvivalWeekRpc.instance:sendSurvivalStartWeekChooseDiff(SurvivalEnum.FirstPlayDifficulty)
	else
		ViewMgr.instance:openView(ViewName.SurvivalHardView)
	end
end

function var_0_0._onAbortClick(arg_17_0)
	GameFacade.showMessageBox(MessageBoxIdDefine.SurvivalGiveUpWeek, MsgBoxEnum.BoxType.Yes_No, arg_17_0._sendGiveUp, nil, nil, arg_17_0, nil, nil)
	SurvivalStatHelper.instance:statBtnClick("_onAbortClick", "SurvivalView")
end

function var_0_0._sendGiveUp(arg_18_0)
	SurvivalWeekRpc.instance:sendSurvivalGetWeekInfo(arg_18_0._onRecvWeekInfo, arg_18_0)
end

function var_0_0._onRecvWeekInfo(arg_19_0, arg_19_1, arg_19_2, arg_19_3)
	if arg_19_2 == 0 then
		SurvivalWeekRpc.instance:sendSurvivalAbandonWeek()
	end
end

function var_0_0._onAchievementClick(arg_20_0)
	if OpenModel.instance:isFunctionUnlock(OpenEnum.UnlockFunc.Achievement) then
		local var_20_0 = ActivityConfig.instance:getActivityCo(VersionActivity2_8Enum.ActivityId.Survival).achievementJumpId

		JumpController.instance:jump(var_20_0)
	else
		GameFacade.showToast(OpenModel.instance:getFuncUnlockDesc(OpenEnum.UnlockFunc.Achievement))
	end

	SurvivalStatHelper.instance:statBtnClick("_onAchievementClick", "SurvivalView")
end

function var_0_0._onRewardClick(arg_21_0)
	ViewMgr.instance:openView(ViewName.SurvivalShelterRewardView)
	SurvivalStatHelper.instance:statBtnClick("_onRewardClick", "SurvivalView")
end

function var_0_0._onTalentClick(arg_22_0)
	ViewMgr.instance:openView(ViewName.SurvivalTalentView)
	SurvivalStatHelper.instance:statBtnClick("_onTalentClick", "SurvivalView")
end

function var_0_0.onClose(arg_23_0)
	TaskDispatcher.cancelTask(arg_23_0.everySecondCall, arg_23_0)
end

return var_0_0
