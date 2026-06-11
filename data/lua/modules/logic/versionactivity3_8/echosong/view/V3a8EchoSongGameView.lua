-- chunkname: @modules/logic/versionactivity3_8/echosong/view/V3a8EchoSongGameView.lua

module("modules.logic.versionactivity3_8.echosong.view.V3a8EchoSongGameView", package.seeall)

local V3a8EchoSongGameView = class("V3a8EchoSongGameView", BaseView)

function V3a8EchoSongGameView:onInitView()
	self._godrag = gohelper.findChild(self.viewGO, "#go_drag")
	self._goTargetStar1 = gohelper.findChild(self.viewGO, "Left/Target/TargetStar/#go_TargetStar1")
	self._goTargetStar2 = gohelper.findChild(self.viewGO, "Left/Target/TargetStar/#go_TargetStar2")
	self._gojoyRightPoint = gohelper.findChild(self.viewGO, "Left/#go_joyRightPoint")
	self._gojoystick = gohelper.findChild(self.viewGO, "Left/#go_joyRightPoint/#go_joystick")
	self._gobackground = gohelper.findChild(self.viewGO, "Left/#go_joyRightPoint/#go_joystick/#go_background")
	self._gohandle = gohelper.findChild(self.viewGO, "Left/#go_joyRightPoint/#go_joystick/#go_background/#go_handle")
	self._btnReset = gohelper.findChildButtonWithAudio(self.viewGO, "Right/#btn_Reset")
	self._goscene = gohelper.findChild(self.viewGO, "#go_scene")
	self._goroot = gohelper.findChild(self.viewGO, "#go_scene/#go_root")
	self._goball = gohelper.findChild(self.viewGO, "#go_scene/#go_root/#go_ball")
	self._gohitball = gohelper.findChild(self.viewGO, "#go_scene/#go_root/#go_hitball")
	self._gotopleft = gohelper.findChild(self.viewGO, "#go_topleft")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function V3a8EchoSongGameView:addEvents()
	self._btnReset:AddClickListener(self._btnResetOnClick, self)
end

function V3a8EchoSongGameView:removeEvents()
	self._btnReset:RemoveClickListener()
end

function V3a8EchoSongGameView:_btnResetOnClick()
	V3a8EchoSongController.instance:dispatchEvent(V3a8EchoSongEvent.PauseGame)
	GameFacade.showMessageBox(MessageBoxIdDefine.EchoSongResetConfirm, MsgBoxEnum.BoxType.Yes_No, self._onChooseReset, self._onCancelReset, nil, self, self)
end

function V3a8EchoSongGameView:_onChooseReset()
	V3a8EchoSongController.instance:sendGameReset()
	V3a8EchoSongController.instance:dispatchEvent(V3a8EchoSongEvent.ResumeGame)
	V3a8EchoSongController.instance:dispatchEvent(V3a8EchoSongEvent.ResetGame)
end

function V3a8EchoSongGameView:_onCancelReset()
	V3a8EchoSongController.instance:dispatchEvent(V3a8EchoSongEvent.ResumeGame)
end

function V3a8EchoSongGameView:_editableInitView()
	return
end

function V3a8EchoSongGameView:_onScaleChange(param, value)
	return
end

function V3a8EchoSongGameView:_clickDownHandler()
	self._clickDownTime = Time.time
end

function V3a8EchoSongGameView:_clickUp()
	if not self._clickDownTime then
		return
	end

	local deltaTime = Time.time - self._clickDownTime

	if deltaTime > V3a8EchoSongEnum.LongClickTime then
		V3a8EchoSongController.instance:dispatchEvent(V3a8EchoSongEvent.TouchEmitted, V3a8EchoSongEnum.TouchEmittedType.Long)
	else
		V3a8EchoSongController.instance:dispatchEvent(V3a8EchoSongEvent.TouchEmitted, V3a8EchoSongEnum.TouchEmittedType.Short)
	end
end

