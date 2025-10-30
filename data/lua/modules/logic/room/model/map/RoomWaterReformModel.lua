﻿-- chunkname: @modules/logic/room/model/map/RoomWaterReformModel.lua

module("modules.logic.room.model.map.RoomWaterReformModel", package.seeall)

local RoomWaterReformModel = class("RoomWaterReformModel", BaseModel)

RoomWaterReformModel.InitBlockColor = -1
RoomWaterReformModel.InitWaterType = -1

function RoomWaterReformModel:onInit()
	self:_clearData()
end

function RoomWaterReformModel:reInit()
	self:_clearData()
end

function RoomWaterReformModel:clear()
	RoomWaterReformModel.super.clear(self)
	self:_clearData()
end

function RoomWaterReformModel:_clearData()
	self._waterAreaMo = nil
	self._isWaterReform = false

	self:setReformMode()
	self:setSelectWaterArea()
	self:clearChangeWaterTypeDict()
	self:clearChangeBlockColorDict()
	self:setBlockColorReformSelectMode()
	self:clearBlockPermanentInfoDict()
end

function RoomWaterReformModel:clearChangeWaterTypeDict()
	self._changeWaterTypeDict = {}
end

function RoomWaterReformModel:clearChangeBlockColorDict()
	self._changeBlockColorDict = {}
end

function RoomWaterReformModel:clearBlockPermanentInfoDict()
	self._blockPermanentInfoDict = {}
end

function RoomWaterReformModel:initWaterArea()
	self:setSelectWaterArea()

	local waterResourceId = RoomResourceEnum.ResourceId.River
	local areaDict = RoomResourceHelper.getResourcePointAreaMODict(nil, {
		waterResourceId
	}, true)

	self._waterAreaMo = areaDict[waterResourceId]
end

function RoomWaterReformModel:clearChangeWaterRecord(blockId)
	if not blockId or not self._changeWaterTypeDict then
		return
	end

	self._changeWaterTypeDict[blockId] = nil
end

function RoomWaterReformModel:clearChangeBlockColorRecord(blockId)
	if not blockId or not self._changeBlockColorDict then
		return
	end

	self._changeBlockColorDict[blockId] = nil
end

function RoomWaterReformModel:resetChangeWaterType()
	if not self._changeWaterTypeDict then
		return
	end

	for blockId, _ in pairs(self._changeWaterTypeDict) do
		local blockMO = RoomMapBlockModel.instance:getFullBlockMOById(blockId)

		if blockMO then
			blockMO:setTempWaterType()
		end
	end

	self:clearChangeWaterTypeDict()
end

