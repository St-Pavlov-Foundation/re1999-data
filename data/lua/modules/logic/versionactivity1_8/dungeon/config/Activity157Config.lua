﻿-- chunkname: @modules/logic/versionactivity1_8/dungeon/config/Activity157Config.lua

module("modules.logic.versionactivity1_8.dungeon.config.Activity157Config", package.seeall)

local Activity157Config = class("Activity157Config", BaseConfig)

local function _sortById(idA, idB)
	return idA < idB
end

function Activity157Config:reqConfigNames()
	return {
		"activity157_const",
		"activity157_factory_component",
		"activity157_mission",
		"activity157_mission_group",
		"activity157_repair_map"
	}
end

function Activity157Config:onInit()
	self.actId2MissionGroupDict = {}
	self.actId2ElementDict = {}
	self.actId2missionGroupTree = {}
end

function Activity157Config:onConfigLoaded(configName, configTable)
	if configName == "activity157_mission" then
		self:initMissionCfg(configTable)
	end
end

function Activity157Config:initMissionCfg(configTable)
	self.actId2MissionGroupDict = {}
	self.actId2ElementDict = {}

	for actId, missionId2CfgDict in pairs(configTable.configDict) do
		local missionGroupDict = self.actId2MissionGroupDict[actId]

		if not missionGroupDict then
			missionGroupDict = {}
			self.actId2MissionGroupDict[actId] = missionGroupDict
		end

		local elementDict = self.actId2ElementDict[actId]

		if not elementDict then
			elementDict = {}
			self.actId2ElementDict[actId] = elementDict
		end

		local missionOrderDict = {}

		for missionId, missionCfg in pairs(missionId2CfgDict) do
			local missionGroupId = missionCfg.groupId
			local groupMissionList = missionGroupDict[missionGroupId]

			if not groupMissionList then
				groupMissionList = {}
				missionGroupDict[missionGroupId] = groupMissionList
			end

			elementDict[missionCfg.elementId] = missionId
			missionOrderDict[missionId] = missionCfg.order
			groupMissionList[#groupMissionList + 1] = missionId
		end

		for _, missionIdList in pairs(missionGroupDict) do
			table.sort(missionIdList, function(missionIdA, missionIdB)
				local orderA = missionOrderDict[missionIdA] or 0
				local orderB = missionOrderDict[missionIdB] or 0

				if orderA ~= orderB then
					return orderA < orderB
				end

				return missionIdA < missionIdB
			end)
		end
	end
end

function Activity157Config:initMissionGroupTree(actId)
	if not actId then
		return
	end

	local missionGroupTree = {}

	self.actId2missionGroupTree[actId] = missionGroupTree

	local allGroupIdList = self:getAllMissionGroupIdList(actId)

	for _, missionGroupId in ipairs(allGroupIdList) do
		local missionId2Parent = {}

		missionGroupTree[missionGroupId] = missionId2Parent

		local missionList = self:getAct157MissionList(actId, missionGroupId)

		for _, missionId in ipairs(missionList) do
			local parentMissionId
			local elementId = self:getMissionElementId(actId, missionId)
			local elementCo = elementId and DungeonConfig.instance:getChapterMapElement(elementId)
			local condition = elementCo and elementCo.condition

			if not string.nilorempty(condition) then
				local _, strPreElementId = string.match(condition, "(ChapterMapElement=)(%d+)")
				local preElementId = strPreElementId and tonumber(strPreElementId)

				parentMissionId = self:getMissionIdByElementId(actId, preElementId)
			end

			missionId2Parent[missionId] = parentMissionId
		end
	end
end

local function getAct157ConstCfg(actId, id, nilError)
	local cfg

	if actId and id then
		local actCfgDict = lua_activity157_const.configDict[actId]

		cfg = actCfgDict and actCfgDict[id]
	end

	if not cfg and nilError then
		logError(string.format("Activity157Config:getAct157ConstCfg error, cfg is nil, actId:%s  id:%s", actId, id))
	end

	return cfg
end

function Activity157Config:getAct157Const(actId, id)
	local result
	local cfg = getAct157ConstCfg(actId, id, true)

	if cfg then
		result = cfg.value
	end

	return result
end

function Activity157Config:getAct157FactoryProductCapacity(actId, id)
	local result = 0
	local strCapacity = self:getAct157Const(actId, id)
	local params = strCapacity and string.splitToNumber(strCapacity, "#")
	local day = params and params[1]
	local dayCapacity = params and params[2]

	if day and dayCapacity then
		result = day * dayCapacity
	end

	return result
end

function Activity157Config:getAct157CompositeFormula(actId)
	local result = {}
	local id = Activity157Enum.ConstId.FactoryCompositeFormula
	local strFormula = self:getAct157Const(actId, id)

	result = ItemModel.instance:getItemDataListByConfigStr(strFormula)

	return result
end

local function getAct157FactoryComponentCfg(actId, componentId, nilError)
	local cfg

	componentId = tonumber(componentId)

	if actId and componentId then
		local actCfgDict = lua_activity157_factory_component.configDict[actId]

		cfg = actCfgDict and actCfgDict[componentId]
	end

	if not cfg and nilError then
		logError(string.format("Activity157Config:getAct157FactoryComponentCfg error, cfg is nil, actId:%s  id:%s", actId, componentId))
	end

	return cfg
end

function Activity157Config:getComponentUnlockCondition(actId, componentId)
	local type, id, quantity
	local cfg = getAct157FactoryComponentCfg(actId, componentId, true)

	if cfg then
		local strCondition = cfg.unlockCondition
		local unlockParams = string.splitToNumber(strCondition, "#")

		type = unlockParams[1]
		id = unlockParams[2]
		quantity = unlockParams[3]
	end

	return type, id, quantity
end

function Activity157Config:getPreComponentId(actId, componentId)
	local result = 0
	local cfg = getAct157FactoryComponentCfg(actId, componentId, true)

	if cfg then
		result = cfg.preComponentId
	end

	return result
end

function Activity157Config:getComponentReward(actId, componentId)
	local result
	local cfg = getAct157FactoryComponentCfg(actId, componentId, true)

	if cfg then
		result = cfg.bonusForShow
	end

	return result
end

function Activity157Config:getComponentBonusBuildingLevel(actId, componentId)
	local result = 1
	local cfg = getAct157FactoryComponentCfg(actId, componentId, true)

	if cfg then
		result = tonumber(cfg.bonusBuildingLevel)
	end

	return result
end

function Activity157Config:getComponentIdList(actId)
	local result = {}

	if lua_activity157_factory_component then
		local actCfgDict = lua_activity157_factory_component.configDict[actId]

		for componentId, _ in pairs(actCfgDict) do
			result[#result + 1] = componentId
		end
	end

	table.sort(result, _sortById)

	return result
end

local function getAct157RepairMapCfg(actId, componentId, nilError)
	local cfg

	if actId and componentId then
		local actCfgDict = lua_activity157_repair_map.configDict[actId]

		cfg = actCfgDict and actCfgDict[componentId]
	end

	if not cfg and nilError then
		logError(string.format("Activity157Config:getAct157RepairMapCfg error, cfg is nil, actId:%s  id:%s", actId, componentId))
	end

	return cfg
end

function Activity157Config:getAct157RepairMapTitleTip(actId, componentId)
	local result = ""
	local cfg = getAct157RepairMapCfg(actId, componentId, true)

	if cfg then
		result = cfg.titleTip
	end

	return result
end

function Activity157Config:getAct157RepairMapTilebase(actId, componentId)
	local result
	local cfg = getAct157RepairMapCfg(actId, componentId, true)

	if cfg then
		result = cfg.tilebase
	end

	return result
end

function Activity157Config:getAct157RepairMapObjects(actId, componentId)
	local result
	local cfg = getAct157RepairMapCfg(actId, componentId, true)

	if cfg then
		result = cfg.objects
	end

	return result
end

local function getAct157MissionGroupCfg(actId, missionGroupId, nilError)
	local cfg

	if actId and missionGroupId then
		local actCfgDict = lua_activity157_mission_group.configDict[actId]

		cfg = actCfgDict and actCfgDict[missionGroupId]
	end

	if not cfg and nilError then
		logError(string.format("Activity157Config:getAct157MissionGroupCfg error, cfg is nil, actId:%s  id:%s", actId, missionGroupId))
	end

	return cfg
end

function Activity157Config:getMissionGroupType(actId, missionGroupId)
	local result
	local cfg = getAct157MissionGroupCfg(actId, missionGroupId, true)

	if cfg then
		result = cfg.type
	end

	return result
end

function Activity157Config:getAllMissionGroupIdList(actId)
	local result = {}
	local actCfgDict

	if actId then
		actCfgDict = lua_activity157_mission_group.configDict[actId]
	end

	if actCfgDict then
		for missionGroupId, _ in pairs(actCfgDict) do
			result[#result + 1] = missionGroupId
		end
	else
		logError(string.format("Activity157Config:getAllMissionGroupIdList error, cfg is nil, actId:%s ", actId))
	end

	table.sort(result, _sortById)

	return result
end

function Activity157Config:getRootMissionId(actId, missionGroupId)
	local result
	local actGroupDict = self.actId2MissionGroupDict[actId]

	if actGroupDict and missionGroupId then
		local missionList = actGroupDict[missionGroupId]

		if missionList then
			result = missionList[1]
		end
	end

	return result
end

function Activity157Config:getAct157MissionList(actId, missionGroupId)
	local result = {}

	if not actId or not missionGroupId then
		return result
	end

	local actGroupDict = self.actId2MissionGroupDict[actId]

	if actGroupDict then
		local missionList = actGroupDict[missionGroupId] or {}

		for _, missionId in ipairs(missionList) do
			result[#result + 1] = missionId
		end
	end

	return result
end

function Activity157Config:isSideMissionGroup(actId, missionGroupId)
	local result = true
	local missionGroupType = self:getMissionGroupType(actId, missionGroupId)

	if missionGroupType then
		result = missionGroupType == Activity157Enum.MissionType.SideMission
	end

	return result
end

function Activity157Config:getLeafMission(actId, missionGroupId)
	local result = {}

	if not actId or not missionGroupId then
		return result
	end

	local actGroupDict = self.actId2MissionGroupDict[actId]

	if actGroupDict and missionGroupId then
		local missionList = actGroupDict[missionGroupId] or {}

		for _, missionId in ipairs(missionList) do
			local childList = self:getAct157ChildMissionList(actId, missionId)

			if not childList or #childList <= 0 then
				result[#result] = missionId
			end
		end
	end

	return result
end

function Activity157Config:getMapName(actId, missionGroupId)
	local result = ""
	local cfg = getAct157MissionGroupCfg(actId, missionGroupId, true)

	if cfg then
		result = cfg.mapName
	end

	return result
end

local function getAct157MissionCfg(actId, missionId, nilError)
	local cfg

	if actId and missionId then
		local actCfgDict = lua_activity157_mission.configDict[actId]

		cfg = actCfgDict and actCfgDict[missionId]
	end

	if not cfg and nilError then
		logError(string.format("Activity157Config:getAct157MissionCfg error, cfg is nil, actId:%s  id:%s", actId, missionId))
	end

	return cfg
end

function Activity157Config:getAct157MissionPos(actId, missionId)
	local result
	local cfg = getAct157MissionCfg(actId, missionId, true)

	if cfg then
		result = string.splitToNumber(cfg.pos, "#")
	end

	return result
end

function Activity157Config:getAct157MissionOrder(actId, missionId)
	local result = 0
	local cfg = getAct157MissionCfg(actId, missionId, true)

	if cfg then
		result = cfg.order
	end

	return result
end

function Activity157Config:getMissionElementId(actId, missionId)
	local result
	local cfg = getAct157MissionCfg(actId, missionId, true)

	if cfg then
		result = cfg.elementId
	end

	return result
end

function Activity157Config:getAct157MissionStoryId(actId, missionId)
	local result
	local cfg = getAct157MissionCfg(actId, missionId, true)

	if cfg then
		result = cfg.storyId
	end

	return result
end

function Activity157Config:getMissionGroup(actId, missionId)
	local result
	local cfg = getAct157MissionCfg(actId, missionId, true)

	if cfg then
		result = cfg.groupId
	end

	return result
end

function Activity157Config:isRootMission(actId, missionId)
	local result = false
	local missionGroupId = self:getMissionGroup(actId, missionId)
	local rootMissionId = self:getRootMissionId(actId, missionGroupId)

	if missionId then
		result = missionId == rootMissionId
	end

	return result
end

function Activity157Config:isSideMission(actId, missionId)
	local missionGroupId = self:getMissionGroup(actId, missionId)
	local isSideMissionGroup = self:isSideMissionGroup(actId, missionGroupId)

	return isSideMissionGroup
end

function Activity157Config:getLineResPath(actId, missionId)
	local result = ""
	local cfg = getAct157MissionCfg(actId, missionId, true)

	if cfg then
		local strLine = cfg.linePrefab

		if not string.nilorempty(strLine) then
			result = string.format("%s_mapline", strLine)
		end
	end

	return result
end

function Activity157Config:getMissionIdByElementId(actId, elementId)
	local result

	if actId and elementId then
		local elementDict = self.actId2ElementDict[actId] or {}

		result = elementDict[elementId]
	end

	return result
end

function Activity157Config:getAct157ParentMissionId(actId, missionId)
	local result

	if not actId or not missionId then
		return result
	end

	if not self.actId2missionGroupTree or not self.actId2missionGroupTree[actId] then
		self:initMissionGroupTree(actId)
	end

	local missionGroupTree = self.actId2missionGroupTree[actId]
	local groupId = self:getMissionGroup(actId, missionId)

	if groupId then
		local missionId2ParentDict = missionGroupTree[groupId] or {}

		result = missionId2ParentDict[missionId]
	end

	return result
end

function Activity157Config:getAct157ChildMissionList(actId, missionId)
	local result = {}

	if not actId or not missionId then
		return result
	end

	if not self.actId2missionGroupTree or not self.actId2missionGroupTree[actId] then
		self:initMissionGroupTree(actId)
	end

	local missionGroupTree = self.actId2missionGroupTree[actId]
	local groupId = self:getMissionGroup(actId, missionId)

	if groupId then
		local missionId2ParentDict = missionGroupTree[groupId] or {}

		for childMissionId, parentMissionId in pairs(missionId2ParentDict) do
			if parentMissionId == missionId then
				result[#result + 1] = childMissionId
			end
		end
	end

	return result
end

function Activity157Config:getMissionArea(actId, missionId)
	local result = ""
	local cfg = getAct157MissionCfg(actId, missionId, true)

	if cfg then
		result = cfg.area
	end

	return result
end

Activity157Config.instance = Activity157Config.New()

return Activity157Config