function V3a8EchoSongGameView:_onDragBegin(param, pointerEventData)
	self._dragBeginPos = recthelper.screenPosToAnchorPos(pointerEventData.position, self.viewGO.transform)
	self._clickDownTime = nil
end

function V3a8EchoSongGameView:_onDragEnd(param, pointerEventData)
	if not self._dragBeginPos then
		return
	end

	V3a8EchoSongController.instance:dispatchEvent(V3a8EchoSongEvent.DragLine, false)

	local deltaPos = recthelper.screenPosToAnchorPos(pointerEventData.position, self.viewGO.transform) - self._dragBeginPos
	local magnitude = deltaPos.magnitude

	if magnitude >= V3a8EchoSongEnum.DragLength then
		V3a8EchoSongController.instance:dispatchEvent(V3a8EchoSongEvent.DragExplore, pointerEventData.position)
	end

	self._dragBeginPos = nil
end

function V3a8EchoSongGameView:_onDrag(param, pointerEventData)
	if not self._dragBeginPos then
		return
	end

	local pos = recthelper.screenPosToAnchorPos(pointerEventData.position, self.viewGO.transform)
	local deltaPos = pos - self._dragBeginPos
	local magnitude = deltaPos.magnitude
	local showLine = magnitude >= V3a8EchoSongEnum.DragLength

	V3a8EchoSongController.instance:dispatchEvent(V3a8EchoSongEvent.DragLine, showLine, pointerEventData.position)
end

function V3a8EchoSongGameView:onUpdateParam()
	return
end

function V3a8EchoSongGameView:onOpen()
	self:addEventCb(V3a8EchoSongController.instance, V3a8EchoSongEvent.ShowResultView, self._onShowResultView, self)

	self._drag = SLFramework.UGUI.UIDragListener.Get(self._godrag)

	self._drag:AddDragBeginListener(self._onDragBegin, self)
	self._drag:AddDragListener(self._onDrag, self)
	self._drag:AddDragEndListener(self._onDragEnd, self)

	self._click = SLFramework.UGUI.UIClickListener.Get(self._godrag)

	self._click:AddClickDownListener(self._clickDownHandler, self)
	self._click:AddClickUpListener(self._clickUp, self)

	self._sliderScale = gohelper.findChildSlider(self.viewGO, "Right/Slider")

	self._sliderScale:AddOnValueChanged(self._onScaleChange, self)
	self._sliderScale:SetValue(1)
	gohelper.setActive(self._sliderScale, false)
end

function V3a8EchoSongGameView:onOpenFinish()
	if SLFramework.FrameworkSettings.IsEditor then
		TaskDispatcher.runRepeat(self._frameHandler, self, 0)
	end
end

function V3a8EchoSongGameView:_frameHandler()
	if SLFramework.FrameworkSettings.IsEditor and UnityEngine.Input.GetKey(UnityEngine.KeyCode.LeftControl) and UnityEngine.Input.GetKey(UnityEngine.KeyCode.W) then
		self:_onShowResultView(true)
	end
end

function V3a8EchoSongGameView:_onShowResultView(isSuccess)
	V3a8EchoSongController.instance:openV3a8EchoSongResultView({
		isSuccess = isSuccess
	})

	if isSuccess then
		V3a8EchoSongController.instance:sendGameSuccess()
	else
		V3a8EchoSongController.instance:sendGameFail()
	end
end

function V3a8EchoSongGameView:onClose()
	if self._drag then
		self._drag:RemoveDragBeginListener()
		self._drag:RemoveDragListener()
		self._drag:RemoveDragEndListener()
	end

	if self._click then
		self._click:RemoveClickDownListener()
		self._click:RemoveClickUpListener()
	end

	if self._sliderScale then
		self._sliderScale:RemoveOnValueChanged()
	end

	TaskDispatcher.cancelTask(self._frameHandler, self)
	V3a8EchoSongModel.instance:clearAllData()
end

function V3a8EchoSongGameView:onDestroyView()
	return
end

return V3a8EchoSongGameView
