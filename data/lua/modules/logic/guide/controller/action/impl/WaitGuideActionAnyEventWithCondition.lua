module("modules.logic.guide.controller.action.impl.WaitGuideActionAnyEventWithCondition", package.seeall)

slot0 = class("WaitGuideActionAnyEventWithCondition", BaseGuideAction)

function slot0.onStart(slot0, slot1)
	uv0.super.onStart(slot0, slot1)

	if slot0:commonCheck(string.split(slot0.actionParam, "#")[1]) then
		slot0:onDone(true)

		return
	end

	slot5 = slot2[3]
	slot6 = slot2[4]
	slot0._param = slot2[5]
	slot0._controller = _G[slot2[2]]

	if not slot0._controller then
		logError("WaitGuideActionAnyEventWithCondition controllerName error:" .. tostring(slot4))

		return
	end

	slot0._eventModule = _G[slot5]

	if not slot0._eventModule then
		logError("WaitGuideActionAnyEventWithCondition eventModuleName error:" .. tostring(slot5))

		return
	end

	slot0._eventName = slot0._eventModule[slot6]

	if not slot0._eventName then
		logError("WaitGuideActionAnyEventWithCondition eventName error:" .. tostring(slot6))

		return
	end

	slot0._controller.instance:registerCallback(slot0._eventName, slot0._onReceiveEvent, slot0)
end

function slot0.commonCheck(slot0, slot1)
	if not slot1 then
		return false
	end

	if not _G[string.split(slot1, "_")[1]] then
		return false
	end

	if not slot3[slot2[2]] then
		return false
	end

	if slot3.instance then
		return slot4(slot3.instance, unpack(slot2, 3))
	else
		return slot4(unpack(slot2, 3))
	end
end

function slot0._onReceiveEvent(slot0, slot1)
	if slot0:checkGuideLock() then
		return
	end

	slot3 = false

	if type(slot1) == "number" then
		slot1 = tostring(slot1)
	elseif slot2 == "boolean" then
		slot1 = tostring(slot1)
	elseif slot2 == "function" then
		slot3 = slot1(slot0._param)
	end

	if not slot3 and slot0._param and slot0._param ~= slot1 then
		return
	end

	slot0._controller.instance:unregisterCallback(slot0._eventName, slot0._onReceiveEvent, slot0)
	slot0:onDone(true)
end

function slot0.clearWork(slot0)
	if slot0._controller then
		slot0._controller.instance:unregisterCallback(slot0._eventName, slot0._onReceiveEvent, slot0)
	end
end

return slot0
