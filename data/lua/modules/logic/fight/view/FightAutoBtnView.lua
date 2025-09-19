module("modules.logic.fight.view.FightAutoBtnView", package.seeall)

local var_0_0 = class("FightAutoBtnView", FightBaseView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0.btn = gohelper.findButtonWithAudio(arg_1_0.viewGO)
	arg_1_0.lock = gohelper.findChild(arg_1_0.viewGO, "lock")
	arg_1_0.image = gohelper.findChildImage(arg_1_0.viewGO, "image")
	arg_1_0.autoAnimation = arg_1_0.image:GetComponent(typeof(UnityEngine.Animation))
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0:com_registClick(arg_2_0.btn, arg_2_0.onClick)
	arg_2_0:com_registFightEvent(FightEvent.SetAutoState, arg_2_0._updateAutoAnim)
	arg_2_0:com_registFightEvent(FightEvent.OnGuideStopAutoFight, arg_2_0._onGuideStopAutoFight)
	arg_2_0:com_registFightEvent(FightEvent.GuideRecordAutoState, arg_2_0.onGuideRecordAutoState)
	arg_2_0:com_registFightEvent(FightEvent.GuideRefreshAutoStateByRecord, arg_2_0.onGuideRefreshAutoStateByRecord)
end

function var_0_0.onClick(arg_3_0)
	if FightDataHelper.stateMgr.isReplay then
		gohelper.setActive(arg_3_0.viewGO, false)

		return
	end

	if FightDataHelper.stateMgr.forceAuto then
		return
	end

	if FightDataHelper.stageMgr:inFightState(FightStageMgr.FightStateType.PlaySeasonChangeHero) then
		return
	end

	if not FightDataHelper.stageMgr:isEmptyOperateState() then
		return
	end

	if FightDataHelper.stageMgr:inFightState(FightStageMgr.FightStateType.DouQuQu) then
		return
	end

	if not OpenModel.instance:isFunctionUnlock(OpenEnum.UnlockFunc.FightAuto) then
		local var_3_0, var_3_1 = OpenModel.instance:getFuncUnlockDesc(OpenEnum.UnlockFunc.FightAuto)

		GameFacade.showToast(var_3_0, var_3_1)

		return
	end

	local var_3_2 = FightDataHelper.fieldMgr.battleId
	local var_3_3 = var_3_2 and lua_battle.configDict[var_3_2]

	if not (var_3_3 and (not var_3_3.noAutoFight or var_3_3.noAutoFight == 0)) then
		GameFacade.showToast(ToastEnum.EpisodeCantUse)

		return
	end

	if GuideModel.instance:isFlagEnable(GuideModel.GuideFlag.FightForbidAutoFight) then
		return
	end

	if GuideModel.instance:isFlagEnable(GuideModel.GuideFlag.FightMoveCard) then
		return
	end

	local var_3_4 = not FightDataHelper.stateMgr:getIsAuto()

	FightDataHelper.stateMgr:setAutoState(var_3_4)
	FightController.instance:setPlayerPrefKeyAuto(0, var_3_4)
	arg_3_0:_updateAutoAnim()

	if var_3_4 then
		FightGameMgr.operateMgr:requestAutoFight()
	end
end

function var_0_0._onGuideStopAutoFight(arg_4_0)
	FightDataHelper.stateMgr:setAutoState(false)
	arg_4_0:_updateAutoAnim()
end

function var_0_0.onGuideRecordAutoState(arg_5_0)
	arg_5_0.guideRecordAutoState = FightDataHelper.stateMgr:getIsAuto()

	if arg_5_0.forceAuto then
		arg_5_0.guideRecordAutoState = true
	end
end

function var_0_0.onGuideRefreshAutoStateByRecord(arg_6_0)
	if arg_6_0.guideRecordAutoState then
		FightDataHelper.stateMgr:setAutoState(true)
		arg_6_0:_updateAutoAnim()
		FightGameMgr.operateMgr:requestAutoFight()
	end
end

function var_0_0._updateAutoAnim(arg_7_0)
	if FightDataHelper.stateMgr:getIsAuto() then
		arg_7_0.autoAnimation.enabled = true

		arg_7_0.autoAnimation:Play()
	else
		arg_7_0.autoAnimation:Stop()

		arg_7_0.autoAnimation.enabled = false

		transformhelper.setLocalRotation(arg_7_0.image.transform, 0, 0, 0)
	end
end

function var_0_0.onOpen(arg_8_0)
	if FightDataHelper.stateMgr.isReplay then
		gohelper.setActive(arg_8_0.viewGO, false)

		return
	end

	if not DungeonModel.instance:hasPassLevelAndStory(10101) then
		gohelper.setActive(arg_8_0.viewGO, false)

		return
	end

	local var_8_0 = FightDataHelper.fieldMgr.battleId
	local var_8_1 = var_8_0 and lua_battle.configDict[var_8_0]
	local var_8_2 = var_8_1 and (not var_8_1.noAutoFight or var_8_1.noAutoFight == 0)
	local var_8_3 = GuideModel.instance:isDoingFirstGuide()
	local var_8_4 = GuideController.instance:isForbidGuides()
	local var_8_5 = OpenModel.instance:isFuncBtnShow(OpenEnum.UnlockFunc.FightAuto) and (not var_8_3 or var_8_4)

	var_8_5 = var_8_5 and var_8_2
	arg_8_0.forceAuto = FightDataHelper.stateMgr.forceAuto

	gohelper.setActive(arg_8_0.lock, arg_8_0.forceAuto or FightDataHelper.fieldMgr:isDouQuQu())

	if var_8_5 then
		UISpriteSetMgr.instance:setFightSprite(arg_8_0.image, "bt_zd", true)
	else
		UISpriteSetMgr.instance:setFightSprite(arg_8_0.image, "zd_dis", true)
	end

	arg_8_0:com_registTimer(arg_8_0._updateAutoAnim, 0.01)
end

return var_0_0
