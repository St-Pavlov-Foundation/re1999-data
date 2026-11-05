-- chunkname: @modules/logic/versionactivity4_1/evelyn/view/EvelynPanelView.lua

module("modules.logic.versionactivity4_1.evelyn.view.EvelynPanelView", package.seeall)

local EvelynPanelView = class("EvelynPanelView", BaseView)

function EvelynPanelView:onInitView()
	self._btnclose = gohelper.findChildButtonWithAudio(self.viewGO, "root/#btn_close")
	self._scrolltabLeft = gohelper.findChildScrollRect(self.viewGO, "root/#scroll_tabLeft")
	self._goTabItem = gohelper.findChild(self.viewGO, "root/#scroll_tabLeft/Viewport/Content/#go_TabItem")
	self._scrolltabTop = gohelper.findChildScrollRect(self.viewGO, "root/#scroll_tabTop")
	self._goToolItem = gohelper.findChild(self.viewGO, "root/#scroll_tabTop/Viewport/Content/#go_ToolItem")
	self._gosourceitem = gohelper.findChild(self.viewGO, "root/Content/Source/#go_sourceitem")
	self._gotoolsitem = gohelper.findChild(self.viewGO, "root/Content/Tools/#go_toolsitem")
	self._goselect = gohelper.findChild(self.viewGO, "root/Content/Tools/#go_select")
	self._gotime = gohelper.findChild(self.viewGO, "root/Content/Tools/#go_select/bg")
	self._goendingitem = gohelper.findChild(self.viewGO, "root/Content/Ending/#go_endingitem")
	self._btnplace = gohelper.findChildButtonWithAudio(self.viewGO, "root/Content/Btn/#btn_place")
	self._goplaced = gohelper.findChild(self.viewGO, "root/Content/Btn/#go_placed")
	self._golock = gohelper.findChild(self.viewGO, "root/Content/Btn/#go_lock")
	self._goLineRoot = gohelper.findChild(self.viewGO, "root/Content/#go_lineRoot")
	self._goContent = gohelper.findChild(self.viewGO, "root/Content")
	self._txtTips = gohelper.findChildTextMesh(self.viewGO, "root/Content/txt_tips")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function EvelynPanelView:addEvents()
	self._btnclose:AddClickListener(self._btncloseOnClick, self)
	self._btnplace:AddClickListener(self._btnplaceOnClick, self)
	self:addEventCb(GameGlobalMgr.instance, GameStateEvent.OnScreenResize, self._onScreenResize, self)
	NavigateMgr.instance:addEscape(self.viewName, self._btncloseOnClick, self)
end

function EvelynPanelView:removeEvents()
	self._btnclose:RemoveClickListener()
	self._btnplace:RemoveClickListener()
	self:removeEventCb(GameGlobalMgr.instance, GameStateEvent.OnScreenResize, self._onScreenResize, self)
	NavigateMgr.instance:removeEscape(self.viewName)
end

function EvelynPanelView:_btncloseOnClick()
	self:closeThis()
end

function EvelynPanelView:_btnplaceOnClick()
	local toolId = self._curToolId

	if not toolId or not self._gameModel then
		return
	end

	if self:_isSubTypeLocked(self._curSubType) then
		return
	end

	if self._gameView then
		self._gameView:_beginPlaceMode(toolId)
	else
		self._gameModel:placeTool(toolId)
	end

	self:closeThis()
end

function EvelynPanelView:_onTabItemClick(subType)
	if subType == self._curSubType then
		return
	end

	if subType ~= EvelynEnum.FirstSubType and self:_isSubTypeLocked(subType) then
		return
	end

	self._curSubType = subType

	local firstToolCo = self._subTypeToolDict[subType][1]

	self._curToolId = firstToolCo and firstToolCo.id or nil

	self:_refreshTabItems()
	self:_refreshToolItems()
	self:_refreshContentFlow()
	self:_refreshTipsText()

	self._scrolltabTop.verticalNormalizedPosition = 1
end

function EvelynPanelView:_onToolItemClick(toolId)
	if toolId == self._curToolId then
		return
	end

	self._curToolId = toolId

	self:_refreshToolItems()
	self:_refreshContentFlow()
	self:_refreshTipsText()
