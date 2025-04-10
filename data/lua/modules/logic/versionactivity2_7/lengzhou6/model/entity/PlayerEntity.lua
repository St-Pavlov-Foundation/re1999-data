module("modules.logic.versionactivity2_7.lengzhou6.model.entity.PlayerEntity", package.seeall)

slot0 = class("PlayerEntity", EntityBase)

function slot0.ctor(slot0)
	uv0.super.ctor(slot0)

	slot0._camp = LengZhou6Enum.entityCamp.player
	slot0._activeSkill = {}
end

function slot0.init(slot0, slot1, slot2, slot3)
	uv0.super.init(slot0, slot1, slot2, slot3)

	slot0._damageComp = EliminateDamageComp.New()
	slot0._treatmentComp = EliminateTreatmentComp.New()
end

function slot0.initByConfig(slot0)
	slot0._config = LengZhou6Config.instance:getEliminateBattleCharacter(slot0._configId)
	slot0._icon = slot0._config.icon
	slot0._name = slot0._config.name

	slot0:setHp(slot0:getRealConfigHp())
	slot0:_initDefaultSkill()
	LocalEliminateChessModel.instance:resetCreateWeight()
	slot0:createAndInitPlayerSkill(slot0._config.skill)
end

function slot0.getRealConfigHp(slot0)
	return LengZhou6Enum.enterGM and LengZhou6Enum.DebugPlayerHp or slot0._config.hp
end

function slot0.changeHp(slot0, slot1)
	slot0._hpDiff = slot1
	slot0._hp = math.max(0, math.min(slot0._hp + slot1, slot0:getRealConfigHp()))
end

function slot0.resetData(slot0, slot1)
	if slot0._damageComp ~= nil then
		slot0._damageComp:reset()
	end

	if slot0._treatmentComp ~= nil then
		slot0._treatmentComp:reset()
	end

	if slot0._skills ~= nil then
		tabletool.clear(slot0._skills)
	end

	if slot0._buffs ~= nil then
		tabletool.clear(slot0._buffs)
	end

	slot0:_initDefaultSkill()
	LocalEliminateChessModel.instance:resetCreateWeight()

	for slot5 = 1, #slot1 do
		slot0:createAndInitPlayerSkill(slot1[slot5])
	end

	tabletool.clear(slot0._activeSkill)
end

function slot0.createAndInitPlayerSkill(slot0, slot1)
	if slot1 == nil or slot1 == 0 then
		return
	end

	slot0:_addSkill(slot1)
	slot0:initSpecialAttrBySkillId(slot1)
	LengZhou6StatHelper.instance:addUseSkillId(slot1)
end

function slot0._initDefaultSkill(slot0)
	for slot4 = 1, 4 do
		slot0:_addSkill(LengZhou6Config.instance:getEliminateBattleCost(slot4))
	end
end

function slot0._addSkill(slot0, slot1)
	table.insert(slot0._skills, LengZhou6SkillUtils.instance.createSkill(slot1))
end

function slot0.initSpecialAttrBySkillId(slot0, slot1)
	if LengZhou6Config.instance:getAllSpecialAttr() == nil then
		return
	end

	for slot6, slot7 in pairs(slot2) do
		if slot6 == slot1 then
			if slot7.effect == "fixColorWeight" then
				LocalEliminateChessModel.instance:changeCreateWeight(slot7.chessType, slot7.value)
			end
		end
	end
end

function slot0.getActiveSkills(slot0)
	if slot0._activeSkill == nil then
		slot0._activeSkill = {}
	end

	if #slot0._activeSkill == 0 then
		for slot4 = 1, #slot0._skills do
			if slot0._skills[slot4]:getSkillType() == LengZhou6Enum.SkillType.active or slot5:getSkillType() == LengZhou6Enum.SkillType.passive and not LengZhou6Config.instance:isPlayerChessPassive(slot5:getConfig().id) then
				table.insert(slot0._activeSkill, slot5)
			end
		end
	end

	return slot0._activeSkill
end

function slot0.updateActiveSkillCD(slot0)
	if slot0._activeSkill == nil then
		return
	end

	for slot4 = 1, #slot0._activeSkill do
		slot0._activeSkill[slot4]:updateCD()
	end
end

function slot0.calDamage(slot0, slot1)
	return slot0._damageComp:damage(slot1)
end

function slot0.calTreatment(slot0, slot1)
	return slot0._treatmentComp:treatment(slot1)
end

function slot0.clearActiveSkillAndSkill(slot0)
	if slot0._activeSkill ~= nil then
		tabletool.clear(slot0._activeSkill)

		slot0._activeSkill = nil
	end

	if slot0._skills ~= nil then
		tabletool.clear(slot0._skills)
	end
end

function slot0.clear(slot0)
	uv0.super.clear(slot0)
	slot0:clearActiveSkill()
end

return slot0
