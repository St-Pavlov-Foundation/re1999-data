-- chunkname: @modules/logic/versionactivity4_1/arcadesurvivor/controller/game/skill/selector/ArcadeSurvivorSelectorDynamic.lua

module("modules.logic.versionactivity4_1.arcadesurvivor.controller.game.skill.selector.ArcadeSurvivorSelectorDynamic", package.seeall)

local ArcadeSurvivorSelectorDynamic = class("ArcadeSurvivorSelectorDynamic", ArcadeSurvivorGameBaseGridSelector)

function ArcadeSurvivorSelectorDynamic:onCtor(axisType)
	self._axisType = tonumber(axisType)
	self._ignoreSourceUnit = true
end

function ArcadeSurvivorSelectorDynamic:_onFindByContext(context)
	local plan = context:getPassPlayerPlan(self._axisType)

	self:_addPlanGrids(plan)

	for _, gridId in ipairs(self:getGridIdList()) do
		self:_addTargetByGridId(gridId)
	end

	return true
end

function ArcadeSurvivorSelectorDynamic:_findGridIdList()
	local sourceUnitMO = self:_getSourceUnitMO()

	if not sourceUnitMO then
		return
	end

	local plan = ArcadeSurvivorGameHelper.createPassPlayerPlan(sourceUnitMO, self._axisType)

	self:_addPlanGrids(plan)
end

function ArcadeSurvivorSelectorDynamic:_addPlanGrids(plan)
	if not plan then
		return
	end

	for gridId in pairs(plan.gridIdDict) do
		self:_addGridId(gridId)
	end
end

return ArcadeSurvivorSelectorDynamic
