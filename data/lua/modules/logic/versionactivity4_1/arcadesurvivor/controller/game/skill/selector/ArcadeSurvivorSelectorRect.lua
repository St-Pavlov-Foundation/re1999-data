-- chunkname: @modules/logic/versionactivity4_1/arcadesurvivor/controller/game/skill/selector/ArcadeSurvivorSelectorRect.lua

module("modules.logic.versionactivity4_1.arcadesurvivor.controller.game.skill.selector.ArcadeSurvivorSelectorRect", package.seeall)

local ArcadeSurvivorSelectorRect = class("ArcadeSurvivorSelectorRect", ArcadeSurvivorGameBaseGridSelector)

function ArcadeSurvivorSelectorRect:onCtor(strRectSize, needSummon)
	local rectSizeArr = string.split(strRectSize, ",")

	self._width = tonumber(rectSizeArr[1]) or 0
	self._height = tonumber(rectSizeArr[2]) or 0
	self._needSummon = needSummon and true or false
end

function ArcadeSurvivorSelectorRect:_findGridIdList()
	local rectGridIdList = self:getRectGridIdList()

	for _, gridId in ipairs(rectGridIdList) do
		self:_addGridId(gridId)
	end
end

function ArcadeSurvivorSelectorRect:_canAddTarget(targetMO)
	if not self._needSummon then
		return true
	end

	return targetMO:getIsSummon()
end

function ArcadeSurvivorSelectorRect:getRectSize()
	return self._width, self._height
end

function ArcadeSurvivorSelectorRect:getRectGridIdList()
	local width, height = self:getRectSize()
	local result = {}

	if width <= 0 or height <= 0 then
		return result
	end

	local offsetX = math.floor(width / 2)
	local offsetY = math.floor(height / 2)
	local minGridX = self._sourceGridX - offsetX
	local minGridY = self._sourceGridY - offsetY
	local maxGridX = minGridX + width - 1
	local maxGridY = minGridY + height - 1
	local centerGridPosX = (minGridX + maxGridX) * 0.5
	local centerGridPosY = (minGridY + maxGridY) * 0.5

	self:_setCenterGridPos(centerGridPosX, centerGridPosY)

	local mapWidth, mapHeight = ArcadeSurvivorGameModel.instance:getMapSize()

	for gridXIndex = math.max(1, minGridX), math.min(mapWidth, maxGridX) do
		for gridYIndex = math.max(1, minGridY), math.min(mapHeight, maxGridY) do
			local gridId = ArcadeSurvivorGameHelper.getGridId(gridXIndex, gridYIndex)

			result[#result + 1] = gridId
		end
	end

	return result
end

return ArcadeSurvivorSelectorRect
