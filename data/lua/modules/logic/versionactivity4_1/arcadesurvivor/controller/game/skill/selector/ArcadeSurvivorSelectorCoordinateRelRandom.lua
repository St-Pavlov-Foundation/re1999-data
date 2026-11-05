-- chunkname: @modules/logic/versionactivity4_1/arcadesurvivor/controller/game/skill/selector/ArcadeSurvivorSelectorCoordinateRelRandom.lua

module("modules.logic.versionactivity4_1.arcadesurvivor.controller.game.skill.selector.ArcadeSurvivorSelectorCoordinateRelRandom", package.seeall)

local ArcadeSurvivorSelectorCoordinateRelRandom = class("ArcadeSurvivorSelectorCoordinateRelRandom", ArcadeSurvivorSelectorCoordinateRel)

function ArcadeSurvivorSelectorCoordinateRelRandom:onCtor(count, refType, ...)
	self._count = tonumber(count) or 0

	ArcadeSurvivorSelectorCoordinateRelRandom.super.onCtor(self, refType, ...)
end

function ArcadeSurvivorSelectorCoordinateRelRandom:_findGridIdList()
	local candidateGridIdList = self:getRelGridIdList()
	local randomGridIdList = self:_getRandomGridIdList(candidateGridIdList, self._count)

	for _, gridId in ipairs(randomGridIdList) do
		self:_addGridId(gridId)
	end
end

function ArcadeSurvivorSelectorCoordinateRelRandom:_getRandomGridIdList(sourceGridIdList, count)
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

return ArcadeSurvivorSelectorCoordinateRelRandom
