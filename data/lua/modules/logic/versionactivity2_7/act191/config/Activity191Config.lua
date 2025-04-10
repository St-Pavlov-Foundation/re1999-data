module("modules.logic.versionactivity2_7.act191.config.Activity191Config", package.seeall)

slot0 = class("Activity191Config", BaseConfig)

function slot0.reqConfigNames(slot0)
	return {
		"activity191_const",
		"activity191_init_build",
		"activity191_node",
		"activity191_badge",
		"activity191_stage",
		"activity191_role",
		"activity191_collection",
		"activity191_template",
		"activity191_relation",
		"activity191_enhance",
		"activity191_shop",
		"activity191_event",
		"activity191_fight_event",
		"activity191_match_rank",
		"activity191_pvp_match",
		"activity191_rank",
		"activity191_effect",
		"activity191_item",
		"activity191_ex_level",
		"activity191_eff_desc",
		"activity191_relation_select"
	}
end

function slot0.onInit(slot0)
end

function slot0.onConfigLoaded(slot0, slot1, slot2)
	if slot1 == "activity191_role" then
		slot0._roleConfig = slot2
		slot3 = {}

		for slot7, slot8 in ipairs(slot0._roleConfig.configList) do
			if not slot3[slot8.roleId] then
				slot3[slot9] = {}
			end

			slot3[slot9][slot8.star] = slot8
		end

		slot0._nativeHeroStarCoDic = slot3
	elseif slot1 == "activity191_relation" then
		slot0._relationConfig = slot2
		slot0._relationLvlConfigDic = {}

		for slot6, slot7 in ipairs(slot0._relationConfig.configList) do
			if not slot0._relationLvlConfigDic[slot7.tag] then
				slot0._relationLvlConfigDic[slot7.tag] = {}
			end

			slot8[slot7.level] = slot7
		end
	end
end

function slot0.getRoleCoByNativeId(slot0, slot1, slot2)
	if not slot0._nativeHeroStarCoDic[slot1][slot2] then
		logError(string.format("nativeHeroID : %s,star : %s config not found", slot1, slot2))
	end

	return slot3
end

function slot0.getRoleCo(slot0, slot1)
	if not slot0._roleConfig.configDict[tonumber(slot1)] then
		logError(string.format("id : %s, config not found", slot1))
	end

	return slot2
end

