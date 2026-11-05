-- chunkname: @modules/logic/versionactivity4_1/arcadesurvivor/view/game/entity/comp/btnode/ArcadeSurvivorEntityBTWaitTurnsNode.lua

module("modules.logic.versionactivity4_1.arcadesurvivor.view.game.entity.comp.btnode.ArcadeSurvivorEntityBTWaitTurnsNode", package.seeall)

local ArcadeSurvivorEntityBTWaitTurnsNode = class("ArcadeSurvivorEntityBTWaitTurnsNode", ArcadeSurvivorEntityBTBaseNode)

function ArcadeSurvivorEntityBTWaitTurnsNode:onCtor(param)
	self._totalTurns = self:_getTotalTurns()
	self._waitedTurns = 0
end

function ArcadeSurvivorEntityBTWaitTurnsNode:onStart()
	self._waitedTurns = 0
end

function ArcadeSurvivorEntityBTWaitTurnsNode:_onTick()
	local totalTurns = self._totalTurns

	if totalTurns <= 0 then
		return ArcadeSurvivorGameEnum.BTNodeStatus.Success
	end

	self._waitedTurns = self._waitedTurns + 1

	if totalTurns < self._waitedTurns then
		return ArcadeSurvivorGameEnum.BTNodeStatus.Success
	end

	return ArcadeSurvivorGameEnum.BTNodeStatus.Running
end

function ArcadeSurvivorEntityBTWaitTurnsNode:_getTotalTurns()
	local turns = tonumber(self:getParamValue(ArcadeSurvivorGameEnum.BTNodeParam.Turns))

	if not turns or turns <= 0 then
		logError(string.format("ArcadeSurvivorEntityBTWaitTurnsNode:_getTotalTurns error, params.turns is invalid, treat as no wait, treeId:%s nodeId:%s turns:%s", self._treeId, self._nodeId, tostring(turns)))

		return 0
	end

	return math.floor(turns)
end

return ArcadeSurvivorEntityBTWaitTurnsNode
