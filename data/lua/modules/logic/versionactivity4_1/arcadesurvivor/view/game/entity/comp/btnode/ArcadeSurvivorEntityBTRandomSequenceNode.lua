-- chunkname: @modules/logic/versionactivity4_1/arcadesurvivor/view/game/entity/comp/btnode/ArcadeSurvivorEntityBTRandomSequenceNode.lua

module("modules.logic.versionactivity4_1.arcadesurvivor.view.game.entity.comp.btnode.ArcadeSurvivorEntityBTRandomSequenceNode", package.seeall)

local ArcadeSurvivorEntityBTRandomSequenceNode = class("ArcadeSurvivorEntityBTRandomSequenceNode", ArcadeSurvivorEntityBTSequenceNode)

function ArcadeSurvivorEntityBTRandomSequenceNode:onCtor(param)
	self._tickChildNodeList = {}
end

function ArcadeSurvivorEntityBTRandomSequenceNode:onStart()
	ArcadeSurvivorEntityBTSequenceNode.onStart(self)

	local childNodeList = {}

	for _, childNode in ipairs(self:getChildNodeList()) do
		childNodeList[#childNodeList + 1] = childNode
	end

	for index = #childNodeList, 2, -1 do
		local randomIndex = math.random(index)

		childNodeList[index], childNodeList[randomIndex] = childNodeList[randomIndex], childNodeList[index]
	end

	self._tickChildNodeList = childNodeList
end

function ArcadeSurvivorEntityBTRandomSequenceNode:_onTick()
	local childNodeList = self._tickChildNodeList
	local childCount = #childNodeList

	if childCount <= 0 then
		return ArcadeSurvivorGameEnum.BTNodeStatus.Success
	end

	while childCount >= self._curChildIndex do
		local childNode = childNodeList[self._curChildIndex]
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

function ArcadeSurvivorEntityBTRandomSequenceNode:onAbort()
	local childNode = self._tickChildNodeList[self._curChildIndex]

	if childNode then
		childNode:abort()
	end
end

function ArcadeSurvivorEntityBTRandomSequenceNode:_onReset()
	self._tickChildNodeList = {}
end

return ArcadeSurvivorEntityBTRandomSequenceNode
