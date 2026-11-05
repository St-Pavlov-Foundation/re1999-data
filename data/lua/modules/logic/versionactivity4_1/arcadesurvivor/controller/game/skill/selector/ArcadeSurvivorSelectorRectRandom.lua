-- chunkname: @modules/logic/versionactivity4_1/arcadesurvivor/controller/game/skill/selector/ArcadeSurvivorSelectorRectRandom.lua

module("modules.logic.versionactivity4_1.arcadesurvivor.controller.game.skill.selector.ArcadeSurvivorSelectorRectRandom", package.seeall)

local ArcadeSurvivorSelectorRectRandom = class("ArcadeSurvivorSelectorRectRandom", ArcadeSurvivorSelectorRect)

function ArcadeSurvivorSelectorRectRandom:onCtor(count, strRectSize, needEmpty)
	self._count = tonumber(count) or 0

	local rectSizeArr = string.split(strRectSize, ",")

	self._width = tonumber(rectSizeArr[1]) or 0
	self._height = tonumber(rectSizeArr[2]) or 0
	self._needEmpty = not string.nilorempty(needEmpty)
end

function ArcadeSurvivorSelectorRectRandom:_findGridIdList()
	local rectGridIdList = self:getRectGridIdList()
	local candidateGridIdList = self:_filterEmptyGridIdList(rectGridIdList)
	local randomGridIdList = self:_getRandomGridIdList(candidateGridIdList, self._count)

	for _, gridId in ipairs(randomGridIdList) do
		self:_addGridId(gridId)
	end
end

function ArcadeSurvivorSelectorRectRandom:_filterEmptyGridIdList(sourceGridIdList)
	if not self._needEmpty or self._targetEntityType ~= ArcadeSurvivorEnum.EntityType.Grid then
		return sourceGridIdList
	end

	local result = {}

	for _, gridId in ipairs(sourceGridIdList) do
		local gridX, gridY = ArcadeSurvivorGameHelper.getGridXYById(gridId)
		local entityData = ArcadeSurvivorGameModel.instance:getEntityDataInGrid(gridX, gridY, ArcadeSurvivorGameEnum.EntityLayer.Normal)

		if not entityData then
			result[#result + 1] = gridId
		end
	end

	return result
end

function ArcadeSurvivorSelectorRectRandom:_getRandomGridIdList(sourceGridIdList, count)
	local sourceCount = #sourceGridIdList
	local randomCount = math.min(count, sourceCount)

	for index = 1, randomCount do
		local swapIndex = math.random(index, sourceCount)

		sourceGridIdList[index], sourceGridIdList[swapIndex] = sourceGridIdList[swapIndex], sourceGridIdList[index]
	end

	for index = sourceCount, randomCount + 1, -1 do
		sourceGridIdList[index] = nil
	end

	return sourceGridIdList
end

return ArcadeSurvivorSelectorRectRandom
