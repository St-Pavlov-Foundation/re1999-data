-- chunkname: @modules/logic/versionactivity4_1/arcadesurvivor/view/game/entity/comp/btnode/ArcadeSurvivorEntityBTBaseNode.lua

module("modules.logic.versionactivity4_1.arcadesurvivor.view.game.entity.comp.btnode.ArcadeSurvivorEntityBTBaseNode", package.seeall)

local ArcadeSurvivorEntityBTBaseNode = class("ArcadeSurvivorEntityBTBaseNode")

function ArcadeSurvivorEntityBTBaseNode:ctor(param)
	self._treeId = param.treeId
	self._nodeId = param.nodeId
	self._nodeType = param.nodeType
	self._params = param.params
	self._childIds = param.childIds or {}
	self._entity = param.entity
	self._blackboard = param.blackboard
	self._parentNode = nil
	self._childNodeList = {}
	self._paramDict = nil
	self._status = ArcadeSurvivorGameEnum.BTNodeStatus.Failure
	self._isActive = false

	self:onCtor(param)
end

function ArcadeSurvivorEntityBTBaseNode:tick()
	if not self._isActive then
		self._isActive = true

		self:onStart()
	end

	local status = self:_onTick() or ArcadeSurvivorGameEnum.BTNodeStatus.Failure

	self._status = status

	if status ~= ArcadeSurvivorGameEnum.BTNodeStatus.Running then
		self._isActive = false
	end

	return status
end

function ArcadeSurvivorEntityBTBaseNode:abort()
	if not self._isActive then
		return
	end

	self._isActive = false
	self._status = ArcadeSurvivorGameEnum.BTNodeStatus.Failure

	self:onAbort()
end

function ArcadeSurvivorEntityBTBaseNode:reset()
	self:abort()

	self._status = ArcadeSurvivorGameEnum.BTNodeStatus.Failure

	self:_onReset()
end

function ArcadeSurvivorEntityBTBaseNode:getStatus()
	return self._status
end

function ArcadeSurvivorEntityBTBaseNode:isRunning()
	return self._status == ArcadeSurvivorGameEnum.BTNodeStatus.Running
end

function ArcadeSurvivorEntityBTBaseNode:isActive()
	return self._isActive
end

function ArcadeSurvivorEntityBTBaseNode:getTreeId()
	return self._treeId
end

function ArcadeSurvivorEntityBTBaseNode:getNodeId()
	return self._nodeId
end

function ArcadeSurvivorEntityBTBaseNode:getNodeType()
	return self._nodeType
end

function ArcadeSurvivorEntityBTBaseNode:getChildIds()
	return self._childIds
end

function ArcadeSurvivorEntityBTBaseNode:getEntity()
	return self._entity
end

function ArcadeSurvivorEntityBTBaseNode:getMO()
	return self._entity and self._entity:getMO()
end

function ArcadeSurvivorEntityBTBaseNode:getParentNode()
	return self._parentNode
end

function ArcadeSurvivorEntityBTBaseNode:getChildNodeList()
	return self._childNodeList
end

function ArcadeSurvivorEntityBTBaseNode:getChildNode(index)
	return self._childNodeList[index]
end

function ArcadeSurvivorEntityBTBaseNode:getChildNodeCount()
	return #self._childNodeList
end

function ArcadeSurvivorEntityBTBaseNode:getParamDict()
	if not self._paramDict then
		self._paramDict = self:_decodeParams()
	end

	return self._paramDict
end

function ArcadeSurvivorEntityBTBaseNode:getParamValue(key)
	local paramDict = self:getParamDict()

	return paramDict and paramDict[key]
end

function ArcadeSurvivorEntityBTBaseNode:_decodeParams()
	if string.nilorempty(self._params) then
		return {}
	end

	local isOk, paramDict = pcall(cjson.decode, self._params)

	if not isOk or type(paramDict) ~= "table" then
		logError(string.format("ArcadeSurvivorEntityBTBaseNode:_decodeParams error, params is not a json object, treeId:%s nodeId:%s nodeType:%s params:%s", self._treeId, self._nodeId, self._nodeType, self._params))

		return {}
	end

	return paramDict
end

function ArcadeSurvivorEntityBTBaseNode:getBlackboardValue(valueCfg)
	return self._blackboard:getValue(valueCfg)
end

function ArcadeSurvivorEntityBTBaseNode:getStoreKey(defaultKey)
	local key = self:getParamValue(ArcadeSurvivorGameEnum.BTNodeParam.StoreKey)

	if string.nilorempty(key) then
		key = defaultKey
	end

	if ArcadeSurvivorGameEnum.BTVarName[key] then
		return key
	else
		logError(string.format("ArcadeSurvivorEntityBTBaseNode:getStoreKey error, key is not registered in BTVarName, treeId:%s nodeId:%s key:%s", self._treeId, self._nodeId, tostring(key)))
	end
end

function ArcadeSurvivorEntityBTBaseNode:setParentNode(parentNode)
	self._parentNode = parentNode
end

function ArcadeSurvivorEntityBTBaseNode:addChildNode(childNode)
	if not childNode then
		return
	end

	childNode:setParentNode(self)

	self._childNodeList[#self._childNodeList + 1] = childNode
end

function ArcadeSurvivorEntityBTBaseNode:onCtor(param)
	return
end

function ArcadeSurvivorEntityBTBaseNode:onStart()
	return
end

function ArcadeSurvivorEntityBTBaseNode:_onTick()
	logError(string.format("ArcadeSurvivorEntityBTBaseNode._onTick error, need override this func, treeId:%s nodeId:%s nodeType:%s", self._treeId, self._nodeId, self._nodeType))

	return ArcadeSurvivorGameEnum.BTNodeStatus.Failure
end

function ArcadeSurvivorEntityBTBaseNode:onAbort()
	return
end

function ArcadeSurvivorEntityBTBaseNode:_onReset()
	return
end

function ArcadeSurvivorEntityBTBaseNode:_onDestroy()
	return
end

function ArcadeSurvivorEntityBTBaseNode:destroy()
	self:abort()
	self:_onDestroy()

	for _, childNode in ipairs(self._childNodeList) do
		childNode:setParentNode(nil)
	end

	self._childNodeList = {}
	self._parentNode = nil
	self._paramDict = nil
	self._childIds = {}
	self._entity = nil
	self._blackboard = nil
end

return ArcadeSurvivorEntityBTBaseNode
