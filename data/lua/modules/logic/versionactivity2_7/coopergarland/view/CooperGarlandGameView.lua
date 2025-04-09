module("modules.logic.versionactivity2_7.coopergarland.view.CooperGarlandGameView", package.seeall)

slot0 = class("CooperGarlandGameView", BaseView)

function slot0.onInitView(slot0)
	slot0._goleft = gohelper.findChild(slot0.viewGO, "Left")
	slot0._goTargetStar1 = gohelper.findChild(slot0.viewGO, "Left/Target/TargetStar/#go_TargetStar1")
	slot0._goTargetStar2 = gohelper.findChild(slot0.viewGO, "Left/Target/TargetStar/#go_TargetStar2")
	slot0._btnControl = gohelper.findChildButtonWithAudio(slot0.viewGO, "Left/Control/#btn_Control")
	slot0._animControl = gohelper.findChildAnim(slot0.viewGO, "Left/Control")
	slot0._goJoystickMode = gohelper.findChild(slot0.viewGO, "Left/Control/#go_Joystick")
	slot0._goGyroscopeMode = gohelper.findChild(slot0.viewGO, "Left/Control/#go_Gyroscope")
	slot0._btnReset = gohelper.findChildButtonWithAudio(slot0.viewGO, "Right/#btn_Reset")
	slot0._goRemove = gohelper.findChild(slot0.viewGO, "Right/Collect")
	slot0._animCollect = gohelper.findChildAnim(slot0.viewGO, "Right/Collect")
	slot0._goIcon1 = gohelper.findChild(slot0.viewGO, "Right/Collect/#go_Icon1")
	slot0._goIcon2 = gohelper.findChild(slot0.viewGO, "Right/Collect/#go_Icon2")
	slot0._txtLightNum = gohelper.findChildText(slot0.viewGO, "Right/Collect/#txt_LightNum")
	slot0._btnRemoveMode = gohelper.findChildClickWithAudio(slot0.viewGO, "Right/Collect/#btn_modeClick")
	slot0._gojoystick = gohelper.findChild(slot0.viewGO, "#go_joystick")
	slot0._goTopTips = gohelper.findChild(slot0.viewGO, "#go_TopTips")
	slot0._goGameTips = gohelper.findChild(slot0.viewGO, "#go_TopTips2")
	slot0._txtGameTips = gohelper.findChildText(slot0.viewGO, "#go_TopTips2/#txt_Tips")

	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0.addEvents(slot0)
	slot0._btnControl:AddClickListener(slot0._btnControlOnClick, slot0)
	slot0._btnReset:AddClickListener(slot0._btnResetOnClick, slot0)
	slot0._btnRemoveMode:AddClickListener(slot0._btnRemoveModeClick, slot0)
	NavigateMgr.instance:addEscape(ViewName.CooperGarlandGameView, slot0._onEscapeBtnClick, slot0)
	slot0:addEventCb(CooperGarlandController.instance, CooperGarlandEvent.OnChangeControlMode, slot0._onChangeControlMode, slot0)
	slot0:addEventCb(CooperGarlandController.instance, CooperGarlandEvent.OnRemoveModeChange, slot0._onRemoveModeChange, slot0)
	slot0:addEventCb(CooperGarlandController.instance, CooperGarlandEvent.OnRemoveComponent, slot0._onRemoveComponent, slot0)
	slot0:addEventCb(CooperGarlandController.instance, CooperGarlandEvent.PlayEnterNextRoundAnim, slot0._onPlayEnterNextRoundAnim, slot0)
	slot0:addEventCb(CooperGarlandController.instance, CooperGarlandEvent.OnEnterNextRound, slot0._onEnterNextRound, slot0)
	slot0:addEventCb(CooperGarlandController.instance, CooperGarlandEvent.OnResetGame, slot0._onResetGame, slot0)
	slot0:addEventCb(CooperGarlandController.instance, CooperGarlandEvent.PlayFinishEpisodeStarVX, slot0._onPlayStarFinishVx, slot0)
	slot0:addEventCb(CooperGarlandController.instance, CooperGarlandEvent.ResetJoystick, slot0._resetJoystick, slot0)
end

