module("modules.logic.common.view.VirtualFixedJoystick", package.seeall)

slot0 = class("VirtualFixedJoystick", LuaCompBase)
slot1 = 1
slot2 = 0.5
slot3 = 0

function slot0.init(slot0, slot1)
	slot0.go = slot1
	slot0._gobg = gohelper.findChild(slot0.go, "#go_background")
	slot0._transbg = slot0._gobg.transform
	slot0._transbg.pivot.x = uv0
	slot0._transbg.pivot.y = uv0
	slot0._radius = slot0._transbg.sizeDelta.x / 2
	slot0._gohandle = gohelper.findChild(slot0.go, "#go_background/#go_handle")
	slot0._transhandle = slot0._gohandle.transform
	slot0._transhandle.anchorMin.x = uv0
	slot0._transhandle.anchorMin.y = uv0
	slot0._transhandle.anchorMax.x = uv0
	slot0._transhandle.anchorMax.y = uv0
	slot0._transhandle.pivot.x = uv0
	slot0._transhandle.pivot.y = uv0
	slot0._input = Vector2.zero
	slot0._click = SLFramework.UGUI.UIClickListener.Get(slot0.go)
	slot0._drag = SLFramework.UGUI.UIDragListener.Get(slot0.go)
end

function slot0.addEventListeners(slot0)
	slot0._click:AddClickDownListener(slot0._onClickDown, slot0)
	slot0._drag:AddDragListener(slot0._onDrag, slot0)
	slot0._click:AddClickUpListener(slot0._onClickUp, slot0)
end

function slot0.removeEventListeners(slot0)
	slot0._click:RemoveClickDownListener()
	slot0._drag:RemoveDragListener()
	slot0._click:RemoveClickUpListener()
end

function slot0._onClickDown(slot0, slot1, slot2, slot3)
	if slot0._dragging then
		return
	end

	slot0._dragging = true

	slot0:_handleInput(slot2)
end

function slot0._onDrag(slot0, slot1, slot2)
	if not slot0._dragging then
		return
	end

	slot0:_handleInput(slot2.position)
end

function slot0._handleInput(slot0, slot1)
	slot2, slot3 = recthelper.screenPosToAnchorPos2(slot1, slot0._transbg)

	slot0:setInPutValue((slot2 - uv0) / slot0._radius, (slot3 - uv0) / slot0._radius)
end

function slot0._onClickUp(slot0, slot1, slot2, slot3)
	if not slot0._dragging then
		return
	end

	slot0:reset()
end

function slot0.setInPutValue(slot0, slot1, slot2)
	slot0._input.x = slot1 or uv0
	slot0._input.y = slot2 or uv0

	if uv1 < slot0._input.magnitude then
		slot0._input = slot0._input.normalized
	end

	slot0:refreshHandlePos()
end

function slot0.refreshHandlePos(slot0)
	transformhelper.setLocalPosXY(slot0._transhandle, GameUtil.clamp(slot0._input.x * slot0._radius, -slot0._radius, slot0._radius), GameUtil.clamp(slot0._input.y * slot0._radius, -slot0._radius, slot0._radius))
end

function slot0.getIsDragging(slot0)
	return slot0._dragging
end

function slot0.getInputValue(slot0)
	return slot0._input
end

function slot0.reset(slot0)
	slot0:setInPutValue()

	slot0._dragging = false
end

function slot0.onDestroy(slot0)
end

return slot0
