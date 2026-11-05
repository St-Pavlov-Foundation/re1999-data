-- chunkname: @modules/logic/versionactivity4_1/arcadesurvivor/view/game/entity/comp/btnode/ArcadeSurvivorEntityBTRandomNode.lua

module("modules.logic.versionactivity4_1.arcadesurvivor.view.game.entity.comp.btnode.ArcadeSurvivorEntityBTRandomNode", package.seeall)

local ArcadeSurvivorEntityBTRandomNode = class("ArcadeSurvivorEntityBTRandomNode", ArcadeSurvivorEntityBTBaseNode)

function ArcadeSurvivorEntityBTRandomNode:onStart()
	self._randomChildNode = nil
end

function ArcadeSurvivorEntityBTRandomNode:_onTick()
	if not self._randomChildNode then
		self._randomChildNode = self:_findRandomChildNode()
	end

	if not self._randomChildNode then
		return ArcadeSurvivorGameEnum.BTNodeStatus.Failure
	end

	return self._randomChildNode:tick()
end

function ArcadeSurvivorEntityBTRandomNode:onAbort()
	if self._randomChildNode then
		self._randomChildNode:abort()
	end
end

function ArcadeSurvivorEntityBTRandomNode:_findRandomChildNode()
	local childNodeList = self:getChildNodeList()
	local childCount = #childNodeList

	if childCount <= 0 then
		return
	end

	if self._candidateList == nil then
		self:_buildCandidateList()
	end

	local candidateList = self._candidateList
	local candidateCount = #candidateList

	if candidateCount <= 0 then
		return childNodeList[math.random(childCount)]
	end

	local randomValue = math.random() * self._totalWeight

	for index = 1, candidateCount do
		local weight = self._weightList[index]

		randomValue = randomValue - weight

		if randomValue < 0 then
			return candidateList[index]
		end
	end

	return candidateList[candidateCount]
end

function ArcadeSurvivorEntityBTRandomNode:_buildCandidateList()
	local candidateList = {}
	local weightList = {}
	local candidateCount = 0
	local totalWeight = 0
	local weightMap = self:getParamValue(ArcadeSurvivorGameEnum.BTNodeParam.WeightMap)
	local childNodeList = self:getChildNodeList()

	for _, childNode in ipairs(childNodeList) do
		local weight = self:_getChildWeight(weightMap, childNode)

		if weight > 0 then
			candidateCount = candidateCount + 1
			candidateList[candidateCount] = childNode
			weightList[candidateCount] = weight
			totalWeight = totalWeight + weight
		end
	end

	self._candidateList = candidateList
	self._weightList = weightList
	self._totalWeight = totalWeight
end

function ArcadeSurvivorEntityBTRandomNode:_getChildWeight(weightMap, childNode)
	if not weightMap then
		return 0
	end

	local nodeId = childNode:getNodeId()
	local weight = tonumber(weightMap[nodeId]) or tonumber(weightMap[tostring(nodeId)]) or 0

	if weight < 0 then
		return 0
	end

	return weight
end

function ArcadeSurvivorEntityBTRandomNode:_onDestroy()
	self._candidateList = nil
	self._weightList = nil
	self._totalWeight = nil
end

return ArcadeSurvivorEntityBTRandomNode
