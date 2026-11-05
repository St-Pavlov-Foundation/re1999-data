-- chunkname: @modules/logic/versionactivity4_1/arcadesurvivor/controller/game/skill/base/ArcadeSurvivorGameBaseGridSelector.lua

module("modules.logic.versionactivity4_1.arcadesurvivor.controller.game.skill.base.ArcadeSurvivorGameBaseGridSelector", package.seeall)

local ArcadeSurvivorGameBaseGridSelector = class("ArcadeSurvivorGameBaseGridSelector", ArcadeSurvivorGameBaseSelector)

function ArcadeSurvivorGameBaseGridSelector:_onFindByContext(context)
	return self:_onFindTarget()
end

function ArcadeSurvivorGameBaseGridSelector:_onFindTarget()
	self:_findGridIdList()

	local gridIdList = self:getGridIdList()

	for index = 1, #gridIdList do
		self:_addTargetByGridId(gridIdList[index])
	end

	return true
end

function ArcadeSurvivorGameBaseGridSelector:_addTargetByGridId(gridId)
	local targetMO = self:_getTargetInGridId(gridId)

	if not targetMO then
		return
	end

	self:_addTarget(targetMO, false)
end

function ArcadeSurvivorGameBaseGridSelector:_findGridIdList()
	logError("ArcadeSurvivorGameBaseGridSelector:_findGridIdList error, need override")
end

return ArcadeSurvivorGameBaseGridSelector