function slot0.getShowRoleCoList(slot0)
	slot1 = {}

	for slot5, slot6 in ipairs(slot0._roleConfig.configList) do
		if not Activity191Helper.matchKeyInArray(slot1, slot6.roleId, "roleId") then
			slot1[#slot1 + 1] = slot6
		end
	end

	table.sort(slot1, Activity191Helper.sortRoleCo)

	return slot1
end

function slot0.getCollectionCo(slot0, slot1)
	if not lua_activity191_collection.configDict[slot1] then
		logError(string.format("collectionID : %s, config not found", slot1))
	end

	return slot2
end

function slot0.getEnhanceCo(slot0, slot1, slot2)
	slot3 = nil

	for slot7, slot8 in ipairs(lua_activity191_enhance.configList) do
		if slot8.activityId == slot1 and slot8.id == slot2 then
			slot3 = slot8

			break
		end
	end

	if not slot3 then
		logError(string.format("enhanceId : %s, config not found", slot2))
	end

	return slot3
end

function slot0.getRelationCoList(slot0, slot1)
	if not slot0._relationLvlConfigDic[slot1] then
		logError(string.format("relationTag : %s, config not found", slot1))
	end

	return slot2
end

function slot0.getRelationCo(slot0, slot1, slot2)
	slot2 = slot2 or 0

	if slot0._relationLvlConfigDic[slot1] and slot0._relationLvlConfigDic[slot1][slot2] then
		return slot0._relationLvlConfigDic[slot1][slot2]
	else
		logError(string.format("relationTag : %s, level : %s config not found", slot1, slot2))
	end
end

function slot0.getRelationMaxCo(slot0, slot1)
	slot2 = slot0._relationLvlConfigDic[slot1]

	return slot2[#slot2]
end

function slot0.getHeroPassiveSkillIdList(slot0, slot1)
	if string.nilorempty(slot0:getRoleCo(slot1).passiveSkill) then
		slot3 = {}

		for slot9, slot10 in pairs(SkillConfig.instance:getPassiveSKillsCoByExSkillLevel(slot2.roleId, #SkillConfig.instance:getheroranksCO(slot2.roleId) - 1)) do
			slot3[#slot3 + 1] = slot10.skillPassive
		end

		return slot3
	else
		return string.splitToNumber(slot2.passiveSkill, "|")
	end
end

function slot0.getHeroSkillIdDic(slot0, slot1, slot2)
	if string.nilorempty(slot0:getRoleCo(slot1).activeSkill1) then
		if slot2 then
			return SkillConfig.instance:getHeroBaseSkillIdDictByExSkillLevel(slot3.roleId, nil, {
				exSkillLevel = slot3.exLevel
			})
		else
			return SkillConfig.instance:getHeroAllSkillIdDictByExSkillLevel(slot3.roleId, nil, , slot3.exLevel)
		end
	else
		slot5 = string.splitToNumber(slot3.activeSkill1, "#")

		if slot2 then
			-- Nothing
		else
			slot4[1] = slot5
			slot4[2] = slot6
			slot4[3] = {
				slot3.uniqueSkill
			}
		end

		return {
			slot5[#slot5],
			string.splitToNumber(slot3.activeSkill2, "#")[#slot5],
			slot3.uniqueSkill
		}
	end
end

function slot0.getHeroLevelExSkillCo(slot0, slot1, slot2)
	if slot0:getRoleCo(slot1).type == Activity191Enum.CharacterType.Hero then
		return SkillConfig.instance:getherolevelexskillCO(slot3.roleId, slot2)
	else
		if not lua_activity191_ex_level.configDict[slot3.roleId] then
			logError(string.format("ex skill not found heroid : %s `s config ", slot3.roleId))

			return nil
		end

		if slot4[slot2] == nil then
			logError(string.format("ex skill config gei nil, heroid : %s, skillLevel : %s", slot3.roleId, slot2))
		end

		return slot4[slot2]
	end
end

function slot0.getExSkillDesc(slot0, slot1, slot2)
	if slot1 == nil then
		return ""
	end

	slot4, slot5, slot6 = string.find(slot1.desc, "▩(%d)%%s")

	if not slot6 then
		logError("not fount skillIndex in desc : " .. slot3)

		return slot3
	end

	slot7 = nil

	if not ((tonumber(slot6) ~= 0 or slot0:getHeroPassiveSkillIdList(slot2)[1]) and slot0:getHeroSkillIdDic(slot2, true)[slot6]) then
		logError("not fount skillId, skillIndex : " .. slot6)

		return slot3
	end

	return slot3, lua_skill.configDict[slot7].name, slot6
end

function slot0.getFetterHeroList(slot0, slot1)
	slot2 = {}

	for slot7, slot8 in ipairs(lua_activity191_role.configList) do
		if slot8.star == 1 and tabletool.indexOf(string.split(slot8.tag, "#"), slot1) then
			slot2[#slot2 + 1] = {
				inBag = 1,
				transfer = 0,
				config = slot8
			}
		end
	end

	table.sort(slot2, Activity191Helper.sortFetterHeroList)

	return slot2
end

slot0.AttrIdToFieldName = {
	[CharacterEnum.AttrId.Attack] = "attack",
	[CharacterEnum.AttrId.Defense] = "defense",
	[CharacterEnum.AttrId.Technic] = "technic",
	[CharacterEnum.AttrId.Hp] = "life",
	[CharacterEnum.AttrId.Mdefense] = "mdefense"
}
slot0.instance = slot0.New()

return slot0