function slot0.removeEvents(slot0)
	slot0._btnControl:RemoveClickListener()
	slot0._btnReset:RemoveClickListener()
	slot0._btnRemoveMode:RemoveClickListener()
	slot0:removeEventCb(CooperGarlandController.instance, CooperGarlandEvent.OnChangeControlMode, slot0._onChangeControlMode, slot0)
	slot0:removeEventCb(CooperGarlandController.instance, CooperGarlandEvent.OnRemoveModeChange, slot0._onRemoveModeChange, slot0)
	slot0:removeEventCb(CooperGarlandController.instance, CooperGarlandEvent.OnRemoveComponent, slot0._onRemoveComponent, slot0)
	slot0:removeEventCb(CooperGarlandController.instance, CooperGarlandEvent.PlayEnterNextRoundAnim, slot0._onPlayEnterNextRoundAnim, slot0)
	slot0:removeEventCb(CooperGarlandController.instance, CooperGarlandEvent.OnEnterNextRound, slot0._onEnterNextRound, slot0)
	slot0:removeEventCb(CooperGarlandController.instance, CooperGarlandEvent.OnResetGame, slot0._onResetGame, slot0)
	slot0:removeEventCb(CooperGarlandController.instance, CooperGarlandEvent.PlayFinishEpisodeStarVX, slot0._onPlayStarFinishVx, slot0)
	slot0:removeEventCb(CooperGarlandController.instance, CooperGarlandEvent.ResetJoystick, slot0._resetJoystick, slot0)
end

function slot0._btnControlOnClick(slot0)
	CooperGarlandController.instance:changeControlMode()
	slot0:_showGameTips(luaLang(CooperGarlandGameModel.instance:getIsJoystick() and "v2a7_coopergarland_change_control_mode1" or "v2a7_coopergarland_change_control_mode2"))
end

function slot0._btnResetOnClick(slot0)
	CooperGarlandController.instance:setStopGame(true)
	GameFacade.showMessageBox(MessageBoxIdDefine.CooperGarlandResetGame, MsgBoxEnum.BoxType.Yes_No, slot0._confirmReset, slot0._closeResetMessBox, nil, slot0, slot0)
end

function slot0._confirmReset(slot0)
	CooperGarlandStatHelper.instance:sendMapReset(slot0.viewName)
	CooperGarlandController.instance:resetGame()
end

function slot0._closeResetMessBox(slot0)
	CooperGarlandController.instance:setStopGame(false)
end

function slot0._btnRemoveModeClick(slot0)
	CooperGarlandController.instance:changeRemoveMode()
end

function slot0._onEscapeBtnClick(slot0)
	slot0.viewContainer:overrideClose()
end

function slot0._onChangeControlMode(slot0)
	slot0:refreshControlMode(true)
end

function slot0._onRemoveModeChange(slot0)
	slot0:refreshControlMode()
	slot0:refreshRemoveMode()

	if CooperGarlandGameModel.instance:getIsRemoveMode() then
		slot0:_showGameTips()
		AudioMgr.instance:trigger(AudioEnum2_7.CooperGarland.play_ui_yuzhou_trap_choose)
	end
end

function slot0._onRemoveComponent(slot0)
	slot0:_btnRemoveModeClick()
	slot0:refreshRemoveCount(true)
	slot0:_showGameTips(luaLang("v2a7_coopergarland_remove_comp"))
	AudioMgr.instance:trigger(AudioEnum2_7.CooperGarland.play_ui_yuzhou_trap_dispel)
end

function slot0._onPlayEnterNextRoundAnim(slot0)
	if not slot0.animator then
		return
	end

	slot0.animator.enabled = true

	slot0.animator:Play("switch", 0, 0)
end

function slot0._onEnterNextRound(slot0)
	slot0:refreshRemoveCount()
end

function slot0._onResetGame(slot0)
	slot0:refresh()
end

function slot0._onPlayStarFinishVx(slot0)
	slot0:setTargetStar(true, true)
	AudioMgr.instance:trigger(AudioEnum2_7.CooperGarland.play_ui_pkls_star_light)
	TaskDispatcher.runDelay(slot0._afterPlayStarFinish, slot0, TimeUtil.OneSecond)
end

function slot0._afterPlayStarFinish(slot0)
	CooperGarlandController.instance:finishEpisode(CooperGarlandGameModel.instance:getEpisodeId(), true)
end

function slot0._resetJoystick(slot0)
	if not slot0.joystick then
		return
	end

	slot0.joystick:reset()
end

function slot0._showGameTips(slot0, slot1)
	gohelper.setActive(slot0._goGameTips, false)

	if string.nilorempty(slot1) then
		return
	end

	slot0._txtGameTips.text = slot1

	gohelper.setActive(slot0._goGameTips, true)
end

