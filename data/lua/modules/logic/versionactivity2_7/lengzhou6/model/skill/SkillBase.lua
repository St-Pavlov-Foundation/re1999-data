module("modules.logic.versionactivity2_7.lengzhou6.model.skill.SkillBase", package.seeall)

slot0 = class("SkillBase")

function slot0.ctor(slot0)
	slot0._id = 0
	slot0._configId = 0
	slot0._cd = 0
	slot0._entity = nil
	slot0._skillType = LengZhou6Enum.SkillType.passive
end

function slot0.init(slot0, slot1, slot2)
	slot0._id = slot1
	slot0._configId = slot2
	slot0._config = LengZhou6Config.instance:getEliminateBattleSkill(slot2)
	slot0._cd = slot0._config.cd

	slot0:_initEffect()
end

function slot0.getConfig(slot0)
	return slot0._config
end

function slot0.getConfigId(slot0)
	return slot0._configId
end

function slot0._initEffect(slot0)
	slot0._triggerPoint = slot0._config.triggerPoint

	if not string.nilorempty(slot0._config.effect) then
		slot0._effect = string.split(slot1, "#")
	end
end

function slot0.getEffect(slot0)
	return slot0._effect
end

function slot0.initEntity(slot0, slot1)
	slot0._entity = slot1
end

function slot0.getEntityCamp(slot0)
	if slot0._entity then
		return slot0._entity:getCamp()
	end

	return -1
end

function slot0.getSkillType(slot0)
	return slot0._skillType
end

function slot0.getCd(slot0)
	return slot0._cd
end

function slot0.setCd(slot0, slot1)
	slot0._cd = slot1

	if slot0._cd < 0 then
		slot0._cd = 0
	end
end

function slot0.updateCD(slot0)
	slot0._cd = slot0._cd - 1

	if slot0._cd < 0 then
		slot0._cd = 0
	end
end

function slot0.execute(slot0)
	if slot0._cd == 0 then
		slot0._cd = slot0._config.cd

		return true
	end
end

return slot0
