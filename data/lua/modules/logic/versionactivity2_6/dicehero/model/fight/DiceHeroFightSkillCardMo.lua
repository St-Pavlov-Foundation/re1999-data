module("modules.logic.versionactivity2_6.dicehero.model.fight.DiceHeroFightSkillCardMo", package.seeall)

slot0 = pureTable("DiceHeroFightSkillCardMo")

function slot0.init(slot0, slot1, slot2)
	slot0.curSelectUids = slot0.curSelectUids or {}
	slot0.skillId = slot1.skillId
	slot0.curRoundUse = 0

	for slot6, slot7 in ipairs(slot1.roundUseCounts) do
		if slot7.round == slot2 then
			slot0.curRoundUse = slot7.count

			break
		end
	end

	slot0.co = lua_dice_card.configDict[slot0.skillId]

	if not slot0.co then
		logError("dice_card配置不存在" .. slot0.skillId)
	end

	slot0.matchDiceUids = {}

	if slot0.matchNums then
		return
	end

	slot0.matchNums = {}
	slot0.matchDiceRules = {}

	for slot7, slot8 in ipairs(string.splitToNumber(slot0.co.patternlist, "#") or {}) do
		if not lua_dice_pattern.configDict[slot8] then
			logError("dice_pattern配置不存在" .. slot8)
		end

		slot0.matchNums[slot7] = (slot0.matchNums[slot7 - 1] or 0) + #(GameUtil.splitString2(slot9.patternList, true) or {})

		for slot14, slot15 in ipairs(slot10) do
			table.insert(slot0.matchDiceRules, slot15)
		end
	end
end

function slot0.initMatchDices(slot0, slot1, slot2)
	slot0.curSelectUids = {}

	for slot6, slot7 in ipairs(slot0.matchDiceRules) do
		slot11 = DiceHeroConfig.instance:getDicePointDict(slot7[2])

		if not DiceHeroConfig.instance:getDiceSuitDict(slot7[1]) then
			logError("dice_suit配置不存在" .. slot8)
		end

		if not slot11 then
			logError("dice_point配置不存在" .. slot9)
		end

		slot12 = {}

		for slot16, slot17 in ipairs(slot1) do
			if slot0:isMatchDice(slot17, slot10, slot11, slot2) then
				table.insert(slot12, slot17.uid)
			end
		end

		slot0.matchDiceUids[slot6] = slot12
	end
end

function slot0.isMatchDice(slot0, slot1, slot2, slot3, slot4)
	if slot1.deleted or slot1.status == DiceHeroEnum.DiceStatu.HardLock then
		return false
	end

	if not slot3[slot1.num] then
		return false
	end

	for slot9 in pairs(DiceHeroConfig.instance:getDiceSuitDict(slot1.suitId)) do
		if slot2[slot9] then
			return true
		end

		if slot4 and slot9 == DiceHeroEnum.DiceType.Power then
			return true
		end
	end

	return false
end

function slot0.isMatchMin(slot0, slot1)
	if #slot0.matchNums == 0 or #slot0.matchDiceUids == 0 then
		return true, {}
	end

	slot3 = {}
	slot4 = {}
	slot5 = {}

	for slot9 = 1, slot0.matchNums[1] do
		if #slot0.matchDiceUids[slot9] == 0 then
			return false
		end

		slot4[slot9] = slot10
		slot3[slot9] = 1
	end

	slot6 = {}

	while slot3[1] <= slot4[1] do
		for slot10 = 1, slot2 do
			slot5[slot10] = slot0.matchDiceUids[slot10][slot3[slot10]]
		end

		for slot10 = slot2, 1, -1 do
			slot3[slot10] = slot3[slot10] + 1

			if slot4[slot10] < slot3[slot10] and slot10 ~= 1 then
				slot3[slot10] = 1
			else
				break
			end
		end

		if not slot0:isRepeat(slot5) then
			if slot1 then
				table.insert(slot6, slot5)

				slot5 = {}
			else
				return true, slot5
			end
		end
	end

	if slot6[1] then
		if slot6[2] then
			slot7 = DiceHeroFightModel.instance:getGameData().diceBox.dicesByUid

			if slot0.skillId == 19 then
				slot8 = 1
				slot9 = math.huge

				for slot13, slot14 in ipairs(slot6) do
					for slot19, slot20 in ipairs(slot14) do
						slot15 = 0 + slot7[slot20].num
					end

					if slot15 < slot9 then
						slot8 = slot13
						slot9 = slot15
					end
				end

				return true, slot6[slot8]
			end

			slot8 = 1
			slot9 = -1
			slot10 = 0

			for slot14, slot15 in ipairs(slot6) do
				slot17 = 0

				for slot21, slot22 in ipairs(slot15) do
					if DiceHeroEnum.BaseDiceSuitDict[slot0.matchDiceRules[slot21][1]] and DiceHeroEnum.BaseDiceSuitDict[slot7[slot22].suitId] then
						slot16 = 0 + 1
					end

					slot17 = slot17 + slot7[slot22].num
				end

				if slot9 < slot16 or slot16 == slot9 and slot10 < slot17 then
					slot8 = slot14
					slot9 = slot16
					slot10 = slot17
				end
			end

			return true, slot6[slot8]
		else
			return true, slot6[1]
		end
	end

	return false