function slot0._editableInitView(slot0)
	slot0.animator = slot0.viewGO:GetComponent(typeof(UnityEngine.Animator))
	slot0._gyroSensitivity = CooperGarlandConfig.instance:getAct192Const(CooperGarlandEnum.ConstId.GyroSensitivity, true)
	slot0._cubeResetSpeed = CooperGarlandConfig.instance:getAct192Const(CooperGarlandEnum.ConstId.CubeBalanceRestSpeed, true)
	slot0.joystick = MonoHelper.addNoUpdateLuaComOnceToGo(slot0._gojoystick, VirtualFixedJoystick)

	if not slot0._isRunning then
		slot0._isRunning = true

		LateUpdateBeat:Add(slot0._onLateUpdate, slot0)
	end

	slot0.originalAutoLeft = UnityEngine.Screen.autorotateToLandscapeLeft
	slot0.originalAutoRight = UnityEngine.Screen.autorotateToLandscapeRight
	UnityEngine.Screen.autorotateToLandscapeLeft = false
	UnityEngine.Screen.autorotateToLandscapeRight = false

	if GameUtil.isMobilePlayerAndNotEmulator() then
		slot0.gyro = UnityEngine.Input.gyro
		slot0.originalGyroStatus = slot0.gyro.enabled
		slot0.gyro.enabled = true
	end

	slot0:setTargetStar(false)
end

slot1 = 3

function slot0._onLateUpdate(slot0)
	if CooperGarlandGameModel.instance:getIsJoystick() then
		if slot0.joystick and slot0.joystick:getIsDragging() then
			slot3 = slot0.joystick:getInputValue()

			CooperGarlandController.instance:changePanelBalance(slot3.x, slot3.y)

			slot0._needReset = true
		elseif slot0._needReset then
			CooperGarlandController.instance:resetPanelBalance(slot0._cubeResetSpeed)

			slot0._needReset = false
		end
	else
		slot2 = 0
		slot3 = 0

		if slot0.gyro then
			slot4 = slot0.gyro.gravity.normalized
			slot2 = slot4.x
			slot3 = slot4.y
		end

		CooperGarlandController.instance:changePanelBalance(Mathf.Clamp(slot0._gyroSensitivity * slot2, -1, 1), Mathf.Clamp(slot0._gyroSensitivity * slot3, -1, 1))
	end

	AudioMgr.instance:setRTPCValue(AudioEnum2_7.CooperGarlandBallRTPC, CooperGarlandGameEntityMgr.instance:getBallVelocity().magnitude * uv0)
end

function slot0.onUpdateParam(slot0)
end

function slot0.onOpen(slot0)
	slot0:refresh()
end

function slot0.refresh(slot0)
	slot0:refreshRemoveCount()
	slot0:refreshRemoveMode()
	slot0:refreshControlMode()
end

function slot0.refreshRemoveCount(slot0, slot1)
	if CooperGarlandConfig.instance:getRemoveCount(CooperGarlandGameModel.instance:getGameId(), CooperGarlandGameModel.instance:getGameRound()) and slot4 > 0 then
		slot7 = CooperGarlandGameModel.instance:getRemoveCount() and slot6 > 0

		gohelper.setActive(slot0._goIcon1, not slot7)
		gohelper.setActive(slot0._goIcon2, slot7)

		if slot1 then
			slot0._animCollect:Play("switch", 0, 0)
		end

		slot0._txtLightNum.text = luaLang("multiple") .. (slot6 or 0)
	end

	gohelper.setActive(slot0._goRemove, slot5)
end

function slot0.refreshRemoveMode(slot0)
	slot1 = CooperGarlandGameModel.instance:getIsRemoveMode()

	gohelper.setActive(slot0._goleft, not slot1)
	gohelper.setActive(slot0._btnReset, not slot1)
	gohelper.setActive(slot0._goTopTips, slot1)
end

function slot0.refreshControlMode(slot0, slot1)
	slot2 = CooperGarlandGameModel.instance:getIsJoystick()

	gohelper.setActive(slot0._gojoystick, not CooperGarlandGameModel.instance:getIsRemoveMode() and slot2)
	gohelper.setActive(slot0._goGyroscopeMode, not slot2)
	gohelper.setActive(slot0._goJoystickMode, slot2)

	if slot1 then
		slot0._animControl:Play(slot2 and "switch2" or "switch1", 0, 0)
	end
end

function slot0.setTargetStar(slot0, slot1, slot2)
	if slot2 and slot0.animator then
		slot0.animator.enabled = false
	end

	gohelper.setActive(slot0._goTargetStar1, not slot1)
	gohelper.setActive(slot0._goTargetStar2, slot1)
end

function slot0.onClose(slot0)
	if slot0._isRunning then
		slot0._isRunning = false

		LateUpdateBeat:Remove(slot0._onLateUpdate, slot0)
	end

	if slot0.originalAutoLeft ~= nil then
		UnityEngine.Screen.autorotateToLandscapeLeft = slot0.originalAutoLeft
	end

	if slot0.originalAutoRight ~= nil then
		UnityEngine.Screen.autorotateToLandscapeRight = slot0.originalAutoRight
	end

	if slot0.gyro then
		slot0.gyro.enabled = slot0.originalGyroStatus
	end

	TaskDispatcher.cancelTask(slot0._afterPlayStarFinish, slot0)
end

function slot0.onDestroyView(slot0)
end

return slot0
