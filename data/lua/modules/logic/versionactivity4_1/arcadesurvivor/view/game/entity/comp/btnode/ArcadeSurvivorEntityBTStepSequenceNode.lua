-- chunkname: @modules/logic/versionactivity4_1/arcadesurvivor/view/game/entity/comp/btnode/ArcadeSurvivorEntityBTStepSequenceNode.lua

module("modules.logic.versionactivity4_1.arcadesurvivor.view.game.entity.comp.btnode.ArcadeSurvivorEntityBTStepSequenceNode", package.seeall)

local ArcadeSurvivorEntityBTStepSequenceNode = class("ArcadeSurvivorEntityBTStepSequenceNode", ArcadeSurvivorEntityBTBaseNode)

function ArcadeSurvivorEntityBTStepSequenceNode:onCtor(param)
	self._curChildIndex = 1
end

function ArcadeSurvivorEntityBTStepSequenceNode:onStart()
	self._curChildIndex = 1
end

function ArcadeSurvivorEntityBTStepSequenceNode:_onTick()
	local childCount = self:getChildNodeCount()

	if childCount <= 0 then
		return ArcadeSurvivorGameEnum.BTNodeStatus.Success
	end

	local childNode = self:getChildNode(self._curChildIndex)
	local status = childNode:tick()

	if status == ArcadeSurvivorGameEnum.BTNodeStatus.Running then
		return status
	end

	if status == ArcadeSurvivorGameEnum.BTNodeStatus.Failure then
		self._curChildIndex = 1

		return status
	end

	self._curChildIndex = self._curChildIndex + 1

	if childCount < self._curChildIndex then
		return ArcadeSurvivorGameEnum.BTNodeStatus.Success
	end

	return ArcadeSurvivorGameEnum.BTNodeStatus.Running
end

function ArcadeSurvivorEntityBTStepSequenceNode:onAbort()
	local childNode = self:getChildNode(self._curChildIndex)

	if childNode then
		childNode:abort()
	end
end

function ArcadeSurvivorEntityBTStepSequenceNode:_onReset()
	self._curChildIndex = 1
end

return ArcadeSurvivorEntityBTStepSequenceNode
