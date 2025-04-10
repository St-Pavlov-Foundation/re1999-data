module("modules.logic.versionactivity2_7.lengzhou6.config.LengZhou6Config", package.seeall)

slot0 = class("LengZhou6Config", BaseConfig)

function slot0.reqConfigNames(slot0)
	return {
		"activity190_episode",
		"activity190_task",
		"eliminate_battle_cost",
		"eliminate_battle_enemy",
		"eliminate_battle_enemybehavior",
		"eliminate_battle_endless_library_round",
		"eliminate_battle_character",
		"eliminate_battle_skill",
		"eliminate_battle_buff",
		"eliminate_battle_endless_mode",
		"eliminate_battle_eliminateblocks"
	}
end

function slot0.onInit(slot0)
	slot0._eliminateBattleDamage = {}
	slot0._eliminateBattleHeal = {}
	slot0._skillIdToSpecialAttr = nil
	slot0._enemyRandomIdsConfig = nil
	slot0._selectEnemyIds = nil
end

function slot0.onConfigLoaded(slot0, slot1, slot2)
end

function slot0.getEpisodeConfig(slot0, slot1, slot2)
	return lua_activity190_episode.configDict[slot1][slot2]
end

function slot0.getEliminateBattleEliminateBlocks(slot0, slot1, slot2)
	slot3 = lua_eliminate_battle_eliminateblocks.configDict[slot1]

	if slot1 == nil or slot2 == nil or slot3 == nil then
		logError("getEliminateBattleEliminateBlocks error eliminateName or eliminateType is nil" .. tostring(slot1) .. tostring(slot2))
	end

	if slot3 == nil then
		return nil
	end

	return slot3[slot2]
end

function slot0.getEliminateBattleEnemy(slot0, slot1)
	return lua_eliminate_battle_enemy.configDict[slot1]
end

function slot0.getEliminateBattleEnemyBehavior(slot0, slot1)
	return lua_eliminate_battle_enemybehavior.configDict[slot1]
end

function slot0.getEliminateBattleCharacter(slot0, slot1)
	return lua_eliminate_battle_character.configDict[slot1]
end

function slot0.getEliminateBattleSkill(slot0, slot1)
	return lua_eliminate_battle_skill.configDict[slot1]
end

function slot0.getEliminateBattleBuff(slot0, slot1)
	return lua_eliminate_battle_buff.configDict[slot1]
end

function slot0.getTaskByActId(slot0, slot1)
	if slot0._taskList == nil then
		slot0._taskList = {}

		for slot5, slot6 in ipairs(lua_activity190_task.configList) do
			if slot6.activityId == slot1 then
				table.insert(slot0._taskList, slot6)
			end
		end
	end

	return slot0._taskList
end

function slot0.getPlayerAllSkillId(slot0)
	slot1 = {}

	for slot5, slot6 in ipairs(lua_eliminate_battle_skill.configList) do
		if slot6.type == LengZhou6Enum.SkillType.active or slot6.type == LengZhou6Enum.SkillType.passive and not uv0.instance:isPlayerChessPassive(slot6.id) then
			table.insert(slot1, slot6.id)
		end
	end

	return slot1
end

function slot0.isPlayerChessPassive(slot0, slot1)
	for slot5 = 1, 4 do
		if uv0.instance:getEliminateBattleCost(slot5) == slot1 then
			return true
		end
	end

	return false
end

function slot0.getEnemyRandomIdsConfig(slot0, slot1)
	if slot0._enemyRandomIdsConfig == nil then
		slot0._enemyRandomIdsConfig = {}
		slot0._enemyEndlessLibraryRound = {}

		for slot6 = 1, #lua_eliminate_battle_endless_library_round.configList do
			slot7 = slot2[slot6]

			table.insert(slot0._enemyEndlessLibraryRound, string.splitToNumber(slot7.endlessLibraryRound, "#")[2])
			table.insert(slot0._enemyRandomIdsConfig, string.splitToNumber(slot7.randomIds, "#"))
		end
	end

	return slot0._enemyRandomIdsConfig[slot0:recordEnemyLastRandomId(slot1)]
end

function slot0.getEnemyRandomRealIndex(slot0, slot1)
	if slot0._enemyEndlessLibraryRound == nil then
		return 1
	end

	for slot5 = 1, #slot0._enemyEndlessLibraryRound do
		if slot1 <= slot0._enemyEndlessLibraryRound[slot5] then
			return slot5
		end
	end
end

function slot0.recordEnemyLastRandomId(slot0, slot1)
	slot2 = slot0:getEnemyRandomRealIndex(slot1)

	if slot0._lastEnemyRoundIndex ~= nil and slot2 ~= slot0._lastEnemyRoundIndex then
		slot0:clearSetSelectEnemyRandomId()
	end

	slot0._lastEnemyRoundIndex = slot2

	return slot2
