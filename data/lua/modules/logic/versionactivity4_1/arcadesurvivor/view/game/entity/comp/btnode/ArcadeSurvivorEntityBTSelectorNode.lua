-- chunkname: @modules/logic/versionactivity4_1/arcadesurvivor/view/game/entity/comp/btnode/ArcadeSurvivorEntityBTSelectorNode.lua

module("modules.logic.versionactivity4_1.arcadesurvivor.view.game.entity.comp.btnode.ArcadeSurvivorEntityBTSelectorNode", package.seeall)

local ArcadeSurvivorEntityBTSelectorNode = class("ArcadeSurvivorEntityBTSelectorNode", ArcadeSurvivorEntityBTBaseNode)

function ArcadeSurvivorEntityBTSelectorNode:onCtor(param)
	self._curChildIndex = 1
	self._tickChildNodeList = {}
end

function ArcadeSurvivorEntityBTSelectorNode:onStart()
	self._curChildIndex = 1
	self._tickChildNodeList = self:_buildTickChildNodeList()
end

function ArcadeSurvivorEntityBTSelectorNode:_onTick()
	local childNodeList = self._tickChildNodeList
	local childCount = #childNodeList

	if childCount <= 0 then
		return ArcadeSurvivorGameEnum.BTNodeStatus.Failure
	end

	while childCount >= self._curChildIndex do
		local childNode = childNodeList[self._curChildIndex]
		local status = childNode:tick()

		if status == ArcadeSurvivorGameEnum.BTNodeStatus.Running then
			return status
		end

		if status == ArcadeSurvivorGameEnum.BTNodeStatus.Success then
			self:_onChildSuccess(childNode)

			return status
		end

		self._curChildIndex = self._curChildIndex + 1
	end

	return ArcadeSurvivorGameEnum.BTNodeStatus.Failure
end

function ArcadeSurvivorEntityBTSelectorNode:onAbort()
	local childNode = self:getCurChildNode()

	if childNode then
		childNode:abort()
	end
end

function ArcadeSurvivorEntityBTSelectorNode:getCurChildNode()
	return self._tickChildNodeList[self._curChildIndex]
end

function ArcadeSurvivorEntityBTSelectorNode:_buildTickChildNodeList()
	return self:getChildNodeList()
end

function ArcadeSurvivorEntityBTSelectorNode:_onChildSuccess(childNode)
	return
end

return ArcadeSurvivorEntityBTSelectorNode
