-- chunkname: @modules/logic/versionactivity4_1/arcadesurvivor/view/hall/ArcadeSurvivorHallQuickLinkMO.lua

module("modules.logic.versionactivity4_1.arcadesurvivor.view.hall.ArcadeSurvivorHallQuickLinkMO", package.seeall)

local ArcadeSurvivorHallQuickLinkMO = pureTable("ArcadeSurvivorHallQuickLinkMO")

function ArcadeSurvivorHallQuickLinkMO:initMo()
	local mos = ArcadeSurvivorHallModel.instance:getInteractiveMODict()

	self._gridMosDict = {}
	self._gridMosList = {}

	local maxGrid = ArcadeSurvivorHallModel.instance:getHallGridSize()

	for i = 1, maxGrid[1] do
		self._gridMosDict[i] = {}

		for j = 1, maxGrid[2] do
			local grid = {
				hexPoint = {
					x = i,
					y = j
				}
			}

			self._gridMosDict[i][j] = grid

			table.insert(self._gridMosList, grid)
		end
	end

	self._buildingGridDict = {}

	for buidlingId, mo in pairs(mos) do
		local minPosX, minPosY, maxPosX, maxPosY = mo:getGridRange()

		self._buildingGridDict[buidlingId] = {}

		for i = minPosX, maxPosX do
			for j = minPosY, maxPosY do
				local _mo = self:_getGridMo(i, j)

				if _mo then
					table.insert(self._buildingGridDict[buidlingId], _mo)
				end
			end
		end
	end
end

function ArcadeSurvivorHallQuickLinkMO:findPath(buidlingId, initX, initY)
	self._buildingId = buidlingId
	self._orginGrid = self:_getGridMo(initX, initY)

	if self:_isBuildingGrid(self._orginGrid) then
		return
	end

	self._buildingGridMO = self._buildingGridDict[self._buildingId]
	self._pathGridList = {}

	for i, _ in ipairs(self._buildingGridMO) do
		self:_findBuildingPath(i)
	end

	local neareastIndex, neareastCount

	for i, list in pairs(self._pathGridList) do
		if not neareastCount or list.linkList and #list.linkList > 0 and neareastCount > #list.linkList then
			neareastIndex = i
			neareastCount = #list.linkList
		end
	end

	local list = self._pathGridList[neareastIndex]

	if list and list.linkList then
		table.remove(list.linkList, 1)

		return list.linkList
	end
end

function ArcadeSurvivorHallQuickLinkMO:_findBuildingPath(index)
	self._findCount = 0
	self._pathGridList[index] = {}
	self._pathGridList[index].closeList = {}
	self._pathGridList[index].openList = {}
	self._pathGridList[index].linkList = {}
	self._orginGrid.orginGrid = nil
	self._orginGrid.f = 0
	self._orginGrid.g = 0
	self._orginGrid.h = 0

	table.insert(self._pathGridList[index].closeList, self._orginGrid)
	self:_checkGrid(self._orginGrid, index)
end

function ArcadeSurvivorHallQuickLinkMO:_checkGrid(orginGrid, index)
	local list = self._pathGridList[index]
	local targetMO = self._buildingGridMO[index]

	self:_findNearLyNodeToOpenList(orginGrid, index)

	if list.openList and #list.openList == 0 then
		table.remove(self._pathGridList, index)

		return
	end

	self._findCount = self._findCount + 1

	if self._findCount > #self._gridMosList then
		table.remove(self._pathGridList, index)

		return
	end

	table.sort(list.openList, self.sortOpen)

	local gridMO = list.openList[1]

	table.insert(list.closeList, gridMO)
	table.remove(list.openList, 1)

	if self:_isSameGrid(gridMO, targetMO) then
		table.insert(list.linkList, gridMO.hexPoint)
		self:_calculatePath(gridMO, index)

		return
	end

	self:_checkGrid(gridMO, index)
end

function ArcadeSurvivorHallQuickLinkMO:_findNearLyNodeToOpenList(orginGrid, index)
	local targetMO = self._buildingGridMO[index]

	if self:_isSameGrid(orginGrid, targetMO) then
		table.insert(self._pathGridList[index].openList, orginGrid)

		return
	end

	local x, y = orginGrid.hexPoint.x, orginGrid.hexPoint.y

	for _, direction in ipairs(ArcadeSurvivorEnum.AxisDirection) do
		local dirHexPoint = ArcadeSurvivorEnum.DirectionHexPointDict[direction]
		local gridX = x + dirHexPoint.x
		local gridY = y + dirHexPoint.y
		local gridMO = self:_isLegal(gridX, gridY, index)

		if gridMO then
			gridMO.orginGrid = orginGrid
			gridMO.g = (orginGrid.g or 0) + 1

			if targetMO ~= gridMO then
				local dis = math.abs(targetMO.hexPoint.x - gridX) + math.abs(targetMO.hexPoint.y - gridY)

				if not gridMO.dis or dis < gridMO.dis then
					gridMO.h = dis
				end
			end

			gridMO.f = gridMO.g + (gridMO.h or 0)

			table.insert(self._pathGridList[index].openList, gridMO)
		end
	end
end

function ArcadeSurvivorHallQuickLinkMO.sortOpen(a, b)
	return a.f < b.f
end

function ArcadeSurvivorHallQuickLinkMO:_calculatePath(gridMo, index)
	if not gridMo or not gridMo.orginGrid or self:_isSameGrid(gridMo.orginGrid, self._orginGrid) then
		return
	end

	local list = self._pathGridList[index]

	table.insert(list.linkList, gridMo.orginGrid.hexPoint)
	self:_calculatePath(gridMo.orginGrid, index)
end

function ArcadeSurvivorHallQuickLinkMO:_isLegal(x, y, index)
	local gridMO = self:_getGridMo(x, y)

	if not gridMO then
		return
	end

	if self:_isObstacle(gridMO, index) then
		return
	end

	if self:_isOpen(gridMO, index) then
		return
	end

	if self:_isClose(gridMO, index) then
		return
	end

	return gridMO
end

function ArcadeSurvivorHallQuickLinkMO:_isSameGrid(a, b)
	return a == b or a.hexPoint.x == b.hexPoint.x and a.hexPoint.y == b.hexPoint.y
end

function ArcadeSurvivorHallQuickLinkMO:_isObstacle(gridMo, index)
	local targetMO = self._buildingGridMO[index]

	if not self:_isSameGrid(gridMo, targetMO) and self:_isBuildingGrid(gridMo) then
		return true
	end
end

function ArcadeSurvivorHallQuickLinkMO:_isBuildingGrid(gridMo)
	for _, gridList in pairs(self._buildingGridDict) do
		for _, grid in ipairs(gridList) do
			if self:_isSameGrid(gridMo, grid) then
				return true
			end
		end
	end
end

function ArcadeSurvivorHallQuickLinkMO:_isOpen(gridMo, index)
	local list = self._pathGridList[index]

	if list and list.openList then
		for _, grid in ipairs(list.openList) do
			if self:_isSameGrid(gridMo, grid) then
				return true
			end
		end
	end
end

function ArcadeSurvivorHallQuickLinkMO:_isClose(gridMo, index)
	local list = self._pathGridList[index]

	if list and list.closeList then
		for _, grid in ipairs(list.closeList) do
			if self:_isSameGrid(gridMo, grid) then
				return true
			end
		end
	end
end

function ArcadeSurvivorHallQuickLinkMO:_getGridMo(x, y)
	return self._gridMosDict[x] and self._gridMosDict[x][y]
end

return ArcadeSurvivorHallQuickLinkMO
