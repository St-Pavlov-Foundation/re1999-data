module("modules.logic.versionactivity2_7.lengzhou6.model.buff.BuffBase", package.seeall)

slot0 = class("BuffBase")

function slot0.ctor(slot0)
	slot0._id = 0
	slot0._configId = 0
	slot0._layerCount = 0
	slot0._addLimit = 1
end

function slot0.init(slot0, slot1, slot2)
	slot0._id = slot1
	slot0.config = LengZhou6Config.instance:getEliminateBattleBuff(slot2)
	slot0._addLimit = slot0.config.limit
	slot0._configId = slot2
	slot0._triggerPoint = slot0.config.triggerPoint
	slot0._layerCount = 1
	slot0._effect = slot0.config.effect
end

function slot0.getBuffEffect(slot0)
	return slot0._effect
end

function slot0.getLayerCount(slot0)
	return slot0._layerCount
end

function slot0.addCount(slot0, slot1)
	slot0._layerCount = math.max(0, math.min(slot0._layerCount + slot1, slot0._addLimit))
end

function slot0.execute(slot0)
	return true
end

return slot0