end

function EvelynPanelView:_editableInitView()
	return
end

function EvelynPanelView:onUpdateParam()
	return
end

function EvelynPanelView:onOpen()
	if not self:_parseToolData() then
		return
	end

	self:_initTabItems()
	self:_initToolItems()
	self:_refreshContentFlow()
	self:_refreshTipsText()
end

function EvelynPanelView:_parseToolData()
	local viewParam = self.viewParam or {}
	local stageId = viewParam.gameId

	self._stageId = stageId
	self._gameModel = viewParam.gameModel
	self._gameView = viewParam.gameView

	local nodeCos = stageId and EvelynConfig.instance:getNodeCos(stageId)

	if not nodeCos then
		logError(string.format("EvelynPanelView:_parseToolData error, no node config, stageId:%s", tostring(stageId)))

		return false
	end

	self._subTypeList = {}
	self._subTypeToolDict = {}

	for _, nodeCo in ipairs(nodeCos) do
		if nodeCo.type == EvelynEnum.PointType.Tool then
			if not self._subTypeToolDict[nodeCo.subType] then
				self._subTypeToolDict[nodeCo.subType] = {}

				table.insert(self._subTypeList, nodeCo.subType)
			end

			table.insert(self._subTypeToolDict[nodeCo.subType], nodeCo)
		end
	end

	if #self._subTypeList <= 0 then
		logError(string.format("EvelynPanelView:_parseToolData error, no tool node, stageId:%s", tostring(stageId)))

		return false
	end

	table.sort(self._subTypeList)

	self._curToolId = viewParam.toolId

	local curToolCo = self._curToolId and EvelynConfig.instance:getNodeCo(stageId, self._curToolId)

	if curToolCo and curToolCo.type == EvelynEnum.PointType.Tool then
		self._curSubType = curToolCo.subType
	else
		self._curSubType = self._subTypeList[1]

		local firstToolCo = self._subTypeToolDict[self._curSubType][1]

		self._curToolId = firstToolCo and firstToolCo.id or nil
	end

	return true
end

function EvelynPanelView:_initTabItems()
	self._tabItems = {}

	for i, subType in ipairs(self._subTypeList) do
		local tabGo

		if i == 1 then
			tabGo = self._goTabItem
		else
			tabGo = gohelper.cloneInPlace(self._goTabItem, "go_TabItem_" .. subType)
		end

		local tabItem = self:getUserDataTb_()

		tabItem.go = tabGo
		tabItem.subType = subType
		tabItem._goNormal = gohelper.findChild(tabGo, "go_Normal")
		tabItem._goSelect = gohelper.findChild(tabGo, "go_Select")
		tabItem._goLock = gohelper.findChild(tabGo, "go_Lock")
		tabItem._unlockAnimator = gohelper.findChildAnim(tabGo, "go_Lock")

		self:_setTabItemView(tabItem)

		local btnClick = gohelper.findChildButtonWithAudio(tabGo, "btn_Click")

		self:addClickCb(btnClick, self._onTabItemClick, self, subType)
		table.insert(self._tabItems, tabItem)
	end

	self:_refreshTabItems()
end

function EvelynPanelView:_setTabItemView(tabItem)
	local name = luaLang("v4a0_evelyn_tool_type_" .. tabItem.subType)
	local txtNormal = gohelper.findChildText(tabItem.go, "go_Normal/txt_Tab")

	if txtNormal then
		txtNormal.text = name
	end

	local txtSelect = gohelper.findChildText(tabItem.go, "go_Select/txt_Tab")

	if txtSelect then
		txtSelect.text = name
	end

	local txtLock = gohelper.findChildText(tabItem.go, "go_Lock/txt_Tab")

	if txtLock then
		txtLock.text = name
	end
end

function EvelynPanelView:_isSubTypeLocked(subType)
	if self._gameModel then
		return not self._gameModel:isSubTypeUnlocked(subType)
	end

	return false
end

