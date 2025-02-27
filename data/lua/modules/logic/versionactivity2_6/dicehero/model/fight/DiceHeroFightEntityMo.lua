module("modules.logic.versionactivity2_6.dicehero.model.fight.DiceHeroFightEntityMo", package.seeall)

slot0 = pureTable("DiceHeroFightEntityMo")

function slot0.init(slot0, slot1)
	slot0.uid = slot1.uid
	slot0.id = slot1.id
	slot0.status = slot1.status
	slot0.hp = tonumber(slot1.hp) or 0
	slot0.shield = tonumber(slot1.shield) or 0
	slot0.power = tonumber(slot1.power) or 0
	slot0.maxHp = tonumber(slot1.maxHp) or 0
	slot0.maxShield = tonumber(slot1.maxShield) or 0
	slot0.maxPower = tonumber(slot1.maxPower) or 0
	slot0.buffs = {}
	slot0.buffsByUid = {}

	if slot0.hp > 0 then
		for slot5, slot6 in ipairs(slot1.buffContainer.buffs) do
			slot7 = DiceHeroFightBuffMo.New()

			slot7:init(slot6)

			if slot7.co.visible == 1 then
				table.insert(slot0.buffs, slot7)
			end

			slot0.buffsByUid[slot6.uid] = slot7
		end
	end

	slot0.relicIds = slot1.relicIds
	slot0.behaviors = {}
end

function slot0.setHp(slot0, slot1)
	slot0.hp = slot1

	if slot0.hp <= 0 then
		slot0.behaviors = {}
		slot0.buffs = {}
		slot0.buffsByUid = {}
	end
end

function slot0.setSkills(slot0, slot1)
	slot0.skills = slot1
end

function slot0.clearBehavior(slot0)
	slot0.behaviors = {}
end

function slot0.addBehavior(slot0, slot1, slot2)
	if slot0.hp <= 0 then
		return
	end

	if not slot0.behaviors.type then
		slot0:setBehaviorData(slot0.behaviors, slot1, slot2)
	else
		slot0.behaviors.exList = slot0.behaviors.exList or {}
		slot3 = {}

		slot0:setBehaviorData(slot3, slot1, slot2)
		table.insert(slot0.behaviors.exList, slot3)
	end
end

function slot0.setBehaviorData(slot0, slot1, slot2, slot3)
	slot1.type = slot2.type
	slot1.value = slot2.value
	slot1.isToSelf = slot2.fromId == slot2.targetIds[1]
	slot1.isToHero = slot3 == slot2.targetIds[1]
	slot1.isToAll = #slot2.targetIds > 1
	slot1.isToFriend = not slot1.isToAll and not slot1.isToSelf and not slot1.isToHero
end

function slot0.isMixDice(slot0)
	for slot4, slot5 in pairs(slot0.buffsByUid) do
		if slot5.co.effect == DiceHeroEnum.SkillEffectType.DiceMix then
			return true
		end
	end

	return false
end

function slot0.isBanSkillCard(slot0, slot1)
	for slot5, slot6 in pairs(slot0.buffsByUid) do
		if slot6.co.effect == DiceHeroEnum.SkillEffectType.BanSkillCard then
			slot7 = tonumber(slot6.co.param) or 0

			return slot7 == slot1 or slot7 == 0
		end
	end

	return false
end

function slot0.addOrUpdateBuff(slot0, slot1)
	if slot0.hp <= 0 then
		return
	end

	if slot0.buffsByUid[slot1.uid] then
		slot0.buffsByUid[slot1.uid]:init(slot1)
	else
		slot2 = DiceHeroFightBuffMo.New()

		slot2:init(slot1)

		slot0.buffsByUid[slot1.uid] = slot2

		if slot2.co.visible == 1 then
			table.insert(slot0.buffs, slot2)
		end
	end
end

function slot0.isAddLayer(slot0, slot1)
	if not slot0.buffsByUid[slot1.uid] then
		return true
	end

	return slot2.layer < slot1.layer
end

function slot0.removeBuff(slot0, slot1)
	if slot0.buffsByUid[slot1] then
		tabletool.removeValue(slot0.buffs, slot0.buffsByUid[slot1])

		slot0.buffsByUid[slot1] = nil
	end
end

function slot0.canUseHeroSkill(slot0)
	if slot0.power < slot0.maxPower then
		return false
	end

	if slot0:isBanSkillCard(DiceHeroEnum.CardType.Hero) then
		return false
	end

	if not slot0.skills then
		return false
	end

	for slot4, slot5 in ipairs(slot0.skills) do
		if slot5.co.spiritskilltype == DiceHeroEnum.HeroCardType.ActiveSkill then
			return true
		end
	end

	return false
end

function slot0.canUsePassiveSkill(slot0)
	if slot0.power <= 0 then
		return
	end

	if slot0:isBanSkillCard(DiceHeroEnum.CardType.Hero) then
		return false
	end

	if not slot0.skills then
		return false
	end

	for slot4, slot5 in ipairs(slot0.skills) do
		if slot5.co.spiritskilltype == DiceHeroEnum.HeroCardType.PassiveSkill then
			return true
		end
	end

	return false
end

function slot0.haveBuff2(slot0)
	for slot4, slot5 in pairs(slot0.buffsByUid) do
		if slot5.co.id == 2 then
			return true
		end
	end

	return false
end

return slot0
