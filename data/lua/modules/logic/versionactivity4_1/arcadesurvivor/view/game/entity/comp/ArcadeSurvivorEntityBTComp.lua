-- chunkname: @modules/logic/versionactivity4_1/arcadesurvivor/view/game/entity/comp/ArcadeSurvivorEntityBTComp.lua

module("modules.logic.versionactivity4_1.arcadesurvivor.view.game.entity.comp.ArcadeSurvivorEntityBTComp", package.seeall)

local ArcadeSurvivorEntityBTComp = class("ArcadeSurvivorEntityBTComp", ArcadeSurvivorEntityBaseComp)

function ArcadeSurvivorEntityBTComp:ctor(param)
	self._entity = param.entity
	self._compName = param.compName
	self._treeId = nil
	self._rootNode = nil
	self._nodeDict = {}
	self._blackboard = nil
end

function ArcadeSurvivorEntityBTComp:onInit()
	local mo = self._entity:getMO()

	self._blackboard = ArcadeSurvivorEntityBTBlackboard.New(mo)

	self:_buildTree()
end

function ArcadeSurvivorEntityBTComp:_buildTree()
	self:_clearTree()

	local mo = self._entity and self._entity:getMO()
	local treeId = mo and mo:getTreeId()

	if not treeId or treeId <= 0 then
		return
	end

	local cfgNodeDict = ArcadeSurvivorConfig.instance:getBehaviorNodeDict(treeId, true)

	if not cfgNodeDict then
		return
	end

	self._treeId = treeId

	for nodeId in pairs(cfgNodeDict) do
		self._nodeDict[nodeId] = self:_createNode(treeId, nodeId)
	end

	self._rootNode = self:_findRootNode()

	self:_linkChildNodes()
end

function ArcadeSurvivorEntityBTComp:_createNode(treeId, nodeId)
	local config = ArcadeSurvivorConfig.instance
	local nodeType = config:getBehaviorNodeType(treeId, nodeId)
	local nodeCls = ArcadeSurvivorGameEnum.BTNodeTypeCls[nodeType]

	if not nodeCls then
		logError(string.format("ArcadeSurvivorEntityBTComp:_createNode error, can't find cls define, treeId:%s nodeId:%s nodeType:%s", treeId, nodeId, nodeType))

		nodeCls = ArcadeSurvivorEntityBTBaseNode
	end

	local nodeParam = {
		treeId = treeId,
		nodeId = nodeId,
		nodeType = nodeType,
		params = config:getBehaviorNodeParams(treeId, nodeId),
		childIds = config:getBehaviorChildIdList(treeId, nodeId),
		entity = self._entity,
		blackboard = self._blackboard
	}

	return nodeCls.New(nodeParam)
end

local ROOT_NODE_DEPTH = 1

function ArcadeSurvivorEntityBTComp:_linkChildNodes()
	if not self._rootNode then
		return
	end

	self:_linkChildNode(self._rootNode, {}, ROOT_NODE_DEPTH)
end

function ArcadeSurvivorEntityBTComp:_linkChildNode(parentNode, pathDict, depth)
	local parentNodeId = parentNode:getNodeId()
	local childIds = parentNode:getChildIds()

	pathDict[parentNodeId] = true

	local linkCount = #childIds

	if parentNode:getNodeType() == ArcadeSurvivorGameEnum.BTNodeType.Root and linkCount > ArcadeSurvivorGameEnum.Const.RootNodeMaxChild then
		logError(string.format("ArcadeSurvivorEntityBTComp:_linkChildNode error, root node can only have one child, childIdCount:%s, drop the extra edges, treeId:%s nodeId:%s", linkCount, self._treeId, parentNodeId))

		linkCount = ArcadeSurvivorGameEnum.Const.RootNodeMaxChild
	end

	for index = 1, linkCount do
		local childId = childIds[index]
		local childNode = self._nodeDict[childId]

		if not childNode then
			logError(string.format("ArcadeSurvivorEntityBTComp:_linkChildNode error, child node is nil, treeId:%s nodeId:%s childId:%s", self._treeId, parentNodeId, childId))
		elseif pathDict[childId] then
			logError(string.format("ArcadeSurvivorEntityBTComp:_linkChildNode error, childIds has a cycle, drop this edge, treeId:%s nodeId:%s childId:%s", self._treeId, parentNodeId, childId))
		elseif childNode:getParentNode() then
			logError(string.format("ArcadeSurvivorEntityBTComp:_linkChildNode error, child node is already linked, maybe duplicated childIds or multi parent, drop this edge, treeId:%s nodeId:%s childId:%s", self._treeId, parentNodeId, childId))
		elseif depth >= ArcadeSurvivorGameEnum.Const.MaxBTNodeDepth then
			logError(string.format("ArcadeSurvivorEntityBTComp:_linkChildNode error, tree depth over limit:%s, drop this edge, treeId:%s nodeId:%s childId:%s", ArcadeSurvivorGameEnum.Const.MaxBTNodeDepth, self._treeId, parentNodeId, childId))
		else
			parentNode:addChildNode(childNode)
			self:_linkChildNode(childNode, pathDict, depth + 1)
		end
	end

	pathDict[parentNodeId] = nil
end

function ArcadeSurvivorEntityBTComp:_findRootNode()
	local rootNode

	for nodeId, node in pairs(self._nodeDict) do
		local isRootType = node:getNodeType() == ArcadeSurvivorGameEnum.BTNodeType.Root

		if isRootType and (not rootNode or nodeId < rootNode:getNodeId()) then
			rootNode = node
		end
	end

	if not rootNode then
		logError(string.format("ArcadeSurvivorEntityBTComp:_findRootNode error, can't find root node, treeId:%s", self._treeId))
	end

	return rootNode
end

function ArcadeSurvivorEntityBTComp:tick()
	local status = ArcadeSurvivorGameEnum.BTNodeStatus.Failure

	if self._rootNode then
		status = self._rootNode:tick()
	end

	return status
end

function ArcadeSurvivorEntityBTComp:reset()
	for _, node in pairs(self._nodeDict) do
		node:reset()
	end
end

function ArcadeSurvivorEntityBTComp:getStatus()
	local status = ArcadeSurvivorGameEnum.BTNodeStatus.Failure

	if self._rootNode then
		status = self._rootNode:getStatus()
	end

	return status
end

function ArcadeSurvivorEntityBTComp:getTreeId()
	return self._treeId
end

function ArcadeSurvivorEntityBTComp:getRootNode()
	return self._rootNode
end

function ArcadeSurvivorEntityBTComp:getNode(nodeId)
	return self._nodeDict[nodeId]
end

function ArcadeSurvivorEntityBTComp:getEntity()
	return self._entity
end

function ArcadeSurvivorEntityBTComp:onClear()
	self:_clearTree()

	if self._blackboard then
		self._blackboard:clearAllVar()
	end

	self._blackboard = nil
end

function ArcadeSurvivorEntityBTComp:_clearTree()
	for _, node in pairs(self._nodeDict) do
		node:destroy()
	end

	self._nodeDict = {}
	self._rootNode = nil
	self._treeId = nil
end

return ArcadeSurvivorEntityBTComp