function EvelynPanelView:_refreshTabItems()
	for _, tabItem in ipairs(self._tabItems or {}) do
		local locked = self:_isSubTypeLocked(tabItem.subType)
		local selected = tabItem.subType == self._curSubType

		gohelper.setActive(tabItem._goLock, locked)
		gohelper.setActive(tabItem._goSelect, not locked and selected)
		gohelper.setActive(tabItem._goNormal, not locked and not selected)

		if not locked and tabItem.subType ~= EvelynEnum.FirstSubType and self._gameModel and not self._gameModel:isSubTypeUnlockAnimPlayed(tabItem.subType) then
			self:_playTabUnlockAnim(tabItem)
		end
	end
end

function EvelynPanelView:_playTabUnlockAnim(tabItem)
	if not tabItem._unlockAnimator or not tabItem._goLock then
		return
	end

	gohelper.setActive(tabItem._goLock, true)
	tabItem._unlockAnimator:Play(EvelynEnum.AnimatorName.Unlock)

	if self._gameModel then
		self._gameModel:markSubTypeUnlockAnimPlayed(tabItem.subType)
	end
end

function EvelynPanelView:_initToolItems()
	self._toolItems = {}

	local index = 0

	for _, subType in ipairs(self._subTypeList) do
		for _, nodeCo in ipairs(self._subTypeToolDict[subType]) do
			index = index + 1

			local itemGo

			if index == 1 then
				itemGo = self._goToolItem
			else
				itemGo = gohelper.cloneInPlace(self._goToolItem, "go_ToolItem_" .. nodeCo.id)
			end

			local toolItem = self:getUserDataTb_()

			toolItem.go = itemGo
			toolItem.nodeCo = nodeCo
			toolItem._goNormal = gohelper.findChild(itemGo, "go_Normal")
			toolItem._goSelect = gohelper.findChild(itemGo, "go_Select")
			toolItem._goFinish = gohelper.findChild(itemGo, "go_Finish")
			toolItem._goDetail = gohelper.findChild(itemGo, "#go_Detail")

			gohelper.setActive(toolItem._goDetail, false)

			toolItem._goHighLight = gohelper.findChild(itemGo, "#go_linkLight")

			gohelper.setActive(toolItem._goHighLight, false)
			gohelper.setActive(gohelper.findChild(itemGo, "#go_point"), false)
			self:_setToolItemView(toolItem)

			local btnClick = gohelper.findChildButtonWithAudio(itemGo, "btn_Click")

			self:addClickCb(btnClick, self._onToolItemClick, self, nodeCo.id)
			table.insert(self._toolItems, toolItem)
		end
	end

	self:_refreshToolItems()
end

function EvelynPanelView:_setToolItemView(toolItem)
	local nodeCo = toolItem.nodeCo
	local txtNormal = gohelper.findChildText(toolItem.go, "go_Normal/txt_Tab")

	if txtNormal then
		txtNormal.text = nodeCo.name
	end

	local txtSelect = gohelper.findChildText(toolItem.go, "go_Select/txt_Tab")

	if txtSelect then
		txtSelect.text = nodeCo.name
	end

	self:_setToolItemIcon(gohelper.findChildImage(toolItem.go, "go_Normal/#image_icon"), nodeCo)
	self:_setToolItemIcon(gohelper.findChildImage(toolItem.go, "go_Select/#image_icon"), nodeCo)
end

function EvelynPanelView:_setToolItemIcon(imageIcon, nodeCo)
	if not imageIcon then
		return
	end

	local showImage = not string.nilorempty(nodeCo.icon)

	gohelper.setActive(imageIcon, showImage)

	if showImage then
		UISpriteSetMgr.instance:setV4a1YifulinSprite(imageIcon, nodeCo.icon)
	end
end

function EvelynPanelView:_refreshToolItems()
	for _, toolItem in ipairs(self._toolItems or {}) do
		gohelper.setActive(toolItem.go, toolItem.nodeCo.subType == self._curSubType)

		local selected = toolItem.nodeCo.id == self._curToolId

		gohelper.setActive(toolItem._goSelect, selected)
		gohelper.setActive(toolItem._goNormal, not selected)

		local finished = self:_isToolPlaced(toolItem.nodeCo.id) and self._gameModel and self._gameModel:isToolShown(toolItem.nodeCo.id) or false

		gohelper.setActive(toolItem._goFinish, finished)
	end
