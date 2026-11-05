-- chunkname: @modules/logic/versionactivity4_1/arcadesurvivor/model/hall/ArcadeSurvivorHallNPCMO.lua

module("modules.logic.versionactivity4_1.arcadesurvivor.model.hall.ArcadeSurvivorHallNPCMO", package.seeall)

local ArcadeSurvivorHallNPCMO = class("ArcadeSurvivorHallNPCMO", ArcadeSurvivorHallInteractiveMO)
local DEFAULT_WEIGHT = 100

function ArcadeSurvivorHallNPCMO:onInitTalk()
	self._totalWeight = {}
	self._group2StepCfgDict = {}
	self._stepContentDict = {}

	local id = self:getId()

	self._talkGroupIdList = ArcadeSurvivorConfig.instance:getHallUnitTalkGroupIdList(id)

	for _, groupId in pairs(self._talkGroupIdList) do
		local condition = ArcadeSurvivorConfig.instance:getTalkCondition(groupId)
		local weight = ArcadeSurvivorConfig.instance:getTalkWeight(groupId)

		self._totalWeight[condition] = (self._totalWeight[condition] or 0) + weight
	end
end

function ArcadeSurvivorHallNPCMO:getTalkGroupId(targetCondition)
	if not self._talkGroupIdList or #self._talkGroupIdList <= 0 then
		return
	end

	local randomWeight = math.random(1, self._totalWeight[targetCondition] or DEFAULT_WEIGHT)

	for _, groupId in pairs(self._talkGroupIdList) do
		local condition = ArcadeSurvivorConfig.instance:getTalkCondition(groupId)
		local weight = ArcadeSurvivorConfig.instance:getTalkWeight(groupId)

		if condition == targetCondition then
			if randomWeight <= weight then
				return groupId
			else
				randomWeight = randomWeight - weight
			end
		end
	end
end

function ArcadeSurvivorHallNPCMO:getStepContentInfo(groupId, stepId)
	local cfgList = self:_getGroupStepCfgList(groupId)
	local stepCfg = cfgList and cfgList[stepId]

	if not stepCfg then
		return
	end

	local stepDict = GameUtil.tabletool_checkDictTable(self._stepContentDict, groupId)
	local contentInfoList = stepDict[stepId]

	if not contentInfoList then
		local content = stepCfg.content

		if string.nilorempty(content) then
			return
		end

		contentInfoList = {}

		self:_matchContentColor(content, contentInfoList)

		stepDict[stepId] = contentInfoList
	end

	return contentInfoList, stepCfg.block
end

local function _sortByStep(a, b)
	return a.step < b.step
end

function ArcadeSurvivorHallNPCMO:_getGroupStepCfgList(groupId)
	local stepCfgList = self._group2StepCfgDict[groupId]

	if not stepCfgList then
		stepCfgList = {}

		local cfgDict = ArcadeSurvivorConfig.instance:getTalkStepDict(groupId)

		if not cfgDict then
			return
		end

		for _, stepCfg in pairs(cfgDict) do
			stepCfgList[#stepCfgList + 1] = stepCfg
		end

		table.sort(stepCfgList, _sortByStep)

		self._group2StepCfgDict[groupId] = stepCfgList
	end

	return stepCfgList
end

function ArcadeSurvivorHallNPCMO:_matchContentColor(content, refList)
	if LuaUtil.isEmptyStr(content) then
		return
	end

	local startIndex, endIndex = string.find(content, "</color>")
	local lastCharArr = refList[#refList] or ""

	if not startIndex then
		local list3 = LuaUtil.getUCharArrWithLineFeed(content)

		for _, charArr in ipairs(list3) do
			local arr = lastCharArr .. charArr

			refList[#refList + 1] = arr
			lastCharArr = arr
		end

		return
	end

	local content1 = string.sub(content, 0, endIndex)
	local m1, m2, m3 = string.match(content1, "(.-)<color=(.-)>(.-)</color>")
	local list1 = LuaUtil.getUCharArrWithLineFeed(m1)

	for _, charArr in ipairs(list1) do
		local arr = lastCharArr .. charArr

		refList[#refList + 1] = arr
		lastCharArr = arr
	end

	local list2 = LuaUtil.getUCharArrWithLineFeed(m3)
	local lastCharArr2 = ""

	for _, charArr in ipairs(list2) do
		local arr = string.format("%s<color=%s>%s%s</color>", lastCharArr, m2, lastCharArr2, charArr)

		refList[#refList + 1] = arr
		lastCharArr2 = lastCharArr2 .. charArr
	end

	if not endIndex then
		return
	end

	local content2 = string.sub(content, endIndex + 1, #content)

	self:_matchContentColor(content2, refList)
end

return ArcadeSurvivorHallNPCMO
