module("modules.logic.fight.view.FightSkillSelectView", package.seeall)

local var_0_0 = class("FightSkillSelectView", BaseView)
local var_0_1 = SLFramework.UGUI.UILongPressListener

function var_0_0.onInitView(arg_1_0)
	arg_1_0._clickBlock = gohelper.findChildClick(arg_1_0.viewGO, "clickBlock")
	arg_1_0._clickBlockTransform = arg_1_0._clickBlock:GetComponent(gohelper.Type_RectTransform)
	arg_1_0._longPress = var_0_1.Get(arg_1_0._clickBlock.gameObject)
	arg_1_0._guideClickObj = gohelper.findChild(arg_1_0.viewGO, "guideClick")

	gohelper.setActive(arg_1_0._guideClickObj, false)

	arg_1_0._guideClickObj.name = "guideClick"
	arg_1_0._guideClickList = {}
	arg_1_0._containerGO = arg_1_0.viewGO
	arg_1_0._containerTr = arg_1_0._containerGO.transform
	arg_1_0._imgSelectGO = gohelper.findChild(arg_1_0.viewGO, "imgSkillSelect")
	arg_1_0._imgSelectTr = arg_1_0._imgSelectGO.transform
	arg_1_0._imgSelectAnimator = arg_1_0._containerGO:GetComponent(typeof(UnityEngine.Animator))

	gohelper.setActive(arg_1_0._containerGO, false)

	arg_1_0.showUI = true
	arg_1_0.entityVisible = true

	arg_1_0:_setSelectGOActive(false)

	arg_1_0.started = nil

	arg_1_0._clickBlock:AddClickListener(arg_1_0._onClick, arg_1_0)
	arg_1_0._clickBlock:AddClickDownListener(arg_1_0._onClickDown, arg_1_0)
	arg_1_0._clickBlock:AddClickUpListener(arg_1_0._onClickUp, arg_1_0)
	arg_1_0._longPress:AddLongPressListener(arg_1_0._onLongPress, arg_1_0)

	arg_1_0._pressTab = {
		0.5,
		99999
	}

	arg_1_0._longPress:SetLongPressTime(arg_1_0._pressTab)
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0:addEventCb(FightController.instance, FightEvent.OnStartSequenceFinish, arg_2_0._onStartSequenceFinish, arg_2_0)
	arg_2_0:addEventCb(FightController.instance, FightEvent.OnCameraFocusChanged, arg_2_0.onCameraFocusChanged, arg_2_0)
	arg_2_0:addEventCb(FightController.instance, FightEvent.OnEnemyActionStatusChange, arg_2_0.onEnemyActionStatusChange, arg_2_0)
	arg_2_0:addEventCb(FightController.instance, FightEvent.OnRoundSequenceFinish, arg_2_0._onRoundSequenceFinish, arg_2_0)
	arg_2_0:addEventCb(FightController.instance, FightEvent.StartReplay, arg_2_0._removeAllEvent, arg_2_0)
	arg_2_0:addEventCb(FightController.instance, FightEvent.SetIsShowUI, arg_2_0._setIsShowUI, arg_2_0)
	arg_2_0:addEventCb(FightController.instance, FightEvent.OnRestartStageBefore, arg_2_0._onRestartStage, arg_2_0)
	arg_2_0:addEventCb(FightController.instance, FightEvent.OnSkillPlayStart, arg_2_0._onSkillPlayStart, arg_2_0)
	arg_2_0:addEventCb(FightController.instance, FightEvent.OnSkillTimeLineDone, arg_2_0._onSkillTimeLineDone, arg_2_0)
	arg_2_0:addEventCb(FightController.instance, FightEvent.SetEntityVisibleByTimeline, arg_2_0._setEntityVisibleByTimeline, arg_2_0)
	arg_2_0:addEventCb(FightController.instance, FightEvent.OnBeginWave, arg_2_0._onBeginWave, arg_2_0)
	arg_2_0:addEventCb(FightController.instance, FightEvent.EntityDeadFinish, arg_2_0.onEntityDeadFinish, arg_2_0)
	arg_2_0:addEventCb(FightController.instance, FightEvent.StageChanged, arg_2_0.onStageChanged, arg_2_0)
	arg_2_0:addEventCb(FightController.instance, FightEvent.GuideCreateClickBySkinId, arg_2_0._onGuideCreateClickBySkinId, arg_2_0)
	arg_2_0:addEventCb(FightController.instance, FightEvent.GuideReleaseClickBySkilId, arg_2_0._onGuideReleaseClickBySkilId, arg_2_0)
	arg_2_0:addEventCb(FightController.instance, FightEvent.OnChangeEntity, arg_2_0.onChangeEntity, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	arg_3_0:removeEventCb(FightController.instance, FightEvent.OnStartSequenceFinish, arg_3_0._onStartSequenceFinish, arg_3_0)
	arg_3_0:removeEventCb(FightController.instance, FightEvent.OnCameraFocusChanged, arg_3_0.onCameraFocusChanged, arg_3_0)
	arg_3_0:removeEventCb(FightController.instance, FightEvent.OnEnemyActionStatusChange, arg_3_0.onEnemyActionStatusChange, arg_3_0)
	arg_3_0:removeEventCb(FightController.instance, FightEvent.OnRoundSequenceFinish, arg_3_0._onRoundSequenceFinish, arg_3_0)
	arg_3_0:removeEventCb(FightController.instance, FightEvent.StartReplay, arg_3_0._removeAllEvent, arg_3_0)
	arg_3_0:removeEventCb(FightController.instance, FightEvent.SetIsShowUI, arg_3_0._setIsShowUI, arg_3_0)
	arg_3_0:removeEventCb(FightController.instance, FightEvent.OnRestartStageBefore, arg_3_0._onRestartStage, arg_3_0)
	arg_3_0:removeEventCb(FightController.instance, FightEvent.OnSkillPlayStart, arg_3_0._onSkillPlayStart, arg_3_0)
	arg_3_0:removeEventCb(FightController.instance, FightEvent.OnSkillTimeLineDone, arg_3_0._onSkillTimeLineDone, arg_3_0)
	arg_3_0:removeEventCb(FightController.instance, FightEvent.SetEntityVisibleByTimeline, arg_3_0._setEntityVisibleByTimeline, arg_3_0)
	arg_3_0:removeEventCb(FightController.instance, FightEvent.OnBeginWave, arg_3_0._onBeginWave, arg_3_0)
	arg_3_0:removeEventCb(FightController.instance, FightEvent.EntityDeadFinish, arg_3_0.onEntityDeadFinish, arg_3_0)
	arg_3_0:removeEventCb(FightController.instance, FightEvent.StageChanged, arg_3_0.onStageChanged, arg_3_0)
	arg_3_0:removeEventCb(PCInputController.instance, PCInputEvent.NotifyBattleSelect, arg_3_0.OnKeySelect, arg_3_0)
	arg_3_0:removeEventCb(FightController.instance, FightEvent.OnChangeEntity, arg_3_0.onChangeEntity, arg_3_0)
	arg_3_0._clickBlock:RemoveClickListener()
	arg_3_0._clickBlock:RemoveClickDownListener()
	arg_3_0._clickBlock:RemoveClickUpListener()
	arg_3_0._longPress:RemoveLongPressListener()

	for iter_3_0, iter_3_1 in ipairs(arg_3_0._guideClickList) do
		local var_3_0 = iter_3_1.click

		var_3_0:RemoveClickListener()
		var_3_0:RemoveClickDownListener()
		var_3_0:RemoveClickUpListener()
		iter_3_1.longPress:RemoveLongPressListener()
	end
end

function var_0_0._onRoundSequenceFinish(arg_4_0)
	arg_4_0:_resetDefaultFocus()
	FightController.instance:dispatchEvent(FightEvent.SelectSkillTarget, FightDataHelper.operationDataMgr.curSelectEntityId)
end

function var_0_0.onChangeEntity(arg_5_0, arg_5_1)
	if not FightHelper.getEntity(FightDataHelper.operationDataMgr.curSelectEntityId) then
		arg_5_0:_resetDefaultFocus()
		FightController.instance:dispatchEvent(FightEvent.SelectSkillTarget, FightDataHelper.operationDataMgr.curSelectEntityId)
	end
end

function var_0_0._updateGuideClick(arg_6_0)
	for iter_6_0, iter_6_1 in ipairs(arg_6_0._guideClickList) do
		local var_6_0 = iter_6_1.entity
		local var_6_1 = var_6_0:getMO()
		local var_6_2, var_6_3, var_6_4, var_6_5 = FightHelper.calcRect(var_6_0, arg_6_0._clickBlockTransform)
		local var_6_6
		local var_6_7
		local var_6_8 = var_6_0:getHangPoint(ModuleEnum.SpineHangPoint.mountmiddle)

		if var_6_8 then
			local var_6_9, var_6_10, var_6_11 = transformhelper.getPos(var_6_8.transform)

			var_6_6, var_6_7 = recthelper.worldPosToAnchorPosXYZ(var_6_9, var_6_10, var_6_11, arg_6_0._containerTr)
		else
			var_6_6 = (var_6_2 + var_6_4) / 2
			var_6_7 = (var_6_3 + var_6_5) / 2
		end

		recthelper.setAnchor(iter_6_1.transform, var_6_6, var_6_7)

		local var_6_12 = math.abs(var_6_2 - var_6_4)
		local var_6_13 = math.abs(var_6_3 - var_6_5)
		local var_6_14 = lua_monster_skin.configDict[var_6_1.skin]
		local var_6_15 = var_6_14 and var_6_14.clickBoxUnlimit == 1
		local var_6_16 = var_6_15 and 800 or 200
		local var_6_17 = var_6_15 and 800 or 500
		local var_6_18 = Mathf.Clamp(var_6_12, 150, var_6_16)
		local var_6_19 = Mathf.Clamp(var_6_13, 150, var_6_17)

		recthelper.setSize(iter_6_1.transform, var_6_18, var_6_19)
	end
end

function var_0_0._onGuideCreateClickBySkinId(arg_7_0, arg_7_1, arg_7_2)
	arg_7_1 = tonumber(arg_7_1)
	arg_7_2 = tonumber(arg_7_2)

	local var_7_0 = FightHelper.getAllEntitys()

	for iter_7_0, iter_7_1 in ipairs(var_7_0) do
		local var_7_1 = iter_7_1:getMO()

		if arg_7_0:_checkEntityGuideClick(var_7_1, arg_7_1, arg_7_2) then
			FightModel.instance:setClickEnemyState(true)

			arg_7_0._curClickEntityId = iter_7_1.id

			local var_7_2 = arg_7_0:getUserDataTb_()

			var_7_2.entity = iter_7_1

			local var_7_3 = gohelper.cloneInPlace(arg_7_0._guideClickObj, "guideClick" .. arg_7_1)

			gohelper.setActive(var_7_3, true)

			var_7_2.obj = var_7_3
			var_7_2.transform = var_7_3.transform

			local var_7_4 = gohelper.getClick(var_7_3)

			var_7_4:AddClickListener(arg_7_0._onClick, arg_7_0)
			var_7_4:AddClickDownListener(arg_7_0._onClickDown, arg_7_0)
			var_7_4:AddClickUpListener(arg_7_0._onClickUp, arg_7_0)

			var_7_2.click = var_7_4

			local var_7_5 = var_0_1.Get(var_7_3)

			var_7_5:AddLongPressListener(arg_7_0._onLongPress, arg_7_0)
			var_7_5:SetLongPressTime(arg_7_0._pressTab)

			var_7_2.longPress = var_7_5

			table.insert(arg_7_0._guideClickList, var_7_2)
			TaskDispatcher.runRepeat(arg_7_0._updateGuideClick, arg_7_0, 0.01)

			break
		end
	end
end

function var_0_0._checkEntityGuideClick(arg_8_0, arg_8_1, arg_8_2, arg_8_3)
	if not arg_8_1 then
		return false
	end

	if arg_8_1.skin ~= tonumber(arg_8_2) then
		return false
	end

	if arg_8_3 and tonumber(arg_8_3) ~= arg_8_1.position then
		return false
	end

	return true
end

function var_0_0._onGuideReleaseClickBySkilId(arg_9_0, arg_9_1, arg_9_2)
	for iter_9_0 = #arg_9_0._guideClickList, 1, -1 do
		local var_9_0 = arg_9_0._guideClickList[iter_9_0].entity:getMO()

		if arg_9_0:_checkEntityGuideClick(var_9_0, arg_9_1, arg_9_2) then
			local var_9_1 = table.remove(arg_9_0._guideClickList, iter_9_0)
			local var_9_2 = var_9_1.click

			var_9_2:RemoveClickListener()
			var_9_2:RemoveClickDownListener()
			var_9_2:RemoveClickUpListener()
			var_9_1.longPress:RemoveLongPressListener()
			gohelper.destroy(var_9_1.obj)
		end
	end

	if #arg_9_0._guideClickList == 0 then
		TaskDispatcher.cancelTask(arg_9_0._updateGuideClick, arg_9_0)
		FightModel.instance:setClickEnemyState(false)

		arg_9_0._curClickEntityId = nil
	end
end

function var_0_0._onClick(arg_10_0, arg_10_1, arg_10_2)
	local var_10_0 = arg_10_1 or arg_10_0._curClickEntityId

	if not var_10_0 then
		return
	end

	local var_10_1 = FightHelper.getEntity(var_10_0)

	if not var_10_1 then
		return
	end

	if not var_10_1:isEnemySide() then
		return
	end

	local var_10_2 = OpenModel.instance:isFunctionUnlock(OpenEnum.UnlockFunc.FightFocus)
	local var_10_3 = GuideModel.instance:isGuideFinish(GuideController.FirstGuideId)

	if not var_10_2 and not var_10_3 then
		return
	end

	if FightDataHelper.stateMgr.isReplay then
		return
	end

	local var_10_4 = FightDataHelper.stageMgr:getCurOperateState()

	if var_10_4 == FightStageMgr.OperateStateType.Discard or var_10_4 == FightStageMgr.OperateStateType.DiscardEffect then
		return
	end

	if FightDataHelper.stateMgr:getIsAuto() then
		if var_10_0 == FightDataHelper.operationDataMgr.curSelectEntityId then
			FightDataHelper.operationDataMgr:setCurSelectEntityId(0)
		else
			arg_10_0:_playSelectAnim()
			FightDataHelper.operationDataMgr:setCurSelectEntityId(var_10_0)
		end
	else
		if var_10_0 ~= FightDataHelper.operationDataMgr.curSelectEntityId then
			arg_10_0:_playSelectAnim()
		end

		FightDataHelper.operationDataMgr:setCurSelectEntityId(var_10_0)
	end

	arg_10_0:_updateSelectUI()
	FightController.instance:dispatchEvent(FightEvent.SelectSkillTarget, var_10_0)
end

function var_0_0._onClickDown(arg_11_0, arg_11_1, arg_11_2)
	arg_11_0._curClickEntityId = nil

	local var_11_0 = FightHelper.getAllEntitys()

	for iter_11_0 = #var_11_0, 1, -1 do
		if not arg_11_0:checkCanSelect(var_11_0[iter_11_0].id) then
			table.remove(var_11_0, iter_11_0)
		end
	end

	local var_11_1 = FightHelper.getClickEntity(var_11_0, arg_11_0._clickBlockTransform, arg_11_2)

	if var_11_1 then
		FightModel.instance:setClickEnemyState(true)

		arg_11_0._curClickEntityId = var_11_1
	end
end

function var_0_0.checkCanSelect(arg_12_0, arg_12_1)
	if FightDataHelper.entityMgr:getById(arg_12_1):isAct191Boss() then
		return false
	end

	if FightDataHelper.entityMgr:isSub(arg_12_1) then
		return false
	end

	local var_12_0 = FightDataHelper.entityMgr:getById(arg_12_1)

	if not var_12_0 then
		return false
	end

	if var_12_0:hasBuffFeature(FightEnum.BuffType_CantSelect) then
		return false
	end

	if var_12_0:hasBuffFeature(FightEnum.BuffType_CantSelectEx) then
		return false
	end

	if var_12_0:hasBuffFeature(FightEnum.BuffType_HideLife) then
		return false
	end

	return true
end

function var_0_0._onClickUp(arg_13_0, arg_13_1, arg_13_2)
	if arg_13_0._curClickEntityId then
		FightModel.instance:setClickEnemyState(false)
	end
end

function var_0_0._onLongPress(arg_14_0, arg_14_1)
	if FightDataHelper.lockOperateMgr:isLock() then
		return
	end

	if not arg_14_0._curClickEntityId then
		return
	end

	if FightDataHelper.stageMgr:getCurStage() == FightStageMgr.StageType.Play then
		return
	end

	if FightDataHelper.stateMgr.isReplay then
		return
	end

	local var_14_0 = FightDataHelper.stageMgr:getCurOperateState()

	if var_14_0 == FightStageMgr.OperateStateType.Discard or var_14_0 == FightStageMgr.OperateStateType.DiscardEffect then
		return
	end

	if GuideModel.instance:isFlagEnable(GuideModel.GuideFlag.FightForbidLongPressCard) then
		return
	end

	if FightViewHandCard.blockOperate then
		return
	end

	if GuideModel.instance:isDoingFirstGuide() then
		logNormal("新手第一个指引不能长按查看详情")

		return
	end

	if FightDataHelper.stateMgr:getIsAuto() then
		return
	end

	if FightDataHelper.operationDataMgr:isCardOpEnd() then
		logNormal("出完牌了不能长按查看详情")

		return
	end

	local var_14_1 = FightHelper.getEntity(arg_14_0._curClickEntityId)

	if not var_14_1 then
		return
	end

	if FightDataHelper.entityMgr:isSub(var_14_1.id) then
		return
	end

	arg_14_0.currentFocusEntityMO = FightDataHelper.entityMgr:getById(arg_14_0._curClickEntityId)

	if not arg_14_0.currentFocusEntityMO then
		return
	end

	arg_14_0.viewContainer:openFightFocusView(arg_14_0.currentFocusEntityMO.id)
end

function var_0_0.onStageChanged(arg_15_0, arg_15_1)
	local var_15_0 = FightDataHelper.stageMgr:getCurStage()

	if FightDataHelper.stateMgr.isReplay then
		logError("reply stage ?")

		return
	end

	if var_15_0 == FightStageMgr.StageType.Operate then
		arg_15_0:clearAllFlag()
		arg_15_0:_updatePos()
	end
end

function var_0_0.onEntityDeadFinish(arg_16_0)
	arg_16_0:_resetDefaultFocus()
	FightController.instance:dispatchEvent(FightEvent.SelectSkillTarget, FightDataHelper.operationDataMgr.curSelectEntityId)
	arg_16_0:_updatePos()
end

function var_0_0.onEnemyActionStatusChange(arg_17_0, arg_17_1)
	arg_17_0.showEnemyActioning = FightEnum.EnemyActionStatus.Select == arg_17_1

	arg_17_0:_setSelectGOActive(true)
end

function var_0_0.onUpdateParam(arg_18_0)
	gohelper.setAsFirstSibling(arg_18_0.viewGO)
end

function var_0_0.onOpen(arg_19_0)
	gohelper.setAsFirstSibling(arg_19_0.viewGO)

	if FightDataHelper.stateMgr.isReplay then
		arg_19_0:_removeAllEvent()
	end
end

function var_0_0.onClose(arg_20_0)
	TaskDispatcher.cancelTask(arg_20_0._updateGuideClick, arg_20_0)
	FightDataHelper.operationDataMgr:setCurSelectEntityId(0)
	TaskDispatcher.cancelTask(arg_20_0._delayStartSequenceFinish, arg_20_0)
	arg_20_0:removeLateUpdate()
end

function var_0_0._onBeginWave(arg_21_0)
	arg_21_0:_resetDefaultFocus()
	FightController.instance:dispatchEvent(FightEvent.SelectSkillTarget, FightDataHelper.operationDataMgr.curSelectEntityId)
end

function var_0_0._setEntityVisibleByTimeline(arg_22_0, arg_22_1, arg_22_2, arg_22_3, arg_22_4)
	if arg_22_1.id ~= FightDataHelper.operationDataMgr.curSelectEntityId then
		return
	end

	arg_22_0.entityVisible = arg_22_3

	arg_22_0:_setSelectGOActive(true)
end

function var_0_0._onSkillPlayStart(arg_23_0, arg_23_1)
	if FightDataHelper.operationDataMgr.curSelectEntityId ~= arg_23_1.id then
		return
	end

	arg_23_0.playingCurSelectEntityTimeline = true

	arg_23_0:_setSelectGOActive(false)
end

function var_0_0._onSkillTimeLineDone(arg_24_0, arg_24_1)
	local var_24_0 = arg_24_1 and arg_24_1.fromId

	if FightDataHelper.operationDataMgr.curSelectEntityId ~= var_24_0 then
		return
	end

	arg_24_0.playingCurSelectEntityTimeline = false

	arg_24_0:_setSelectGOActive(true)
end

function var_0_0._setIsShowUI(arg_25_0, arg_25_1)
	arg_25_0.showUI = arg_25_1

	if not arg_25_0._canvasGroup then
		arg_25_0._canvasGroup = gohelper.onceAddComponent(arg_25_0._containerGO, typeof(UnityEngine.CanvasGroup))
	end

	gohelper.setActiveCanvasGroup(arg_25_0._canvasGroup, arg_25_1)
end

function var_0_0._removeAllEvent(arg_26_0)
	arg_26_0:removeEvents()
	arg_26_0:removeLateUpdate()
end

function var_0_0.onCameraFocusChanged(arg_27_0, arg_27_1)
	if arg_27_1 then
		arg_27_0._on_camera_focus = true

		arg_27_0:_setSelectGOActive(false)
	else
		arg_27_0._on_camera_focus = false

		arg_27_0:_setSelectGOActive(true)
	end
end

function var_0_0.clearAllFlag(arg_28_0)
	arg_28_0._on_camera_focus = nil
	arg_28_0.playingCurSelectEntityTimeline = nil
	arg_28_0.entityVisible = true
	arg_28_0.showEnemyActioning = nil
end

function var_0_0._setSelectGOActive(arg_29_0, arg_29_1)
	if not arg_29_1 then
		gohelper.setActive(arg_29_0._imgSelectGO, false)

		return
	end

	if arg_29_0.showEnemyActioning then
		gohelper.setActive(arg_29_0._imgSelectGO, false)

		return
	end

	if arg_29_0._on_camera_focus then
		gohelper.setActive(arg_29_0._imgSelectGO, false)

		return
	end

	if arg_29_0.playingCurSelectEntityTimeline then
		gohelper.setActive(arg_29_0._imgSelectGO, false)

		return
	end

	if not arg_29_0.entityVisible then
		gohelper.setActive(arg_29_0._imgSelectGO, false)

		return
	end

	if GuideModel.instance:isDoingFirstGuide() then
		gohelper.setActive(arg_29_0._imgSelectGO, false)

		return
	end

	if not GMFightShowState.monsterSelect then
		gohelper.setActive(arg_29_0._imgSelectGO, false)

		return
	end

	gohelper.setActive(arg_29_0._imgSelectGO, true)
end

function var_0_0._resetSelect(arg_30_0)
	arg_30_0:_resetDefaultFocus()
	FightController.instance:dispatchEvent(FightEvent.SelectSkillTarget, FightDataHelper.operationDataMgr.curSelectEntityId)
	arg_30_0:_updateSelectUI()
end

function var_0_0._onStartSequenceFinish(arg_31_0)
	FightDataHelper.operationDataMgr:setCurSelectEntityId(0)
	TaskDispatcher.runDelay(arg_31_0._delayStartSequenceFinish, arg_31_0, 0.01)
end

function var_0_0._delayStartSequenceFinish(arg_32_0)
	arg_32_0.started = true

	arg_32_0:clearAllFlag()
	gohelper.setActive(arg_32_0._containerGO, true)
	arg_32_0:_resetDefaultFocus()
	FightController.instance:dispatchEvent(FightEvent.SelectSkillTarget, FightDataHelper.operationDataMgr.curSelectEntityId)
	arg_32_0:addEventCb(PCInputController.instance, PCInputEvent.NotifyBattleSelect, arg_32_0.OnKeySelect, arg_32_0)
	arg_32_0:initUpdateBeat()
end

function var_0_0.OnKeySelect(arg_33_0, arg_33_1)
	if FightDataHelper.stateMgr.isReplay then
		return
	end

	local var_33_0 = FightDataHelper.operationDataMgr:getSelectEnemyPosLOrR(arg_33_1)

	if var_33_0 ~= nil then
		arg_33_0:_onClick(var_33_0)
	end
end

function var_0_0.initUpdateBeat(arg_34_0)
	if arg_34_0.lateUpdateHandle or not arg_34_0.showUI or arg_34_0.playingCurSelectEntityTimeline then
		return
	end

	arg_34_0.lateUpdateHandle = LateUpdateBeat:CreateListener(arg_34_0._onFrameLateUpdate, arg_34_0)

	LateUpdateBeat:AddListener(arg_34_0.lateUpdateHandle)
end

function var_0_0._onFrameLateUpdate(arg_35_0)
	if arg_35_0._on_camera_focus then
		return
	end

	arg_35_0:_updatePos()
end

function var_0_0.removeLateUpdate(arg_36_0)
	if arg_36_0.lateUpdateHandle then
		LateUpdateBeat:RemoveListener(arg_36_0.lateUpdateHandle)

		arg_36_0.lateUpdateHandle = nil
	end
end

function var_0_0._playSelectAnim(arg_37_0)
	if arg_37_0._imgSelectAnimator then
		arg_37_0._imgSelectAnimator:Play("fightview_skillselect", 0, 0)
	else
		logError("无法播放目标锁定动画，Animator不存在")
	end
end

function var_0_0._onRestartStage(arg_38_0)
	gohelper.setActive(arg_38_0._containerGO, false)
	arg_38_0:removeLateUpdate()

	arg_38_0.started = nil
end

function var_0_0._updatePos(arg_39_0)
	arg_39_0:_updateSelectUI()
end

function var_0_0._resetDefaultFocus(arg_40_0)
	if OpenModel.instance:isFunctionUnlock(OpenEnum.UnlockFunc.FightAutoFocus) then
		FightDataHelper.operationDataMgr:resetCurSelectEntityIdDefault()
	end
end

function var_0_0._updateSelectUI(arg_41_0)
	local var_41_0 = FightHelper.getEntity(FightDataHelper.operationDataMgr.curSelectEntityId)

	arg_41_0:_setSelectGOActive(var_41_0 ~= nil)

	if var_41_0 then
		local var_41_1, var_41_2 = arg_41_0:_getEntityMiddlePos(var_41_0)

		recthelper.setAnchor(arg_41_0._imgSelectTr, var_41_1, var_41_2)
	end
end

function var_0_0._getEntityMiddlePos(arg_42_0, arg_42_1)
	if FightHelper.isAssembledMonster(arg_42_1) then
		local var_42_0 = arg_42_1:getMO()
		local var_42_1 = lua_fight_assembled_monster.configDict[var_42_0.skin]
		local var_42_2, var_42_3, var_42_4 = transformhelper.getPos(arg_42_1.go.transform)
		local var_42_5, var_42_6 = recthelper.worldPosToAnchorPosXYZ(var_42_2 + var_42_1.selectPos[1], var_42_3 + var_42_1.selectPos[2], var_42_4, arg_42_0._containerTr)

		return var_42_5, var_42_6
	end

	local var_42_7 = arg_42_1:getHangPoint(ModuleEnum.SpineHangPoint.mountmiddle)

	if var_42_7 and var_42_7.name == ModuleEnum.SpineHangPoint.mountmiddle then
		local var_42_8, var_42_9, var_42_10 = transformhelper.getPos(var_42_7.transform)
		local var_42_11, var_42_12 = recthelper.worldPosToAnchorPosXYZ(var_42_8, var_42_9, var_42_10, arg_42_0._containerTr)

		return var_42_11, var_42_12
	else
		local var_42_13, var_42_14, var_42_15, var_42_16 = FightHelper.calcRect(arg_42_1, arg_42_0._clickBlockTransform)

		return (var_42_13 + var_42_15) / 2, (var_42_14 + var_42_16) / 2
	end
end

function var_0_0.getCurrentFocusEntityId(arg_43_0)
	return arg_43_0.currentFocusEntityMO.id
end

function var_0_0.onDestroyView(arg_44_0)
	return
end

return var_0_0