end

function EvelynPanelView:_isToolPlaced(toolId)
	return self._gameModel and self._gameModel:isToolPlaced(toolId) or false
end

function EvelynPanelView:_refreshContentFlow()
	self:_refreshPlaceBtn()

	local curPlaced = self:_isToolPlaced(self._curToolId)

	gohelper.setActive(self._goselect, curPlaced)
	self:_clearContentFlow()

	local toolCo = self._curToolId and EvelynConfig.instance:getNodeCo(self._stageId, self._curToolId)

	if not toolCo then
		return
	end

	logWarn(string.format("[EvelynPanel][CurrentTool] toolId:%s inputPanelParam:'%s' outPutpanelParam:'%s' inputs:'%s' outputs:'%s'", tostring(toolCo.id), tostring(toolCo.inputPanelParam), tostring(toolCo.outPutpanelParam), tostring(toolCo.inputs), tostring(toolCo.outputs)))

	local inputIds = self:_getToolRelateIds(toolCo, true)
	local outputIds = self:_getToolRelateIds(toolCo, false)

	self._flowNodeDict = {}

	self:_createAreaNodeItems(inputIds, self._gosourceitem, true, toolCo.id)
	self:_createAreaNodeItems({
		toolCo.id
	}, self._gotoolsitem, nil, toolCo.id)
	self:_createAreaNodeItems(outputIds, self._goendingitem, false, toolCo.id)
	self:_createFlowLines(toolCo, inputIds, outputIds)
	self:_debugLogFlowLineInfo(toolCo, inputIds, outputIds)
	self:_refreshToolTime(toolCo)
end

function EvelynPanelView:_refreshPlaceBtn()
	local curToolCo = self._curToolId and EvelynConfig.instance:getNodeCo(self._stageId, self._curToolId)
	local locked = self:_isSubTypeLocked(self._curSubType)

	if not locked and self._gameModel and curToolCo then
		locked = not self._gameModel:isToolShown(self._curToolId)
	end

	local placed = self:_isToolPlaced(self._curToolId)

	gohelper.setActive(self._golock, locked)
	gohelper.setActive(self._goplaced, not locked and placed)
	gohelper.setActive(self._btnplace.gameObject, not locked and not placed)
end

function EvelynPanelView:_clearContentFlow()
	for _, nodeItem in pairs(self._flowNodeDict or {}) do
		gohelper.destroy(nodeItem.viewGO)
	end

	self._flowNodeDict = nil

	for _, lineItem in ipairs(self._flowLineItems or {}) do
		gohelper.destroy(lineItem.viewGO)
	end

	self._flowLineItems = nil
end

function EvelynPanelView:_getToolRelateIds(toolCo, isInput)
	if self._gameModel then
		if isInput then
			return self._gameModel:getToolInputIds(toolCo.id)
		end

		return self._gameModel:getToolOutputIds(toolCo.id)
	end

	local idStr = isInput and toolCo.inputs or toolCo.outputs
	local idList = {}

	if not string.nilorempty(idStr) then
		for _, str in ipairs(string.split(idStr, "#")) do
			local id = tonumber(str)

			if id then
				table.insert(idList, id)
			end
		end
	end

	return idList
end

