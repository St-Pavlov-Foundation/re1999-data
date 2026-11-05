-- chunkname: @modules/logic/versionactivity4_1/arcadesurvivor/controller/game/skill/selector/ArcadeSurvivorSelectorCoordinateRel.lua

module("modules.logic.versionactivity4_1.arcadesurvivor.controller.game.skill.selector.ArcadeSurvivorSelectorCoordinateRel", package.seeall)

local ArcadeSurvivorSelectorCoordinateRel = class("ArcadeSurvivorSelectorCoordinateRel", ArcadeSurvivorGameBaseGridSelector)

function ArcadeSurvivorSelectorCoordinateRel:onCtor(refType, ...)
	self._refType = tonumber(refType)
	self._relGridItemList = {}

	local strGridList = {
		...
	}

	for i = 1, #strGridList do
		local strGrid = strGridList[i]

		if not string.nilorempty(strGrid) then
			self._relGridItemList[#self._relGridItemList + 1] = string.splitToNumber(strGrid, ",")
		end
	end
end

function ArcadeSurvivorSelectorCoordinateRel:_findGridIdList()
	local relGridIdList = self:getRelGridIdList()

	for _, gridId in ipairs(relGridIdList) do
		self:_addGridId(gridId)
	end
end

function ArcadeSurvivorSelectorCoordinateRel:getRelGridIdList()
	local result = {}
	local refGridX, refGridY, refDirection
	local refTypes = ArcadeSurvivorGameEnum.CoordinateRefType
	local fixedXY = self._refType == refTypes.OwnerFixedXY or self._refType == refTypes.PlayerFixedXY

	if self._refType == refTypes.Owner or self._refType == refTypes.OwnerFixedXY then
		refGridX = self._sourceGridX
		refGridY = self._sourceGridY
		refDirection = self._sourceDirection
	elseif self._refType == refTypes.Player or self._refType == refTypes.PlayerFixedXY then
		local refMO = ArcadeSurvivorGameModel.instance:getCharacterMO()

		if refMO then
			refGridX, refGridY = refMO:getGridPos()
			refDirection = refMO:getDirection()
		end
	else
		logError(string.format("ArcadeSurvivorSelectorCoordinateRel: _findGridIdList error, refType = %s", self._refType))
	end

	if not refGridX or not refGridY or not fixedXY and not refDirection then
		return result
	end

	local candidateGridIdDict = {}

	for index = 1, #self._relGridItemList do
		local gridItem = self._relGridItemList[index]
		local worldGridX, worldGridY

		if fixedXY then
			worldGridX, worldGridY = refGridX + gridItem[1], refGridY + gridItem[2]
		else
			worldGridX, worldGridY = ArcadeSurvivorGameHelper.localGrid2WorldGrid(refDirection, refGridX, refGridY, gridItem[1], gridItem[2])
		end

		local isOutside = ArcadeSurvivorGameHelper.isOutsideMap(worldGridX, worldGridY)

		if not isOutside then
			local gridId = ArcadeSurvivorGameHelper.getGridId(worldGridX, worldGridY)

			if not candidateGridIdDict[gridId] then
				candidateGridIdDict[gridId] = true
				result[#result + 1] = gridId
			end
		end
	end

	return result
end

return ArcadeSurvivorSelectorCoordinateRel
