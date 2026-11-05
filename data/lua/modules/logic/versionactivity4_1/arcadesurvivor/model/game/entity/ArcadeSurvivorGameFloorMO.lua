-- chunkname: @modules/logic/versionactivity4_1/arcadesurvivor/model/game/entity/ArcadeSurvivorGameFloorMO.lua

module("modules.logic.versionactivity4_1.arcadesurvivor.model.game.entity.ArcadeSurvivorGameFloorMO", package.seeall)

local ArcadeSurvivorGameFloorMO = class("ArcadeSurvivorGameFloorMO", ArcadeSurvivorGameBaseUnitMO)

function ArcadeSurvivorGameFloorMO:onCtor()
	local id = self:getId()
	local skillIdList = ArcadeSurvivorConfig.instance:getFloorSkillIdList(id)

	for _, skillId in ipairs(skillIdList) do
		self:addSkill(skillId)
	end

	self._leftRound = 0
	self._durationRound = ArcadeSurvivorConfig.instance:getFloorDurationTicks(id)

	if self._durationRound > 0 then
		self._leftRound = self._durationRound
	end
end

function ArcadeSurvivorGameFloorMO:getResName()
	local id = self:getId()

	return ArcadeSurvivorConfig.instance:getFloorRes(id)
end

function ArcadeSurvivorGameFloorMO:getLeftRound()
	return self._leftRound or 0
end

function ArcadeSurvivorGameFloorMO:getIsAlive()
	if self._durationRound <= 0 then
		return true
	end

	return self._leftRound and self._leftRound > 0
end

function ArcadeSurvivorGameFloorMO:tickRoundCountdown()
	if self._durationRound <= 0 then
		return false
	end

	if not self._leftRound then
		return true
	end

	self._leftRound = math.max(0, self._leftRound - 1)

	return self._leftRound <= 0
end

function ArcadeSurvivorGameFloorMO:resetRoundCountdown()
	if self._durationRound <= 0 then
		return
	end

	self._leftRound = self._durationRound
end

return ArcadeSurvivorGameFloorMO