function EvelynPanelView:_createAreaNodeItems(nodeIds, anchorGo, isInput, toolId)
	local count = #nodeIds

	if count <= 0 then
		return
	end

	local setting = self.viewContainer:getSetting()
	local anchorTrs = anchorGo.transform
	local parentGo = anchorGo

	for i, nodeId in ipairs(nodeIds) do
		local nodeCo = EvelynConfig.instance:getNodeCo(self._stageId, nodeId)
		local prefabPath = nodeCo and setting.otherRes[nodeCo.type]

		if prefabPath then
			local cloneGo = self:getResInst(prefabPath, parentGo)

			cloneGo.name = "flow_node_" .. nodeId

			local pOffX, pOffY, pScale = EvelynConfig.instance:getNodeRelatePanelParam(self._stageId, toolId, nodeId, isInput)

			logWarn(string.format("[EvelynPanel][PanelParam] toolId:%s nodeId:%s isInput:%s pOffX:%.1f pOffY:%.1f pScale:%.2f", tostring(toolId), tostring(nodeId), tostring(isInput), pOffX, pOffY, pScale))

			cloneGo.transform.localPosition = Vector3(pOffX, pOffY, 0)
			cloneGo.transform.localScale = Vector3(pScale, pScale, 1)

			local nodeItem = MonoHelper.addNoUpdateLuaComOnceToGo(cloneGo, EvelynNodeItem)

			nodeItem:setNodeCo(nodeCo)

			if isInput == nil then
				local goPoint = gohelper.findChild(cloneGo, "root/has/#go_point")

				if goPoint then
					gohelper.setActive(goPoint, false)
				end
			end

			self:_refreshNodeLinkVisibility(nodeItem, nodeCo, isInput)

			self._flowNodeDict[nodeId] = nodeItem
		else
			logError(string.format("EvelynPanelView:_createAreaNodeItems error, no node or prefab, nodeId:%s", tostring(nodeId)))
		end
	end
end

function EvelynPanelView:_refreshNodeLinkVisibility(nodeItem, nodeCo, isInput)
	if not nodeCo then
		return
	end

	local pointType = EvelynEnum.PointType

	if nodeCo.type ~= pointType.Tool and nodeCo.type ~= pointType.Res then
		return
	end

	local hasLinkL = isInput == nil or isInput == false
	local hasLinkR = isInput == nil or isInput == true
	local linkLName = nodeItem._goLinkL and nodeItem._goLinkL.name or "nil"
	local linkRName = nodeItem._goLinkR and nodeItem._goLinkR.name or "nil"

	logWarn(string.format("[EvelynPanel] node:%s(type:%s) area:%s | linkL:%s(show:%s) linkR:%s(show:%s)", tostring(nodeCo.id), tostring(nodeCo.type), isInput == nil and "Tools" or isInput and "Source" or "Ending", linkLName, tostring(hasLinkL), linkRName, tostring(hasLinkR)))

	if nodeItem._goLinkL then
		gohelper.setActive(nodeItem._goLinkL, hasLinkL)
	end

	if nodeItem._goLinkR then
		gohelper.setActive(nodeItem._goLinkR, hasLinkR)
	end
end

function EvelynPanelView:_debugLogFlowLineInfo(toolCo, inputIds, outputIds)
	local toolItem = self._flowNodeDict and self._flowNodeDict[toolCo.id]

	if not toolItem then
		return
	end

	local toolGo = toolItem.viewGO
	local toolCenter = recthelper.rectToRelativeAnchorPos(toolGo.transform.position, self._goLineRoot.transform)

	logWarn(string.format("[EvelynPanel][FlowLine] toolId:%s toolGo:%s center:(%.1f,%.1f)", tostring(toolCo.id), toolGo.name, toolCenter.x, toolCenter.y))

	for _, inputId in ipairs(inputIds or {}) do
		local ax, ay, aRef = self:_getFlowEndpoint(inputId, true)
		local bx, by, bRef = self:_getFlowEndpoint(toolCo.id, false)

		logWarn(string.format("[EvelynPanel][FlowLine] input %s->%s | from:%s(%.1f,%.1f) -> to:%s(%.1f,%.1f)", tostring(inputId), tostring(toolCo.id), aRef, ax, ay, bRef, bx, by))
	end

	for _, outputId in ipairs(outputIds or {}) do
		local ax, ay, aRef = self:_getFlowEndpoint(toolCo.id, true)
		local bx, by, bRef = self:_getFlowEndpoint(outputId, false)

		logWarn(string.format("[EvelynPanel][FlowLine] output %s->%s | from:%s(%.1f,%.1f) -> to:%s(%.1f,%.1f)", tostring(toolCo.id), tostring(outputId), aRef, ax, ay, bRef, bx, by))
	end
end

function EvelynPanelView:_createFlowLines(toolCo, inputIds, outputIds)
	if #inputIds + #outputIds <= 0 then
		return
	end

	UnityEngine.Canvas.ForceUpdateCanvases()

	self._flowLineItems = {}

	for _, inputId in ipairs(inputIds) do
		table.insert(self._flowLineItems, self:_createFlowLine(inputId, toolCo.id))
	end

	for _, outputId in ipairs(outputIds) do
		table.insert(self._flowLineItems, self:_createFlowLine(toolCo.id, outputId))
	end
