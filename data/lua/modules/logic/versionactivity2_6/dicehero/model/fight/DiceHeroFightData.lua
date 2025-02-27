module("modules.logic.versionactivity2_6.dicehero.model.fight.DiceHeroFightData", package.seeall)

slot0 = class("DiceHeroFightData")

function slot0.ctor(slot0, slot1)
	slot0:init(slot1)
end

function slot0.init(slot0, slot1)
	slot0.round = slot1.round
	slot0.status = slot1.status
	slot0.allyHero = DiceHeroFightEntityMo.New()

	slot0.allyHero:init(slot1.allyHero)

	if slot0.allyHero.id ~= 0 then
		slot0.allyHero.co = lua_dice_character.configDict[slot0.allyHero.id]
	end

	slot0.enemyHeros = {}
	slot0.enemyHerosByUid = slot0.enemyHerosByUid or {}

	for slot5, slot6 in ipairs(slot1.enemyHeros) do
		slot0.enemyHeros[slot5] = slot0.enemyHerosByUid[slot6.uid] or DiceHeroFightEntityMo.New()

		slot0.enemyHeros[slot5]:init(slot6)

		slot0.enemyHerosByUid[slot6.uid] = slot0.enemyHeros[slot5]

		slot0.enemyHeros[slot5]:clearBehavior()

		if slot0.enemyHeros[slot5].id ~= 0 then
			slot0.enemyHeros[slot5].co = lua_dice_enemy.configDict[slot0.enemyHeros[slot5].id]
		end
	end

	slot0.skillCards = {}
	slot0.heroSkillCards = {}
	slot0.skillCardsBySkillId = slot0.skillCardsBySkillId or {}

	for slot5, slot6 in ipairs(slot1.skillCards) do
		slot7 = slot0.skillCardsBySkillId[slot6.skillId] or DiceHeroFightSkillCardMo.New()

		slot7:init(slot6, slot0.round)

		slot0.skillCardsBySkillId[slot6.skillId] = slot7

		if slot7.co.type == DiceHeroEnum.CardType.Hero then
			table.insert(slot0.heroSkillCards, slot7)
		else
			table.insert(slot0.skillCards, slot7)
		end
	end

	slot0.allyHero:setSkills(slot0.heroSkillCards)

	slot0.diceBox = DiceHeroFightDiceBoxMo.New()

	slot0.diceBox:init(slot1.diceBox)

	slot0.confirmed = slot1.confirmed

	for slot5, slot6 in ipairs(slot1.behaviors) do
		if slot0.enemyHerosByUid[slot6.fromId] then
			slot0.enemyHerosByUid[slot6.fromId]:addBehavior(slot6, slot0.allyHero.uid)
		end
	end

	slot0.curSelectCardMo = nil
	slot0.curSelectEnemyMo = nil

	for slot5, slot6 in ipairs(slot0.skillCards) do
		slot6:initMatchDices(slot0.diceBox.dices, slot0.allyHero:isMixDice())
	end

	DiceHeroController.instance:dispatchEvent(DiceHeroEvent.SkillCardSelectChange)

	slot0._autoSelectEnemyUid = slot0._autoSelectEnemyUid
end

function slot0.setCurSelectCard(slot0, slot1)
	if slot0.curSelectCardMo then
		slot0.curSelectCardMo:clearSelects()
	end

	slot0.curSelectEnemyMo = nil
	slot0.curSelectCardMo = slot1

	if slot0.curSelectCardMo and slot0.curSelectCardMo.co.aim1 == DiceHeroEnum.SkillCardTargetType.SingleEnemy then
		if not slot0.enemyHerosByUid[slot0._autoSelectEnemyUid] or slot2.hp <= 0 then
			slot0._autoSelectEnemyUid = nil
			slot2 = nil
		else
			slot0.curSelectEnemyMo = slot2
		end

		if not slot2 then
			for slot6, slot7 in ipairs(slot0.enemyHeros) do
				if slot7.hp > 0 then
					slot0.curSelectEnemyMo = slot7
					slot0._autoSelectEnemyUid = slot7.uid

					break
				end
			end
		end
	end

	DiceHeroController.instance:dispatchEvent(DiceHeroEvent.SkillCardSelectChange)
end

function slot0.getCardMoBySkillId(slot0, slot1)
	return slot0.skillCardsBySkillId[slot1]
end

function slot0.onStepEnd(slot0)
	for slot4, slot5 in ipairs(slot0.skillCards) do
		slot5:initMatchDices(slot0.diceBox.dices, slot0.allyHero:isMixDice())
	end

	slot0:setCurSelectCard(nil)
end

function slot0.setCurEnemy(slot0, slot1)
	if not slot0.curSelectCardMo or slot0.curSelectCardMo.co.aim1 ~= DiceHeroEnum.SkillCardTargetType.SingleEnemy then
		return
	end

	if slot1 and slot1.hp == 0 then
		return
	end

	slot0.curSelectEnemyMo = slot1
	slot0._autoSelectEnemyUid = slot1.uid

	DiceHeroController.instance:dispatchEvent(DiceHeroEvent.EnemySelectChange)
end

return slot0
