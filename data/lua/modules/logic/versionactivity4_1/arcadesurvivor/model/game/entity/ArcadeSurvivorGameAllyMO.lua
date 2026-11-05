-- chunkname: @modules/logic/versionactivity4_1/arcadesurvivor/model/game/entity/ArcadeSurvivorGameAllyMO.lua

module("modules.logic.versionactivity4_1.arcadesurvivor.model.game.entity.ArcadeSurvivorGameAllyMO", package.seeall)

local ArcadeSurvivorGameAllyMO = class("ArcadeSurvivorGameAllyMO", ArcadeSurvivorGameBaseUnitMO)

function ArcadeSurvivorGameAllyMO:onCtor()
	local id = self:getId()
	local skillIdList = ArcadeSurvivorConfig.instance:getAllySkillIdList(id)

	for _, skillId in ipairs(skillIdList) do
		self:addSkill(skillId)
	end

	self._leftRound = 0
	self._durationRound = ArcadeSurvivorConfig.instance:getAllyDuration(id)

	if self._durationRound > 0 then
		self._leftRound = self._durationRound
	end
end

function ArcadeSurvivorGameAllyMO:getAttrValue(attrId)
	if attrId == ArcadeSurvivorEnum.Attribute.hp then
		return self:getHp()
	elseif attrId == ArcadeSurvivorEnum.Attribute.respawnTimes then
		return 0
	end

	local summonerMO = self:getSummonerMO()

	if not summonerMO then
		return 0
	end

	return summonerMO:getAttrValue(attrId)
end

function ArcadeSurvivorGameAllyMO:getResName()
	local id = self:getId()

	return ArcadeSurvivorConfig.instance:getAllyRes(id)
end

function ArcadeSurvivorGameAllyMO:getLeftRound()
	return self._leftRound or 0
end

function ArcadeSurvivorGameAllyMO:tickRoundCountdown()
	if self._durationRound <= 0 then
		return true
	end

	local leftRound = self._leftRound

	if not leftRound then
		return false
	end

	leftRound = leftRound - 1
	self._leftRound = leftRound

	return leftRound <= 0
end

function ArcadeSurvivorGameAllyMO:getHp()
	local summonerMO = self:getSummonerMO()

	return summonerMO and summonerMO:getHp() or 0
end

function ArcadeSurvivorGameAllyMO:getIsAlive()
	if self._durationRound <= 0 then
		return true
	end

	return self._leftRound and self._leftRound > 0
end

return ArcadeSurvivorGameAllyMO
