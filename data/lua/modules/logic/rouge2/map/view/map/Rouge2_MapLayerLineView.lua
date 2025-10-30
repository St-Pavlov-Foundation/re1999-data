﻿-- chunkname: @modules/logic/rouge2/map/view/map/Rouge2_MapLayerLineView.lua

module("modules.logic.rouge2.map.view.map.Rouge2_MapLayerLineView", package.seeall)

local Rouge2_MapLayerLineView = class("Rouge2_MapLayerLineView", BaseView)

function Rouge2_MapLayerLineView:onInitView()
	self.goLineContainer = gohelper.findChild(self.viewGO, "#go_linecontainer")
	self.goLineIconItem = gohelper.findChild(self.viewGO, "#go_linecontainer/#go_lineitem")
	self.goLine = gohelper.findChild(self.viewGO, "#go_linecontainer/#go_line")
	self.goStart = gohelper.findChild(self.viewGO, "#go_linecontainer/#go_start")
	self.txtStartName = gohelper.findChildText(self.viewGO, "#go_linecontainer/#go_start/#txt_startname")
	self.simageStartIcon = gohelper.findChildSingleImage(self.viewGO, "#go_linecontainer/#go_start/#simage_starticon")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function Rouge2_MapLayerLineView:addEvents()
	return
end

function Rouge2_MapLayerLineView:removeEvents()
	return
end

function Rouge2_MapLayerLineView:_editableInitView()
	gohelper.setActive(self.goLineIconItem, false)
	gohelper.setActive(self.goLine, false)

	self.rectTrStart = self.goStart:GetComponent(gohelper.Type_RectTransform)

	self:hide()

	self.lineItemList = {}

	self:addEventCb(Rouge2_MapController.instance, Rouge2_MapEvent.onSelectLayerChange, self.onSelectLayerChange, self)
	self:addEventCb(Rouge2_MapController.instance, Rouge2_MapEvent.onPathSelectMapFocusDone, self.onPathSelectMapFocusDone, self)
	self:addEventCb(Rouge2_MapController.instance, Rouge2_MapEvent.onChangeMapInfo, self.onChangeMapInfo, self)
	self:addEventCb(Rouge2_MapController.instance, Rouge2_MapEvent.onUpdateMapInfo, self.onUpdateMapInfo, self)
end

function Rouge2_MapLayerLineView:onChangeMapInfo()
	if not Rouge2_MapModel.instance:isPathSelect() then
		self:hide()

		return
	end

	self:initData()
end

function Rouge2_MapLayerLineView:onUpdateMapInfo()
	if not Rouge2_MapModel.instance:isPathSelect() then
		self:hide()

		return
	end

	self:refreshLayer()
end

function Rouge2_MapLayerLineView:onSelectLayerChange(layerId)
	self.selectLayerId = layerId

	self:refreshLayerSelect()
end

function Rouge2_MapLayerLineView:onOpen()
	self:hide()

	if not Rouge2_MapModel.instance:isPathSelect() then
		return
	end

	self:initData()
end

function Rouge2_MapLayerLineView:initData()
	self.pathSelectCo = Rouge2_MapModel.instance:getPathSelectCo()
	self.nextLayerList = Rouge2_MapModel.instance:getNextLayerList()
	self.selectLayerId = Rouge2_MapModel.instance:getSelectLayerId()
end

function Rouge2_MapLayerLineView:onPathSelectMapFocusDone()
	self:show()
	self:refreshLayer()
end

function Rouge2_MapLayerLineView:refreshLayer()
	self:refreshStartPoint()
	self:refreshEndPoint()
end

function Rouge2_MapLayerLineView:refreshStartPoint()
	local layerCo = Rouge2_MapModel.instance:getLayerCo()
	local middleLayerCo = lua_rouge2_middle_layer.configDict[layerCo.middleLayerId]

	self.txtStartName.text = middleLayerCo.name

	self.simageStartIcon:LoadImage(layerCo.iconRes)

	local anchorX, anchorY = Rouge2_MapHelper.getPos(self.pathSelectCo.startPos)

	recthelper.setAnchor(self.rectTrStart, anchorX, anchorY)
end

function Rouge2_MapLayerLineView:refreshEndPoint()
	for index, layerId in ipairs(self.nextLayerList) do
		self:refreshEndPointItem(index, layerId)
	end

	for i = #self.nextLayerList + 1, #self.lineItemList do
		gohelper.setActive(self.lineItemList[i].lineContainer, false)
	end
end

