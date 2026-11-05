-- chunkname: @modules/logic/versionactivity4_1/arcadesurvivor/controller/game/skill/selector/ArcadeSurvivorSelectorCoordinateAbs.lua

module("modules.logic.versionactivity4_1.arcadesurvivor.controller.game.skill.selector.ArcadeSurvivorSelectorCoordinateAbs", package.seeall)

local ArcadeSurvivorSelectorCoordinateAbs = class("ArcadeSurvivorSelectorCoordinateAbs", ArcadeSurvivorGameBaseGridSelector)

function ArcadeSurvivorSelectorCoordinateAbs:onCtor(...)
	self._absGridList = {}

	local strGridList = {
		...
	}

	for i = 1, #strGridList do
		local strGrid = strGridList[i]
		local gridArr = string.splitToNumber(strGrid, ",")

		self._absGridList[#self._absGridList + 1] = gridArr
	end
end

function ArcadeSurvivorSelectorCoordinateAbs:_findGridIdList()
	for _, grid in ipairs(self._absGridList) do
		self:_addGridXY(grid[1], grid[2])
	end
end

return ArcadeSurvivorSelectorCoordinateAbs
