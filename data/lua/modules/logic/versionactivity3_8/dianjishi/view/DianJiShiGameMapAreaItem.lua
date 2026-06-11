-- chunkname: @modules/logic/versionactivity3_8/dianjishi/view/DianJiShiGameMapAreaItem.lua

module("modules.logic.versionactivity3_8.dianjishi.view.DianJiShiGameMapAreaItem", package.seeall)

local DianJiShiGameMapAreaItem = class("DianJiShiGameMapAreaItem", LuaCompBase)

function DianJiShiGameMapAreaItem:init(go)
	self.go = go
	self._tran = self.go.transform
	self._goFlag = gohelper.findChild(self.go, "go_Flag")
	self._goValue = gohelper.findChild(self.go, "go_Flag/go_Value")
	self._imageValue = gohelper.findChildImage(self.go, "go_Flag/go_Value/image_Value")
	self._txtValue = gohelper.findChildText(self.go, "go_Flag/go_Value/txt_Value")
	self._goCheck = gohelper.findChild(self.go, "go_Flag/go_Check")
	self._imageCheckBg = gohelper.findChild(self.go, "go_Flag/go_Check/bg")
	self._goLight = gohelper.findChild(self.go, "go_Flag/go_Light")
	self._goPlaced = gohelper.findChild(self.go, "go_Flag/go_Placed")
	self._imagePlacedBg = gohelper.findChild(self.go, "go_Flag/go_Placed/bg")
	self._goLeftTop = gohelper.findChild(self.go, "go_LeftTop")
	self._goLeftBottom = gohelper.findChild(self.go, "go_LeftBottom")
	self._goRightTop = gohelper.findChild(self.go, "go_RightTop")
	self._goRightBottom = gohelper.findChild(self.go, "go_RightBottom")
	self._directionMap = self:getUserDataTb_()
	self._directionMap[DianJiShiGameEnum.AreaTipsDir.LeftTop] = self._goLeftTop
	self._directionMap[DianJiShiGameEnum.AreaTipsDir.LeftBottom] = self._goLeftBottom
	self._directionMap[DianJiShiGameEnum.AreaTipsDir.RightTop] = self._goRightTop
	self._directionMap[DianJiShiGameEnum.AreaTipsDir.RightBottom] = self._goRightBottom

	gohelper.setActive(self._goLight, false)
	gohelper.setActive(self._goCheck, false)
	gohelper.setActive(self._goPlaced, false)

	self._tranLight = self._goLight.transform
	self._tranImagePlacedBg = self._imagePlacedBg.transform
	self._tranImageValueBg = self._imageValue.transform
	self._tranImageCheckBg = self._imageCheckBg.transform
end

function DianJiShiGameMapAreaItem:addEventListeners()
	self:addEventCb(DianJiShiGameController.instance, DianJiShiGameEvent.OnPlaceBlockDone, self._onPlaceBlockDone, self)
	self:addEventCb(DianJiShiGameController.instance, DianJiShiGameEvent.OnPlaceBlockError, self._onPlaceBlockError, self)
	self:addEventCb(DianJiShiGameController.instance, DianJiShiGameEvent.OnLightAreaValue, self._onLightAreaValue, self)
end

function DianJiShiGameMapAreaItem:removeEventListeners()
	return
end

function DianJiShiGameMapAreaItem:onUpdateMO(areaInfo, index)
	self._areaInfo = areaInfo
	self._areaId = self._areaInfo.id
	self._index = index

	self:refreshUI()
end

function DianJiShiGameMapAreaItem:refreshUI()
	self:setBonus()
	self:setAreaFlag()
end

function DianJiShiGameMapAreaItem:setBonus()
	if not self._areaInfo then
		return
	end

	local cellWidth, cellHeight = DianJiShiGameModel.instance:getCellSize()
	local minXIndex = self._areaInfo.minXIndex or 0
	local minYIndex = self._areaInfo.minYIndex or 0
	local maxXIndex = self._areaInfo.maxXIndex or 0
	local maxYIndex = self._areaInfo.maxYIndex or 0
	local wholeWidth = (maxXIndex - minXIndex + 1) * cellWidth
	local wholeHeight = (maxYIndex - minYIndex + 1) * cellHeight

	recthelper.setSize(self._tran, wholeWidth, wholeHeight)

	local posX, posY = DianJiShiGameController.instance:posIndex2Pos(minXIndex, minYIndex, true)

	recthelper.setAnchor(self._tran, posX, posY)
end

function DianJiShiGameMapAreaItem:setAreaFlag()
	local areaCo = self._areaInfo and self._areaInfo.config
	local dir = areaCo and areaCo.direction

	dir = dir or DianJiShiGameEnum.Direction.LeftTop

	local goDir = self._directionMap and self._directionMap[dir]

	if gohelper.isNil(goDir) then
		return
	end

	gohelper.addChild(goDir, self._goFlag)

	local configValue = areaCo and areaCo.value or 0
	local placeValue = self._areaInfo and self._areaInfo.value or 0
	local resultValue = configValue - placeValue
	local isFinish = resultValue == 0

	self:setTagBgDir(dir)
	gohelper.setActive(self._goValue, not isFinish)
	gohelper.setActive(self._goCheck, isFinish)

	if not isFinish then
		self._txtValue.text = resultValue

		local valueBgName = areaCo.icon

		UISpriteSetMgr.instance:setV3a8DianJiShiSprite(self._imageValue, valueBgName, true)
	end
end

function DianJiShiGameMapAreaItem:setTagBgDir(dir)
	local isLeft = dir == DianJiShiGameEnum.AreaTipsDir.LeftTop or dir == DianJiShiGameEnum.AreaTipsDir.LeftBottom
	local xScale = isLeft and -1 or 1

	transformhelper.setLocalScale(self._tranLight, xScale, 1, 1)
	transformhelper.setLocalScale(self._tranImagePlacedBg, xScale, 1, 1)
	transformhelper.setLocalScale(self._tranImageValueBg, xScale, 1, 1)
	transformhelper.setLocalScale(self._tranImageCheckBg, xScale, 1, 1)
end

function DianJiShiGameMapAreaItem:_onLightAreaValue(areaIdMap)
	local isLight = areaIdMap and areaIdMap[self._areaId] == true

	self:_updateLightEffect(isLight)
end

function DianJiShiGameMapAreaItem:_onPlaceBlockDone()
	if not self._isLight then
		return
	end

	self:_updateLightEffect(false)
	gohelper.setActive(self._goPlaced, false)
	gohelper.setActive(self._goPlaced, true)
end

function DianJiShiGameMapAreaItem:_onPlaceBlockError()
	self:_updateLightEffect(false)
end

function DianJiShiGameMapAreaItem:_updateLightEffect(isLight)
	if self._isLight == isLight then
		return
	end

	self._isLight = isLight

	gohelper.setActive(self._goLight, self._isLight)
end

function DianJiShiGameMapAreaItem:onDestroy()
	return
end

return DianJiShiGameMapAreaItem
