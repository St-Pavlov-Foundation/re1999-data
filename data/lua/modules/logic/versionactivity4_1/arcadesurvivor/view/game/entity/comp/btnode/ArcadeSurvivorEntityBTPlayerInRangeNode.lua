-- chunkname: @modules/logic/versionactivity4_1/arcadesurvivor/view/game/entity/comp/btnode/ArcadeSurvivorEntityBTPlayerInRangeNode.lua

module("modules.logic.versionactivity4_1.arcadesurvivor.view.game.entity.comp.btnode.ArcadeSurvivorEntityBTPlayerInRangeNode", package.seeall)

local ArcadeSurvivorEntityBTPlayerInRangeNode = class("ArcadeSurvivorEntityBTPlayerInRangeNode", ArcadeSurvivorEntityBTBaseNode)

function ArcadeSurvivorEntityBTPlayerInRangeNode:onCtor(param)
	self._effectId = self:getParamValue(ArcadeSurvivorGameEnum.BTNodeParam.EffectId)
	self._selector = self._effectId and ArcadeSurvivorGameSkillFactory.createSelectorByParam(ArcadeSurvivorConfig.instance:getSkillEffectTarget(self._effectId))

	if not self._effectId then
		logError(string.format("ArcadeSurvivorEntityBTPlayerInRangeNode:onCtor error, params.effectId is empty, treeId:%s nodeId:%s", self._treeId, self._nodeId))
	elseif not self._selector then
		logError(string.format("ArcadeSurvivorEntityBTPlayerInRangeNode:onCtor error, can not create selector, treeId:%s nodeId:%s effectId:%s", self._treeId, self._nodeId, tostring(self._effectId)))
	end
end

function ArcadeSurvivorEntityBTPlayerInRangeNode:_onTick()
	if not self._selector then
		return ArcadeSurvivorGameEnum.BTNodeStatus.Failure
	end

	local casterMO = self:getMO()
	local playerMO = ArcadeSurvivorGameModel.instance:getCharacterMO()

	if not casterMO or not playerMO then
		logError(string.format("ArcadeSurvivorEntityBTPlayerInRangeNode:_onTick error, caster mo or player mo is nil, treeId:%s nodeId:%s effectId:%s", self._treeId, self._nodeId, tostring(self._effectId)))

		return ArcadeSurvivorGameEnum.BTNodeStatus.Failure
	end

	local gridX, gridY = casterMO:getGridPos()
	local direction = casterMO:getDirection()

	self._selector:findTarget(gridX, gridY, direction)

	if self._selector:getHaveTarget(playerMO:getEntityType(), playerMO:getUid()) then
		return ArcadeSurvivorGameEnum.BTNodeStatus.Success
	end

	return ArcadeSurvivorGameEnum.BTNodeStatus.Failure
end

return ArcadeSurvivorEntityBTPlayerInRangeNode
