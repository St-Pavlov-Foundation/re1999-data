module("modules.logic.fight.model.data.FightBuffInfoData", package.seeall)

slot0 = FightDataClass("FightBuffInfoData")

function slot0.onConstructor(slot0, slot1, slot2)
	slot0.time = tonumber(slot1.uid)
	slot0.entityId = slot2
	slot0.buffId = slot1.buffId
	slot0.duration = slot1.duration
	slot0.uid = slot1.uid
	slot0.exInfo = slot1.exInfo
	slot0.fromUid = slot1.fromUid
	slot0.count = slot1.count
	slot0.actCommonParams = slot1.actCommonParams
	slot0.layer = slot1.layer
	slot0.type = slot1.type

	if not slot0:getCO() then
		logError("buff表找不到id:" .. slot0.buffId)
	end

	slot0.name = slot3 and slot3.name or ""
	slot0.clientNum = 0
end

function slot0.clone(slot0)
	slot1 = uv0.New(slot0)
	slot1.clientNum = slot0.clientNum
	slot0._last_clone_mo = slot1

	return slot1
end

function slot0.getCO(slot0)
	return lua_skill_buff.configDict[slot0.buffId]
end

function slot0.setClientNum(slot0, slot1)
	slot0.clientNum = slot1
end

return slot0
