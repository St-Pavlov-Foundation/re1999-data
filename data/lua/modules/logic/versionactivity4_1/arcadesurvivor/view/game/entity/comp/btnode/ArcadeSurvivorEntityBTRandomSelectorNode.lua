-- chunkname: @modules/logic/versionactivity4_1/arcadesurvivor/view/game/entity/comp/btnode/ArcadeSurvivorEntityBTRandomSelectorNode.lua

module("modules.logic.versionactivity4_1.arcadesurvivor.view.game.entity.comp.btnode.ArcadeSurvivorEntityBTRandomSelectorNode", package.seeall)

local ArcadeSurvivorEntityBTRandomSelectorNode = class("ArcadeSurvivorEntityBTRandomSelectorNode", ArcadeSurvivorEntityBTSelectorNode)

function ArcadeSurvivorEntityBTRandomSelectorNode:_buildTickChildNodeList()
	local childNodeList = {}

	for _, childNode in ipairs(self:getChildNodeList()) do
		childNodeList[#childNodeList + 1] = childNode
	end

	if self._lastChildNodeId and self:getParamValue(ArcadeSurvivorGameEnum.BTNodeParam.ExcludeLast) ~= nil then
		local candidateList = {}

		for _, childNode in ipairs(childNodeList) do
			if childNode:getNodeId() ~= self._lastChildNodeId then
				candidateList[#candidateList + 1] = childNode
			end
		end

		if #candidateList > 0 then
			childNodeList = candidateList
		end
	end

	for index = #childNodeList, 2, -1 do
		local randomIndex = math.random(index)

		childNodeList[index], childNodeList[randomIndex] = childNodeList[randomIndex], childNodeList[index]
	end

	return childNodeList
end

function ArcadeSurvivorEntityBTRandomSelectorNode:_onChildSuccess(childNode)
	self._lastChildNodeId = childNode:getNodeId()
end

function ArcadeSurvivorEntityBTRandomSelectorNode:_onReset()
	self._lastChildNodeId = nil
end

return ArcadeSurvivorEntityBTRandomSelectorNode
