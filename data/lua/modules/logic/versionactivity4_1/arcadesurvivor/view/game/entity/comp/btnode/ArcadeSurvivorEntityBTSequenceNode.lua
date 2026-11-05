-- chunkname: @modules/logic/versionactivity4_1/arcadesurvivor/view/game/entity/comp/btnode/ArcadeSurvivorEntityBTSequenceNode.lua

module("modules.logic.versionactivity4_1.arcadesurvivor.view.game.entity.comp.btnode.ArcadeSurvivorEntityBTSequenceNode", package.seeall)

local ArcadeSurvivorEntityBTSequenceNode = class("ArcadeSurvivorEntityBTSequenceNode", ArcadeSurvivorEntityBTBaseNode)

function ArcadeSurvivorEntityBTSequenceNode:onCtor(param)
	self._curChildIndex = 1
end

function ArcadeSurvivorEntityBTSequenceNode:onStart()
	self._curChildIndex = 1
end

function ArcadeSurvivorEntityBTSequenceNode:_onTick()
	local childCount = self:getChildNodeCount()

	if childCount <= 0 then
		return ArcadeSurvivorGameEnum.BTNodeStatus.Success
	end

	while childCount >= self._curChildIndex do
		local childNode = self:getChildNode(self._curChildIndex)
		local status = childNode:tick()

		if status == ArcadeSurvivorGameEnum.BTNodeStatus.Running then
			return status
		end

		if status == ArcadeSurvivorGameEnum.BTNodeStatus.Failure then
			return status
		end

		self._curChildIndex = self._curChildIndex + 1
	end

	return ArcadeSurvivorGameEnum.BTNodeStatus.Success
end

function ArcadeSurvivorEntityBTSequenceNode:onAbort()
	local childNode = self:getChildNode(self._curChildIndex)

	if childNode then
		childNode:abort()
	end
end

return ArcadeSurvivorEntityBTSequenceNode