end

function slot0.setSelectEnemyRandomId(slot0, slot1, slot2)
	if slot2 == nil then
		return
	end

	if slot0._selectEnemyIds == nil then
		slot0._selectEnemyIds = {}
	end

	slot0._selectEnemyIds[slot2] = (slot0._selectEnemyIds[slot2] or 0) + 1

	if slot0._selectEnemyIds[slot2] == 2 then
		slot4 = slot0:getEnemyRandomRealIndex(slot1)

		if slot0._enemyRandomIdsConfig ~= nil then
			for slot9 = 1, #slot0._enemyRandomIdsConfig[slot4] do
				if slot5[slot9] == slot2 then
					table.remove(slot5, slot9)

					break
				end
			end

			slot0._enemyRandomIdsConfig[slot4] = slot5
		end
	end
end

function slot0.clearSetSelectEnemyRandomId(slot0)
	slot0._selectEnemyIds = nil
end

function slot0.getEliminateBattleCost(slot0, slot1)
	return tonumber(lua_eliminate_battle_cost.configDict[slot1].value or 0)
end

function slot0.getEliminateBattleCostStr(slot0, slot1)
	return lua_eliminate_battle_cost.configDict[slot1].value
end

function slot0.getComboThreshold(slot0)
	return slot0:getEliminateBattleCost(27)
end

function slot0.getAllSpecialAttr(slot0)
	if slot0._skillIdToSpecialAttr == nil then
		slot0._skillIdToSpecialAttr = {}

		for slot4 = 28, 31 do
			if not string.nilorempty(slot0:getEliminateBattleCostStr(slot4)) then
				slot6 = string.split(slot5, "#")
				slot0._skillIdToSpecialAttr[tonumber(slot6[1])] = {
					effect = slot6[2],
					chessType = slot6[3],
					value = tonumber(slot6[4])
				}
			end
		end
	end

	return slot0._skillIdToSpecialAttr
end

function slot0.getEliminateBattleEndlessMode(slot0, slot1)
	if slot0._battleEndLessMode == nil then
		slot0._battleEndLessMode = {}
	end

	if slot0._battleEndLessMode[slot1] == nil then
		if lua_eliminate_battle_endless_mode.configDict[slot1] == nil then
			return nil
		end

		for slot7 = 1, 5 do
			if not string.nilorempty(slot2["skill" .. slot7]) then
				-- Nothing
			end
		end

		slot0._battleEndLessMode[slot1] = {
			hp = tonumber(slot2.hpUp),
			[slot8] = tonumber(slot2["powerUp" .. slot7])
		}
	end

	return slot0._battleEndLessMode[slot1]
end

function slot0.getDamageValue(slot0, slot1, slot2)
	if slot0._eliminateBattleDamage == nil then
		slot0._eliminateBattleDamage = {}
	end

	if slot0._eliminateBattleDamage[slot1] == nil then
		slot0._eliminateBattleDamage[slot1] = {}
	end

	if slot0._eliminateBattleDamage[slot1][slot2] == nil then
		slot3 = {
			slot5[1],
			slot5[2]
		}

		if slot0:getEliminateBattleEliminateBlocks(slot1, slot2) ~= nil then
			slot5 = string.splitToNumber(slot4.damageRate, "#")
		end

		slot0._eliminateBattleDamage[slot1][slot2] = slot3
	end

	return slot0._eliminateBattleDamage[slot1][slot2][1] or 0, slot3[2] or 0
end

function slot0.getHealValue(slot0, slot1, slot2)
	if slot0._eliminateBattleHeal == nil then
		slot0._eliminateBattleHeal = {}
	end

	if slot0._eliminateBattleHeal[slot1] == nil then
		slot0._eliminateBattleHeal[slot1] = {}
	end

	if slot0._eliminateBattleHeal[slot1][slot2] == nil then
		slot3 = {
			slot5[1],
			slot5[2]
		}

		if slot0:getEliminateBattleEliminateBlocks(slot1, slot2) ~= nil then
			slot5 = string.splitToNumber(slot4.healRate, "#")
		end

		slot0._eliminateBattleHeal[slot1][slot2] = slot3
	end

	return slot0._eliminateBattleHeal[slot1][slot2][1] or 0, slot3[2] or 0
end

function slot0.clearLevelCache(slot0)
	slot0._enemyRandomIdsConfig = nil
	slot0._enemyEndlessLibraryRound = nil
	slot0._selectEnemyIds = nil
end

slot0.instance = slot0.New()

return slot0
