module("modules.logic.fight.view.FightView", package.seeall)

local var_0_0 = class("FightView", BaseView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._rootGO = gohelper.findChild(arg_1_0.viewGO, "root")
	arg_1_0._topRightBtnRoot = gohelper.findChild(arg_1_0.viewGO, "root/btns")
	arg_1_0._btnBack = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "root/btns/btnBack")
	arg_1_0._btnSpecialTip = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "root/btns/btnSpecialTip")
	arg_1_0._btnSpeed = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "root/btns/btnSpeed")
	arg_1_0._imageSpeed = gohelper.findChildImage(arg_1_0.viewGO, "root/btns/btnSpeed/image")
	arg_1_0._btnCareerRestrain = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "root/btnRestraintInfo")
	arg_1_0._roundGO = gohelper.findChild(arg_1_0.viewGO, "root/topLeftContent/imgRound")
	arg_1_0._txtWave = gohelper.findChildText(arg_1_0.viewGO, "root/topLeftContent/imgRound/txtWave")
	arg_1_0._txtRound = gohelper.findChildText(arg_1_0.viewGO, "root/topLeftContent/imgRound/txtRound")
	arg_1_0._txtSpeed = gohelper.findChildText(arg_1_0.viewGO, "root/btns/btnSpeed/Text")
	arg_1_0._goReplay = gohelper.findChild(arg_1_0.viewGO, "root/#go_replay")
	arg_1_0._goEnemyNum = gohelper.findChild(arg_1_0.viewGO, "root/enemynum")
	arg_1_0._txtEnemyNum = gohelper.findChildText(arg_1_0.viewGO, "root/enemynum/#txt_enemynum")
	arg_1_0._enemyinfoRoot = gohelper.findChild(arg_1_0.viewGO, "root/topLeftContent/enemyinfo")
	arg_1_0._enemyActionRoot = gohelper.findChild(arg_1_0.viewGO, "root/topLeftContent/enemyaction")
	arg_1_0.enemyActionNormal = gohelper.findChild(arg_1_0.viewGO, "root/topLeftContent/enemyaction/normal")
	arg_1_0.enemyActionSelect = gohelper.findChild(arg_1_0.viewGO, "root/topLeftContent/enemyaction/selected")
	arg_1_0.enemyActionLocked = gohelper.findChild(arg_1_0.viewGO, "root/topLeftContent/enemyaction/locked")
	arg_1_0.btnEnemyAction = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "root/topLeftContent/enemyaction/#btn_enemyaction")
	arg_1_0.weeklyWalkSubEnemy = gohelper.findChild(arg_1_0.viewGO, "root/enemyweekwalkheart")
	arg_1_0.btnCheckSub = gohelper.findChildClickWithDefaultAudio(arg_1_0.viewGO, "root/enemyweekwalkheart/btn_checkSub")
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0._btnBack:AddClickListener(arg_2_0._onClickBack, arg_2_0)
	arg_2_0._btnSpeed:AddClickListener(arg_2_0._onClickSpeed, arg_2_0)
	arg_2_0._btnSpecialTip:AddClickListener(arg_2_0._onClickBtnSpecialTip, arg_2_0)
	arg_2_0._btnCareerRestrain:AddClickListener(arg_2_0._onClickCareerRestrain, arg_2_0)
	arg_2_0.btnEnemyAction:AddClickListener(arg_2_0.onClickEnemyAction, arg_2_0)
	arg_2_0:addClickCb(arg_2_0.btnCheckSub, arg_2_0.onBtnCheckSub, arg_2_0)
	arg_2_0:addEventCb(FightController.instance, FightEvent.OnCombineCardEnd, arg_2_0._onBlockOperateEnd, arg_2_0)
	arg_2_0:addEventCb(FightController.instance, FightEvent.OnUniversalAppear, arg_2_0._onBlockOperateEnd, arg_2_0)
	arg_2_0:addEventCb(FightController.instance, FightEvent.SetIsShowUI, arg_2_0._setIsShowUI, arg_2_0)
	arg_2_0:addEventCb(FightController.instance, FightEvent.OnChangeEntity, arg_2_0._onChangeEntity, arg_2_0)
	arg_2_0:addEventCb(FightController.instance, FightEvent.OnBeginWave, arg_2_0._onBeginWave, arg_2_0)
	arg_2_0:addEventCb(FightController.instance, FightEvent.OnFightReconnectLastWork, arg_2_0._onFightReconnectLastWork, arg_2_0)
	arg_2_0:addEventCb(FightController.instance, FightEvent.GMHideFightView, arg_2_0._onGMShowChange, arg_2_0)
	arg_2_0:addEventCb(FightController.instance, FightEvent.SetStateForDialogBeforeStartFight, arg_2_0._onSetStateForDialogBeforeStartFight, arg_2_0)
	arg_2_0:addEventCb(FightController.instance, FightEvent.StageChanged, arg_2_0.onStageChange, arg_2_0)
	arg_2_0:addEventCb(FightController.instance, FightEvent.RefreshUIRound, arg_2_0._onRefreshUIRound, arg_2_0)
	arg_2_0:addEventCb(FightController.instance, FightEvent.AddSubEntity, arg_2_0._onAddSubEntity, arg_2_0)
	arg_2_0:addEventCb(FightController.instance, FightEvent.ClearMonsterSub, arg_2_0._onClearMonsterSub, arg_2_0)
	arg_2_0:addEventCb(FightController.instance, FightEvent.RefreshMonsterSubCount, arg_2_0._onRefreshMonsterSubCount, arg_2_0)
	arg_2_0:addEventCb(FightController.instance, FightEvent.SetBtnListVisibleWhenHidingFightView, arg_2_0.onSetBtnListVisibleWhenHidingFightView, arg_2_0)
	arg_2_0:addEventCb(ViewMgr.instance, ViewEvent.OnOpenView, arg_2_0._onOpenView, arg_2_0)
	arg_2_0:addEventCb(ViewMgr.instance, ViewEvent.OnCloseView, arg_2_0._onCloseView, arg_2_0)
	arg_2_0:addEventCb(FightController.instance, FightEvent.ChangeRound, arg_2_0._onChangeRound, arg_2_0)
	arg_2_0:addEventCb(PCInputController.instance, PCInputEvent.NotifyBattleOpentips, arg_2_0._onClickBack, arg_2_0)
	arg_2_0:addEventCb(PCInputController.instance, PCInputEvent.NotifyBattleAutoFight, arg_2_0.OnKeyAutoPress, arg_2_0)
	arg_2_0:addEventCb(PCInputController.instance, PCInputEvent.NotifyBattleSpeedUp, arg_2_0._onClickSpeed, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	arg_3_0._btnBack:RemoveClickListener()
	arg_3_0._btnSpecialTip:RemoveClickListener()
	arg_3_0._btnSpeed:RemoveClickListener()
	arg_3_0._btnCareerRestrain:RemoveClickListener()
	arg_3_0.btnEnemyAction:RemoveClickListener()
	arg_3_0:removeEventCb(FightController.instance, FightEvent.OnCombineCardEnd, arg_3_0._onBlockOperateEnd, arg_3_0)
	arg_3_0:removeEventCb(FightController.instance, FightEvent.OnUniversalAppear, arg_3_0._onBlockOperateEnd, arg_3_0)
	arg_3_0:removeEventCb(FightController.instance, FightEvent.SetIsShowUI, arg_3_0._setIsShowUI, arg_3_0)
	arg_3_0:removeEventCb(FightController.instance, FightEvent.OnChangeEntity, arg_3_0._onChangeEntity, arg_3_0)
	arg_3_0:removeEventCb(FightController.instance, FightEvent.OnBeginWave, arg_3_0._onBeginWave, arg_3_0)
	arg_3_0:removeEventCb(FightController.instance, FightEvent.OnFightReconnectLastWork, arg_3_0._onFightReconnectLastWork, arg_3_0)
	arg_3_0:removeEventCb(FightController.instance, FightEvent.GMHideFightView, arg_3_0._onGMShowChange, arg_3_0)
	arg_3_0:removeEventCb(FightController.instance, FightEvent.SetStateForDialogBeforeStartFight, arg_3_0._onSetStateForDialogBeforeStartFight, arg_3_0)
	arg_3_0:removeEventCb(ViewMgr.instance, ViewEvent.OnOpenView, arg_3_0._onOpenView, arg_3_0)
	arg_3_0:removeEventCb(ViewMgr.instance, ViewEvent.OnCloseView, arg_3_0._onCloseView, arg_3_0)
	arg_3_0:removeEventCb(FightController.instance, FightEvent.ChangeRound, arg_3_0._onChangeRound, arg_3_0)
	arg_3_0:removeEventCb(PCInputController.instance, PCInputEvent.NotifyBattleOpentips, arg_3_0._onClickBack, arg_3_0)
	arg_3_0:removeEventCb(PCInputController.instance, PCInputEvent.NotifyBattleAutoFight, arg_3_0.OnKeyAutoPress, arg_3_0)
	arg_3_0:removeEventCb(PCInputController.instance, PCInputEvent.NotifyBattleSpeedUp, arg_3_0._onClickSpeed, arg_3_0)
end

function var_0_0.onOpen(arg_4_0)
	local var_4_0 = FightModel.instance:getFightParam().episodeId
	local var_4_1 = FightModel.instance:getFightParam().battleId

	arg_4_0:_updateRound()
	arg_4_0:_updateReplay()

	local var_4_2 = GuideModel.instance:isDoingFirstGuide()
	local var_4_3 = GuideController.instance:isForbidGuides()
	local var_4_4 = OpenModel.instance:isFuncBtnShow(OpenEnum.UnlockFunc.FightSpeed) and (not var_4_2 or var_4_3)
	local var_4_5 = OpenModel.instance:isFuncBtnShow(OpenEnum.UnlockFunc.FightBack) and (not var_4_2 or var_4_3)

	gohelper.setActive(arg_4_0._btnSpecialTip.gameObject, var_0_0.canShowSpecialBtn())

	if not var_4_4 and (var_4_0 == OpenConfig.instance:getOpenCo(OpenEnum.UnlockFunc.FightSpeed).episodeId or GuideModel.instance:isGuideFinish(110)) then
		var_4_4 = true
	end

	if var_4_4 then
		if FightDataHelper.stateMgr.isReplay then
			FightModel.instance:setUserSpeed(2)
		else
			local var_4_6 = PlayerPrefsHelper.getNumber(arg_4_0:_getPlayerPrefKeySpeed(), 1)

			FightModel.instance:setUserSpeed(var_4_6)
		end
	else
		FightModel.instance:setUserSpeed(1)
	end

	arg_4_0:_updateSpeed()
	gohelper.setActive(arg_4_0._btnSpeed.gameObject, var_4_4)
	gohelper.setActive(arg_4_0._btnCareerRestrain.gameObject, false)
	gohelper.setActive(arg_4_0._btnBack.gameObject, var_4_5)
	gohelper.setActive(arg_4_0._roundGO, var_4_5 and GMFightShowState.topRightRound)
	NavigateMgr.instance:addEscape(ViewName.FightView, arg_4_0._onEscapeBtnClick, arg_4_0)
	arg_4_0:_showEnemySubCount()
	arg_4_0:initEnemyActionStatus()
	arg_4_0:_refreshDouQuQu()
end

function var_0_0._refreshDouQuQu(arg_5_0)
	if FightDataHelper.fieldMgr:isDouQuQu() then
		gohelper.setActive(arg_5_0._enemyinfoRoot, false)

		if FightDataModel.instance.douQuQuMgr and FightDataModel.instance.douQuQuMgr.isRecord then
			return
		end

		gohelper.setActive(arg_5_0._btnBack.gameObject, false)
		NavigateMgr.instance:removeEscape(ViewName.FightView)
	end
end

function var_0_0.initEnemyActionStatus(arg_6_0)
	local var_6_0 = FightModel.instance:getBattleId()
	local var_6_1 = var_6_0 and lua_battle.configDict[var_6_0]

	if var_6_1 and var_6_1.aiLink ~= 0 then
		arg_6_0:setEnemyActionStatus(FightEnum.EnemyActionStatus.Normal)
	else
		arg_6_0:setEnemyActionStatus(FightEnum.EnemyActionStatus.NotOpen)
	end
end

function var_0_0.onClose(arg_7_0)
	FightModel.instance:setUserSpeed(1)
	TaskDispatcher.cancelTask(arg_7_0._showBtnSpeedAni, arg_7_0, 0.001)
end

function var_0_0._setIsShowUI(arg_8_0, arg_8_1)
	if not arg_8_0._canvasGroup then
		arg_8_0._canvasGroup = gohelper.onceAddComponent(arg_8_0._rootGO, typeof(UnityEngine.CanvasGroup))
	end

	if FightDataHelper.tempMgr.aiJiAoSelectTargetView then
		arg_8_1 = false
	end

	gohelper.setActiveCanvasGroup(arg_8_0._canvasGroup, arg_8_1)
end

function var_0_0.OnKeyAutoPress(arg_9_0)
	if not FightDataHelper.stateMgr.isReplay then
		arg_9_0:_onClickAuto()
	end
end

function var_0_0._onOpenView(arg_10_0, arg_10_1)
	return
end

function var_0_0._onCloseView(arg_11_0, arg_11_1)
	if arg_11_1 == ViewName.FightFocusView then
		TaskDispatcher.runDelay(arg_11_0._resetCamera, arg_11_0, 0.16)
	end

	if arg_11_1 == ViewName.FightEnemyActionView and arg_11_0.actionStatus == FightEnum.EnemyActionStatus.Select then
		arg_11_0:setEnemyActionStatus(FightEnum.EnemyActionStatus.Normal)
	end
end

function var_0_0._onBlockOperateEnd(arg_12_0)
	if arg_12_0._blockOperate then
		arg_12_0._blockOperate = nil
	end
end

function var_0_0._updateSpeed(arg_13_0)
	local var_13_0 = FightModel.instance:getUserSpeed() == 1 and 1 or 2

	UISpriteSetMgr.instance:setFightSprite(arg_13_0._imageSpeed, "btn_x" .. var_13_0, true)

	arg_13_0._txtSpeed.text = string.format("X%d", var_13_0)

	TaskDispatcher.runDelay(arg_13_0._showBtnSpeedAni, arg_13_0, 0.001)
end

function var_0_0._showBtnSpeedAni(arg_14_0)
	local var_14_0 = FightModel.instance:getUserSpeed() == 1 and "idle" or "click"

	arg_14_0._btnSpeed:GetComponent(typeof(UnityEngine.Animator)):Play(var_14_0)
end

function var_0_0._onRefreshUIRound(arg_15_0)
	arg_15_0:_updateRound()
end

function var_0_0._updateRound(arg_16_0)
	arg_16_0:_refreshWaveUI()
	arg_16_0:_refreshRoundUI()
	arg_16_0:_showEnemySubHeroCount()
end

function var_0_0._refreshWaveUI(arg_17_0)
	local var_17_0 = FightModel.instance.maxWave
	local var_17_1 = FightModel.instance:getCurWaveId()
	local var_17_2 = math.min(var_17_1, var_17_0)

	if FightDataHelper.fieldMgr:isDouQuQu() then
		local var_17_3 = FightDataModel.instance.douQuQuMgr

		var_17_2 = var_17_3.index or 1
		var_17_0 = var_17_3.maxIndex or 1
	end

	arg_17_0._txtWave.text = GameUtil.getSubPlaceholderLuaLangTwoParam(luaLang("fight_wave_lang"), var_17_2, var_17_0)
end

function var_0_0._refreshRoundUI(arg_18_0)
	local var_18_0 = FightModel.instance:getMaxRound()
	local var_18_1 = FightModel.instance:getCurRoundId()
	local var_18_2 = math.min(var_18_1, var_18_0)

	arg_18_0._txtRound.text = GameUtil.getSubPlaceholderLuaLangTwoParam(luaLang("fight_round_lang"), var_18_2, var_18_0)
end

function var_0_0._onChangeRound(arg_19_0)
	arg_19_0:_refreshRoundUI()
end

function var_0_0._showEnemySubHeroCount(arg_20_0)
	local var_20_0 = FightDataHelper.entityMgr:getEnemySubList()

	arg_20_0._txtEnemyNum.text = #var_20_0

	if #var_20_0 > 0 then
		FightController.instance:dispatchEvent(FightEvent.OnGuideShowEnemyNum)
	end

	local var_20_1 = FightDataHelper.fieldMgr.customData

	if var_20_1 and var_20_1[FightCustomData.CustomDataType.WeekwalkVer2] then
		arg_20_0._txtEnemyNum.text = "∞"
	end
end

function var_0_0.onBtnCheckSub(arg_21_0)
	if not FightDataHelper.stageMgr:isFree() then
		return
	end

	local var_21_0 = FightDataHelper.fieldMgr.customData

	if var_21_0 and var_21_0[FightCustomData.CustomDataType.WeekwalkVer2] then
		ViewMgr.instance:openView(ViewName.FightWeekWalkEnemyTipsView)
	end
end

function var_0_0._showEnemySubCount(arg_22_0)
	local var_22_0 = FightDataHelper.entityMgr:getEnemySubList()
	local var_22_1 = GMFightShowState.leftMonster

	gohelper.setActive(arg_22_0._goEnemyNum, #var_22_0 > 0 and var_22_1)
	gohelper.setActive(arg_22_0.weeklyWalkSubEnemy, false)

	local var_22_2 = FightDataHelper.fieldMgr.customData

	if var_22_2 and var_22_2[FightCustomData.CustomDataType.WeekwalkVer2] then
		gohelper.setActive(arg_22_0._goEnemyNum, false)
		gohelper.setActive(arg_22_0.weeklyWalkSubEnemy, true)
	end
end

function var_0_0._onAddSubEntity(arg_23_0)
	arg_23_0:_showEnemySubCount()
	arg_23_0:_showEnemySubHeroCount()
end

function var_0_0._onClearMonsterSub(arg_24_0)
	arg_24_0:_showEnemySubHeroCount()
end

function var_0_0._onRefreshMonsterSubCount(arg_25_0)
	arg_25_0:_showEnemySubHeroCount()
end

function var_0_0._onBeginWave(arg_26_0)
	arg_26_0:_showEnemySubCount()
	arg_26_0:_refreshWaveUI()
end

function var_0_0._onChangeEntity(arg_27_0)
	arg_27_0:_showEnemySubHeroCount()
end

function var_0_0._updateReplay(arg_28_0)
	gohelper.setActive(arg_28_0._goReplay, FightDataHelper.stateMgr.isReplay)
end

function var_0_0._onEscapeBtnClick(arg_29_0)
	if arg_29_0._btnBack.gameObject.activeInHierarchy then
		arg_29_0:_onClickBack()
	end
end

function var_0_0._onClickBack(arg_30_0)
	if not OpenModel.instance:isFunctionUnlock(OpenEnum.UnlockFunc.FightBack) then
		local var_30_0, var_30_1 = OpenModel.instance:getFuncUnlockDesc(OpenEnum.UnlockFunc.FightBack)

		GameFacade.showToast(var_30_0, var_30_1)

		return
	end

	if GuideModel.instance:isFlagEnable(GuideModel.GuideFlag.FightForbidAutoFight) then
		return
	end

	if GuideModel.instance:isFlagEnable(GuideModel.GuideFlag.FightMoveCard) then
		return
	end

	local var_30_2 = FightDataHelper.stageMgr:inFightState(FightStageMgr.FightStateType.DistributeCard)

	if FightDataHelper.stageMgr:inFightState(FightStageMgr.FightStateType.Enter) or var_30_2 then
		local var_30_3 = GuideModel.instance:getDoingGuideIdList()

		if var_30_3 and #var_30_3 > 0 then
			return
		end
	end

	GameSceneMgr.instance:getCurScene().camera:enablePostProcessSmooth(false)
	ViewMgr.instance:openView(ViewName.FightQuitTipView)
end

function var_0_0.onSetBtnListVisibleWhenHidingFightView(arg_31_0, arg_31_1, arg_31_2)
	local var_31_0 = arg_31_0._topRightBtnRoot.transform

	if not arg_31_0.originBtnPosX then
		arg_31_0.originBtnPosX = recthelper.getAnchorX(var_31_0)
		arg_31_0.btnRootSiblingIndex = gohelper.getSibling(arg_31_0._topRightBtnRoot) - 1
	end

	gohelper.addChild(arg_31_1 and arg_31_0.viewGO or arg_31_0._rootGO, arg_31_0._topRightBtnRoot)
	recthelper.setAnchorX(var_31_0, arg_31_0.originBtnPosX)
	gohelper.setSibling(arg_31_0._topRightBtnRoot, arg_31_0.btnRootSiblingIndex)

	if arg_31_2 then
		if not arg_31_0.originBtnVisibleNames then
			arg_31_0.originBtnVisibleNames = {}

			for iter_31_0 = 0, var_31_0.childCount - 1 do
				local var_31_1 = var_31_0:GetChild(iter_31_0)

				arg_31_0.originBtnVisibleNames[var_31_1.name] = var_31_1.gameObject.activeSelf
			end
		end

		if arg_31_1 then
			for iter_31_1 = 0, var_31_0.childCount - 1 do
				local var_31_2 = var_31_0:GetChild(iter_31_1)

				gohelper.setActive(var_31_2.gameObject, tabletool.indexOf(arg_31_2, var_31_2.name))
			end
		else
			for iter_31_2 = 0, var_31_0.childCount - 1 do
				local var_31_3 = var_31_0:GetChild(iter_31_2)

				gohelper.setActive(var_31_3.gameObject, arg_31_0.originBtnVisibleNames[var_31_3.name])
			end
		end
	end
end

function var_0_0._onClickSpeed(arg_32_0)
	if GuideModel.instance:isFlagEnable(GuideModel.GuideFlag.FightForbidSpeed) then
		return
	end

	local var_32_0 = FightModel.instance:getUserSpeed() == 1 and 2 or 1

	FightModel.instance:setUserSpeed(var_32_0)
	PlayerPrefsHelper.setNumber(arg_32_0:_getPlayerPrefKeySpeed(), var_32_0)
	FightController.instance:dispatchEvent(FightEvent.OnUpdateSpeed)
	arg_32_0:_updateSpeed()
end

function var_0_0._onClickBtnSpecialTip(arg_33_0)
	if GuideModel.instance:getFlagValue(GuideModel.GuideFlag.FightForbidClickOpenView) then
		return
	end

	if GuideModel.instance:isFlagEnable(GuideModel.GuideFlag.FightMoveCard) then
		return
	end

	local var_33_0 = GuideModel.instance:getDoingGuideIdList()
	local var_33_1 = var_33_0 and #var_33_0 or 0

	if not FightModel.instance:isStartFinish() and var_33_1 > 0 then
		return
	end

	FightController.instance:openFightSpecialTipView()
end

function var_0_0._getPlayerPrefKeySpeed(arg_34_0)
	return PlayerPrefsKey.FightSpeed .. PlayerModel.instance:getPlayinfo().userId
end

function var_0_0._onClickCareerRestrain(arg_35_0)
	if not OpenModel.instance:isFunctionUnlock(OpenEnum.UnlockFunc.FightProperty) then
		local var_35_0, var_35_1 = OpenModel.instance:getFuncUnlockDesc(OpenEnum.UnlockFunc.FightProperty)

		GameFacade.showToast(var_35_0, var_35_1)

		return
	end

	if GuideModel.instance:isFlagEnable(GuideModel.GuideFlag.FightMoveCard) then
		return
	end

	ViewMgr.instance:openView(ViewName.HeroGroupCareerTipView)
end

function var_0_0._onFightReconnectLastWork(arg_36_0)
	gohelper.setActive(arg_36_0._btnSpecialTip.gameObject, var_0_0.canShowSpecialBtn())
end

function var_0_0._onGMShowChange(arg_37_0)
	arg_37_0:_showEnemySubCount()
end

function var_0_0.onDestroyView(arg_38_0)
	TaskDispatcher.cancelTask(arg_38_0._resetCamera, arg_38_0)
end

function var_0_0.canShowSpecialBtn()
	local var_39_0 = FightWorkBeforeStartNoticeView.canShowTips()

	if not var_39_0 then
		local var_39_1 = FightModel.instance:getFightParam().episodeId
		local var_39_2 = DungeonConfig.instance:getEpisodeCO(var_39_1)
		local var_39_3 = var_39_2 and var_39_2.type

		if Activity104Model.instance:isSeasonEpisodeType(var_39_3) then
			local var_39_4 = Activity104Model.instance:getFightCardDataList()

			var_39_0 = var_39_4 and #var_39_4 > 0
		elseif Season123Controller.canUse123EquipEpisodeType(var_39_3) then
			local var_39_5 = Season123Model.instance:getFightCardDataList()

			var_39_0 = var_39_5 and #var_39_5 > 0
		end
	end

	if GuideModel.instance:isFlagEnable(GuideModel.GuideFlag.FightForbidRoundView) then
		var_39_0 = false
	end

	return var_39_0
end

function var_0_0._resetCamera(arg_40_0)
	FightController.instance:dispatchEvent(FightEvent.SetIsShowUI, true)
	FightMsgMgr.sendMsg(FightMsgId.CameraFocusChanged, false)
	FightController.instance:dispatchEvent(FightEvent.OnCameraFocusChanged, false)

	if GameSceneMgr.instance:getCurSceneType() ~= SceneType.Fight or GameSceneMgr.instance:isClosing() then
		return
	end

	local var_40_0 = FightHelper.getAllEntitys()

	for iter_40_0, iter_40_1 in ipairs(var_40_0) do
		iter_40_1:setVisibleByPos(true)

		if iter_40_1.buff then
			iter_40_1.buff:hideBuffEffects()
			iter_40_1.buff:showBuffEffects()
		end

		if iter_40_1.nameUI then
			iter_40_1.nameUI:setActive(true)
		end
	end

	local var_40_1 = GameSceneMgr.instance:getScene(SceneType.Fight)

	var_40_1.level:setFrontVisible(true)
	var_40_1.camera:setSceneCameraOffset()
end

function var_0_0._onSetStateForDialogBeforeStartFight(arg_41_0, arg_41_1)
	gohelper.setActive(arg_41_0._topRightBtnRoot, not arg_41_1)
	gohelper.setActive(arg_41_0._roundGO, not arg_41_1)

	if FightDataHelper.fieldMgr:isDouQuQu() or FightDataHelper.fieldMgr:is191DouQuQu() then
		gohelper.setActive(arg_41_0._enemyinfoRoot, false)
	else
		gohelper.setActive(arg_41_0._enemyinfoRoot, not arg_41_1)
	end

	arg_41_0:refreshEnemyAction(not arg_41_1)
end

function var_0_0.refreshEnemyAction(arg_42_0, arg_42_1)
	if arg_42_0.actionStatus == FightEnum.EnemyActionStatus.NotOpen then
		gohelper.setActive(arg_42_0._enemyActionRoot, false)

		return
	end

	gohelper.setActive(arg_42_0._enemyActionRoot, arg_42_1)
	gohelper.setActive(arg_42_0.enemyActionNormal, arg_42_0.actionStatus == FightEnum.EnemyActionStatus.Normal)
	gohelper.setActive(arg_42_0.enemyActionSelect, arg_42_0.actionStatus == FightEnum.EnemyActionStatus.Select)
	gohelper.setActive(arg_42_0.enemyActionLocked, arg_42_0.actionStatus == FightEnum.EnemyActionStatus.Lock)
end

function var_0_0.onStageChange(arg_43_0)
	if arg_43_0.actionStatus == FightEnum.EnemyActionStatus.NotOpen then
		return
	end

	if FightDataHelper.stageMgr:getCurStage() == FightStageMgr.StageType.Play then
		arg_43_0:setEnemyActionStatus(FightEnum.EnemyActionStatus.Lock)
	else
		arg_43_0:setEnemyActionStatus(FightEnum.EnemyActionStatus.Normal)
	end
end

function var_0_0.setEnemyActionStatus(arg_44_0, arg_44_1)
	arg_44_0.actionStatus = arg_44_1

	FightController.instance:dispatchEvent(FightEvent.OnEnemyActionStatusChange, arg_44_0.actionStatus)
	arg_44_0:refreshEnemyAction(true)
end

function var_0_0.onClickEnemyAction(arg_45_0)
	if arg_45_0.actionStatus ~= FightEnum.EnemyActionStatus.Normal then
		return
	end

	if arg_45_0:checkMonsterCardIsEmpty() then
		return
	end

	arg_45_0:setEnemyActionStatus(FightEnum.EnemyActionStatus.Select)
	ViewMgr.instance:openView(ViewName.FightEnemyActionView)
end

function var_0_0.checkMonsterCardIsEmpty(arg_46_0)
	local var_46_0 = FightDataHelper.roundMgr:getRoundData()
	local var_46_1 = var_46_0 and var_46_0:getAIUseCardMOList()

	if var_46_1 then
		for iter_46_0, iter_46_1 in ipairs(var_46_1) do
			if FightDataHelper.entityMgr:getById(iter_46_1.uid) then
				return false
			end
		end
	end

	return true
end

return var_0_0
