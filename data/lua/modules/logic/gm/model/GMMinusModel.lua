module("modules.logic.gm.model.GMMinusModel", package.seeall)

slot0 = class("GMMinusModel", BaseModel)

function slot0.onInit(slot0)
	slot0:reInit()
end

function slot0.reInit(slot0)
	slot0._firstLoginDataDict = {}
end

function slot0.setFirstLogin(slot0, slot1, slot2)
	slot0._firstLoginDataDict[slot1] = slot2
end

function slot0.getFirstLogin(slot0, slot1, slot2)
	return slot0._firstLoginDataDict[slot1] == nil and slot2 or slot3
end

slot1 = {}
slot2 = {}

function slot0.setConst(slot0, slot1, slot2)
	if uv0[slot1] then
		return
	end

	uv0[slot1] = true
	uv1[slot1] = slot2
end

function slot0.getConst(slot0, slot1, slot2)
	if not uv0[slot1] then
		return slot2
	end

	return uv1[slot1]
end

function slot0.setToPlayer(slot0, slot1, slot2)
	if not PlayerModel.instance:getMyUserId() or slot3 == 0 then
		return
	end

	slot0:setToUnity(slot1 .. "#" .. tostring(slot3), slot2)
end

function slot0.getFromPlayer(slot0, slot1, slot2)
	if not PlayerModel.instance:getMyUserId() or slot3 == 0 then
		return slot2
	end

	return slot0:getFromUnity(slot1 .. "#" .. tostring(slot3), slot2)
end

function slot0.setToUnity(slot0, slot1, slot2)
	PlayerPrefsHelper._set(slot1, slot2)
end

function slot0.getFromUnity(slot0, slot1, slot2)
	assert(slot2 ~= nil)

	return PlayerPrefsHelper._get(slot1, slot2, type(slot2) == "number")
end

slot0.instance = slot0.New()

return slot0
