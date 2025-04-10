module("modules.logic.tower.model.TowerBossTeachModel", package.seeall)

slot0 = class("TowerBossTeachModel", BaseModel)

function slot0.onInit(slot0)
	slot0.lastFightTeachId = 0
end

function slot0.reInit(slot0)
	slot0.lastFightTeachId = 0
end

function slot0.isAllEpisodeFinish(slot0, slot1)
	slot2 = TowerConfig.instance:getAssistBossConfig(slot1)
	slot4 = TowerModel.instance:getTowerInfoById(TowerEnum.TowerType.Boss, slot2.towerId)

	for slot8, slot9 in ipairs(TowerConfig.instance:getAllBossTeachConfigList(slot2.towerId)) do
		if slot4 and not slot4:isPassBossTeach(slot9.teachId) then
			return false
		end
	end

	return true
end

function slot0.getTeachFinishEffectSaveKey(slot0, slot1)
	return string.format("%s_%s", TowerEnum.LocalPrefsKey.TowerBossTeachFinishEffect, slot1)
end

function slot0.setLastFightTeachId(slot0, slot1)
	slot0.lastFightTeachId = slot1
end

function slot0.getLastFightTeachId(slot0)
	return slot0.lastFightTeachId
end

function slot0.getFirstUnFinishTeachId(slot0, slot1)
	slot2 = TowerConfig.instance:getAssistBossConfig(slot1)
	slot4 = TowerModel.instance:getTowerInfoById(TowerEnum.TowerType.Boss, slot2.towerId)

	for slot8, slot9 in ipairs(TowerConfig.instance:getAllBossTeachConfigList(slot2.towerId)) do
		if slot4 and not slot4:isPassBossTeach(slot9.teachId) then
			return slot9.teachId
		end
	end

	return slot3[1].teachId
end

slot0.instance = slot0.New()

return slot0
