-- chunkname: @modules/logic/versionactivity4_1/arcadesurvivor/controller/game/buff/ArcadeSurvivorGameSkillBuff.lua

module("modules.logic.versionactivity4_1.arcadesurvivor.controller.game.buff.ArcadeSurvivorGameSkillBuff", package.seeall)

local ArcadeSurvivorGameSkillBuff = class("ArcadeSurvivorGameSkillBuff", ArcadeSurvivorGameBaseBuff)

function ArcadeSurvivorGameSkillBuff:onCtor()
	local id = self:getId()
	local param = ArcadeSurvivorConfig.instance:getBuffParam(id)

	self._skillId = tonumber(param)
end

function ArcadeSurvivorGameSkillBuff:_onActive()
	if not self._skillId then
		return
	end

	local unitMO = self:getUnitMO()

	if not unitMO then
		return
	end

	local skill = unitMO:addSkill(self._skillId, ArcadeSurvivorGameEnum.SkillSourceType.Buff, self:getId())

	if skill then
		local context = ArcadeSurvivorGameTriggerContext.New(ArcadeSurvivorGameEnum.TriggerPoint.None, nil, unitMO)

		skill:activeCast(context)
	end
end

function ArcadeSurvivorGameSkillBuff:_onExpire()
	if not self._skillId then
		return
	end

	local unitMO = self:getUnitMO()

	if not unitMO then
		return
	end

	unitMO:removeSkill(self._skillId, ArcadeSurvivorGameEnum.SkillSourceType.Buff, self:getId())
end

return ArcadeSurvivorGameSkillBuff