end

function slot0.isRepeat(slot0, slot1)
	for slot5 = 1, #slot1 - 1 do
		for slot9 = slot5 + 1, #slot1 do
			if slot1[slot5] == slot1[slot9] then
				return true
			end
		end
	end

	return false
end

function slot0.canSelect(slot0)
	if DiceHeroFightModel.instance:getGameData().allyHero:isBanSkillCard(slot0.co.type) then
		return false, DiceHeroEnum.CantUseReason.BanSkill
	end

	if slot0.co.roundLimitCount ~= 0 and slot0.co.roundLimitCount <= slot0.curRoundUse then
		return false, DiceHeroEnum.CantUseReason.NoUseCount
	end

	if not slot0:isMatchMin() then
		return false, DiceHeroEnum.CantUseReason.NoDice
	end

	return true
end

function slot0.addDice(slot0, slot1)
	for slot5 = 1, #slot0.matchDiceUids do
		if not slot0.curSelectUids[slot5] and tabletool.indexOf(slot0.matchDiceUids[slot5], slot1) then
			slot0.curSelectUids[slot5] = slot1

			DiceHeroController.instance:dispatchEvent(DiceHeroEvent.SkillCardDiceChange)

			return true
		end
	end

	return false
end

function slot0.getCanUseDiceUidDict(slot0)
	slot1 = {}

	for slot5 = 1, #slot0.matchDiceUids do
		if not slot0.curSelectUids[slot5] then
			for slot9, slot10 in pairs(slot0.matchDiceUids[slot5]) do
				slot1[slot10] = true
			end
		end
	end

	return slot1
end

function slot0.removeDice(slot0, slot1)
	for slot5 = 1, #slot0.matchDiceUids do
		if slot0.curSelectUids[slot5] == slot1 then
			slot0.curSelectUids[slot5] = nil

			slot0:_refreshDiceIndex()
			DiceHeroController.instance:dispatchEvent(DiceHeroEvent.SkillCardDiceChange)

			break
		end
	end
end

function slot0._refreshDiceIndex(slot0)
	slot1 = #slot0.matchDiceUids

	while true do
		slot2 = false

		for slot6 = slot1, 1, -1 do
			if slot0.curSelectUids[slot6] then
				for slot10 = 1, slot6 - 1 do
					if not slot0.curSelectUids[slot10] and tabletool.indexOf(slot0.matchDiceUids[slot10], slot0.curSelectUids[slot6]) then
						slot0.curSelectUids[slot10] = slot0.curSelectUids[slot6]
						slot0.curSelectUids[slot6] = slot0.curSelectUids[slot10]
						slot2 = true

						break
					end
				end
			end
		end

		if not slot2 then
			break
		end
	end
end

function slot0.clearSelects(slot0)
	slot0.curSelectUids = {}
end

function slot0.canUse(slot0)
	if #slot0.matchNums == 0 then
		return -1, {}
	end

	slot1 = 0

	for slot5 = 1, #slot0.matchDiceUids do
		if not slot0.curSelectUids[slot5] then
			break
		end

		slot1 = slot5
	end

	for slot5 = #slot0.matchNums, 1, -1 do
		if slot0.matchNums[slot5] <= slot1 then
			return slot5, {
				unpack(slot0.curSelectUids, 1, slot0.matchNums[slot5])
			}
		end
	end

	return false
end

function slot0.clearMatches(slot0)
	slot0.matchDiceUids = {}
end

return slot0
