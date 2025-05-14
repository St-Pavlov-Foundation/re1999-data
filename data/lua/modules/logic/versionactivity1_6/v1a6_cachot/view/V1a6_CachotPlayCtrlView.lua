module("modules.logic.versionactivity1_6.v1a6_cachot.view.V1a6_CachotPlayCtrlView", package.seeall)

local var_0_0 = class("V1a6_CachotPlayCtrlView", BaseView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._goCtrl = gohelper.findChild(arg_1_0.viewGO, "#go_control")
	arg_1_0._icon = gohelper.findChildImage(arg_1_0.viewGO, "#go_control/bg")
	arg_1_0._iconCanvasGroup = gohelper.onceAddComponent(arg_1_0._icon, gohelper.Type_CanvasGroup)
	arg_1_0._iconTrans = arg_1_0._icon.transform

	local var_1_0 = gohelper.findChild(arg_1_0.viewGO, "#go_interact")

	if var_1_0 then
		arg_1_0._gouninteract = gohelper.findChild(var_1_0, "uninteract")
		arg_1_0._gointeract = gohelper.findChild(var_1_0, "interactale")
		arg_1_0._btninteract = gohelper.findChildButton(var_1_0, "#btn_interactclick")
	end
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0._drag = SLFramework.UGUI.UIDragListener.Get(arg_2_0._goCtrl)

	arg_2_0._drag:AddDragBeginListener(arg_2_0._onDragBegin, arg_2_0)
	arg_2_0._drag:AddDragEndListener(arg_2_0._onDragEnd, arg_2_0)
	arg_2_0._drag:AddDragListener(arg_2_0._onDrag, arg_2_0)

	if arg_2_0._btninteract then
		arg_2_0._btninteract:AddClickListener(arg_2_0.onInteract, arg_2_0)
		V1a6_CachotController.instance:registerCallback(V1a6_CachotEvent.NearEventMoChange, arg_2_0._onNearEventChange, arg_2_0)
		V1a6_CachotController.instance:registerCallback(V1a6_CachotEvent.ClickNearEvent, arg_2_0.onInteract, arg_2_0)
	end

	ViewMgr.instance:registerCallback(ViewEvent.OnOpenView, arg_2_0.cancelDrag, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	arg_3_0._drag:RemoveDragBeginListener()
	arg_3_0._drag:RemoveDragEndListener()
	arg_3_0._drag:RemoveDragListener()

	if arg_3_0._btninteract then
		arg_3_0._btninteract:RemoveClickListener()
		V1a6_CachotController.instance:unregisterCallback(V1a6_CachotEvent.NearEventMoChange, arg_3_0._onNearEventChange, arg_3_0)
		V1a6_CachotController.instance:unregisterCallback(V1a6_CachotEvent.ClickNearEvent, arg_3_0.onInteract, arg_3_0)
	end

	ViewMgr.instance:unregisterCallback(ViewEvent.OnOpenView, arg_3_0.cancelDrag, arg_3_0)
end

function var_0_0.onOpen(arg_4_0)
	arg_4_0:_onNearEventChange()

	arg_4_0._iconCanvasGroup.alpha = 0.5

	TaskDispatcher.runRepeat(arg_4_0._checkInput, arg_4_0, 0, -1)
end

function var_0_0.onClose(arg_5_0)
	TaskDispatcher.cancelTask(arg_5_0._checkInput, arg_5_0)
	TaskDispatcher.cancelTask(arg_5_0._delayTriggerEvent, arg_5_0)
	UIBlockMgr.instance:endBlock("BeginTriggerEvent")

	V1a6_CachotRoomModel.instance.isLockPlayerMove = false
end

function var_0_0._onDragBegin(arg_6_0)
	arg_6_0._beginDrag = true
	arg_6_0._iconCanvasGroup.alpha = 1
end

function var_0_0._onDragEnd(arg_7_0)
	arg_7_0:cancelDrag()

	arg_7_0._beginDrag = false
end

function var_0_0._onDrag(arg_8_0, arg_8_1, arg_8_2)
	if not arg_8_0._beginDrag then
		return
	end

	local var_8_0 = recthelper.screenPosToAnchorPos(arg_8_2.position, arg_8_0._goCtrl.transform)
	local var_8_1 = Mathf.Clamp(var_8_0.x, -180, 180)

	recthelper.setAnchorX(arg_8_0._iconTrans, var_8_1)

	if var_8_1 <= 10 and var_8_1 >= -10 then
		arg_8_0._dragValue = nil

		return
	end

	arg_8_0._dragValue = var_8_1 > 0 and 1 or -1
end

function var_0_0._checkInput(arg_9_0)
	local var_9_0 = 0

	if UnityEngine.Input.GetKey(UnityEngine.KeyCode.LeftArrow) or UnityEngine.Input.GetKey(UnityEngine.KeyCode.A) then
		var_9_0 = -1
	elseif UnityEngine.Input.GetKey(UnityEngine.KeyCode.RightArrow) or UnityEngine.Input.GetKey(UnityEngine.KeyCode.D) then
		var_9_0 = 1
	end

	if var_9_0 ~= 0 and not arg_9_0._beginDrag then
		arg_9_0:onPlayerMove(var_9_0)
	elseif arg_9_0._beginDrag and arg_9_0._dragValue then
		arg_9_0:onPlayerMove(arg_9_0._dragValue)
	else
		V1a6_CachotRoomModel.instance:setIsMoving(false)
	end

	if UnityEngine.Input.GetKeyDown(UnityEngine.KeyCode.Return) then
		arg_9_0:onInteract()
	end
end

function var_0_0.onPlayerMove(arg_10_0, arg_10_1)
	if not arg_10_0:canMove() then
		V1a6_CachotRoomModel.instance:setIsMoving(false)

		return
	end

	V1a6_CachotRoomModel.instance:setIsMoving(true)
	V1a6_CachotController.instance:dispatchEvent(V1a6_CachotEvent.PlayerMove, arg_10_1)
end

function var_0_0._onNearEventChange(arg_11_0)
	if not arg_11_0._gouninteract then
		return
	end

	local var_11_0 = V1a6_CachotRoomModel.instance:getNearEventMo()

	gohelper.setActive(arg_11_0._gouninteract, not var_11_0)
	gohelper.setActive(arg_11_0._gointeract, var_11_0)

	if var_11_0 then
		V1a6_CachotCollectionController.instance:dispatchEvent(V1a6_CachotEvent.GuideNearEvent)
	end
end

function var_0_0.onInteract(arg_12_0)
	local var_12_0 = V1a6_CachotRoomModel.instance:getNearEventMo()

	if not var_12_0 then
		return
	end

	if V1a6_CachotRoomModel.instance.isLockPlayerMove then
		return false
	end

	UIBlockMgr.instance:startBlock("BeginTriggerEvent")
	V1a6_CachotController.instance:dispatchEvent(V1a6_CachotEvent.BeginTriggerEvent, var_12_0)

	V1a6_CachotRoomModel.instance.isLockPlayerMove = true

	TaskDispatcher.runDelay(arg_12_0._delayTriggerEvent, arg_12_0, 1.067)
end

function var_0_0._delayTriggerEvent(arg_13_0)
	local var_13_0 = V1a6_CachotRoomModel.instance:getNearEventMo()

	if not var_13_0 then
		return
	end

	UIBlockMgr.instance:endBlock("BeginTriggerEvent")

	V1a6_CachotRoomModel.instance.isLockPlayerMove = false

	V1a6_CachotController.instance:dispatchEvent(V1a6_CachotEvent.TriggerEvent)

	local var_13_1 = V1a6_CachotRoomModel.instance:getNowBattleEventMo()

	if var_13_1 then
		V1a6_CachotController.instance:dispatchEvent(V1a6_CachotEvent.PlayerTriggerInteract, var_13_1)
	else
		RogueRpc.instance:sendRogueEventStartRequest(V1a6_CachotEnum.ActivityId, var_13_0.eventId)
	end
end

function var_0_0.canMove(arg_14_0)
	if V1a6_CachotRoomModel.instance.isLockPlayerMove then
		return false
	end

	local var_14_0 = PopupController.instance:getPopupCount()

	if var_14_0 == 1 and ViewMgr.instance:isOpen(ViewName.GuideView) then
		return true
	end

	if var_14_0 > 0 then
		return false
	end

	return ViewHelper.instance:checkViewOnTheTop(ViewName.V1a6_CachotRoomView) or ViewHelper.instance:checkViewOnTheTop(ViewName.V1a6_CachotMainView)
end

function var_0_0.cancelDrag(arg_15_0)
	if not arg_15_0._beginDrag then
		return
	end

	arg_15_0._beginDrag = nil
	arg_15_0._dragValue = nil
	arg_15_0._iconCanvasGroup.alpha = 0.5

	recthelper.setAnchorX(arg_15_0._iconTrans, 0)
end

return var_0_0