end

function EvelynPanelView:_createFlowLine(fromId, toId)
	local setting = self.viewContainer:getSetting()
	local cloneGo = self:getResInst(setting.otherRes[5], self._goLineRoot)

	cloneGo.name = "flow_line_" .. fromId .. "_" .. toId

	local lineItem = MonoHelper.addNoUpdateLuaComOnceToGo(cloneGo, EvelynLineItem)

	lineItem._flowFromId = fromId
	lineItem._flowToId = toId

	self:_refreshFlowLineTransform(lineItem, fromId, toId)

	return lineItem
end

function EvelynPanelView:_onScreenResize()
	for _, lineItem in ipairs(self._flowLineItems or {}) do
		self:_refreshFlowLineTransform(lineItem, lineItem._flowFromId, lineItem._flowToId)
	end
end

function EvelynPanelView:_refreshFlowLineTransform(lineItem, fromId, toId)
	local ax, ay = self:_getFlowEndpoint(fromId, true)
	local bx, by = self:_getFlowEndpoint(toId, false)
	local angleDeg = self._gameView and self._gameView:_calcLineAngle(ax, ay, bx, by) or EvelynEnum.CurveAngle.Up

	lineItem:refresh(ax, ay, bx, by, angleDeg, self._goLineRoot.transform)
end

function EvelynPanelView:_getFlowEndpoint(nodeId, isFrom)
	local nodeItem = self._flowNodeDict and self._flowNodeDict[nodeId]

	if not nodeItem then
		return 0, 0, "nil"
	end

	local nodeGo = nodeItem.viewGO
	local nodeCo = nodeItem._nodeCo
	local linkGo = isFrom and nodeItem:getLinkGoR() or nodeItem:getLinkGoL()

	if linkGo and not gohelper.isNil(linkGo) then
		local pos = recthelper.rectToRelativeAnchorPos(linkGo.transform.position, self._goLineRoot.transform)

		return pos.x, pos.y, nodeGo.name .. "/" .. linkGo.name
	end

	local pos = recthelper.rectToRelativeAnchorPos(nodeGo.transform.position, self._goLineRoot.transform)
	local halfW = recthelper.getWidth(nodeGo.transform) * 0.5

	if isFrom then
		return pos.x + halfW, pos.y, nodeGo.name .. "(fallback+r)"
	end

	return pos.x - halfW, pos.y, nodeGo.name .. "(fallback-l)"
end

function EvelynPanelView:_refreshToolTime(toolCo)
	local txtTime = gohelper.findChildText(self._goselect, "bg/txt_time")

	if not toolCo or not tonumber(toolCo.useTime) or tonumber(toolCo.useTime) <= 0 then
		gohelper.setActive(self._gotime, false)

		return
	end

	gohelper.setActive(self._gotime, true)

	if not txtTime then
		return
	end

	local useTime = self._gameModel and self._gameModel:getToolUseTime(toolCo.id) or tonumber(toolCo.useTime) or EvelynEnum.AnimTime.ToolToRes

	txtTime.text = GameUtil.getSubPlaceholderLuaLangOneParam(luaLang("v4a0_evelyn_tool_use_time_tip"), useTime)
end

function EvelynPanelView:_refreshTipsText()
	if not self._txtTips then
		return
	end

	local toolCo = self._curToolId and EvelynConfig.instance:getNodeCo(self._stageId, self._curToolId)

	if toolCo and not string.nilorempty(toolCo.desc) then
		self._txtTips.text = toolCo.desc
	else
		self._txtTips.text = ""
	end
end

function EvelynPanelView:onClose()
	return
end

function EvelynPanelView:onDestroyView()
	self._tabItems = nil
	self._toolItems = nil
	self._subTypeList = nil
	self._subTypeToolDict = nil
	self._gameModel = nil
	self._gameView = nil
	self._curSubType = nil
	self._curToolId = nil
	self._stageId = nil
	self._flowNodeDict = nil
	self._flowLineItems = nil
end

return EvelynPanelView
