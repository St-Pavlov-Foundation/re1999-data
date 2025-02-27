module("modules.logic.versionactivity2_6.dicehero.config.DiceHeroConfig", package.seeall)

slot0 = class("DiceHeroConfig", BaseConfig)

function slot0.reqConfigNames(slot0)
	return {
		"dice",
		"dice_buff",
		"dice_card",
		"dice_character",
		"dice_enemy",
		"dice_level",
		"dice_pattern",
		"dice_relic",
		"dice_point",
		"dice_suit",
		"dice_dialogue",
		"dice_task"
	}
end

function slot0.getTaskList(slot0)
	slot1 = {}

	for slot5, slot6 in ipairs(lua_dice_task.configList) do
		if slot6.isOnline == 1 then
			table.insert(slot1, slot6)
		end
	end

	return slot1
end

function slot0.getLevelCo(slot0, slot1, slot2)
	for slot6, slot7 in ipairs(lua_dice_level.configList) do
		if slot7.chapter == slot1 and slot7.room == slot2 then
			return slot7
		end
	end
end

function slot0.getLevelCos(slot0, slot1)
	if not slot0._levelCos then
		slot0._levelCos = {}

		for slot5, slot6 in ipairs(lua_dice_level.configList) do
			if not slot0._levelCos[slot6.chapter] then
				slot0._levelCos[slot6.chapter] = {}
			end

			slot0._levelCos[slot6.chapter][slot6.room] = slot6
		end
	end

	return slot0._levelCos[slot1] or {}
end

function slot0.getDiceSuitDict(slot0, slot1)
	if not slot0._suitDict then
		slot0._suitDict = {}

		for slot5, slot6 in ipairs(lua_dice_suit.configList) do
			for slot11, slot12 in ipairs(string.splitToNumber(slot6.suit, "#") or {}) do
				-- Nothing
			end

			slot0._suitDict[slot6.id] = {
				[slot12] = true
			}
		end

		slot2 = {}

		GameUtil.setDefaultValue(slot2, true)

		slot0._suitDict[0] = slot2
	end

	return slot0._suitDict[slot1]
end

function slot0.getDicePointDict(slot0, slot1)
	if not slot0._pointDict then
		slot0._pointDict = {}

		for slot5, slot6 in ipairs(lua_dice_point.configList) do
			for slot11, slot12 in ipairs(string.splitToNumber(slot6.pointList, "#") or {}) do
				-- Nothing
			end

			slot0._pointDict[slot6.id] = {
				[slot12] = true
			}
		end

		slot2 = {}

		GameUtil.setDefaultValue(slot2, true)

		slot0._pointDict[0] = slot2
	end

	return slot0._pointDict[slot1]
end

slot0.instance = slot0.New()

return slot0
