-- chunkname: @modules/logic/versionactivity4_1/arcadesurvivor/view/game/entity/comp/btnode/ArcadeSurvivorEntityBTCompareNode.lua

module("modules.logic.versionactivity4_1.arcadesurvivor.view.game.entity.comp.btnode.ArcadeSurvivorEntityBTCompareNode", package.seeall)

local ArcadeSurvivorEntityBTCompareNode = class("ArcadeSurvivorEntityBTCompareNode", ArcadeSurvivorEntityBTBaseNode)

function ArcadeSurvivorEntityBTCompareNode:onCtor(param)
	local op = self:getParamValue(ArcadeSurvivorGameEnum.BTNodeParam.Op)

	self._op = op
	self._compareOp = ArcadeSurvivorGameHelper.getBTCompareOp(op)
end

function ArcadeSurvivorEntityBTCompareNode:_onTick()
	if not self._compareOp then
		return ArcadeSurvivorGameEnum.BTNodeStatus.Failure
	end

	local left = self:getBlackboardValue(self:getParamValue(ArcadeSurvivorGameEnum.BTNodeParam.Left))
	local right = self:getBlackboardValue(self:getParamValue(ArcadeSurvivorGameEnum.BTNodeParam.Right))

	if left == nil or right == nil then
		logError(string.format("ArcadeSurvivorEntityBTCompareNode:_onTick error, can not resolve l or r, treeId:%s nodeId:%s", self._treeId, self._nodeId))

		return ArcadeSurvivorGameEnum.BTNodeStatus.Failure
	end

	if not ArcadeSurvivorGameHelper.isBTCompareOperandValid(self._compareOp.isOrder, left, right) then
		return ArcadeSurvivorGameEnum.BTNodeStatus.Failure
	end

	if self._compareOp.compFunc(left, right) then
		return ArcadeSurvivorGameEnum.BTNodeStatus.Success
	end

	return ArcadeSurvivorGameEnum.BTNodeStatus.Failure
end

return ArcadeSurvivorEntityBTCompareNode
