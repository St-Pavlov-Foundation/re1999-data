module("modules.logic.versionactivity2_7.lengzhou6.model.entity.EntityBase", package.seeall)

slot0 = class("EntityBase")

function slot0.ctor(slot0)
	slot0._hp = 0
	slot0._skills = {}
	slot0._buffs = {}
	slot0._configId = 0
	slot0._damageComp = nil
	slot0._treatmentComp = nil
	slot0._camp = -1
	slot0._icon = ""
	slot0._name = ""
end

function slot0.init(slot0, slot1, slot2, slot3)
	slot0._configId = slot1

	slot0:initByConfig()
end

function slot0.initByConfig(slot0)
end

function slot0.changeHp(slot0, slot1)
	slot0._hpDiff = slot1
	slot0._hp = math.max(0, slot0._hp + slot1)
end

function slot0.getCurDiff(slot0)
	return slot0._hpDiff
end

function slot0.getHp(slot0)
	return slot0._hp
end

function slot0.setHp(slot0, slot1)
	slot0._hp = slot1
end

function slot0.getConfigId(slot0)
	return slot0._configId
end

function slot0.getDamageComp(slot0)
	return slot0._damageComp
end

function slot0.getTreatmentComp(slot0)
	return slot0._treatmentComp
end

function slot0.triggerBuffAndSkill(slot0)
	if slot0._skills then
		for slot4 = 1, #slot0._skills do
			if slot0._skills[slot4] ~= nil and slot5:getSkillType() == LengZhou6Enum.SkillType.passive then
				slot5:execute()
			end
		end
	end

	if slot0._buffs then
		for slot4 = 1, #slot0._buffs do
			if slot0._buffs[slot4] ~= nil then
				slot5:execute()
			end
		end
	end
end

function slot0.getCamp(slot0)
	return slot0._camp
end

function slot0.calDamage(slot0)
end

function slot0.calTreatment(slot0)
end

function slot0.getIcon(slot0)
	return slot0._icon
end

function slot0.getName(slot0)
	return slot0._name
end

function slot0.addBuff(slot0, slot1)
	table.insert(slot0._buffs, slot1)
end

function slot0.getBuffByConfigId(slot0, slot1)
	for slot5 = 1, #slot0._buffs do
		if slot0._buffs[slot5]._configId == slot1 then
			return slot6
		end
	end

	return nil
end

function slot0.getBuffs(slot0)
	return slot0._buffs
end

function slot0.clear(slot0)
	slot0._hp = nil
	slot0._configId = nil

	if slot0._skills ~= nil then
		tabletool.clear(slot0._skills)

		slot0._skills = nil
	end

	if slot0._buffs ~= nil then
		tabletool.clear(slot0._buffs)

		slot0._buffs = nil
	end

	slot0._damageComp = nil
	slot0._treatmentComp = nil
	slot0._camp = -1
	slot0._icon = nil
	slot0._name = nil
	slot0._config = nil
end

return slot0
