-- chunkname: @modules/logic/versionactivity4_1/arcadesurvivor/controller/game/skill/condition/ArcadeSurvivorConditionBuffLayer.lua

module("modules.logic.versionactivity4_1.arcadesurvivor.controller.game.skill.condition.ArcadeSurvivorConditionBuffLayer", package.seeall)

local ArcadeSurvivorConditionBuffLayer = class("ArcadeSurvivorConditionBuffLayer", ArcadeSurvivorGameBaseCond)

function ArcadeSurvivorConditionBuffLayer:onCtor(param)
	self._buffTargetCountDict = {}

	local paramArr = string.split(param, "#")

	if paramArr then
		for _, strCount in ipairs(paramArr) do
			local countArr = string.split(strCount, ":")
			local buffId, layer = unpack(countArr)

			self._buffTargetCountDict[tonumber(buffId)] = tonumber(layer)
		end
	end
end

function ArcadeSurvivorConditionBuffLayer:_onIsCondSuccess(context)
	local caster = context and context:getCaster()

	if not caster then
		return false
	end

	for buffId, targetCount in pairs(self._buffTargetCountDict) do
		local buff = caster:getBuff(buffId)
		local isActive = buff and buff:getIsActive()

		if not isActive then
			return false
		end

		local count = buff:getStackCount()

		if count < targetCount then
			return false
		end
	end

	return true
end

return ArcadeSurvivorConditionBuffLayer
