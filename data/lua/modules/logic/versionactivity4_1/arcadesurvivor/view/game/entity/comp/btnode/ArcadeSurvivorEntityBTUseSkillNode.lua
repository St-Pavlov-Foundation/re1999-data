-- chunkname: @modules/logic/versionactivity4_1/arcadesurvivor/view/game/entity/comp/btnode/ArcadeSurvivorEntityBTUseSkillNode.lua

module("modules.logic.versionactivity4_1.arcadesurvivor.view.game.entity.comp.btnode.ArcadeSurvivorEntityBTUseSkillNode", package.seeall)

local ArcadeSurvivorEntityBTUseSkillNode = class("ArcadeSurvivorEntityBTUseSkillNode", ArcadeSurvivorEntityBTBaseNode)

function ArcadeSurvivorEntityBTUseSkillNode:onCtor(param)
	self._skillId = self:_getSkillId()
	self._isWaitingSkillEnd = false
end

function ArcadeSurvivorEntityBTUseSkillNode:onStart()
	self._isWaitingSkillEnd = false
end

function ArcadeSurvivorEntityBTUseSkillNode:_onTick()
	local skillId = self._skillId

	if not skillId then
		return ArcadeSurvivorGameEnum.BTNodeStatus.Failure
	end

	local mo = self:getMO()

	if not mo or mo:getIsDead() then
		return ArcadeSurvivorGameEnum.BTNodeStatus.Failure
	end

	if not mo:hasSkill(skillId) then
		return ArcadeSurvivorGameEnum.BTNodeStatus.Failure
	end

	if self._isWaitingSkillEnd then
		if mo:hasWaitDelayHit(skillId) then
			return ArcadeSurvivorGameEnum.BTNodeStatus.Running
		end

		self._isWaitingSkillEnd = false

		return ArcadeSurvivorGameEnum.BTNodeStatus.Success
	end

	local result = ArcadeSurvivorGameSkillController.instance:castSkill(mo:getEntityType(), mo:getUid(), skillId)

	if not result then
		return ArcadeSurvivorGameEnum.BTNodeStatus.Failure
	end

	if mo:hasWaitDelayHit(skillId) then
		self._isWaitingSkillEnd = true

		return ArcadeSurvivorGameEnum.BTNodeStatus.Running
	end

	return ArcadeSurvivorGameEnum.BTNodeStatus.Success
end

function ArcadeSurvivorEntityBTUseSkillNode:_getSkillId()
	local skillId = tonumber(self:getParamValue(ArcadeSurvivorGameEnum.BTNodeParam.SkillId))

	if not skillId or skillId <= 0 then
		logError(string.format("ArcadeSurvivorEntityBTUseSkillNode:_getSkillId error, params.skillId is invalid, treeId:%s nodeId:%s skillId:%s", self._treeId, self._nodeId, tostring(skillId)))

		return nil
	end

	return math.floor(skillId)
end

function ArcadeSurvivorEntityBTUseSkillNode:onAbort()
	self._isWaitingSkillEnd = false
end

function ArcadeSurvivorEntityBTUseSkillNode:_onReset()
	self._isWaitingSkillEnd = false
end

return ArcadeSurvivorEntityBTUseSkillNode
