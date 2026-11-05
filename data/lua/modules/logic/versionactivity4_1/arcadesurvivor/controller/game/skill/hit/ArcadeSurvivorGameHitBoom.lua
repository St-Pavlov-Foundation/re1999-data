-- chunkname: @modules/logic/versionactivity4_1/arcadesurvivor/controller/game/skill/hit/ArcadeSurvivorGameHitBoom.lua

module("modules.logic.versionactivity4_1.arcadesurvivor.controller.game.skill.hit.ArcadeSurvivorGameHitBoom", package.seeall)

local ArcadeSurvivorGameHitBoom = class("ArcadeSurvivorGameHitBoom", ArcadeSurvivorGameBaseHit)

function ArcadeSurvivorGameHitBoom:onCtor(params)
	self._damage = tonumber(params[1])
	self._rangeSelector = nil

	local selectorType = params[2]
	local targetEntityType = params[3]

	if not selectorType or not targetEntityType then
		return
	end

	local selectorParamArr = {
		selectorType,
		targetEntityType
	}

	for index = 4, #params do
		selectorParamArr[#selectorParamArr + 1] = params[index]
	end

	self._rangeSelector = ArcadeSurvivorGameSkillFactory.createSelectorByParam(selectorParamArr)
end

function ArcadeSurvivorGameHitBoom:_onHit(context, caster, targetList, gridIdDict)
	local damageTargetList = {}
	local damageTargetDict = {}
	local damageGridIdDict = {}

	self:_addRangeDamageTargets(damageTargetList, damageTargetDict, targetList, damageGridIdDict)
	ArcadeSurvivorGameController.instance:takeDamage(caster, damageTargetList, self._damage)

	if gridIdDict then
		tabletool.clear(gridIdDict)

		for gridId in pairs(damageGridIdDict) do
			gridIdDict[gridId] = true
		end
	end
end

function ArcadeSurvivorGameHitBoom:_addTargetList(damageTargetList, damageTargetDict, targetList)
	if not targetList then
		return
	end

	for _, target in ipairs(targetList) do
		local isTargetNotAdded = not damageTargetDict[target]

		if isTargetNotAdded then
			damageTargetDict[target] = true
			damageTargetList[#damageTargetList + 1] = target
		end
	end
end

function ArcadeSurvivorGameHitBoom:_addRangeDamageTargets(damageTargetList, damageTargetDict, targetList, damageGridIdDict)
	if not targetList or not self._rangeSelector then
		return
	end

	for _, target in ipairs(targetList) do
		local targetGridX, targetGridY = target:getGridPos()
		local targetDirection = target:getDirection()
		local extraTargetList, extraGridIdDict = self._rangeSelector:findTarget(targetGridX, targetGridY, targetDirection)

		self:_addTargetList(damageTargetList, damageTargetDict, extraTargetList)

		for gridId in pairs(extraGridIdDict or {}) do
			damageGridIdDict[gridId] = true
		end
	end
end

return ArcadeSurvivorGameHitBoom