function Rouge2_MapLayerLineView:refreshEndPointItem(index, layerId)
	local layerCo = lua_rouge2_layer.configDict[layerId]
	local lineItem = self.lineItemList[index]

	lineItem = lineItem or self:createLineItem()

	gohelper.setActive(lineItem.lineContainer, true)

	lineItem.lineContainer.name = layerCo.id

	local pathResInfo = string.split(layerCo.pathRes, "#")
	local pathIconName = pathResInfo[1]
	local pathIconDir = tonumber(pathResInfo[2])

	lineItem.imageLine.fillOrigin = pathIconDir

	UISpriteSetMgr.instance:setRouge6Sprite(lineItem.imageLine, pathIconName, true)

	local middleLayerId = layerCo.middleLayerId
	local endPointName = ""

	if middleLayerId and middleLayerId ~= 0 then
		local middleLayerCo = lua_rouge2_middle_layer.configDict[layerCo.middleLayerId]

		endPointName = middleLayerCo.name
	else
		endPointName = Rouge2_MapConfig.instance:getLastLayerEndPointName()
	end

	lineItem.txtSelectLayerName.text = endPointName
	lineItem.txtUnSelectLayerName.text = endPointName
	lineItem.layerCo = layerCo

	lineItem.simageSelectIcon:LoadImage(layerCo.iconRes)
	lineItem.simageUnSelectIcon:LoadImage(layerCo.iconRes)

	local anchorX, anchorY = Rouge2_MapHelper.getPos(layerCo.pathPos)

	recthelper.setAnchor(lineItem.rectLine, anchorX, anchorY)

	anchorX, anchorY = Rouge2_MapHelper.getPos(layerCo.iconPos)

	recthelper.setAnchor(lineItem.rectLineIcon, anchorX, anchorY)

	local select = lineItem.layerCo.id == self.selectLayerId

	lineItem.animator:Play(select and "select_open" or "unselect_open")
end

function Rouge2_MapLayerLineView:refreshLayerSelect()
	for _, lineItem in ipairs(self.lineItemList) do
		local select = lineItem.layerCo.id == self.selectLayerId

		lineItem.animator:Play(select and "select" or "unselect")
	end
end

function Rouge2_MapLayerLineView:createLineItem()
	local lineItem = self:getUserDataTb_()
	local lineContainer = gohelper.create2d(self.goLineContainer)
	local line = gohelper.clone(self.goLine, lineContainer, "line")
	local lineIconItem = gohelper.clone(self.goLineIconItem, lineContainer, "lineIcon")

	gohelper.setActive(line, true)
	gohelper.setActive(lineIconItem, true)

	lineItem.lineContainer = lineContainer
	lineItem.rectLine = line:GetComponent(gohelper.Type_RectTransform)
	lineItem.rectLineIcon = lineIconItem:GetComponent(gohelper.Type_RectTransform)
	lineItem.imageLine = gohelper.findChildImage(line, "line")
	lineItem.iconSelect = gohelper.findChild(lineIconItem, "select")
	lineItem.txtSelectLayerName = gohelper.findChildText(lineIconItem, "select/#txt_line")
	lineItem.simageSelectIcon = gohelper.findChildSingleImage(lineIconItem, "select/#simage_icon")
	lineItem.iconUnSelect = gohelper.findChild(lineIconItem, "unselect")
	lineItem.txtUnSelectLayerName = gohelper.findChildText(lineIconItem, "unselect/#txt_line")
	lineItem.simageUnSelectIcon = gohelper.findChildSingleImage(lineIconItem, "unselect/#simage_icon")
	lineItem.animator = lineIconItem:GetComponent(gohelper.Type_Animator)
	lineItem.click = gohelper.getClickWithDefaultAudio(lineIconItem)

	lineItem.click:AddClickListener(self.onClickLine, self, lineItem)
	gohelper.setActive(lineItem.iconSelect, true)
	gohelper.setActive(lineItem.iconUnSelect, true)
	recthelper.setAnchor(lineContainer.transform, 0, 0)
	table.insert(self.lineItemList, lineItem)

	return lineItem
end

function Rouge2_MapLayerLineView:onClickLine(lineItem)
	local layerId = lineItem.layerCo.id

	Rouge2_MapModel.instance:updateSelectLayerId(layerId)
end

function Rouge2_MapLayerLineView:show()
	gohelper.setActive(self.goLineContainer, true)
end

function Rouge2_MapLayerLineView:hide()
	gohelper.setActive(self.goLineContainer, false)
end

function Rouge2_MapLayerLineView:onDestroyView()
	for _, lineItem in ipairs(self.lineItemList) do
		lineItem.click:RemoveClickListener()
		lineItem.simageSelectIcon:UnLoadImage()
		lineItem.simageUnSelectIcon:UnLoadImage()
	end

	self.lineItemList = nil

	self.simageStartIcon:UnLoadImage()
end

return Rouge2_MapLayerLineView