function RoomWaterReformModel:resetChangeBlockColor()
	if not self._changeBlockColorDict then
		return
	end

	local hexPointList = {}

	for blockId, _ in pairs(self._changeBlockColorDict) do
		local blockMO = RoomMapBlockModel.instance:getFullBlockMOById(blockId)

		if blockMO then
			blockMO:setTempBlockColorType()

			local hexPoint = blockMO.hexPoint

			hexPointList[#hexPointList + 1] = hexPoint
		end
	end

	RoomMapBlockModel.instance:refreshNearRiverByHexPointList(hexPointList, 1)
	self:clearChangeBlockColorDict()
end

function RoomWaterReformModel:isWaterReform()
	return self._isWaterReform
end

function RoomWaterReformModel:getReformMode()
	return self._reformMode
end

function RoomWaterReformModel:isBlockInSelect(blockMO)
	local isWaterReform = self:isWaterReform()

	if not isWaterReform or not blockMO then
		return
	end

	local result = false
	local blockId = blockMO.id
	local hasRiver = blockMO:hasRiver()

	if hasRiver then
		local selectWaterBlockMoList = self:getSelectWaterBlockMoList()

		for _, selectBlockMo in ipairs(selectWaterBlockMoList) do
			result = selectBlockMo.id == blockId

			if result then
				break
			end
		end
	else
		local selectedBlockDict = self:getSelectedBlocks()

		result = selectedBlockDict and selectedBlockDict[blockId] and true or false
	end

	return result
end

function RoomWaterReformModel:hasSelectWaterArea()
	local result = self._selectAreaId and true or false

	return result
end

function RoomWaterReformModel:getSelectWaterBlockMoList()
	local result = {}
	local hasSelect = self:hasSelectWaterArea()

	if not hasSelect then
		return result
	end

	local hasFindDict = {}
	local areaList = self._waterAreaMo and self._waterAreaMo:findeArea()
	local resourcePointList = areaList and areaList[self._selectAreaId]

	if resourcePointList then
		for _, resPoint in ipairs(resourcePointList) do
			local x = resPoint.x
			local y = resPoint.y

			if not hasFindDict[x] or not hasFindDict[x][y] then
				local blockMO = RoomMapBlockModel.instance:getBlockMO(x, y)

				result[#result + 1] = blockMO
				hasFindDict[x] = hasFindDict[x] or {}
				hasFindDict[x][y] = true
			end
		end
	end

	return result
end

function RoomWaterReformModel:getWaterAreaId(x, y, direction)
	local newAreaId = self._waterAreaMo:getAreaIdByXYD(x, y, direction)

	return newAreaId
end

function RoomWaterReformModel:getWaterAreaList()
	local areaList = self._waterAreaMo and self._waterAreaMo:findeArea()

	return areaList or {}
end

function RoomWaterReformModel:getSelectWaterResourcePointList()
	local areaList = self:getWaterAreaList()
	local resourcePointList = areaList[self._selectAreaId]

	return resourcePointList
end

function RoomWaterReformModel:getSelectAreaId()
	return self._selectAreaId
end

function RoomWaterReformModel:getRecordChangeWaterType()
	return self._changeWaterTypeDict
end

function RoomWaterReformModel:hasChangedWaterType()
	local recordChangeWaterType = self:getRecordChangeWaterType()
	local result = recordChangeWaterType and next(recordChangeWaterType)

	return result
end

function RoomWaterReformModel:isUnlockWaterReform(waterType)
	local result = true
	local unlockItemId = RoomConfig.instance:getWaterReformItemId(waterType)

	if unlockItemId and unlockItemId ~= 0 then
		local itemCount = ItemModel.instance:getItemCount(unlockItemId)

		result = itemCount > 0
	end

	return result
end

function RoomWaterReformModel:isUnlockBlockColor(blockColor)
	local result = true

	if blockColor ~= RoomWaterReformModel.InitBlockColor then
		local voucherId = RoomConfig.instance:getBlockColorReformVoucherId(blockColor)

		if voucherId and voucherId ~= 0 then
			local voucherMO = UnlockVoucherModel.instance:getVoucher(voucherId)

			result = voucherMO and true or false
		end
	end

	return result
end

function RoomWaterReformModel:isUnlockAllBlockColor()
	local colorList = RoomConfig.instance:getBlockColorReformList()

	for _, blockColor in ipairs(colorList) do
		local isUnlock = self:isUnlockBlockColor(blockColor)

		if not isUnlock then
			return false
		end
	end

	return true
end

function RoomWaterReformModel:getBlockColorReformSelectMode()
	return self._blockColorReformSelectMode or RoomEnum.BlockColorReformSelectMode.Single
end

function RoomWaterReformModel:hasSelectedBlock()
	local result = false

	if self._selectedBlockDict then
		result = next(self._selectedBlockDict) and true or false
	end

	return result
end

function RoomWaterReformModel:getSelectedBlocks()
	return self._selectedBlockDict
end

function RoomWaterReformModel:getRecordChangeBlockColor()
	return self._changeBlockColorDict
end

function RoomWaterReformModel:hasChangedBlockColor()
	local recordChangeBlockColor = self:getRecordChangeBlockColor()
	local result = recordChangeBlockColor and next(recordChangeBlockColor)

	return result
end

function RoomWaterReformModel:getChangedBlockColorCount(targetColor, ignoreColor)
	local result = 0
	local recordChangeBlockColor = self:getRecordChangeBlockColor()

	for blockId, blockColor in pairs(recordChangeBlockColor) do
		if (not ignoreColor or blockColor ~= ignoreColor) and (not targetColor or blockColor == targetColor) then
			result = result + 1
		end
	end

	return result
end

function RoomWaterReformModel:getBlockPermanentInfo(blockId)
	return self._blockPermanentInfoDict and self._blockPermanentInfoDict[blockId] or RoomWaterReformModel.InitBlockColor
end

function RoomWaterReformModel:setWaterReform(isWaterReform)
	self._isWaterReform = isWaterReform == true
end

function RoomWaterReformModel:setReformMode(mode)
	self._reformMode = mode
end

function RoomWaterReformModel:setSelectWaterArea(newAreaId)
	self._selectAreaId = newAreaId
end

function RoomWaterReformModel:recordChangeWaterType(blockId, waterType)
	if not blockId or not waterType then
		return
	end

	if not self._changeWaterTypeDict then
		self:clearChangeWaterTypeDict()
	end

	self._changeWaterTypeDict[blockId] = waterType
end

function RoomWaterReformModel:setBlockColorReformSelectMode(mode)
	self._blockColorReformSelectMode = mode
end

function RoomWaterReformModel:setBlockSelectedByList(blockIdList, isSelected, isClear)
	if isClear then
		self._selectedBlockDict = {}
	end

	if blockIdList then
		for _, blockId in ipairs(blockIdList) do
			self:setBlockSelected(blockId, isSelected)
		end
	end
end

function RoomWaterReformModel:setBlockSelected(blockId, isSelected)
	if not self._selectedBlockDict then
		self._selectedBlockDict = {}
	end

	if isSelected then
		self._selectedBlockDict[blockId] = true
	else
		self._selectedBlockDict[blockId] = nil
	end
end

function RoomWaterReformModel:recordChangeBlockColor(blockId, blockColor)
	if not blockId or not blockColor then
		return
	end

	if not self._changeBlockColorDict then
		self:clearChangeBlockColorDict()
	end

	self._changeBlockColorDict[blockId] = blockColor
end

function RoomWaterReformModel:setBlockPermanentInfo(infos)
	if not infos then
		return
	end

	if not self._blockPermanentInfoDict then
		self._blockPermanentInfoDict = {}
	end

	for _, info in ipairs(infos) do
		self._blockPermanentInfoDict[info.blockId] = info.color
	end
end

RoomWaterReformModel.instance = RoomWaterReformModel.New()

return RoomWaterReformModel
