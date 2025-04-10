module("modules.logic.versionactivity2_7.lengzhou6.model.entity.EnemyEntity", package.seeall)

slot0 = class("EnemyEntity", EntityBase)

function slot0.ctor(slot0)
	uv0.super.ctor(slot0)

	slot0._action = EnemyActionData.New()
	slot0._camp = LengZhou6Enum.entityCamp.enemy
end

function slot0.init(slot0, slot1, slot2, slot3)
	uv0.super.init(slot0, slot1, slot2, slot3)
end

function slot0.initByConfig(slot0)
	slot0._config = LengZhou6Config.instance:getEliminateBattleEnemy(slot0._configId)

	if slot0._config == nil then
		logError("eliminate_battle_enemy config is nil" .. slot0._configId)
	end

	slot0._icon = slot0._config.icon
	slot0._name = slot0._config.name

	slot0:setHp(slot0._config.hp)
	slot0:initAction()

	if not string.nilorempty(slot0._config.loop) then
		slot2 = string.splitToNumber(slot1, "#")

		slot0._action:initLoopIndex(slot2[1], slot2[2])
	end
end

function slot0.initAction(slot0)
	slot0._action:init(slot0._configId)
end

function slot0.setActionStepIndexAndRound(slot0, slot1, slot2)
	if slot0._action ~= nil and slot1 ~= nil and slot2 ~= nil then
		slot0._action:setCurBehaviorId(slot1)
		slot0._action:setCurRound(slot2)
	end
end

function slot0.getCurSkillList(slot0)
	return slot0._action:getCurBehavior() and slot1:getSkillList() or nil
end

function slot0.getAllCanUseSkillId(slot0)
	if slot0._buffs ~= nil then
		for slot4 = 1, #slot0._buffs do
			if slot0._buffs[slot4]:getBuffEffect() == LengZhou6Enum.BuffEffect.petrify and slot5:execute(true) then
				return nil, slot0._action:calCurResidueCd()
			end
		end
	end

	slot0:clearInvalidBuff()

	slot2 = slot0._action:calCurResidueCd()

	if slot0._action:getSkillList() ~= nil then
		for slot6 = 1, #slot1 do
			slot7 = slot1[slot6]
			slot0._skills[slot7._id] = slot7
		end

		slot2 = 0
	end

	return slot1, slot2
end

function slot0.clearInvalidBuff(slot0)
	slot1 = {}

	if slot0._buffs ~= nil then
		for slot5 = 1, #slot0._buffs do
			if slot0._buffs[slot5]:getBuffEffect() == 0 then
				table.insert(slot1, slot5)
			end
		end
	end

	for slot5 = #slot1, 1, -1 do
		if slot0._buffs[slot1[slot5]] ~= nil then
			slot0._buffs[slot6] = nil
		end
	end
end

function slot0.getAction(slot0)
	return slot0._action
end

function slot0.havePoisonBuff(slot0)
	if slot0._buffs then
		for slot4, slot5 in ipairs(slot0._buffs) do
			if slot5._configId == 1001 then
				return true
			end
		end
	end

	return false
end

function slot0.useSkill(slot0, slot1)
	if slot0._skills[slot1] ~= nil then
		slot0._skills[slot1]:execute()
	end

	slot0._skills[slot1] = nil
end

return slot0
