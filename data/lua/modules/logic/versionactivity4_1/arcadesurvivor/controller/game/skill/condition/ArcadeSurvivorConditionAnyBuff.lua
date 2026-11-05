-- chunkname: @modules/logic/versionactivity4_1/arcadesurvivor/controller/game/skill/condition/ArcadeSurvivorConditionAnyBuff.lua

module("modules.logic.versionactivity4_1.arcadesurvivor.controller.game.skill.condition.ArcadeSurvivorConditionAnyBuff", package.seeall)

local ArcadeSurvivorConditionAnyBuff = class("ArcadeSurvivorConditionAnyBuff", ArcadeSurvivorGameBaseCond)

function ArcadeSurvivorConditionAnyBuff:onCtor(param)
	self._buffIdList = {}

	local paramArr = string.split(param, "#")

	if paramArr then
		for _, buffId in ipairs(paramArr) do
			self._buffIdList[#self._buffIdList + 1] = tonumber(buffId)
		end
	end
end

function ArcadeSurvivorConditionAnyBuff:_onIsCondSuccess(context)
	local caster = context and context:getCaster()

	if not caster then
		return false
	end

	for _, buffId in ipairs(self._buffIdList) do
		local buff = caster:getBuff(buffId)

		if buff and buff:getIsActive() then
			return true
		end
	end

	return false
end

return ArcadeSurvivorConditionAnyBuff
