module("modules.logic.versionactivity2_7.act191.model.Act191GameMO", package.seeall)

slot0 = pureTable("Act191GameMO")

function slot0.init(slot0, slot1)
	slot0.actId = Activity191Model.instance:getCurActId()
	slot0.coin = slot1.coin
	slot0.curStage = slot1.curStage
	slot0.curNode = slot1.curNode
	slot0.nodeInfo = slot1.nodeInfo
	slot0.curTeamIndex = slot1.curTeamIndex ~= 0 and slot1.curTeamIndex or 1
	slot0.teamInfo = slot1.teamInfo

	slot0:updateWareHouseInfo(slot1.warehouseInfo)

	slot0.score = slot1.score
	slot0.state = slot1.state
	slot0.rank = slot1.rank
end

function slot0.update(slot0, slot1)
	if slot0.curNode ~= slot1.curNode then
		slot0.nodeChange = true
	end

	slot0.coin = slot1.coin
	slot0.curStage = slot1.curStage
	slot0.curNode = slot1.curNode
	slot0.nodeInfo = slot1.nodeInfo
	slot0.curTeamIndex = slot1.curTeamIndex
	slot0.teamInfo = slot1.teamInfo

	slot0:updateWareHouseInfo(slot1.warehouseInfo, true)

	slot0.score = slot1.score
	slot0.state = slot1.state
	slot0.rank = slot1.rank
end

