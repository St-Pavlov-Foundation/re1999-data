module("modules.logic.versionactivity2_7.act191.model.Act191MatchMO", package.seeall)

slot0 = pureTable("Act191MatchMO")

function slot0.init(slot0, slot1)
	slot0.uid = slot1.uid
	slot0.rank = slot1.rank
	slot0.robot = slot1.robot
	slot0.playerUid = slot1.playerUid
	slot0.heroMap = slot1.heroMap
	slot0.subHeroMap = slot1.subHeroMap
	slot0.enhanceSet = slot1.enhanceSet
	slot0.wareHouseInfo = slot1.warehouseInfo
end

function slot0.getRoleCo(slot0, slot1)
	if slot0.robot then
		return Activity191Config.instance:getRoleCo(slot1)
	elseif slot0:getHeroInfo(slot1, true) then
		return Activity191Config.instance:getRoleCoByNativeId(slot1, slot2.star)
	end
end

function slot0.getHeroInfo(slot0, slot1, slot2)
	slot3 = slot0.wareHouseInfo.heroInfoMap[tostring(slot1)]

	if slot2 and not slot3 then
		logError("enemyHeroInfo not found" .. slot1)
	end

	return slot3
end

function slot0.getItemCo(slot0, slot1)
	slot2 = nil

	return Activity191Config.instance:getCollectionCo(slot0.robot and slot1 or slot0:getItemInfo(slot1).itemId)
end

function slot0.getItemInfo(slot0, slot1)
	if slot0.wareHouseInfo.itemInfoMap[tostring(slot1)] then
		return slot2
	else
		logError("enemyItemInfo not found" .. slot1)
	end
end

function slot0.getTeamFetterCntDic(slot0)
	slot1 = {}

	for slot5, slot6 in pairs(slot0.heroMap) do
		slot7 = {}

		if slot6.heroId ~= 0 then
			for slot13, slot14 in ipairs(string.split(slot0:getRoleCo(slot6.heroId).tag, "#")) do
				slot7[slot14] = 1
			end

			if slot6.itemUid1 ~= 0 and not string.nilorempty(slot0:getItemCo(slot6.itemUid1).tag) then
				for slot14, slot15 in ipairs(string.split(slot10.tag, "#")) do
					slot7[slot15] = 1
				end
			end
		end

		for slot11, slot12 in pairs(slot7) do
			if slot1[slot11] then
				slot1[slot11] = slot1[slot11] + 1
			else
				slot1[slot11] = 1
			end
		end
	end

	for slot5, slot6 in pairs(slot0.subHeroMap) do
		for slot12, slot13 in ipairs(string.split(slot0:getRoleCo(slot6).tag, "#")) do
			if slot1[slot13] then
				slot1[slot13] = slot1[slot13] + 1
			else
				slot1[slot13] = 1
			end
		end
	end

	return slot1
end

function slot0.getFetterHeroList(slot0, slot1)
	slot2 = {}

	for slot7, slot8 in ipairs(lua_activity191_role.configList) do
		if slot8.star == 1 then
			slot9 = 0
			slot10 = 0

			if slot0.robot and slot0:isHeroInTeam(slot8.id) or not slot0.robot and slot0:isHeroInTeam(slot8.roleId) then
				slot10 = 2
			elseif not slot0.robot and slot0:getHeroInfo(slot8.roleId) then
				slot10 = 1
			end

			if tabletool.indexOf(string.split(slot8.tag, "#"), slot1) then
				slot2[#slot2 + 1] = {
					config = slot8,
					inBag = slot10,
					transfer = slot9
				}
			elseif slot0:getBattleHeroInfoInTeam(slot8.roleId) and slot12.itemUid1 ~= 0 and not string.nilorempty(slot0:getItemCo(slot12.itemUid1).tag) and tabletool.indexOf(string.split(slot13.tag, "#"), slot1) then
				slot2[#slot2 + 1] = {
					inBag = 2,
					transfer = 1,
					config = slot8
				}
			end
		end
	end

	table.sort(slot2, Activity191Helper.sortFetterHeroList)

	return slot2
end

function slot0.isHeroInTeam(slot0, slot1)
	for slot5, slot6 in pairs(slot0.heroMap) do
		if slot6.heroId == slot1 then
			return true
		end
	end

	for slot5, slot6 in pairs(slot0.subHeroMap) do
		if slot6 == slot1 then
			return true
		end
	end
end

function slot0.getBattleHeroInfoInTeam(slot0, slot1)
	for slot5, slot6 in pairs(slot0.heroMap) do
		if slot6.heroId == slot1 then
			return slot6
		end
	end
end

return slot0
