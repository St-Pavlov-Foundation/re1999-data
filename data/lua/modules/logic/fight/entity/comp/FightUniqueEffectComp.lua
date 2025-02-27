module("modules.logic.fight.entity.comp.FightUniqueEffectComp", package.seeall)

slot0 = class("FightUniqueEffectComp", LuaCompBase)

function slot0.ctor(slot0, slot1)
	slot0.entity = slot1
	slot0.entityId = slot0.entity.id
	slot0.existEffectWrapDict = {}
	slot0.releaseEffectDict = {}
	slot0.updateHandle = UpdateBeat:CreateListener(slot0.update, slot0)

	UpdateBeat:AddListener(slot0.updateHandle)
end

function slot0.onDestroy(slot0)
	if slot0.updateHandle then
		UpdateBeat:RemoveListener(slot0.updateHandle)
	end
end

function slot0.addHangEffect(slot0, slot1, slot2, slot3, slot4)
	if slot0.existEffectWrapDict[slot1] then
		return slot5
	end

	slot5 = slot0.entity.effect:addHangEffect(slot1, slot2, slot3)

	FightRenderOrderMgr.instance:onAddEffectWrap(slot0.entityId, slot5)

	slot0.existEffectWrapDict[slot1] = slot5

	if slot4 then
		slot0:releaseEffectAfterTime(slot1, slot4)
	end

	return slot5
end

function slot0.addGlobalEffect(slot0, slot1, slot2, slot3)
	if slot0.existEffectWrapDict[slot1] then
		return
	end

	slot4 = slot0.entity.effect:addGlobalEffect(slot1, slot2)

	FightRenderOrderMgr.instance:onAddEffectWrap(slot0.entityId, slot4)

	slot0.existEffectWrapDict[slot1] = slot4

	if slot3 then
		slot0:releaseEffectAfterTime(slot1, slot3)
	end

	return slot4
end

function slot0.releaseEffectAfterTime(slot0, slot1, slot2)
	slot0.releaseEffectDict[slot1] = Time.realtimeSinceStartup + slot2
end

function slot0.update(slot0)
	for slot5, slot6 in pairs(slot0.releaseEffectDict) do
		if slot6 <= Time.realtimeSinceStartup then
			slot0:removeEffect(slot5)
		end
	end
end

function slot0.removeEffect(slot0, slot1)
	if not slot0.existEffectWrapDict[slot1] then
		return
	end

	slot0.existEffectWrapDict[slot1] = nil
	slot0.releaseEffectDict[slot1] = nil

	FightRenderOrderMgr.instance:onRemoveEffectWrap(slot0.entityId, slot2)
	slot0.entity.effect:removeEffect(slot2)
end

return slot0