function slot0.updateWareHouseInfo(slot0, slot1, slot2)
	if not slot2 or slot0.warehouseInfo and #slot0.warehouseInfo.enhanceId ~= #slot1.enhanceId then
		slot0.destinyHeroMap = {}
		slot0.enhanceItemList = {}

		for slot6, slot7 in ipairs(slot1.enhanceId) do
			if string.nilorempty(Activity191Config.instance:getEnhanceCo(slot0.actId, slot7).relateItem) then
				slot11 = string.splitToNumber(lua_activity191_effect.configDict[tonumber(slot8.effects)].typeParam, "#")
				slot0.destinyHeroMap[slot11[1]] = slot11[2]
			else
				slot0.enhanceItemList[#slot0.enhanceItemList + 1] = tonumber(slot8.relateItem)
			end
		end
	end

	slot0.warehouseInfo = slot1
end

function slot0.updateTeamInfo(slot0, slot1, slot2)
	slot0.curTeamIndex = slot1
	slot3 = false

	for slot7, slot8 in ipairs(slot0.teamInfo) do
		if slot8.index == slot1 then
			slot0.teamInfo[slot7] = slot2
			slot3 = true

			break
		end
	end

	if not slot3 then
		table.insert(slot0.teamInfo, slot2)
	end
end

function slot0.updateCurNodeInfo(slot0, slot1)
	for slot5 = 1, #slot0.nodeInfo do
		if slot0.nodeInfo[slot5].nodeId == slot0.curNode then
			slot0.nodeInfo[slot5] = slot1
		end
	end
end

function slot0.getStageNodeInfoList(slot0, slot1)
	slot2 = {}

	for slot6, slot7 in ipairs(slot0.nodeInfo) do
		if slot7.stage == (slot1 or slot0.curStage) then
			slot2[#slot2 + 1] = slot7
		end
	end

	table.sort(slot2, function (slot0, slot1)
		return slot0.nodeId < slot1.nodeId
	end)

	return slot2
end

function slot0.getNodeInfoById(slot0, slot1)
	for slot5, slot6 in ipairs(slot0.nodeInfo) do
		if slot6.nodeId == slot1 then
			return slot6
		end
	end
end

function slot0.getNodeDetailMo(slot0, slot1, slot2)
	if not Activity191Helper.matchKeyInArray(slot0.nodeInfo, "nodeId", slot1 or slot0.curNode) or string.nilorempty(slot3.nodeStr) then
		if slot2 then
			return
		end

		logError("check select node" .. slot1)

		return
	end

	slot4 = Act191NodeDetailMO.New()

	slot4:init(slot3.nodeStr)

	return slot4
end

function slot0.getTeamInfo(slot0, slot1)
	if not Activity191Helper.matchKeyInArray(slot0.teamInfo, "index", slot1 or slot0.curTeamIndex) then
		slot2 = Activity191Module_pb.Act191BattleTeamInfo()
		slot2.index = slot1
		slot2.name = formatLuaLang("herogroup_common_name", GameUtil.getNum2Chinese(slot1))
		slot2.auto = false

		table.insert(slot0.teamInfo, slot2)
	end

	return slot2
end

function slot0.getPreviewFetterCntDic(slot0, slot1)
	slot2 = {}
	slot3 = slot0:getTeamInfo()

	for slot7, slot8 in pairs(slot1) do
		slot9 = {
			[slot17] = 1
		}

		for slot16, slot17 in ipairs(string.split(Activity191Config.instance:getRoleCoByNativeId(slot8, slot0:getHeroInfoInWarehouse(slot8).star).tag, "#")) do
			-- Nothing
		end

		if slot7 <= 4 and Activity191Helper.matchKeyInArray(slot3.battleHeroInfo, "index", slot7) then
			for slot17 = 1, 2 do
				if slot13["itemUid" .. slot17] ~= 0 and not string.nilorempty(Activity191Config.instance:getCollectionCo(slot0:getItemInfoInWarehouse(slot18).itemId).tag) then
					for slot24, slot25 in ipairs(string.split(slot20.tag, "#")) do
						slot9[slot25] = 1
					end
				end
			end
		end

		for slot16, slot17 in pairs(slot9) do
			if slot2[slot16] then
				slot2[slot16] = slot2[slot16] + 1
			else
				slot2[slot16] = 1
			end
		end
	end

	return slot2
end

function slot0.getTeamFetterCntDic(slot0)
	slot1 = {}

	for slot6, slot7 in ipairs(slot0:getTeamInfo().battleHeroInfo) do
		slot8 = {}

		if slot7.heroId ~= 0 then
			for slot15, slot16 in ipairs(string.split(Activity191Config.instance:getRoleCoByNativeId(slot7.heroId, slot0:getHeroInfoInWarehouse(slot7.heroId).star).tag, "#")) do
				slot8[slot16] = 1
			end

			for slot15 = 1, 2 do
				if slot7["itemUid" .. slot15] ~= 0 and not string.nilorempty(Activity191Config.instance:getCollectionCo(slot0:getItemInfoInWarehouse(slot16).itemId).tag) then
					for slot23, slot24 in ipairs(string.split(slot18.tag, "#")) do
						slot8[slot24] = 1
					end
				end
			end
		end

		for slot12, slot13 in pairs(slot8) do
			if slot1[slot12] then
				slot1[slot12] = slot1[slot12] + 1
			else
				slot1[slot12] = 1
			end
		end
	end

	for slot6, slot7 in ipairs(slot2.subHeroInfo) do
		for slot14, slot15 in ipairs(string.split(Activity191Config.instance:getRoleCoByNativeId(slot7.heroId, slot0:getHeroInfoInWarehouse(slot7.heroId).star).tag, "#")) do
			if slot1[slot15] then
				slot1[slot15] = slot1[slot15] + 1
			else
				slot1[slot15] = 1
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

			if slot0:isHeroInTeam(slot8.roleId) then
				slot10 = 2
			elseif slot0:getHeroInfoInWarehouse(slot8.roleId, true) then
				slot10 = 1
			end

			if tabletool.indexOf(string.split(slot8.tag, "#"), slot1) then
				slot2[#slot2 + 1] = {
					config = slot8,
					inBag = slot10,
					transfer = slot9
				}
			elseif slot0:getBattleHeroInfoInTeam(slot8.roleId) then
				slot13 = false

				if slot12.itemUid1 ~= 0 and not string.nilorempty(Activity191Config.instance:getCollectionCo(slot0:getItemInfoInWarehouse(slot12.itemUid1).itemId).tag) and tabletool.indexOf(string.split(slot15.tag, "#"), slot1) then
					slot2[#slot2 + 1] = {
						inBag = 2,
						transfer = 1,
						config = slot8
					}
					slot13 = true
				end

				if not slot13 and slot12.itemUid2 ~= 0 and not string.nilorempty(Activity191Config.instance:getCollectionCo(slot0:getItemInfoInWarehouse(slot12.itemUid2).itemId).tag) and tabletool.indexOf(string.split(slot15.tag, "#"), slot1) then
					slot2[#slot2 + 1] = {
						inBag = 2,
						transfer = 1,
						config = slot8
					}
				end
			end
		end
	end

	table.sort(slot2, Activity191Helper.sortFetterHeroList)

	return slot2
end

function slot0.setCurTeamIndex(slot0, slot1)
	if slot0.curTeamIndex == slot1 then
		return
	end

	Activity191Rpc.instance:sendChangeAct191TeamRequest(slot0.actId, slot1, slot0:getTeamInfo(slot1), Activity191Enum.OpTeamType.ChangeIndex)
end

function slot0.setTeamName(slot0, slot1)
	slot2 = slot0:getTeamInfo()
	slot2.name = slot1

	Activity191Rpc.instance:sendChangeAct191TeamRequest(slot0.actId, slot0.curTeamIndex, slot2, Activity191Enum.OpTeamType.ChangeName)
end

function slot0.setAutoFight(slot0, slot1)
	slot2 = slot0:getTeamInfo()
	slot2.auto = slot1

	Activity191Rpc.instance:sendChangeAct191TeamRequest(slot0.actId, slot0.curTeamIndex, slot2)
end

function slot0.getHeroInfoInWarehouse(slot0, slot1, slot2)
	slot3 = nil

	for slot7, slot8 in ipairs(slot0.warehouseInfo.hero) do
		if slot1 == slot8.heroId then
			slot3 = slot8

			break
		end
	end

	if not slot2 and not slot3 then
		logError(string.format("heroId : %s, heroInfo not found", slot1))
	end

	return slot3
end

function slot0.getBattleHeroInfoInTeam(slot0, slot1)
	for slot6, slot7 in ipairs(slot0:getTeamInfo().battleHeroInfo) do
		if slot7.heroId == slot1 then
			return slot7
		end
	end
end

function slot0.getSubHeroInfoInTeam(slot0, slot1)
	for slot6, slot7 in ipairs(slot0:getTeamInfo().subHeroInfo) do
		if slot7.heroId == slot1 then
			return slot7
		end
	end
end

function slot0.isHeroInTeam(slot0, slot1, slot2)
	for slot7, slot8 in ipairs(slot0:getTeamInfo().battleHeroInfo) do
		if slot8.heroId == slot1 then
			if slot2 then
				slot8.heroId = 0
			end

			return true
		end
	end

	for slot7, slot8 in ipairs(slot3.subHeroInfo) do
		if slot8.heroId == slot1 then
			if slot2 then
				slot8.heroId = 0
			end

			return true
		end
	end
end

function slot0.teamHasMainHero(slot0, slot1)
	for slot6, slot7 in ipairs(slot0:getTeamInfo(slot1 or slot0.curTeamIndex).battleHeroInfo) do
		if slot7.heroId ~= 0 then
			return true
		end
	end

	return false
end

function slot0.saveQuickGroupInfo(slot0, slot1)
	slot2 = slot0:getTeamInfo()

	for slot6 = 1, 4 do
		Activity191Helper.getWithBuildBattleHeroInfo(slot2.battleHeroInfo, slot6).heroId = slot1[slot6] or 0
		Activity191Helper.getWithBuildSubHeroInfo(slot2.subHeroInfo, slot6).heroId = slot1[slot6 + 4] or 0
	end

	Activity191Rpc.instance:sendChangeAct191TeamRequest(slot0.actId, slot0.curTeamIndex, slot2)
end

function slot0.repleaceHeroInTeam(slot0, slot1, slot2)
	slot0:isHeroInTeam(slot1, true)

	if slot2 <= 4 then
		Activity191Helper.getWithBuildBattleHeroInfo(slot0:getTeamInfo().battleHeroInfo, slot2).heroId = slot1
	else
		Activity191Helper.getWithBuildSubHeroInfo(slot3.subHeroInfo, slot2 - 4).heroId = slot1
	end

	Activity191Rpc.instance:sendChangeAct191TeamRequest(slot0.actId, slot0.curTeamIndex, slot3)
end

function slot0.removeHeroInTeam(slot0, slot1)
	for slot6, slot7 in ipairs(slot0:getTeamInfo().battleHeroInfo) do
		if slot7.heroId == slot1 then
			slot7.heroId = 0

			Activity191Rpc.instance:sendChangeAct191TeamRequest(slot0.actId, slot0.curTeamIndex, slot2)

			return
		end
	end

	for slot6, slot7 in ipairs(slot2.subHeroInfo) do
		if slot7.heroId == slot1 then
			slot7.heroId = 0

			Activity191Rpc.instance:sendChangeAct191TeamRequest(slot0.actId, slot0.curTeamIndex, slot2)

			return
		end
	end
end

function slot0.exchangeHero(slot0, slot1, slot2)
	slot3 = slot0:getTeamInfo()
	slot4, slot5 = nil
	slot4 = (slot1 > 4 or Activity191Helper.getWithBuildBattleHeroInfo(slot3.battleHeroInfo, slot1)) and Activity191Helper.getWithBuildSubHeroInfo(slot3.subHeroInfo, slot1 - 4)
	slot5 = (slot2 > 4 or Activity191Helper.getWithBuildBattleHeroInfo(slot3.battleHeroInfo, slot2)) and Activity191Helper.getWithBuildSubHeroInfo(slot3.subHeroInfo, slot2 - 4)
	slot4.heroId = slot5.heroId
	slot5.heroId = slot4.heroId

	Activity191Rpc.instance:sendChangeAct191TeamRequest(slot0.actId, slot0.curTeamIndex, slot3)
end

function slot0.getItemInfoInWarehouse(slot0, slot1)
	slot2 = nil

	for slot6, slot7 in ipairs(slot0.warehouseInfo.item) do
		if slot7.uid == slot1 then
			slot2 = slot7

			break
		end
	end

	if not slot2 then
		logError(string.format("itemUid : %s, itemInfo not found", slot1))
	end

	return slot2
end

function slot0.isItemInTeam(slot0, slot1, slot2)
	for slot7, slot8 in ipairs(slot0:getTeamInfo().battleHeroInfo) do
		if slot8.itemUid1 == slot1 then
			if slot2 then
				slot8.itemUid1 = 0
			end

			return true, slot8.heroId
		elseif slot8.itemUid2 == slot1 then
			if slot2 then
				slot8.itemUid2 = 0
			end

			return true, slot8.heroId
		end
	end
end

function slot0.repleaceItemInTeam(slot0, slot1, slot2, slot3)
	slot0:isItemInTeam(slot1, true)

	slot4 = slot0:getTeamInfo()
	Activity191Helper.getWithBuildBattleHeroInfo(slot4.battleHeroInfo, slot2)["itemUid" .. slot3] = slot1

	Activity191Rpc.instance:sendChangeAct191TeamRequest(slot0.actId, slot0.curTeamIndex, slot4)
end

function slot0.removeItemInTeam(slot0, slot1)
	for slot6, slot7 in ipairs(slot0:getTeamInfo().battleHeroInfo) do
		if slot7.itemUid1 == slot1 then
			slot7.itemUid1 = 0
		elseif slot7.itemUid2 == slot1 then
			slot7.itemUid2 = 0
		end
	end

	Activity191Rpc.instance:sendChangeAct191TeamRequest(slot0.actId, slot0.curTeamIndex, slot2)
end

function slot0.exchangeItem(slot0, slot1, slot2)
	slot3 = slot0:getTeamInfo()
	slot4, slot5 = nil
	slot7 = slot1 % 2 == 0 and 2 or 1
	slot4 = Activity191Helper.getWithBuildBattleHeroInfo(slot3.battleHeroInfo, math.ceil(slot1 / 2))
	slot5 = Activity191Helper.getWithBuildBattleHeroInfo(slot3.battleHeroInfo, math.ceil(slot2 / 2))
	slot8 = slot2 % 2 == 0 and 2 or 1
	slot4["itemUid" .. slot7] = slot5["itemUid" .. slot8]
	slot5["itemUid" .. slot8] = slot4["itemUid" .. slot7]

	Activity191Rpc.instance:sendChangeAct191TeamRequest(slot0.actId, slot0.curTeamIndex, slot3)
end

function slot0.isHeroDestinyUnlock(slot0, slot1)
	if slot0.destinyHeroMap[slot1] then
		return true, slot2
	end

	return false
end

function slot0.isItemEnhance(slot0, slot1)
	if tabletool.indexOf(slot0.enhanceItemList, slot1) then
		return true
	end

	return false
end

function slot0.autoFill(slot0)
	slot1 = slot0:getTeamInfo(1)
	slot2 = slot0.warehouseInfo.item

	for slot6, slot7 in ipairs(slot0.warehouseInfo.hero) do
		if slot6 <= 4 then
			Activity191Helper.getWithBuildBattleHeroInfo(slot1.battleHeroInfo, slot6).heroId = slot7.heroId

			if slot2[slot6] then
				slot8.itemUid1 = slot2[slot6].uid
			end

			if slot2[slot6 + 4] then
				slot8.itemUid2 = slot2[slot6 + 4].uid
			end
		elseif slot6 <= 8 then
			Activity191Helper.getWithBuildSubHeroInfo(slot1.subHeroInfo, slot6 - 4).heroId = slot7.heroId
		end

		Activity191Rpc.instance:sendChangeAct191TeamRequest(slot0.actId, 1, slot1)
	end
end

return slot0
