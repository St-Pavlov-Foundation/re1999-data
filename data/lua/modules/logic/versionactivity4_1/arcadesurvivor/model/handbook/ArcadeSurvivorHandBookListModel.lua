-- chunkname: @modules/logic/versionactivity4_1/arcadesurvivor/model/handbook/ArcadeSurvivorHandBookListModel.lua

module("modules.logic.versionactivity4_1.arcadesurvivor.model.handbook.ArcadeSurvivorHandBookListModel", package.seeall)

local ArcadeSurvivorHandBookListModel = class("ArcadeSurvivorHandBookListModel", ListScrollModel)

function ArcadeSurvivorHandBookListModel:clearTypeDict()
	self.typeDict = nil
end

function ArcadeSurvivorHandBookListModel:setMOList(type)
	self.typeDict = self.typeDict or {}

	if not self.typeDict[type] then
		local moList = ArcadeSurvivorHandBookModel.instance:getMOListByType(type)

		self.typeDict[type] = {}

		if moList then
			for _, mo in pairs(moList) do
				table.insert(self.typeDict[type], mo)
			end

			self:_setItemAnchor(type)
		end
	end

	self:setList(self.typeDict[type])
end

local function _sortMO(a, b)
	local aSizeX, aSizeY = a:getIconSize()
	local bSizeX, bSizeY = b:getIconSize()

	if aSizeX ~= bSizeX then
		return aSizeX < bSizeX
	end

	if aSizeY ~= bSizeY then
		return aSizeY < bSizeY
	end

	return a:getId() < b:getId()
end

function ArcadeSurvivorHandBookListModel:_setItemAnchor(type)
	local moList = self.typeDict[type]

	if not moList then
		return
	end

	table.sort(moList, _sortMO)

	local itemParams = ArcadeSurvivorHallEnum.HandBookItemParams
	local lineMoList = {}
	local minSize = itemParams.MinSize

	for i, mo in ipairs(moList) do
		local lineMoCount = #lineMoList
		local sizeX, sizeY = mo:getIconSize()
		local anchorY = itemParams.StartY
		local preMO = moList[i - 1]

		if preMO then
			local _, preSizeY = preMO:getIconSize()
			local _, preAnchorY = preMO:getAnchor()

			if sizeX >= itemParams.RowCount * minSize then
				anchorY = preSizeY + preAnchorY + itemParams.SpaceY
				lineMoList = {}
			elseif lineMoCount > itemParams.RowCount - sizeX / minSize then
				anchorY = preSizeY + preAnchorY + itemParams.SpaceY
				lineMoList = {}
			elseif preSizeY < sizeY then
				local t1PreMO = moList[i - lineMoCount - 1]

				if t1PreMO then
					local _, t1PreSizeY = t1PreMO:getIconSize()
					local _, t1PreAnchorY = t1PreMO:getAnchor()

					anchorY = t1PreSizeY + t1PreAnchorY + itemParams.SpaceY
				else
					anchorY = itemParams.StartY
				end

				for _, t2PreMo in ipairs(lineMoList) do
					local _, t2PreSizeY = t2PreMo:getIconSize()
					local t2AnchorY = anchorY + sizeY - t2PreSizeY

					t2PreMo:setAnchorY(t2AnchorY)
				end
			else
				anchorY = preAnchorY
			end
		end

		table.insert(lineMoList, mo)
		self:_calculateAnchorX(lineMoList)
		mo:setAnchorY(anchorY)
	end
end

function ArcadeSurvivorHandBookListModel:_calculateAnchorX(lineMoList)
	local itemParams = ArcadeSurvivorHallEnum.HandBookItemParams
	local lineMoCount = #lineMoList

	for i, mo in ipairs(lineMoList) do
		local sizeX, _ = mo:getIconSize()
		local anchorX = 0
		local isMinSizeX = sizeX == itemParams.MinSize
		local preMO = lineMoList[i - 1]

		if preMO then
			local preSizeX, _ = preMO:getIconSize()
			local preAnchorX, _ = preMO:getAnchor()

			if lineMoCount == 2 then
				if isMinSizeX then
					local itemSizeX = itemParams.MinSize
					local remain = itemParams.MaxWidth - itemParams.StartX - itemSizeX * itemParams.RowCount
					local offset = math.max(remain / 2, 0)

					anchorX = preAnchorX + preSizeX + offset
				else
					anchorX = itemParams.MaxWidth - sizeX
				end
			else
				local remain = itemParams.MaxWidth - itemParams.StartX

				for _, tMO in ipairs(lineMoList) do
					local tSizeX, _ = tMO:getIconSize()

					remain = remain - tSizeX
				end

				local offset = math.max(remain / (lineMoCount - 1), 0)

				anchorX = preAnchorX + preSizeX + offset
			end
		elseif lineMoCount == 1 then
			if isMinSizeX then
				anchorX = itemParams.StartX
			else
				anchorX = itemParams.MaxWidth * 0.5 - sizeX * 0.5
			end
		else
			anchorX = itemParams.StartX
		end

		mo:setAnchorX(anchorX)
		mo:setRowInfo(lineMoCount, i)
	end
end

function ArcadeSurvivorHandBookListModel:getMoByTypeIndex(type, index)
	local moList = self.typeDict and self.typeDict[type]

	return moList and moList[index]
end

ArcadeSurvivorHandBookListModel.instance = ArcadeSurvivorHandBookListModel.New()

return ArcadeSurvivorHandBookListModel
