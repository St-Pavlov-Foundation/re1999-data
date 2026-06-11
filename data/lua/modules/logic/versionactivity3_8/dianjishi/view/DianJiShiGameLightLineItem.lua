-- chunkname: @modules/logic/versionactivity3_8/dianjishi/view/DianJiShiGameLightLineItem.lua

module("modules.logic.versionactivity3_8.dianjishi.view.DianJiShiGameLightLineItem", package.seeall)

local DianJiShiGameLightLineItem = class("DianJiShiGameLightLineItem", LuaCompBase)

function DianJiShiGameLightLineItem:init(go)
	self.go = go
	self._tran = self.go.transform
	self._goLeft = gohelper.findChild(self.go, "go_Left")
	self._goRight = gohelper.findChild(self.go, "go_Right")
	self._goBottom = gohelper.findChild(self.go, "go_Bottom")
	self._goTop = gohelper.findChild(self.go, "go_Top")
end

function DianJiShiGameLightLineItem:addEventListeners()
	return
end

function DianJiShiGameLightLineItem:removeEventListeners()
	return
end

function DianJiShiGameLightLineItem:onUpdateMO(cellInfo, cubeMap, blockPosIndex, index)
	self._cellInfo = cellInfo
	self._cubeMap = cubeMap
	self._posIndex = self._cellInfo
	self._posXIndex = self._posIndex and self._posIndex[1] or 0
	self._posYIndex = self._posIndex and self._posIndex[2] or 0
	self._blockPosIndex = blockPosIndex

	self:refreshUI()
end

function DianJiShiGameLightLineItem:refreshUI()
	local blockPosXIndex = self._blockPosIndex and self._blockPosIndex[1] or 0
	local blockPosYIndex = self._blockPosIndex and self._blockPosIndex[2] or 0
	local curPosXIndex, curPosYIndex = DianJiShiGameController.instance:cellPosIndex2GlobalIndex(self._posXIndex, self._posYIndex, blockPosXIndex, blockPosYIndex)
	local posX, posY = DianJiShiGameController.instance:posIndex2Pos(curPosXIndex, curPosYIndex, true)

	recthelper.setAnchor(self._tran, posX, posY)

	local left = self:_checkIsEdge(self._posXIndex - 1, self._posYIndex)
	local right = self:_checkIsEdge(self._posXIndex + 1, self._posYIndex)
	local top = self:_checkIsEdge(self._posXIndex, self._posYIndex + 1)
	local bottom = self:_checkIsEdge(self._posXIndex, self._posYIndex - 1)

	gohelper.setActive(self._goLeft, self:_checkIsEdge(self._posXIndex - 1, self._posYIndex))
	gohelper.setActive(self._goRight, self:_checkIsEdge(self._posXIndex + 1, self._posYIndex))
	gohelper.setActive(self._goTop, self:_checkIsEdge(self._posXIndex, self._posYIndex + 1))
	gohelper.setActive(self._goBottom, self:_checkIsEdge(self._posXIndex, self._posYIndex - 1))
end

function DianJiShiGameLightLineItem:_checkIsEdge(cellPosX, cellPosY)
	local row = self._cubeMap and self._cubeMap[cellPosX]

	return not row or not row[cellPosY]
end

return DianJiShiGameLightLineItem
