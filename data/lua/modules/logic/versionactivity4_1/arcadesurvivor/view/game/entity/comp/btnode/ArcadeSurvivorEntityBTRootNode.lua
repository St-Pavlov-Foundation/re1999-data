-- chunkname: @modules/logic/versionactivity4_1/arcadesurvivor/view/game/entity/comp/btnode/ArcadeSurvivorEntityBTRootNode.lua

module("modules.logic.versionactivity4_1.arcadesurvivor.view.game.entity.comp.btnode.ArcadeSurvivorEntityBTRootNode", package.seeall)

local ArcadeSurvivorEntityBTRootNode = class("ArcadeSurvivorEntityBTRootNode", ArcadeSurvivorEntityBTBaseNode)
local MAX_CONTINUE_TICK_COUNT = 64

function ArcadeSurvivorEntityBTRootNode:_onTick()
	local childNode = self:getChildNode(ArcadeSurvivorGameEnum.Const.RootNodeMaxChild)

	if not childNode then
		return ArcadeSurvivorGameEnum.BTNodeStatus.Failure
	end

	local status
	local continueOnSuccess = self:getParamValue(ArcadeSurvivorGameEnum.BTNodeParam.ContinueOnSuccess) == true
	local tickCount = 0

	repeat
		status = childNode:tick()
		tickCount = tickCount + 1

		if tickCount >= MAX_CONTINUE_TICK_COUNT then
			logError(string.format("ArcadeSurvivorEntityBTRootNode:_onTick error, continue tick over limit:%s, treeId:%s nodeId:%s", MAX_CONTINUE_TICK_COUNT, self._treeId, self._nodeId))

			return ArcadeSurvivorGameEnum.BTNodeStatus.Failure
		end
	until not continueOnSuccess or status ~= ArcadeSurvivorGameEnum.BTNodeStatus.Success

	return status
end

function ArcadeSurvivorEntityBTRootNode:onAbort()
	local childNode = self:getChildNode(ArcadeSurvivorGameEnum.Const.RootNodeMaxChild)

	if childNode then
		childNode:abort()
	end
end

return ArcadeSurvivorEntityBTRootNode
