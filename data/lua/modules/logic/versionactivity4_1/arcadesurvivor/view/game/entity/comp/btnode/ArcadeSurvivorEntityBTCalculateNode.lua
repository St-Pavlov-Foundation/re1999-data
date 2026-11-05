-- chunkname: @modules/logic/versionactivity4_1/arcadesurvivor/view/game/entity/comp/btnode/ArcadeSurvivorEntityBTCalculateNode.lua

module("modules.logic.versionactivity4_1.arcadesurvivor.view.game.entity.comp.btnode.ArcadeSurvivorEntityBTCalculateNode", package.seeall)

local ArcadeSurvivorEntityBTCalculateNode = class("ArcadeSurvivorEntityBTCalculateNode", ArcadeSurvivorEntityBTBaseNode)

function ArcadeSurvivorEntityBTCalculateNode:onCtor(param)
	local op = self:getParamValue(ArcadeSurvivorGameEnum.BTNodeParam.Op)

	self._op = op
	self._calcOp = ArcadeSurvivorGameHelper.getBTCalcOp(op)
	self._storeKey = self:getStoreKey(ArcadeSurvivorGameEnum.BTVarName.calcResult)
end

function ArcadeSurvivorEntityBTCalculateNode:_onTick()
	if not self._calcOp or not self._storeKey then
		return ArcadeSurvivorGameEnum.BTNodeStatus.Failure
	end

	local left = tonumber(self:getBlackboardValue(self:getParamValue(ArcadeSurvivorGameEnum.BTNodeParam.Left)))
	local right = tonumber(self:getBlackboardValue(self:getParamValue(ArcadeSurvivorGameEnum.BTNodeParam.Right)))

	if not ArcadeSurvivorGameHelper.isBTFiniteNumber(left) or not ArcadeSurvivorGameHelper.isBTFiniteNumber(right) then
		return ArcadeSurvivorGameEnum.BTNodeStatus.Failure
	end

	local validate = self._calcOp.validateFunc

	if validate and not validate(left, right) then
		return ArcadeSurvivorGameEnum.BTNodeStatus.Failure
	end

	local result = self._calcOp.calcFunc(left, right)

	if type(result) ~= "number" then
		logError(string.format("ArcadeSurvivorEntityBTCalculateNode:_onTick error, calc result is not number, treeId:%s nodeId:%s op:%s l:%s r:%s", self._treeId, self._nodeId, tostring(self._op), tostring(left), tostring(right)))

		return ArcadeSurvivorGameEnum.BTNodeStatus.Failure
	end

	self._blackboard:setVar(self._storeKey, result)

	return ArcadeSurvivorGameEnum.BTNodeStatus.Success
end

return ArcadeSurvivorEntityBTCalculateNode
