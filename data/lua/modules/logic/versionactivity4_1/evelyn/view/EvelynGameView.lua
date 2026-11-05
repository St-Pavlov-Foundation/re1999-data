-- chunkname: @modules/logic/versionactivity4_1/evelyn/view/EvelynGameView.lua

module("modules.logic.versionactivity4_1.evelyn.view.EvelynGameView", package.seeall)

local EvelynGameView = class("EvelynGameView", BaseView)
local MinMapScale = 0.5
local MaxMapScale = 1.5
local MapScaleStep = 0.1
local MapWheelScaleRate = 0.2
local MapClampExtra = 0
local DragFlyBackDuration = 0.2
local ToolsBarScrollMaxCount = 6
local IntroLockKey = "EvelynGameIntroLock"

function EvelynGameView:onInitView()
	self._goDragRoot = gohelper.findChild(self.viewGO, "root/#go_dragRoot")
	self._goPlaceRoot = gohelper.findChild(self.viewGO, "root/#go_placeRoot")
	self._goMapRoot = gohelper.findChild(self.viewGO, "root/#go_dragRoot/#go_mapRoot")
	self._goTipRoot = gohelper.findChild(self.viewGO, "root/#go_dragRoot/#go_tipRoot")
	self._goTips = gohelper.findChild(self.viewGO, "root/#go_Tips")
	self._txtTips = gohelper.findChildText(self.viewGO, "root/#go_Tips/#txt_Tips")
	self._btnReset = gohelper.findChildButtonWithAudio(self.viewGO, "root/#btn_Reset")
	self._btnAnalysis = gohelper.findChildButtonWithAudio(self.viewGO, "root/#btn_Analysis")
	self._btnTools = gohelper.findChildButtonWithAudio(self.viewGO, "root/Tools/#btn_Tools")
	self._goarrow = gohelper.findChild(self.viewGO, "root/Tools/#btn_Tools/txt_Tools/#go_arrow")
	self._scrollTools = gohelper.findChildScrollRect(self.viewGO, "root/Tools/#scroll_Tools")

	local goTools = gohelper.findChild(self.viewGO, "root/Tools")

	self._toolsAnimator = goTools and goTools:GetComponent(gohelper.Type_Animator)
	self._goTarget = gohelper.findChild(self.viewGO, "root/#go_Target")
	self._txtTarget = gohelper.findChildText(self.viewGO, "root/#go_Target/#txt_Target")
	self._goScale = gohelper.findChild(self.viewGO, "root/#go_Scale")
	self._btndown = gohelper.findChildButtonWithAudio(self.viewGO, "root/#go_Scale/#btn_down")
	self._btnup = gohelper.findChildButtonWithAudio(self.viewGO, "root/#go_Scale/#btn_up")

	gohelper.removeUIClickAudio(self._btndown.gameObject)
	gohelper.removeUIClickAudio(self._btnup.gameObject)

	self._gomapSlider = gohelper.findChild(self.viewGO, "root/#go_Scale/#go_mapSlider")
	self._gotopLeft = gohelper.findChild(self.viewGO, "root/#go_topLeft")
	self._goArrowTemplate = gohelper.findChild(self.viewGO, "root/#btn_arrowTop")

	local goArrowRight = gohelper.findChild(self.viewGO, "root/#btn_arrowRight")

	if goArrowRight then
		gohelper.setActive(goArrowRight, false)
	end

	self.goMapBg = gohelper.findChild(self.viewGO, "root/simage_fullbg/simage_fullbg")
	self._btnCloseTip = gohelper.findChildButtonWithAudio(self.viewGO, "root/#btn_closeTip")
	self._btnClosePlace = gohelper.findChildButtonWithAudio(self.viewGO, "root/#go_dragRoot/#btn_closePlace")
	self._goDetail = gohelper.findChild(self.viewGO, "root/#go_Detail")
	self._txtDetail = gohelper.findChildText(self.viewGO, "root/#go_Detail/go_scroll/viewport/content/#txt_Detail")

	gohelper.setActive(self._goDetail, false)

	self._btnToolsImage = self._btnTools.gameObject:GetComponent(gohelper.Type_Image)

	gohelper.setActive(self._btnCloseTip, false)
	gohelper.setActive(self._btnClosePlace, false)

	self._viewAnimator = self.viewGO:GetComponent(gohelper.Type_Animator)

	if self._editableInitView then
		self:_editableInitView()
	end
end

function EvelynGameView:_editableInitView()
	self._mapDragHandler = SLFramework.UGUI.UIDragListener.Get(self._goDragRoot)
	self._mapSlider = gohelper.findChildSlider(self._gomapSlider, "")
end

function EvelynGameView:addEvents()
	self._btnReset:AddClickListener(self._btnResetOnClick, self)
	self._btnAnalysis:AddClickListener(self._btnAnalysisOnClick, self)
	self._btnTools:AddClickListener(self._btnToolsOnClick, self)
	self._btndown:AddClickListener(self._btndownOnClick, self)
	self._btnup:AddClickListener(self._btnupOnClick, self)
	self._btnCloseTip:AddClickListener(self._onCloseDetailClick, self)
	self._btnClosePlace:AddClickListener(self._cancelPlaceMode, self)
	self._mapDragHandler:AddDragBeginListener(self._onMapDragBegin, self)
	self._mapDragHandler:AddDragListener(self._onMapDrag, self)
	self._mapSlider:AddOnValueChanged(self._onMapSliderValueChanged, self)

	self._btnDownClickLsn = SLFramework.UGUI.UIClickListener.Get(self._btndown.gameObject)

	if self._btnDownClickLsn then
		self._btnDownClickLsn:AddClickDownListener(self._onScaleControlDown, self)
	end

	self._btnUpClickLsn = SLFramework.UGUI.UIClickListener.Get(self._btnup.gameObject)

	if self._btnUpClickLsn then
		self._btnUpClickLsn:AddClickDownListener(self._onScaleControlDown, self)
	end

	self._sliderClickLsn = SLFramework.UGUI.UIClickListener.Get(self._gomapSlider)

	if self._sliderClickLsn then
		self._sliderClickLsn:AddClickDownListener(self._onScaleControlDown, self)
	end

	self._isScrollWheelEnabled = BootNativeUtil.isStandalonePlayer() or SDKMgr.instance:isEmulator()

	self:addEventCb(GameGlobalMgr.instance, GameStateEvent.OnScreenResize, self._onScreenResize, self)
	self:addEventCb(GuideController.instance, GuideEvent.FinishGuide, self.onGuideFinish, self)
	self:addEventCb(GuideController.instance, GuideEvent.StartGuideStep, self.onGuideStepStart, self)
	self:addEventCb(GuideController.instance, GuideEvent.FinishStep, self.onGuideStepFinish, self)
	self:addEventCb(ViewMgr.instance, ViewEvent.OnOpenViewFinish, self._onOpenViewFinish, self)

	self._guideTipActive = nil

	UpdateBeat:Add(self._onUpdate, self)
end

function EvelynGameView:removeEvents()
	self._btnReset:RemoveClickListener()
	self._btnAnalysis:RemoveClickListener()
	self._btnTools:RemoveClickListener()
	self._btndown:RemoveClickListener()
	self._btnup:RemoveClickListener()
	self._btnCloseTip:RemoveClickListener()
	self._btnClosePlace:RemoveClickListener()
	self._mapDragHandler:RemoveDragBeginListener()
	self._mapDragHandler:RemoveDragListener()
	self._mapSlider:RemoveOnValueChanged()

	if self._btnDownClickLsn then
		self._btnDownClickLsn:RemoveClickDownListener()

		self._btnDownClickLsn = nil
	end

	if self._btnUpClickLsn then
		self._btnUpClickLsn:RemoveClickDownListener()

		self._btnUpClickLsn = nil
	end

	if self._sliderClickLsn then
		self._sliderClickLsn:RemoveClickDownListener()

		self._sliderClickLsn = nil
	end

	self:removeEventCb(GameGlobalMgr.instance, GameStateEvent.OnScreenResize, self._onScreenResize, self)
	self:removeEventCb(GuideController.instance, GuideEvent.FinishGuide, self.onGuideFinish, self)
	self:removeEventCb(GuideController.instance, GuideEvent.StartGuideStep, self.onGuideStepStart, self)
	self:removeEventCb(GuideController.instance, GuideEvent.FinishStep, self.onGuideStepFinish, self)
	self:removeEventCb(ViewMgr.instance, ViewEvent.OnOpenViewFinish, self._onOpenViewFinish, self)
	UpdateBeat:Remove(self._onUpdate, self)

	self._isScrollWheelEnabled = nil
end

function EvelynGameView:onOpen()
	AudioMgr.instance:trigger(AudioEnum4_1.Evelyn.play_ui_atlantis_yifulin_open)
	self:_initGame()

	if self._viewAnimator then
		self._viewAnimator:Play(EvelynEnum.AnimatorName.Open, 0, 0)
	end
end

function EvelynGameView:onUpdateParam()
	self._settleMasking = nil
end

function EvelynGameView:onClose()
	TaskDispatcher.cancelTask(self._onFocusLineUpdate, self)
	self:_clearPlaceFeedback()
	self:_clearAllPointAnims()
	self:_clearStepDelay()
	self:_clearCamMove()
	self:_clearIntroZoom()
	TaskDispatcher.cancelTask(self._onGuideCompleteDelayDone, self)
end

function EvelynGameView:onDestroyView()
	for _, item in pairs(self._nodeItemDict or {}) do
		for _, dragGo in pairs({
			item._goLinkIconL,
			item._goLinkIconR,
			item._goLinkBtn
		}) do
			local dragHandler = SLFramework.UGUI.UIDragListener.Get(dragGo)

			if dragHandler then
				dragHandler:RemoveDragBeginListener()
				dragHandler:RemoveDragListener()
				dragHandler:RemoveDragEndListener()
			end
		end
	end

	self._gameModel = nil
	self._nodeItemDict = nil
	self._toolItemDict = nil
	self._lineItemDict = nil
	self._goMap = nil
	self._toolsScrollRect = nil
	self._toolsBarVisibleCount = nil

	for _, barItem in ipairs(self._toolBarItems or {}) do
		local dragHandler = SLFramework.UGUI.UIDragListener.Get(barItem.go)

		if dragHandler then
			dragHandler:RemoveDragBeginListener()
			dragHandler:RemoveDragListener()
			dragHandler:RemoveDragEndListener()
		end
	end

	self._toolBarItems = nil

	for _, dragItem in pairs(self._dragItemDic or {}) do
		ZProj.TweenHelper.KillByObj(dragItem.go.transform)
	end

	self._dragItemDic = nil
	self._curDragToolId = nil
	self._dragSession = nil
	self._linkDragSession = nil
	self._linkDragLineItem = nil

	self:_clearToolUsingAnim()
	self:_clearCompleteAnim()
	self:_clearDragFeedback(true)
	self:_clearPlaceFeedback()
	self:_clearAllPointAnims()

	self._curDetailItem = nil

	self:_cancelPlaceMode()
	self:_clearStepDelay()
	self:_clearCamMove()
	self:_clearIntroZoom()
end

function EvelynGameView:_initGame()
	local gameId = self.viewParam and self.viewParam.gameId
	local stageId = self:_resolveStageId(gameId)

	if not stageId then
		return
	end

	self._gameModel = EvelynGameModel.New()

	self._gameModel:initMap(stageId)

	if not self._gameModel:getMapCo() then
		return
	end

	self._statStartTime = ServerTime.now()
	self._statSent = false

	self:_setupMapSize()
	self:_createNodeItems()
	self:_createLineItems()
	self:_initToolsBar()
	self:_refreshTargetText()
	self:_setCollapsed()

	local initScale = self._minMapScale + (MaxMapScale - self._minMapScale) * EvelynEnum.MapOriginSize
	local baseScale = self._goMapRoot.transform.localScale.x

	self._mapScale = baseScale and baseScale > 0.0001 and baseScale or MaxMapScale

	self:_setMapScale(self._minMapScale)
	self:_resetMapPos()

	self._introTargetScale = initScale

	self:_startIntroSequence(EvelynEnum.AnimTime.OpenAnimDuration)
	self:_initLinkTargetArrows()
end

function EvelynGameView:_resolveStageId(gameId)
	if not gameId or gameId == 0 then
		logError("EvelynGameView:_resolveStageId error, empty gameId")

		return nil
	end

	local actId = EvelynModel.instance:getActId()

	if EvelynConfig.instance:getMapCo(actId, gameId) then
		return gameId
	end

	logError(string.format("EvelynGameView:_resolveStageId error, no map config, gameId:%s", tostring(gameId)))

	return nil
end

function EvelynGameView:_setupMapSize()
	self._goMap = self._goMapRoot

	local mapTrs = self._goMap.transform

	mapTrs.anchorMin = Vector2(0.5, 0.5)
	mapTrs.anchorMax = Vector2(0.5, 0.5)
	mapTrs.pivot = Vector2(0.5, 0.5)

	recthelper.setSize(mapTrs, self._gameModel:getMapWidth(), self._gameModel:getMapHeight())
	self:_calcMinMapScale()
	self:_setupMapBg()
end

function EvelynGameView:_setupMapBg()
	if not self.goMapBg then
		return
	end

	local rootW = self._rootWidth
	local rootH = self._rootHeight

	if not rootW or not rootH or rootW <= 0 or rootH <= 0 then
		return
	end

	local bgTrs = self.goMapBg.transform
	local nativeW = recthelper.getWidth(bgTrs)
	local nativeH = recthelper.getHeight(bgTrs)

	if nativeW and nativeH and nativeW > 0 and nativeH > 0 then
		self._bgNativeWidth = nativeW
		self._bgNativeHeight = nativeH
		self._bgNativeAspect = nativeW / nativeH
	end

	bgTrs.anchorMin = Vector2(0.5, 0.5)
	bgTrs.anchorMax = Vector2(0.5, 0.5)
	bgTrs.pivot = Vector2(0.5, 0.5)
	self._bgInitWidth = nativeW
	self._bgInitHeight = nativeH

	logWarn(string.format("[EvelynGame][SetupBg] native:(%.1f,%.1f) nativeAspect:%.4f screen:(%.1f,%.1f)", nativeW, nativeH, self._bgNativeAspect or 0, rootW, rootH))
end

function EvelynGameView:_calcMinMapScale()
	self._minMapScale = MinMapScale

	local rootGo = gohelper.findChild(self.viewGO, "root")

	if not rootGo or not self._gameModel then
		return
	end

	local rootW = recthelper.getWidth(rootGo.transform)
	local rootH = recthelper.getHeight(rootGo.transform)

	self._rootWidth = rootW
	self._rootHeight = rootH

	local mapW = self._gameModel:getMapWidth()
	local mapH = self._gameModel:getMapHeight()

	if mapW <= 0 or mapH <= 0 or rootW <= 0 or rootH <= 0 then
		return
	end

	local minX, maxX, minY, maxY = self._gameModel:getNodeBounds()
	local boundH = math.max(maxY, mapH * 0.5) - math.min(minY, -mapH * 0.5)

	if boundH <= 0 then
		return
	end

	local minScale = rootH / boundH

	if minScale > MaxMapScale then
		minScale = MaxMapScale
	end

	if minScale > 0 then
		self._minMapScale = minScale
	end
end

function EvelynGameView:_createNodeItems()
	self._nodeItemDict = {}
	self._toolItemDict = {}

	local setting = self.viewContainer:getSetting()

	for _, nodeCo in ipairs(self._gameModel:getNodeList() or {}) do
		local prefabPath = setting.otherRes[nodeCo.type]

		if not prefabPath then
			logError(string.format("EvelynGameView:_createNodeItems error, no prefab, nodeType:%s", tostring(nodeCo.type)))
		else
			local cloneGo = self:getResInst(prefabPath, self._goMap)

			cloneGo.name = "node_" .. nodeCo.id .. "_type_" .. nodeCo.type

			local x, y = self._gameModel:getNodePos(nodeCo.id)

			recthelper.setAnchor(cloneGo.transform, x, y)

			local item = self:_initNodeItemView(cloneGo, nodeCo)

			self._nodeItemDict[nodeCo.id] = item

			if nodeCo.type == EvelynEnum.PointType.Tool then
				self._toolItemDict[nodeCo.id] = item
			end
		end
	end
end

function EvelynGameView:_initNodeItemView(cloneGo, nodeCo)
	local item = self:getUserDataTb_()

	item.go = cloneGo
	item.nodeCo = nodeCo

	local pointType = EvelynEnum.PointType

	if nodeCo.type == pointType.Tool then
		item._goEmpty = gohelper.findChild(cloneGo, "root/empty")
		item._goHas = gohelper.findChild(cloneGo, "root/has")
		item._goCorrect = gohelper.findChild(cloneGo, "root/has/#go_correct")

		gohelper.setActive(gohelper.findChild(cloneGo, "root/empty/#go_dragPlace"), true)

		item._goDragLight = gohelper.findChild(cloneGo, "root/empty/#go_dragPlace/light")
		item._goBtnPlace = gohelper.findChild(cloneGo, "root/empty/#go_btnPlace")
		item._goBtnPlaceLight = gohelper.findChild(cloneGo, "root/empty/#go_btnPlace/light")

		gohelper.setActive(item._goBtnPlace, false)

		item._txtName = gohelper.findChildText(cloneGo, "root/has/#txt_tools")

		self:_setNodeIcon(gohelper.findChildImage(cloneGo, "root/has/#txt_tools/#image_icon"), nodeCo)

		item._goLinkpointL = gohelper.findChild(cloneGo, "root/has/#go_linkpointL")
		item._goLinkpointR = gohelper.findChild(cloneGo, "root/has/#go_linkpointR")
		item._goUsing = gohelper.findChild(cloneGo, "root/has/#go_using")
		item._imageUsing = gohelper.findChildImage(cloneGo, "root/has/#go_using/#image_progress")
		item._goPoint = gohelper.findChild(cloneGo, "root/has/#go_point")
		item._pointItem = gohelper.findChild(cloneGo, "root/has/#go_point/go_item")
		item._pointItemList = self:getUserDataTb_()

		self:_initToolPointItems(item, nodeCo.id)

		item._goLinkIconL = self:_enableLinkIconRaycast(cloneGo, "root/has/#go_linkpointL/icon")
		item._goLinkIconR = self:_enableLinkIconRaycast(cloneGo, "root/has/#go_linkpointR/icon")

		self:_addLinkDragListeners(item, nodeCo.id)

		local btnClick = gohelper.findChildButtonWithAudio(cloneGo, "root/btn_Click")

		self:addClickCb(btnClick, self._onToolNodeClick, self, nodeCo.id)

		item._goHighLight = gohelper.findChild(cloneGo, "root/has/#go_linkLight")

		gohelper.setActive(item._goHighLight, false)

		item._goSelect = gohelper.findChild(cloneGo, "root/#go_Select")
		item._goRoot = gohelper.findChild(cloneGo, "root")
	elseif nodeCo.type == pointType.Origin then
		item._txtName = gohelper.findChildText(cloneGo, "root/#go_Normal/#txt_name")
		item._goHighLight = gohelper.findChild(cloneGo, "root/#go_HighLight")

		gohelper.setActive(item._goHighLight, false)

		item._goSelect = gohelper.findChild(cloneGo, "root/#go_Select")

		gohelper.setActive(item._goSelect, false)

		local btnClick = gohelper.findChildButtonWithAudio(cloneGo, "root/btn_Click")

		item._goLinkIconR = gohelper.findChild(cloneGo, "root/#go_Normal/#go_linkLiftRight")
		item._goLinkBtn = gohelper.findChild(cloneGo, "root/btn_Click")

		self:_addLinkDragListeners(item, nodeCo.id)
		self:_setNodeIcon(gohelper.findChildImage(cloneGo, "root/#go_Normal/#image_icon"), nodeCo)
		self:addClickCb(btnClick, self._onNodeClick, self, nodeCo.id)
	elseif nodeCo.type == pointType.Res then
		item._txtName = gohelper.findChildText(cloneGo, "root/#go_Normal/#txt_ending")
		item._goHighLight = gohelper.findChild(cloneGo, "root/#go_HighLight")

		gohelper.setActive(item._goHighLight, false)

		local btnClick = gohelper.findChildButtonWithAudio(cloneGo, "root/btn_Click")

		self:addClickCb(btnClick, self._onNodeClick, self, nodeCo.id)

		item._goLinkIconL = gohelper.findChild(cloneGo, "root/#go_Normal/#go_linkLeft/icon")
		item._goLinkIconR = gohelper.findChild(cloneGo, "root/#go_Normal/#go_linkRight/icon")
		item._goLinkpointL = gohelper.findChild(cloneGo, "root/#go_Normal/#go_linkLeft")
		item._goLinkpointR = gohelper.findChild(cloneGo, "root/#go_Normal/#go_linkRight")

		gohelper.setActive(item._goLinkpointL, false)
		gohelper.setActive(item._goLinkpointR, false)

		item._goLinkBtn = gohelper.findChild(cloneGo, "root/btn_Click")

		self:_addLinkDragListeners(item, nodeCo.id)

		item._goSelect = gohelper.findChild(cloneGo, "root/#go_Select")
	elseif nodeCo.type == pointType.End then
		item._goHighLight = gohelper.findChild(cloneGo, "root/#go_HighLight")

		gohelper.setActive(item._goHighLight, false)

		item._txtName = gohelper.findChildText(cloneGo, "root/txt_truth")

		local btnClick = gohelper.findChildButtonWithAudio(cloneGo, "root/btn_Click")

		item._goLinkIconL = gohelper.findChild(cloneGo, "root/#go_linkLeft")
		item._goSelect = gohelper.findChild(cloneGo, "root/#go_Select")
		item._finishAnimator = gohelper.findChildAnim(cloneGo, "root/go_finish")

		self:addClickCb(btnClick, self._onNodeClick, self, nodeCo.id)
	end

	if item._txtName then
		item._txtName.text = nodeCo.name
	end

	return item
end

function EvelynGameView:_initToolPointItems(item, toolId)
	if not item._goPoint or not item._pointItem then
		return
	end

	local inputCount = #self._gameModel:getToolInputIds(toolId)

	if inputCount <= 0 then
		return
	end

	gohelper.setActive(item._goPoint, true)

	local pointTrs = item._goPoint.transform
	local step = recthelper.getWidth(pointTrs) / inputCount
	local centerY = recthelper.getHeight(pointTrs) * 0.5

	for i = 1, inputCount do
		local pointGo

		if i == 1 then
			pointGo = item._pointItem
		else
			pointGo = gohelper.cloneInPlace(item._pointItem, "go_item_" .. i)
		end

		recthelper.setAnchor(pointGo.transform, (i - 0.5) * step, centerY)

		local pointItem = self:getUserDataTb_()

		pointItem.go = pointGo
		pointItem._goUnlight = gohelper.findChild(pointGo, "unlight")
		pointItem._goLighted = gohelper.findChild(pointGo, "lighted")
		pointItem._goLighteff = gohelper.findChild(pointGo, "lighteff")
		pointItem._animator = gohelper.findChildAnim(pointGo, "")

		table.insert(item._pointItemList, pointItem)
	end
end

function EvelynGameView:_refreshToolPointItems(item, toolId)
	if not item._pointItemList or #item._pointItemList == 0 then
		return
	end

	local inputIds = self._gameModel:getToolInputIds(toolId)
	local linkedCount = 0

	for _, inputId in ipairs(inputIds) do
		if self._gameModel:isLineLinked(inputId, toolId) then
			linkedCount = linkedCount + 1
		end
	end

	local prevLinkedCount = item._prevLinkedCount or 0

	if prevLinkedCount < linkedCount then
		local newPointIndex = linkedCount
		local pointItem = item._pointItemList[newPointIndex]

		if pointItem and not pointItem._consumed and not pointItem._isPlaying then
			self:_playPointAnim(item, pointItem, newPointIndex)
		end
	end

	item._prevLinkedCount = linkedCount

	local anyPointVisible = false

	for i, pointItem in ipairs(item._pointItemList) do
		local pointShown = not pointItem._consumed

		if pointShown then
			anyPointVisible = true
		end

		gohelper.setActive(pointItem.go, pointShown)

		if not pointItem._consumed and not pointItem._isPlaying then
			gohelper.setActive(pointItem._goUnlight, true)
			gohelper.setActive(pointItem._goLighted, false)
			gohelper.setActive(pointItem._goLighteff, false)
		end
	end

	if not item._pointContainerHidden then
		gohelper.setActive(item._goPoint, anyPointVisible)
	end
end

function EvelynGameView:_playPointAnim(item, pointItem, pointIndex)
	pointItem._isPlaying = true
	pointItem._ownerItem = item
	pointItem._pointIndex = pointIndex
	pointItem._gameView = self

	if pointItem._animator then
		pointItem._animator:Play(EvelynEnum.AnimatorName.Done, 0, 0)
	end

	TaskDispatcher.cancelTask(EvelynGameView._onPointItemHideDoneForPoint, pointItem)
	TaskDispatcher.runDelay(EvelynGameView._onPointItemHideDoneForPoint, pointItem, EvelynEnum.AnimTime.PointDone)

	pointItem._pendingHide = true
end

function EvelynGameView._onPointItemHideDoneForPoint(pointItem)
	local gameView = pointItem._gameView

	if not gameView or not gameView._nodeItemDict then
		return
	end

	gameView:_onPointItemHideDone(pointItem, pointItem._ownerItem, pointItem._pointIndex)
end

function EvelynGameView:_onPointItemHideDone(pointItem, item, pointIndex)
	if not pointItem or gohelper.isNil(pointItem.go) then
		return
	end

	pointItem._hideTask = nil
	pointItem._pendingHide = false
	pointItem._isPlaying = false
	pointItem._consumed = true

	gohelper.setActive(pointItem.go, false)
end

function EvelynGameView:_schedulePointContainerHide(toolIds)
	for _, toolId in ipairs(toolIds or {}) do
		local toolItem = self._toolItemDict and self._toolItemDict[toolId]

		if toolItem and not gohelper.isNil(toolItem._goPoint) then
			if toolItem._pointHideTask then
				TaskDispatcher.cancelTask(toolItem._pointHideTask)
			end

			toolItem._pointContainerHidden = false
			toolItem._pointHideTask = TaskDispatcher.runDelay(function()
				self:_onToolPointContainerHideDone(toolItem)
			end, self, EvelynEnum.AnimTime.PointDone)
		end
	end
end

function EvelynGameView:_snapshotToolExpanded()
	local snap = {}

	for toolId in pairs(self._toolItemDict or {}) do
		snap[toolId] = self._gameModel:isToolExpanded(toolId)
	end

	return snap
end

function EvelynGameView:_diffNewlyExpandedToolIds(snap)
	local toolIds = {}

	for toolId in pairs(self._toolItemDict or {}) do
		if self._gameModel:isToolExpanded(toolId) and not snap[toolId] then
			table.insert(toolIds, toolId)
		end
	end

	return toolIds
end

function EvelynGameView:_clearAllPointAnims()
	for _, item in pairs(self._nodeItemDict or {}) do
		if item._pointHideTask then
			TaskDispatcher.cancelTask(item._pointHideTask)

			item._pointHideTask = nil
		end

		for _, pointItem in ipairs(item._pointItemList or {}) do
			TaskDispatcher.cancelTask(EvelynGameView._onPointItemHideDoneForPoint, pointItem)

			pointItem._gameView = nil
			pointItem._pendingHide = false
			pointItem._isPlaying = false
		end
	end
end

function EvelynGameView:_addLinkDragListeners(item, nodeId)
	for _, dragGo in pairs({
		item._goLinkIconL,
		item._goLinkIconR,
		item._goLinkBtn
	}) do
		local dragHandler = SLFramework.UGUI.UIDragListener.Get(dragGo)

		dragHandler:AddDragBeginListener(self._onLinkDragBegin, self, nodeId)
		dragHandler:AddDragListener(self._onLinkDrag, self)
		dragHandler:AddDragEndListener(self._onLinkDragEnd, self)
	end
end

function EvelynGameView:_enableLinkIconRaycast(cloneGo, iconPath)
	local iconImage = gohelper.findChildImage(cloneGo, iconPath)

	if not iconImage then
		return nil
	end

	iconImage.raycastTarget = true

	return iconImage.gameObject
end

function EvelynGameView:_setNodeIcon(imageIcon, nodeCo)
	if imageIcon then
		local showImage = not string.nilorempty(nodeCo.icon)

		gohelper.setActive(imageIcon, showImage)

		if showImage then
			UISpriteSetMgr.instance:setV4a1YifulinSprite(imageIcon, nodeCo.icon)
		end
	end
end

function EvelynGameView:_createLineItems()
	self._lineItemDict = {}

	local setting = self.viewContainer:getSetting()

	for _, lineCo in pairs(self._gameModel:getLineDict() or {}) do
		local lineKey = self._gameModel:getLineKey(lineCo.from, lineCo.to)
		local cloneGo = self:getResInst(setting.otherRes[5], self._goMap)

		cloneGo.name = "line_" .. lineKey

		local item = self:getUserDataTb_()

		item.go = cloneGo
		item.lineCo = lineCo
		item.evelynLineItem = MonoHelper.addNoUpdateLuaComOnceToGo(cloneGo, EvelynLineItem)

		self:_refreshLineTransform(item)

		self._lineItemDict[lineKey] = item
	end
end

function EvelynGameView:_refreshLineTransform(lineItem)
	local lineCo = lineItem.lineCo
	local ax, ay = self:_getLineEndpoint(lineCo.from, true)
	local bx, by = self:_getLineEndpoint(lineCo.to, false)
	local angleDeg = self:_calcLineAngle(ax, ay, bx, by)

	if lineItem.evelynLineItem then
		lineItem.evelynLineItem:refresh(ax, ay, bx, by, angleDeg, self._goMap.transform)
	end
end

function EvelynGameView:_calcLineAngle(ax, ay, bx, by)
	local dx = math.abs(bx - ax)
	local baseDistance = EvelynEnum.BaseAngleDistance
	local maxAngle = EvelynEnum.CurveAngle.Up
	local angleDeg

	if dx <= baseDistance then
		angleDeg = maxAngle
	else
		angleDeg = baseDistance / dx * maxAngle
	end

	if by < ay then
		angleDeg = -angleDeg
	end

	return angleDeg
end

function EvelynGameView:_refreshAllLineTransforms()
	for _, lineItem in pairs(self._lineItemDict or {}) do
		self:_refreshLineTransform(lineItem)
	end
end

function EvelynGameView:_onScreenResize()
	if self._lineItemDict then
		self:_refreshAllLineTransforms()
	end
end

function EvelynGameView:_getLineEndpoint(nodeId, isFrom)
	local item = self._nodeItemDict and self._nodeItemDict[nodeId]

	if not item then
		return self._gameModel:getNodePos(nodeId)
	end

	local pointType = EvelynEnum.PointType
	local iconGo

	if item.nodeCo.type == pointType.Tool then
		iconGo = isFrom and item._goLinkIconR or item._goLinkIconL
	elseif item.nodeCo.type == pointType.Origin then
		iconGo = item._goLinkIconR
	elseif item.nodeCo.type == pointType.Res then
		iconGo = isFrom and item._goLinkIconR or item._goLinkIconL
	elseif item.nodeCo.type == pointType.End then
		iconGo = item._goLinkIconL
	end

	if iconGo and not gohelper.isNil(iconGo) then
		local pos = recthelper.rectToRelativeAnchorPos(iconGo.transform.position, self._goMap.transform)

		return pos.x, pos.y
	end

	local x, y = self._gameModel:getNodePos(nodeId)
	local halfW = self:_getRootHalfSize(item.go)

	if isFrom then
		return x + halfW, y
	end

	return x - halfW, y
end

function EvelynGameView:_initToolsBar()
	self._toolBarItems = {}
	self._dragItemDic = {}

	local setting = self.viewContainer:getSetting()
	local contentGo = gohelper.findChild(self.viewGO, "root/Tools/#scroll_Tools/viewport/Content")

	if not contentGo then
		return
	end

	local toolIds = {}

	for toolId in pairs(self._toolItemDict or {}) do
		table.insert(toolIds, toolId)
	end

	table.sort(toolIds)

	for _, toolId in ipairs(toolIds) do
		local toolItem = self._toolItemDict[toolId]
		local cloneGo = self:getResInst(setting.otherRes[EvelynEnum.PointType.Tool], contentGo)

		cloneGo.name = "toolbar_" .. toolId

		gohelper.setActive(gohelper.findChild(cloneGo, "root/empty"), false)
		gohelper.setActive(gohelper.findChild(cloneGo, "root/has"), true)

		local txtName = gohelper.findChildText(cloneGo, "root/has/#txt_tools")

		if txtName then
			txtName.text = toolItem.nodeCo.name
		end

		self:_setNodeIcon(gohelper.findChildImage(cloneGo, "root/has/#txt_tools/#image_icon"), toolItem.nodeCo)
		gohelper.setActive(gohelper.findChild(cloneGo, "root/has/#go_linkLight"), false)
		gohelper.setActive(gohelper.findChild(cloneGo, "root/has/#go_point"), false)

		local barItem = self:getUserDataTb_()

		barItem.go = cloneGo
		barItem.toolId = toolId
		barItem.subType = toolItem.nodeCo.subType
		barItem.isToolUse = toolItem.nodeCo.isToolUse == 1
		barItem._goPlacing = gohelper.findChild(cloneGo, "root/has/#go_placed")
		barItem._goPlaced = gohelper.findChild(cloneGo, "root/has/#go_placed/icon")
		barItem._goNew = gohelper.findChild(cloneGo, "root/has/#go_new")
		barItem._animNew = gohelper.findChildAnim(cloneGo, "root/has/#go_new")

		local btnClick = gohelper.findChildButtonWithAudio(cloneGo, "root/btn_Click")

		self:addClickCb(btnClick, self._onToolBarItemClick, self, toolId)

		local dragHandler = SLFramework.UGUI.UIDragListener.Get(cloneGo)

		dragHandler:AddDragBeginListener(self._onToolBarDragBegin, self, toolId)
		dragHandler:AddDragListener(self._onToolBarDrag, self)
		dragHandler:AddDragEndListener(self._onToolBarDragEnd, self)
		table.insert(self._toolBarItems, barItem)
	end
end

function EvelynGameView:_refreshToolsBar()
	if not self._gameModel then
		return
	end

	local prevVisibleCount = self._toolsBarVisibleCount
	local unplacedItems = {}
	local placedItems = {}

	for _, barItem in ipairs(self._toolBarItems or {}) do
		local placed = self._gameModel:isToolPlaced(barItem.toolId)

		if placed then
			table.insert(placedItems, barItem)
		else
			table.insert(unplacedItems, barItem)
		end
	end

	local siblingIndex = 0

	for _, barItem in ipairs(unplacedItems) do
		barItem.go.transform:SetSiblingIndex(siblingIndex)

		siblingIndex = siblingIndex + 1
	end

	for _, barItem in ipairs(placedItems) do
		barItem.go.transform:SetSiblingIndex(siblingIndex)

		siblingIndex = siblingIndex + 1
	end

	local visibleCount = 0

	for _, barItem in ipairs(self._toolBarItems or {}) do
		local visible = not barItem.isToolUse and self._gameModel:isToolShown(barItem.toolId)

		gohelper.setActive(barItem.go, visible)

		local placed = self._gameModel:isToolPlaced(barItem.toolId)

		gohelper.setActive(barItem._goPlacing, placed)
		gohelper.setActive(barItem._goPlaced, placed)

		if visible and not barItem._wasVisible then
			if barItem._goNew then
				gohelper.setActive(barItem._goNew, true)
			end

			if barItem._animNew then
				barItem._animNew:Play(EvelynEnum.AnimatorName.Open, 0, 0)
			end
		end

		barItem._wasVisible = visible

		if visible then
			visibleCount = visibleCount + 1
		end
	end

	self._toolsBarVisibleCount = visibleCount

	self:_refreshToolsBarScroll()

	if not self._toolsBarShown and self._toolsBarVisibleCount and prevVisibleCount and prevVisibleCount < self._toolsBarVisibleCount then
		self:_setToolsBarShown(true)
	end
end

function EvelynGameView:_refreshToolsBarScroll()
	if not self._scrollTools or gohelper.isNil(self._scrollTools.gameObject) then
		return
	end

	if not self._toolsScrollRect then
		local _, scrollRect = self._scrollTools.gameObject:TryGetComponent(gohelper.Type_ScrollRect, nil)

		self._toolsScrollRect = scrollRect
	end

	if not self._toolsScrollRect then
		return
	end

	self._toolsScrollRect.horizontal = (self._toolsBarVisibleCount or #self._toolBarItems) > ToolsBarScrollMaxCount
	self._toolsScrollRect.vertical = false
end

function EvelynGameView:_getDragItem(toolId)
	local dragItem = self._dragItemDic and self._dragItemDic[toolId]

	if dragItem then
		return dragItem
	end

	local toolItem = self._toolItemDict and self._toolItemDict[toolId]

	if not toolItem then
		return nil
	end

	local setting = self.viewContainer:getSetting()
	local cloneGo = self:getResInst(setting.otherRes[EvelynEnum.PointType.Tool], self._goPlaceRoot.gameObject)

	cloneGo.name = "drag_" .. toolId

	gohelper.setActive(gohelper.findChild(cloneGo, "root/empty"), false)
	gohelper.setActive(gohelper.findChild(cloneGo, "root/has"), true)

	local txtName = gohelper.findChildText(cloneGo, "root/has/#txt_tools")

	if txtName then
		txtName.text = toolItem.nodeCo.name
	end

	self:_setNodeIcon(gohelper.findChildImage(cloneGo, "root/has/#txt_tools/#image_icon"), toolItem.nodeCo)
	gohelper.setActive(gohelper.findChild(cloneGo, "root/has/#go_linkLight"), false)

	local goPoint = gohelper.findChild(cloneGo, "root/has/#go_point")

	if goPoint then
		gohelper.setActive(goPoint, false)
	end

	dragItem = self:getUserDataTb_()
	dragItem.go = cloneGo
	dragItem.toolId = toolId
	dragItem._goCorrect = gohelper.findChild(cloneGo, "root/has/#go_correct")
	dragItem._goWrong = gohelper.findChild(cloneGo, "root/has/#go_wrong")

	gohelper.setActive(cloneGo, false)

	self._dragItemDic[toolId] = dragItem

	return dragItem
end

function EvelynGameView:_onToolBarDragBegin(toolId, pointerEventData)
	if self._gameClearFinishing then
		return
	end

	if not self._toolsBarShown then
		return
	end

	if self._gameModel and self._gameModel:isToolPlaced(toolId) then
		return
	end

	self:_cancelPlaceMode()
	self:_clearDragFeedback(true)

	local dragItem = self:_getDragItem(toolId)

	if not dragItem then
		return
	end

	self._curDragToolId = toolId

	AudioMgr.instance:trigger(AudioEnum4_1.Evelyn.play_ui_atlantis_tool_out)

	local barItem = self:_findToolBarItem(toolId)

	if barItem then
		gohelper.setActive(barItem._goPlacing, true)
		gohelper.setActive(barItem._goPlaced, false)
	end

	self:_setDragLightAllVisible(true)
	self:_buildDragSession(dragItem)
	ZProj.TweenHelper.KillByObj(dragItem.go.transform)

	dragItem.go.transform.localScale = Vector3(1, 1, 1)

	gohelper.setAsLastSibling(dragItem.go)
	self:_moveDragItemToPointer(dragItem, pointerEventData)
	gohelper.setActive(dragItem.go, true)

	local toolItem = self._toolItemDict and self._toolItemDict[toolId]
	local nodeCo = toolItem and toolItem.nodeCo

	if self._goTips then
		gohelper.setActive(self._goTips, true)
	end

	if self._txtTips and nodeCo and not string.nilorempty(nodeCo.desc) then
		self._txtTips.text = nodeCo.desc
	end
end

function EvelynGameView:_onToolBarDrag(param, pointerEventData)
	local toolId = self._curDragToolId
	local dragItem = toolId and self._dragItemDic and self._dragItemDic[toolId]

	if not dragItem then
		return
	end

	self:_moveDragItemToPointer(dragItem, pointerEventData)
end

function EvelynGameView:_onToolBarDragEnd(param, pointerEventData)
	local toolId = self._curDragToolId

	self._curDragToolId = nil

	self:_setDragLightAllVisible(false)

	if self._goTips then
		gohelper.setActive(self._goTips, false)
	end

	local dragItem = toolId and self._dragItemDic and self._dragItemDic[toolId]

	if not dragItem then
		self._dragSession = nil

		return
	end

	self:_moveDragItemToPointer(dragItem, pointerEventData)

	local overSlot = self:_getDragOverSlot(dragItem)

	self._dragSession = nil

	if overSlot and overSlot.toolId == toolId then
		self:_beginDragFeedback(dragItem, true, overSlot)

		return
	end

	if not self._gameModel or self._gameModel:isToolPlaced(toolId) then
		self:_flyBackDragItem(dragItem, toolId)

		return
	end

	if overSlot then
		self:_beginDragFeedback(dragItem, false, overSlot)

		return
	end

	AudioMgr.instance:trigger(AudioEnum4_1.Evelyn.play_ui_atlantis_tool_back)

	local noHitBarItem = self:_findToolBarItem(toolId)

	if noHitBarItem then
		gohelper.setActive(noHitBarItem._goPlacing, false)
		gohelper.setActive(noHitBarItem._goPlaced, false)
	end

	self:_flyBackDragItem(dragItem, toolId)
end

function EvelynGameView:_beginDragFeedback(dragItem, correct, overSlot)
	self:_clearDragFeedback(true)

	local animTime = correct and EvelynEnum.AnimTime.ToolDragSuccess or EvelynEnum.AnimTime.ToolDragFail

	if correct then
		gohelper.setActive(dragItem._goCorrect, true)
		AudioMgr.instance:trigger(AudioEnum4_1.Evelyn.play_ui_atlantis_tool_down)
	else
		gohelper.setActive(dragItem._goWrong, true)
		AudioMgr.instance:trigger(AudioEnum4_1.Evelyn.play_ui_atlantis_connect_no)
	end

	self._dragFeedbackItem = dragItem
	self._dragFeedbackCorrect = correct

	local scaleX, scaleY = self:_getDragItemMapScale(dragItem)

	ZProj.TweenHelper.DOScale(dragItem.go.transform, scaleX, scaleY, 1, animTime)

	if overSlot then
		ZProj.TweenHelper.DOAnchorPos(dragItem.go.transform, overSlot.centerX, overSlot.centerY, animTime)
	end

	TaskDispatcher.runDelay(self._onDragFeedbackDone, self, animTime)
end

function EvelynGameView:_onDragFeedbackDone()
	local dragItem = self._dragFeedbackItem
	local correct = self._dragFeedbackCorrect

	self._dragFeedbackItem = nil
	self._dragFeedbackCorrect = nil

	if not dragItem or gohelper.isNil(dragItem.go) then
		return
	end

	gohelper.setActive(dragItem._goCorrect, false)
	gohelper.setActive(dragItem._goWrong, false)

	if correct then
		gohelper.setActive(dragItem.go, false)
		self:_placeTool(dragItem.toolId)

		local barItem = self:_findToolBarItem(dragItem.toolId)

		if barItem then
			gohelper.setActive(barItem._goPlacing, true)
			gohelper.setActive(barItem._goPlaced, true)
		end

		return
	end

	local failBarItem = self:_findToolBarItem(dragItem.toolId)

	if failBarItem then
		gohelper.setActive(failBarItem._goPlacing, false)
		gohelper.setActive(failBarItem._goPlaced, false)
	end

	self:_flyBackDragItem(dragItem, dragItem.toolId)
end

function EvelynGameView:_clearDragFeedback(hideMirror)
	TaskDispatcher.cancelTask(self._onDragFeedbackDone, self)

	local dragItem = self._dragFeedbackItem

	self._dragFeedbackItem = nil
	self._dragFeedbackCorrect = nil

	if not dragItem or gohelper.isNil(dragItem.go) then
		return
	end

	gohelper.setActive(dragItem._goCorrect, false)
	gohelper.setActive(dragItem._goWrong, false)

	if hideMirror then
		gohelper.setActive(dragItem.go, false)
	end
end

function EvelynGameView:_flyBackDragItem(dragItem, toolId)
	local barGo = self:_findToolBarGo(toolId)

	if not barGo then
		gohelper.setActive(dragItem.go, false)

		return
	end

	local homePos = recthelper.rectToRelativeAnchorPos(barGo.transform.position, dragItem.go.transform.parent)

	ZProj.TweenHelper.KillByObj(dragItem.go.transform)
	ZProj.TweenHelper.DOAnchorPos(dragItem.go.transform, homePos.x, homePos.y, DragFlyBackDuration, self._onDragFlyBackDone, self, dragItem)
	ZProj.TweenHelper.DOScale(dragItem.go.transform, 1, 1, 1, DragFlyBackDuration)
end

function EvelynGameView:_buildDragSession(dragItem)
	local session = {}

	session.halfW, session.halfH = self:_getRootHalfSize(dragItem.go)

	local scale = self._mapScale or MaxMapScale
	local mapX, mapY = recthelper.getAnchor(self._goMap.transform)

	session.slots = {}

	for toolId, item in pairs(self._toolItemDict or {}) do
		if not self._gameModel:isToolPlaced(toolId) and self._gameModel:isToolShown(toolId) then
			local nodeX, nodeY = self._gameModel:getNodePos(toolId)
			local halfW, halfH = self:_getRootHalfSize(item.go)

			table.insert(session.slots, {
				toolId = toolId,
				centerX = mapX + nodeX * scale,
				centerY = mapY + nodeY * scale,
				halfW = halfW * scale,
				halfH = halfH * scale
			})
		end
	end

	self._dragSession = session
end

function EvelynGameView:_getRootHalfSize(go)
	local rootGo = gohelper.findChild(go, "root")

	if not rootGo then
		return recthelper.getWidth(go.transform) * 0.5, recthelper.getHeight(go.transform) * 0.5
	end

	return recthelper.getWidth(rootGo.transform) * 0.5, recthelper.getHeight(rootGo.transform) * 0.5
end

function EvelynGameView:_getDragItemMapScale(dragItem)
	local scale = self._mapScale or MaxMapScale
	local toolItem = self._toolItemDict and self._toolItemDict[dragItem.toolId]

	if not toolItem or gohelper.isNil(toolItem.go) then
		return scale, scale
	end

	local mirrorHalfW, mirrorHalfH = self:_getRootHalfSize(dragItem.go)
	local nodeHalfW, nodeHalfH = self:_getRootHalfSize(toolItem.go)

	if mirrorHalfW <= 0 or mirrorHalfH <= 0 then
		return scale, scale
	end

	return nodeHalfW * scale / mirrorHalfW, nodeHalfH * scale / mirrorHalfH
end

function EvelynGameView:_getDragOverSlot(dragItem)
	local session = self._dragSession

	if not session then
		return nil
	end

	local centerX, centerY = recthelper.getAnchor(dragItem.go.transform)
	local otherSlot

	for _, slot in ipairs(session.slots) do
		if math.abs(centerX - slot.centerX) < session.halfW + slot.halfW and math.abs(centerY - slot.centerY) < session.halfH + slot.halfH then
			if slot.toolId == dragItem.toolId then
				return slot
			end

			otherSlot = otherSlot or slot
		end
	end

	return otherSlot
end

function EvelynGameView:_moveDragItemToPointer(dragItem, pointerEventData)
	local anchorPos = recthelper.screenPosToAnchorPos(pointerEventData.position, dragItem.go.transform.parent)

	recthelper.setAnchor(dragItem.go.transform, anchorPos.x, anchorPos.y)
end

function EvelynGameView:_onDragFlyBackDone(dragItem)
	if not dragItem or gohelper.isNil(dragItem.go) then
		return
	end

	gohelper.setActive(dragItem.go, false)
end

function EvelynGameView:_findToolBarGo(toolId)
	for _, barItem in ipairs(self._toolBarItems or {}) do
		if barItem.toolId == toolId then
			return barItem.go
		end
	end

	return nil
end

function EvelynGameView:_findToolBarItem(toolId)
	for _, barItem in ipairs(self._toolBarItems or {}) do
		if barItem.toolId == toolId then
			return barItem
		end
	end

	return nil
end

function EvelynGameView:_setDragLightAllVisible(visible)
	if not self._gameModel then
		return
	end

	for _, item in pairs(self._toolItemDict or {}) do
		if item._goDragLight then
			local show = visible and not self._gameModel:isToolPlaced(item.nodeCo.id) and self._gameModel:isToolShown(item.nodeCo.id)

			gohelper.setActive(item._goDragLight, show)
		end
	end
end

function EvelynGameView:_getLinkPreviewLineItem(index)
	self._linkPreviewLineItems = self._linkPreviewLineItems or {}

	local lineItem = self._linkPreviewLineItems[index + 1]

	if lineItem and not gohelper.isNil(lineItem.go) then
		return lineItem
	end

	local setting = self.viewContainer:getSetting()
	local dragRootGo = self._goMapRoot.transform.parent.gameObject
	local cloneGo = self:getResInst(setting.otherRes[5], dragRootGo)

	cloneGo.name = "link_preview_line_" .. index + 1
	lineItem = MonoHelper.addNoUpdateLuaComOnceToGo(cloneGo, EvelynLineItem)

	gohelper.setActive(cloneGo, false)

	self._linkPreviewLineItems[index + 1] = lineItem
	self._linkPreviewPoolSize = math.max(self._linkPreviewPoolSize or 0, index + 1)

	return lineItem
end

function EvelynGameView:_buildLinkPreviewLines(toolId)
	self._linkPreviewFromIds = nil

	if not self._gameModel or not self._goMapRoot then
		return
	end

	local index = 0

	for _, inputId in ipairs(self._gameModel:getToolInputIds(toolId) or {}) do
		if self._gameModel:isNodeShown(inputId) and not self._gameModel:isLineLinked(inputId, toolId) then
			local lineItem = self:_getLinkPreviewLineItem(index)

			if lineItem then
				gohelper.setAsLastSibling(lineItem.go)

				self._linkPreviewFromIds = self._linkPreviewFromIds or {}
				self._linkPreviewFromIds[index] = inputId
				index = index + 1
			end
		end
	end

	for i = index, (self._linkPreviewPoolSize or 0) - 1 do
		local lineItem = self._linkPreviewLineItems and self._linkPreviewLineItems[i + 1]

		if lineItem and not gohelper.isNil(lineItem.go) then
			gohelper.setActive(lineItem.go, false)
		end
	end
end

function EvelynGameView:_updateLinkPreviewLines()
	local toolId = self._curDragToolId

	if not toolId or not self._linkPreviewFromIds then
		return
	end

	local dragItem = self._dragItemDic and self._dragItemDic[toolId]

	if not dragItem or gohelper.isNil(dragItem.go) then
		return
	end

	local parentTrs = self._goMapRoot.transform.parent

	if not parentTrs then
		return
	end

	local toX, toY = recthelper.getAnchor(dragItem.go.transform)

	for index, fromId in pairs(self._linkPreviewFromIds) do
		local lineItem = self._linkPreviewLineItems and self._linkPreviewLineItems[index + 1]

		if lineItem and not gohelper.isNil(lineItem.go) then
			local fromX, fromY = self:_getLinkPreviewFromPos(fromId, parentTrs)

			if fromX then
				gohelper.setActive(lineItem.go, true)
				lineItem:refresh(fromX, fromY, toX, toY, self:_calcLineAngle(fromX, fromY, toX, toY), parentTrs)
			else
				gohelper.setActive(lineItem.go, false)
			end
		end
	end
end

function EvelynGameView:_getLinkPreviewFromPos(nodeId, parentTrs)
	local item = self._nodeItemDict and self._nodeItemDict[nodeId]

	if not item then
		return nil, nil
	end

	local iconGo = item._goLinkIconR

	if iconGo and not gohelper.isNil(iconGo) then
		local pos = recthelper.rectToRelativeAnchorPos(iconGo.transform.position, parentTrs)

		return pos.x, pos.y
	end

	local x, y = self._gameModel:getNodePos(nodeId)
	local halfW = self:_getRootHalfSize(item.go)
	local scale = self._mapScale or MaxMapScale
	local mapX, mapY = recthelper.getAnchor(self._goMap.transform)

	return mapX + (x + halfW) * scale, mapY + y * scale
end

function EvelynGameView:_hideLinkPreviewLines()
	self._linkPreviewFromIds = nil

	for _, lineItem in ipairs(self._linkPreviewLineItems or {}) do
		if not gohelper.isNil(lineItem.go) then
			gohelper.setActive(lineItem.go, false)
		end
	end
end

function EvelynGameView:_onToolNodeClick(toolId)
	if not self._gameModel then
		return
	end

	if self._placeModeToolId == toolId then
		self:_onPlaceBtnClick()

		return
	end

	if self._placeModeToolId then
		self:_cancelPlaceMode()
	end

	if not self._gameModel:isToolPlaced(toolId) then
		return
	end

	local item = self._nodeItemDict and self._nodeItemDict[toolId]
	local nodeCo = item and item.nodeCo

	if nodeCo and self._goDetail then
		if self._txtDetail and not string.nilorempty(nodeCo.desc) then
			self._txtDetail.text = nodeCo.desc
		end

		gohelper.setActive(self._goDetail, true)

		self._curDetailItem = item

		gohelper.setActive(self._btnCloseTip, true)
		self:_positionDetailPanel(item)
	end
end

function EvelynGameView:_openToolPanelView(toolId)
	EvelynController.instance:openPanelView({
		toolId = toolId,
		episodeId = self.viewParam and self.viewParam.episodeId,
		gameId = self.viewParam and self.viewParam.gameId,
		gameModel = self._gameModel,
		gameView = self
	})
end

function EvelynGameView:_onToolBarItemClick(toolId)
	self:_openToolPanelView(toolId)
end

function EvelynGameView:_onNodeClick(nodeId)
	local item = self._nodeItemDict and self._nodeItemDict[nodeId]

	if not item then
		return
	end

	local nodeCo = item.nodeCo

	if not nodeCo or nodeCo.type ~= EvelynEnum.PointType.Origin then
		return
	end

	if not self._goDetail then
		return
	end

	if self._txtDetail and not string.nilorempty(nodeCo.desc) then
		self._txtDetail.text = nodeCo.desc
	end

	gohelper.setActive(self._goDetail, true)

	self._curDetailItem = item

	gohelper.setActive(self._btnCloseTip, true)
	self:_positionDetailPanel(item)
end

function EvelynGameView:_positionDetailPanel(item)
	if not item or not item.go or not self._goDetail then
		return
	end

	local rootGo = gohelper.findChild(self.viewGO, "root")
	local goScroll = gohelper.findChild(self._goDetail, "go_scroll")

	if not rootGo or not goScroll then
		return
	end

	local rootTrs = rootGo.transform
	local scrollTrs = goScroll.transform
	local rootW = self._rootWidth
	local rootH = self._rootHeight

	if not rootW or not rootH or rootW <= 0 or rootH <= 0 then
		return
	end

	local localPos = rootTrs:InverseTransformPoint(item.go.transform.position)
	local scrollCorners = scrollTrs:GetWorldCorners()
	local scrollBottom = rootTrs:InverseTransformPoint(scrollCorners[0])
	local scrollTop = rootTrs:InverseTransformPoint(scrollCorners[2])
	local panelHalfW = math.abs(scrollTop.x - scrollBottom.x) * 0.5
	local panelHalfH = math.abs(scrollTop.y - scrollBottom.y) * 0.5
	local goContent = gohelper.findChild(goScroll, "viewport/content")
	local contentOffsetInScroll = 0
	local contentH = panelHalfH * 2

	if goContent then
		ZProj.UGUIHelper.RebuildLayout(goContent.transform)

		local contentCorners = goContent.transform:GetWorldCorners()
		local contentBottomY = rootTrs:InverseTransformPoint(contentCorners[0]).y
		local contentTopY = rootTrs:InverseTransformPoint(contentCorners[2]).y

		contentH = math.abs(contentTopY - contentBottomY)
		contentOffsetInScroll = (contentTopY + contentBottomY) * 0.5 - (scrollTop.y + scrollBottom.y) * 0.5
	end

	local itemHalfH = 0
	local nodeRootGo = gohelper.findChild(item.go, "root")

	if nodeRootGo then
		local nodeCorners = nodeRootGo.transform:GetWorldCorners()

		itemHalfH = math.abs(rootTrs:InverseTransformPoint(nodeCorners[2]).y - rootTrs:InverseTransformPoint(nodeCorners[0]).y) * 0.5
	else
		local _, halfH = self:_getRootHalfSize(item.go)

		itemHalfH = (halfH or 0) * (self._mapScale or MaxMapScale)
	end

	local gap = EvelynEnum.DetailOffset.Y
	local detailY

	if localPos.y <= 0 then
		detailY = localPos.y + itemHalfH + gap - math.max(contentOffsetInScroll - contentH * 0.5, -panelHalfH)
	else
		detailY = localPos.y - itemHalfH - gap - math.min(contentOffsetInScroll + contentH * 0.5, panelHalfH)
	end

	local minY = -rootH * 0.5 + panelHalfH
	local maxY = rootH * 0.5 - panelHalfH

	if minY < maxY and (detailY < minY or maxY < detailY) then
		if localPos.y <= 0 then
			detailY = localPos.y - itemHalfH - gap - math.min(contentOffsetInScroll + contentH * 0.5, panelHalfH)
		else
			detailY = localPos.y + itemHalfH + gap - math.max(contentOffsetInScroll - contentH * 0.5, -panelHalfH)
		end

		detailY = math.max(minY, math.min(maxY, detailY))
	end

	local detailX = localPos.x + EvelynEnum.DetailOffset.X
	local minX = -rootW * 0.5 + panelHalfW
	local maxX = rootW * 0.5 - panelHalfW

	if minX < maxX then
		detailX = math.max(minX, math.min(maxX, detailX))
	end

	self._goDetail.transform.localPosition = Vector3(detailX, 0, 0)
	scrollTrs.localPosition = Vector3(0, detailY, 0)
end

function EvelynGameView:_onCloseDetailClick()
	if not self._goDetail then
		return
	end

	gohelper.setActive(self._goDetail, false)
	gohelper.setActive(self._btnCloseTip, false)

	self._curDetailItem = nil
end

function EvelynGameView:_placeTool(toolId)
	if not self._gameModel then
		return false
	end

	local wasExpanded = self._gameModel:isToolExpanded(toolId)
	local expandedSnap = self:_snapshotToolExpanded()

	if not self._gameModel:placeTool(toolId) then
		return false
	end

	EvelynController.instance:dispatchEvent(EvelynEvent.GuideToolPlaced)

	if not wasExpanded and self._gameModel:isToolExpanded(toolId) then
		self:_beginToolUsingAnim(toolId)
	else
		self:_refreshMapVisual()
	end

	local selfUsingExpanded = not wasExpanded and self._gameModel:isToolExpanded(toolId)
	local linkedExpandedIds = {}

	for _, expandedId in ipairs(self:_diffNewlyExpandedToolIds(expandedSnap)) do
		if expandedId ~= toolId or not selfUsingExpanded then
			table.insert(linkedExpandedIds, expandedId)
		end
	end

	self:_schedulePointContainerHide(linkedExpandedIds)
	self:_refreshToolsBar()

	return true
end

function EvelynGameView:_setCollapsed()
	self._expandedAll = false
	self._toolsBarShown = true

	self:_refreshMapVisual()
	self:_refreshToolsBar()
end

function EvelynGameView:_expandAll()
	self:_clearToolUsingAnim()

	for toolId in pairs(self._toolItemDict or {}) do
		self._gameModel:placeTool(toolId)
		self._gameModel:expandTool(toolId)
	end

	self._gameModel:propagate()
	self._gameModel:linkAllLines()

	self._expandedAll = true

	self:_refreshMapVisual()
	self:_refreshToolsBar()
end

function EvelynGameView:_refreshMapVisual()
	if not self._gameModel then
		return
	end

	local pointType = EvelynEnum.PointType
	local delayedOutputs = {}
	local usingToolId = self._toolUsingToolId

	if usingToolId then
		for _, outputId in ipairs(self._gameModel:getToolOutputIds(usingToolId)) do
			delayedOutputs[outputId] = true
		end
	end

	local linkableInputNodeIds = {}

	for _, toolItem in pairs(self._toolItemDict or {}) do
		local toolId = toolItem.nodeCo.id

		if self._gameModel:isToolPlaced(toolId) then
			local inputIds = self._gameModel:getToolInputIds(toolId)
			local hasUnlinkedInput = false

			for _, inputId in ipairs(inputIds) do
				if not self._gameModel:isLineLinked(inputId, toolId) then
					hasUnlinkedInput = true

					break
				end
			end

			if hasUnlinkedInput then
				for _, inputId in ipairs(inputIds) do
					if not self._gameModel:isLineLinked(inputId, toolId) then
						linkableInputNodeIds[inputId] = true
					end
				end
			end
		end
	end

	local newResShownCount = 0

	for nodeId, item in pairs(self._nodeItemDict or {}) do
		local nodeType = item.nodeCo.type

		if nodeType == pointType.Origin then
			gohelper.setActive(item.go, true)

			if item._goHighLight then
				gohelper.setActive(item._goHighLight, linkableInputNodeIds[nodeId] == true)
			end

			local hasLinkedOutput = false
			local allOutputsLinked = true
			local hasOutput = false

			for _, lineCo in pairs(self._gameModel:getLineDict() or {}) do
				if lineCo.from == nodeId then
					hasOutput = true

					if self._gameModel:isLineLinked(lineCo.from, lineCo.to) then
						hasLinkedOutput = true
					else
						allOutputsLinked = false
					end
				end
			end

			gohelper.setActive(item._goLinkpointR, hasLinkedOutput)
			gohelper.setActive(item._goSelect, hasOutput and allOutputsLinked)
		elseif nodeType == pointType.Tool then
			if not self._gameModel:isToolShown(nodeId) then
				gohelper.setActive(item.go, false)
			else
				gohelper.setActive(item.go, true)

				local placed = self._gameModel:isToolPlaced(nodeId)

				gohelper.setActive(item._goEmpty, not placed)
				gohelper.setActive(item._goHas, placed)

				if item._goBtnPlace then
					local showPlace = not placed and self._placeModeToolId == nodeId

					gohelper.setActive(item._goBtnPlace, showPlace)
					gohelper.setActive(item._goBtnPlaceLight, showPlace)
				end

				self:_refreshToolPointItems(item, nodeId)

				if placed then
					local hasLinkedInput = false
					local allInputsLinked = true
					local inputIds = self._gameModel:getToolInputIds(nodeId)

					for _, inputId in ipairs(inputIds) do
						if self._gameModel:isLineLinked(inputId, nodeId) then
							hasLinkedInput = true
						else
							allInputsLinked = false
						end
					end

					local hasLinkedOutput = false
					local allOutputsLinked = true
					local outputIds = self._gameModel:getToolOutputIds(nodeId)

					for _, outputId in ipairs(outputIds) do
						if self._gameModel:isLineLinked(nodeId, outputId) then
							hasLinkedOutput = true
						else
							allOutputsLinked = false
						end
					end

					local isUsing = self._toolUsingToolId == nodeId

					gohelper.setActive(item._goLinkpointL, hasLinkedInput)
					gohelper.setActive(item._goLinkpointR, hasLinkedOutput and not isUsing)

					local hasInput = #inputIds > 0
					local hasOutput = #outputIds > 0

					gohelper.setActive(item._goSelect, hasInput and allInputsLinked and hasOutput and allOutputsLinked)
				else
					gohelper.setActive(item._goLinkpointL, false)
					gohelper.setActive(item._goLinkpointR, false)
					gohelper.setActive(item._goSelect, false)
				end
			end
		else
			local shown = self._gameModel:isNodeShown(nodeId)

			if shown and delayedOutputs[nodeId] then
				shown = false
			end

			if shown and item._prevShown ~= true and nodeType == pointType.Res then
				newResShownCount = newResShownCount + 1
			end

			item._prevShown = shown

			gohelper.setActive(item.go, shown)

			if item._goHighLight then
				gohelper.setActive(item._goHighLight, shown and linkableInputNodeIds[nodeId] == true)
			end

			if shown then
				local hasLinkedInput = false
				local hasLinkedOutput = false
				local allInputsLinked = true
				local allOutputsLinked = true
				local hasInput = false
				local hasOutput = false

				for _, lineCo in pairs(self._gameModel:getLineDict() or {}) do
					if lineCo.to == nodeId then
						hasInput = true

						if self._gameModel:isLineLinked(lineCo.from, lineCo.to) then
							hasLinkedInput = true
						else
							allInputsLinked = false
						end
					end

					if lineCo.from == nodeId then
						hasOutput = true

						if self._gameModel:isLineLinked(lineCo.from, lineCo.to) then
							hasLinkedOutput = true
						else
							allOutputsLinked = false
						end
					end
				end

				gohelper.setActive(item._goLinkpointL, hasLinkedInput)
				gohelper.setActive(item._goLinkpointR, hasLinkedOutput)

				if item.nodeCo.type == pointType.End then
					gohelper.setActive(item._goSelect, true)

					if item._finishAnimator and not item._finishAnimPlayed then
						item._finishAnimPlayed = true

						item._finishAnimator:Play(EvelynEnum.AnimatorName.Finish, 0, 0)
					end
				else
					gohelper.setActive(item._goSelect, hasInput and allInputsLinked and hasOutput and allOutputsLinked)
				end
			else
				gohelper.setActive(item._goLinkpointL, false)
				gohelper.setActive(item._goLinkpointR, false)
				gohelper.setActive(item._goSelect, false)
			end
		end
	end

	if newResShownCount > 0 then
		AudioMgr.instance:trigger(AudioEnum4_1.Evelyn.play_ui_atlantis_tool_get)
	end

	for lineKey, lineItem in pairs(self._lineItemDict or {}) do
		local shown = self._gameModel:isLineLinkedByKey(lineKey)

		if shown and usingToolId and lineItem.lineCo.from == usingToolId then
			shown = false
		end

		gohelper.setActive(lineItem.go, shown)
	end
end

function EvelynGameView:_onLinkDragBegin(nodeId, pointerEventData)
	if not self._gameModel then
		return
	end

	if self._gameClearFinishing then
		return
	end

	if self._placeModeToolId then
		self:_cancelPlaceMode()
	end

	local item = self._nodeItemDict and self._nodeItemDict[nodeId]

	if not item or not self._goMapRoot then
		return
	end

	local parentTrs = self._goMapRoot.transform.parent

	if not parentTrs then
		return
	end

	local touchPos = recthelper.screenPosToAnchorPos(pointerEventData.position, parentTrs)
	local fromX, fromY = self:_pickLinkAnchorPos(item, touchPos, parentTrs)

	if not fromX then
		return
	end

	local scale = self._mapScale or MaxMapScale
	local session = {
		nodeId = nodeId,
		parentTrs = parentTrs,
		fromX = fromX,
		fromY = fromY,
		targets = {}
	}
	local dragNodeCo = item.nodeCo
	local isResOrOrigin = dragNodeCo.type == EvelynEnum.PointType.Res or dragNodeCo.type == EvelynEnum.PointType.Origin

	for targetId, targetItem in pairs(self._nodeItemDict or {}) do
		if targetId ~= nodeId and self._gameModel:isNodeLinkable(targetId) then
			local shouldAddTarget = true

			if isResOrOrigin then
				local targetNodeCo = self._gameModel:getNodeCo(targetId)

				if not targetNodeCo or targetNodeCo.type ~= EvelynEnum.PointType.Tool then
					shouldAddTarget = false
				elseif not self._gameModel:isToolUnlocked(targetId) then
					shouldAddTarget = false
				else
					local inputIds = self._gameModel:getToolInputIds(targetId)
					local allInputsLinked = true

					for _, inputId in ipairs(inputIds) do
						if not self._gameModel:isLineLinked(inputId, targetId) then
							allInputsLinked = false

							break
						end
					end

					if allInputsLinked then
						shouldAddTarget = false
					elseif self._gameModel:isLineLinked(nodeId, targetId) then
						shouldAddTarget = false
					end
				end
			end

			if shouldAddTarget then
				local halfW, halfH = self:_getRootHalfSize(targetItem.go)
				local pos = recthelper.rectToRelativeAnchorPos(targetItem.go.transform.position, parentTrs)

				table.insert(session.targets, {
					nodeId = targetId,
					centerX = pos.x,
					centerY = pos.y,
					halfW = halfW * scale,
					halfH = halfH * scale
				})
			end
		end
	end

	self._linkDragSession = session

	AudioMgr.instance:trigger(AudioEnum4_1.Evelyn.play_ui_atlantis_pen_strat)
	self:_hideLinkTargetArrows()

	local lineItem = self:_getLinkDragLineItem()

	gohelper.setAsLastSibling(lineItem.go)
	gohelper.setActive(lineItem.go, true)
	self:_updateLinkDragLine(fromX, fromY, touchPos.x, touchPos.y)
	self:_showDragHighlight(session)

	if (item.nodeCo.type == EvelynEnum.PointType.Tool or item.nodeCo.type == EvelynEnum.PointType.Res) and item._goLinkpointR then
		gohelper.setActive(item._goLinkpointR, true)
	end
end

function EvelynGameView:_pickLinkAnchorPos(item, touchPos, parentTrs)
	if item.nodeCo.type ~= EvelynEnum.PointType.Tool then
		local iconGo = item._goLinkIconR

		if not iconGo or gohelper.isNil(iconGo) then
			return nil, nil
		end

		local pos = recthelper.rectToRelativeAnchorPos(iconGo.transform.position, parentTrs)

		return pos.x, pos.y
	end

	local bestX, bestY, bestDist

	for _, iconGo in pairs({
		item._goLinkIconL,
		item._goLinkIconR
	}) do
		if iconGo then
			local pos = recthelper.rectToRelativeAnchorPos(iconGo.transform.position, parentTrs)
			local dx = pos.x - touchPos.x
			local dy = pos.y - touchPos.y
			local dist = dx * dx + dy * dy

			if not bestDist or dist < bestDist then
				bestDist = dist
				bestX, bestY = pos.x, pos.y
			end
		end
	end

	return bestX, bestY
end

function EvelynGameView:_onLinkDrag(param, pointerEventData)
	local session = self._linkDragSession

	if not session then
		return
	end

	local pos = recthelper.screenPosToAnchorPos(pointerEventData.position, session.parentTrs)

	self:_updateLinkDragLine(session.fromX, session.fromY, pos.x, pos.y)
end

function EvelynGameView:_updateLinkEdgeMove()
	local session = self._linkDragSession

	if not session then
		return
	end

	local screenPos

	if UnityEngine.Input.touchCount > 0 then
		screenPos = UnityEngine.Input.GetTouch(0).position
	else
		screenPos = UnityEngine.Input.mousePosition
	end

	local pos = recthelper.screenPosToAnchorPos(screenPos, session.parentTrs)
	local rootW = self._rootWidth
	local rootH = self._rootHeight

	if not rootW or not rootH or rootW <= 0 or rootH <= 0 then
		return
	end

	local distance = EvelynEnum.EdgeMoveDistance
	local moveStep = EvelynEnum.EdgeMoveSpeed * UnityEngine.Time.deltaTime
	local dx, dy = 0, 0

	if pos.x < -rootW * 0.5 + distance then
		dx = moveStep
	elseif pos.x > rootW * 0.5 - distance then
		dx = -moveStep
	end

	if pos.y < -rootH * 0.5 + distance then
		dy = moveStep
	elseif pos.y > rootH * 0.5 - distance then
		dy = -moveStep
	end

	if dx ~= 0 or dy ~= 0 then
		self:_moveLinkDragMap(dx, dy, pos)
	end
end

function EvelynGameView:_moveLinkDragMap(dx, dy, pointerPos)
	local session = self._linkDragSession

	if not session or not self._goMapRoot then
		return
	end

	local oldX, oldY = recthelper.getAnchor(self._goMapRoot.transform)

	recthelper.setAnchor(self._goMapRoot.transform, oldX + dx, oldY + dy)
	self:_clampMapPos()

	local newX, newY = recthelper.getAnchor(self._goMapRoot.transform)
	local realDx = newX - oldX
	local realDy = newY - oldY

	if realDx == 0 and realDy == 0 then
		return
	end

	session.fromX = session.fromX + realDx
	session.fromY = session.fromY + realDy

	for _, target in ipairs(session.targets) do
		target.centerX = target.centerX + realDx
		target.centerY = target.centerY + realDy
	end

	self:_updateLinkDragLine(session.fromX, session.fromY, pointerPos.x, pointerPos.y)
end

function EvelynGameView:_syncLinkDragSessionOnScaleChange(oldScale, newScale)
	local session = self._linkDragSession

	if not session or not self._goMapRoot then
		return
	end

	if not oldScale or oldScale <= 0 or newScale <= 0 then
		return
	end

	if math.abs(oldScale - newScale) < 0.0001 then
		return
	end

	local parentTrs = session.parentTrs

	if not parentTrs then
		return
	end

	local dragItem = self._nodeItemDict and self._nodeItemDict[session.nodeId]

	if dragItem then
		local iconGo = dragItem._goLinkIconR

		if iconGo and not gohelper.isNil(iconGo) then
			local pos = recthelper.rectToRelativeAnchorPos(iconGo.transform.position, parentTrs)

			session.fromX, session.fromY = pos.x, pos.y
		end
	end

	local scale = self._mapScale or newScale

	for _, target in ipairs(session.targets) do
		local targetItem = self._nodeItemDict and self._nodeItemDict[target.nodeId]

		if targetItem and not gohelper.isNil(targetItem.go) then
			local pos = recthelper.rectToRelativeAnchorPos(targetItem.go.transform.position, parentTrs)

			target.centerX, target.centerY = pos.x, pos.y

			local halfW, halfH = self:_getRootHalfSize(targetItem.go)

			target.halfW = halfW * scale
			target.halfH = halfH * scale
		end
	end

	local screenPos

	if UnityEngine.Input.touchCount > 0 then
		screenPos = UnityEngine.Input.GetTouch(0).position
	else
		screenPos = UnityEngine.Input.mousePosition
	end

	local pos = recthelper.screenPosToAnchorPos(screenPos, parentTrs)

	self:_updateLinkDragLine(session.fromX, session.fromY, pos.x, pos.y)
end

function EvelynGameView:_syncToolDragSessionOnScaleChange()
	local session = self._dragSession

	if not session or not session.slots or not self._goMapRoot then
		return
	end

	local scale = self._mapScale or MaxMapScale
	local mapX, mapY = recthelper.getAnchor(self._goMap.transform)

	for _, slot in ipairs(session.slots) do
		local item = self._toolItemDict and self._toolItemDict[slot.toolId]

		if item and not gohelper.isNil(item.go) then
			local nodeX, nodeY = self._gameModel:getNodePos(slot.toolId)

			slot.centerX = mapX + nodeX * scale
			slot.centerY = mapY + nodeY * scale

			local halfW, halfH = self:_getRootHalfSize(item.go)

			slot.halfW = halfW * scale
			slot.halfH = halfH * scale
		end
	end
end

function EvelynGameView:_updateToolDragEdgeMove()
	if not self._curDragToolId or not self._dragSession then
		return
	end

	local screenPos

	if UnityEngine.Input.touchCount > 0 then
		screenPos = UnityEngine.Input.GetTouch(0).position
	else
		screenPos = UnityEngine.Input.mousePosition
	end

	local parentTrs = self._goMapRoot.transform.parent

	if not parentTrs then
		return
	end

	local pos = recthelper.screenPosToAnchorPos(screenPos, parentTrs)
	local rootW = self._rootWidth
	local rootH = self._rootHeight

	if not rootW or not rootH or rootW <= 0 or rootH <= 0 then
		return
	end

	local distance = EvelynEnum.EdgeMoveDistance
	local moveStep = EvelynEnum.EdgeMoveSpeed * UnityEngine.Time.deltaTime
	local dx, dy = 0, 0

	if pos.x < -rootW * 0.5 + distance then
		dx = moveStep
	elseif pos.x > rootW * 0.5 - distance then
		dx = -moveStep
	end

	if pos.y < -rootH * 0.5 + distance then
		dy = moveStep
	elseif pos.y > rootH * 0.5 - distance then
		dy = -moveStep
	end

	if dx == 0 and dy == 0 then
		return
	end

	local oldX, oldY = recthelper.getAnchor(self._goMapRoot.transform)

	recthelper.setAnchor(self._goMapRoot.transform, oldX + dx, oldY + dy)
	self:_clampMapPos()

	local newX, newY = recthelper.getAnchor(self._goMapRoot.transform)
	local realDx = newX - oldX
	local realDy = newY - oldY

	if realDx == 0 and realDy == 0 then
		return
	end

	for _, slot in ipairs(self._dragSession.slots) do
		slot.centerX = slot.centerX + realDx
		slot.centerY = slot.centerY + realDy
	end

	local dragItem = self._dragItemDic and self._dragItemDic[self._curDragToolId]

	if dragItem and not gohelper.isNil(dragItem.go) then
		local placeRootTrs = self._goPlaceRoot and self._goPlaceRoot.transform

		if placeRootTrs then
			local anchorPos = recthelper.screenPosToAnchorPos(screenPos, placeRootTrs)

			recthelper.setAnchor(dragItem.go.transform, anchorPos.x, anchorPos.y)
		end
	end
end

function EvelynGameView:_initLinkTargetArrows()
	self._targetArrowItemList = {}

	if self._goArrowTemplate then
		gohelper.setActive(self._goArrowTemplate, false)
	end
end

function EvelynGameView:_getOrCloneArrow()
	for _, arrowItem in ipairs(self._targetArrowItemList or {}) do
		if not arrowItem._inUse then
			arrowItem._inUse = true

			return arrowItem
		end
	end

	if not self._goArrowTemplate then
		return nil
	end

	local parentTrs = self._goArrowTemplate.transform.parent

	if not parentTrs then
		return nil
	end

	local cloneGo = UnityEngine.Object.Instantiate(self._goArrowTemplate, parentTrs)
	local rt = cloneGo.transform

	rt.anchorMin = Vector2(0.5, 0.5)
	rt.anchorMax = Vector2(0.5, 0.5)
	rt.pivot = Vector2(0.5, 0.5)

	local arrowItem = {
		_inUse = true,
		go = cloneGo
	}

	table.insert(self._targetArrowItemList, arrowItem)

	return arrowItem
end

function EvelynGameView:_hideLinkTargetArrows()
	for _, arrowItem in ipairs(self._targetArrowItemList or {}) do
		arrowItem._inUse = false

		gohelper.setActive(arrowItem.go, false)
	end
end

function EvelynGameView:_showDragHighlight(session)
	if not session then
		return
	end

	for _, oldItem in ipairs(self._linkTargetDetailItems or {}) do
		if oldItem._goDetail then
			gohelper.setActive(oldItem._goDetail, false)
		end
	end

	self._linkTargetDetailItems = {}

	local dragItem = self._nodeItemDict and self._nodeItemDict[session.nodeId]

	if dragItem and dragItem._goHighLight then
		gohelper.setActive(dragItem._goHighLight, true)
	end

	local dragNodeCo = dragItem and dragItem.nodeCo

	if dragNodeCo and (dragNodeCo.type == EvelynEnum.PointType.Res or dragNodeCo.type == EvelynEnum.PointType.Origin) then
		for otherId, otherItem in pairs(self._nodeItemDict or {}) do
			if otherId ~= session.nodeId and otherItem._goHighLight then
				local otherType = otherItem.nodeCo and otherItem.nodeCo.type

				if otherType == EvelynEnum.PointType.Res or otherType == EvelynEnum.PointType.Origin then
					gohelper.setActive(otherItem._goHighLight, false)
				end
			end

			self:_showLinkTargetDetail(otherItem)
		end
	end

	for _, target in ipairs(session.targets or {}) do
		local targetItem = self._nodeItemDict and self._nodeItemDict[target.nodeId]

		if targetItem and targetItem._goHighLight then
			gohelper.setActive(targetItem._goHighLight, true)
		end
	end

	if #(session.targets or {}) == 0 then
		if self._txtTips then
			self._txtTips.text = luaLang("v4a1_evelyn_not_target")
		end

		if self._goTips then
			gohelper.setActive(self._goTips, true)
			logWarn(string.format("[EvelynGame] ShowTips: no targets, goTips=%s, txtTips=%s", tostring(self._goTips), tostring(self._txtTips)))
		else
			logError("[EvelynGame] ShowTips failed: _goTips is nil")
		end
	else
		logWarn(string.format("[EvelynGame] HideTips: has %d targets", #session.targets))
	end
end

function EvelynGameView:_ensureToolDetailLoaded(item)
	if not item or not item._goRoot then
		return
	end

	if not self._goTipRoot then
		return
	end

	if item._goDetail and not gohelper.isNil(item._goDetail) then
		return
	end

	local setting = self.viewContainer:getSetting()
	local cloneGo = self:getResInst(setting.otherRes[6], self._goTipRoot)

	if not cloneGo then
		return
	end

	cloneGo.name = "go_Detail_" .. item.nodeCo.id
	item._goDetail = cloneGo
	item._txtDetail = gohelper.findChildText(cloneGo, "#go_detail/go_scroll/viewport/content/#txt_Detail")

	gohelper.setActive(cloneGo, false)
end

function EvelynGameView:_syncToolDetailPos(item)
	if not self._goTipRoot then
		return
	end

	if not item or not item._goDetail or not item._goRoot then
		return
	end

	if gohelper.isNil(item._goDetail) or gohelper.isNil(item._goRoot) then
		return
	end

	local pos = recthelper.rectToRelativeAnchorPos(item._goRoot.transform.position, self._goTipRoot.transform)
	local scale = self._mapScale or 1

	recthelper.setAnchor(item._goDetail.transform, pos.x + (EvelynEnum.ToolDetailItemOffset.X or 0) * scale, pos.y + (EvelynEnum.ToolDetailItemOffset.Y or 0) * scale)

	item._goDetail.transform.localScale = Vector3(scale, scale, 1)
end

function EvelynGameView:_updateLinkTargetDetails()
	local list = self._linkTargetDetailItems

	if not list or #list == 0 then
		return
	end

	local remain = {}

	for _, targetItem in ipairs(list) do
		local toolId = targetItem.nodeCo and targetItem.nodeCo.id

		if toolId and self._gameModel and self._gameModel:isToolPlaced(toolId) and self._gameModel:isToolShown(toolId) then
			self:_syncToolDetailPos(targetItem)
			table.insert(remain, targetItem)
		elseif targetItem._goDetail then
			gohelper.setActive(targetItem._goDetail, false)
		end
	end

	self._linkTargetDetailItems = remain
end

function EvelynGameView:_showLinkTargetDetail(targetItem)
	if not targetItem or not targetItem.nodeCo then
		return
	end

	if targetItem.nodeCo.type ~= EvelynEnum.PointType.Tool then
		return
	end

	local toolId = targetItem.nodeCo.id

	if not self._gameModel:isToolPlaced(toolId) then
		return
	end

	if not self._gameModel:isToolShown(toolId) then
		return
	end

	if self._gameModel:isToolInputsLinked(toolId) then
		return
	end

	self:_ensureToolDetailLoaded(targetItem)

	if targetItem._txtDetail and not string.nilorempty(targetItem.nodeCo.desc) then
		targetItem._txtDetail.text = targetItem.nodeCo.desc
	end

	if targetItem._goDetail then
		gohelper.setActive(targetItem._goDetail, true)
		self:_syncToolDetailPos(targetItem)
	end

	table.insert(self._linkTargetDetailItems, targetItem)
end

function EvelynGameView:_hideDragHighlight(session)
	if not session then
		return
	end

	local dragItem = self._nodeItemDict and self._nodeItemDict[session.nodeId]

	if dragItem and dragItem._goHighLight then
		gohelper.setActive(dragItem._goHighLight, false)
	end

	for _, target in ipairs(session.targets or {}) do
		local targetItem = self._nodeItemDict and self._nodeItemDict[target.nodeId]

		if targetItem and targetItem._goHighLight then
			gohelper.setActive(targetItem._goHighLight, false)
		end
	end

	for _, targetItem in ipairs(self._linkTargetDetailItems or {}) do
		if targetItem._goDetail then
			gohelper.setActive(targetItem._goDetail, false)
		end
	end

	self._linkTargetDetailItems = nil

	if self._goTips then
		gohelper.setActive(self._goTips, false)
	end
end

function EvelynGameView:_placeArrowAt(x, y)
	local rootW = self._rootWidth
	local rootH = self._rootHeight

	if not rootW or not rootH or rootW <= 0 or rootH <= 0 then
		return false
	end

	local halfW = rootW * 0.5
	local halfH = rootH * 0.5

	if x >= -halfW and x <= halfW and y >= -halfH and y <= halfH then
		return false
	end

	local arrowItem = self:_getOrCloneArrow()

	if not arrowItem then
		return false
	end

	local arrowTrs = arrowItem.go.transform
	local dx, dy = x, y
	local dist = math.sqrt(dx * dx + dy * dy)

	if dist <= 0 then
		arrowItem._inUse = false

		return false
	end

	local ux, uy = dx / dist, dy / dist
	local arrowEdgeDistY = EvelynEnum.BgArrowDistance
	local arrowEdgeDistX = arrowEdgeDistY - (EvelynEnum.BgOffsetLimit or 0)
	local distX = math.abs(ux) > 0.0001 and halfW / math.abs(ux) or math.huge
	local distY = math.abs(uy) > 0.0001 and halfH / math.abs(uy) or math.huge
	local px, py

	if distX <= distY then
		local arrowX = ux > 0 and halfW - arrowEdgeDistX or -halfW + arrowEdgeDistX
		local arrowY = math.abs(ux) > 0.0001 and arrowX * uy / ux or 0

		px, py = arrowX, arrowY
	else
		local arrowY = uy > 0 and halfH - arrowEdgeDistY or -halfH + arrowEdgeDistY
		local arrowX = math.abs(uy) > 0.0001 and arrowY * ux / uy or 0

		px, py = arrowX, arrowY
	end

	recthelper.setAnchor(arrowTrs, px, py)

	local angle = math.atan2(uy, ux) * 180 / math.pi - 90

	arrowTrs.localEulerAngles = Vector3(0, 0, angle)

	gohelper.setActive(arrowItem.go, true)

	return true
end

function EvelynGameView:_updateLinkTargetArrows()
	local session = self._linkDragSession

	if not session or not session.targets then
		return
	end

	if self._dragSession then
		return
	end

	for _, arrowItem in ipairs(self._targetArrowItemList or {}) do
		arrowItem._inUse = false

		gohelper.setActive(arrowItem.go, false)
	end

	for _, target in ipairs(session.targets) do
		if self._gameModel:isToolShown(target.nodeId) and self._gameModel:isToolPlaced(target.nodeId) then
			self:_placeArrowAt(target.centerX, target.centerY)
		end
	end
end

function EvelynGameView:_updateToolDragSlotArrows()
	if self._linkDragSession then
		return
	end

	for _, arrowItem in ipairs(self._targetArrowItemList or {}) do
		arrowItem._inUse = false

		gohelper.setActive(arrowItem.go, false)
	end

	local session = self._dragSession

	if not session or not session.slots then
		return
	end

	for _, slot in ipairs(session.slots) do
		if self._gameModel:isToolShown(slot.toolId) then
			self:_placeArrowAt(slot.centerX, slot.centerY)
		end
	end
end

function EvelynGameView:_onLinkDragEnd(param, pointerEventData)
	local session = self._linkDragSession

	self._linkDragSession = nil

	if self._linkDragLineItem then
		gohelper.setActive(self._linkDragLineItem.go, false)
	end

	self:_hideLinkTargetArrows()
	self:_hideDragHighlight(session)

	if not session or not self._gameModel then
		self:_refreshMapVisual()

		return
	end

	local pos = recthelper.screenPosToAnchorPos(pointerEventData.position, session.parentTrs)

	AudioMgr.instance:trigger(AudioEnum4_1.Evelyn.play_ui_atlantis_pen_end)

	local hitNodeId

	for _, target in ipairs(session.targets) do
		if math.abs(pos.x - target.centerX) < target.halfW and math.abs(pos.y - target.centerY) < target.halfH then
			hitNodeId = target.nodeId

			break
		end
	end

	if not hitNodeId then
		self:_refreshMapVisual()

		return
	end

	local fromWasExpanded = self._gameModel:isToolExpanded(session.nodeId)
	local toWasExpanded = self._gameModel:isToolExpanded(hitNodeId)

	if not self._gameModel:linkLine(session.nodeId, hitNodeId) and not self._gameModel:linkLine(hitNodeId, session.nodeId) then
		AudioMgr.instance:trigger(AudioEnum4_1.Evelyn.play_ui_atlantis_connect_no)

		local sessionNodeCo = self._gameModel:getNodeCo(session.nodeId)
		local hitNodeCo = self._gameModel:getNodeCo(hitNodeId)

		if sessionNodeCo and hitNodeCo and (sessionNodeCo.type == EvelynEnum.PointType.Res or sessionNodeCo.type == EvelynEnum.PointType.Origin) and hitNodeCo.type == EvelynEnum.PointType.Tool then
			GameFacade.showToast(ToastEnum.EvelynLineConnectError)
		end

		self:_refreshMapVisual()

		return
	end

	EvelynController.instance:dispatchEvent(EvelynEvent.GuideLinkSuccess)
	AudioMgr.instance:trigger(AudioEnum4_1.Evelyn.play_ui_atlantis_connect_yes)

	if not toWasExpanded and self._gameModel:isToolExpanded(hitNodeId) then
		self:_beginToolUsingAnim(hitNodeId)
	elseif not fromWasExpanded and self._gameModel:isToolExpanded(session.nodeId) then
		self:_beginToolUsingAnim(session.nodeId)
	else
		self:_refreshMapVisual()
	end
end

function EvelynGameView:_beginToolUsingAnim(toolId)
	self:_clearToolUsingAnim()

	local nodeCo = self._gameModel and self._gameModel:getNodeCo(toolId)
	local useTimeVal = nodeCo and tonumber(nodeCo.useTime)
	local toolItem = self._toolItemDict and self._toolItemDict[toolId]

	if not useTimeVal or useTimeVal <= 0 then
		if toolItem then
			toolItem._pointContainerHidden = false
			toolItem._pointHideTask = TaskDispatcher.runDelay(function()
				self:_onToolPointContainerHideDone(toolItem)
			end, self, EvelynEnum.AnimTime.PointDone)
		end

		self:_onToolUsingAnimDone()

		return
	end

	self._toolUsingToolId = toolId

	local useTimeDuration = self._gameModel and self._gameModel:getToolUseTime(toolId) or EvelynEnum.AnimTime.ToolToRes
	local totalDuration = math.max(useTimeDuration, EvelynEnum.AnimTime.PointDone)

	if toolItem and toolItem._goUsing then
		gohelper.setActive(toolItem._goUsing, true)
	end

	if toolItem then
		toolItem._pointContainerHidden = false
	end

	self:_refreshMapVisual()

	if toolItem and toolItem._imageUsing then
		toolItem._imageUsing.fillAmount = 0
		self._toolUsingTweenId = ZProj.TweenHelper.DOFillAmount(toolItem._imageUsing, 1, useTimeDuration, self._onToolUsingAnimDone, self, nil, EaseType.Linear)
	else
		TaskDispatcher.runDelay(self._onToolUsingAnimDone, self, totalDuration)
	end

	if toolItem then
		toolItem._pointHideTask = TaskDispatcher.runDelay(function()
			self:_onToolPointContainerHideDone(toolItem)
		end, self, totalDuration)
	end
end

function EvelynGameView:_onToolUsingAnimDone()
	self._toolUsingTweenId = nil

	local toolId = self._toolUsingToolId

	self._toolUsingToolId = nil

	local toolItem = toolId and self._toolItemDict and self._toolItemDict[toolId]

	if toolItem and toolItem._goUsing and not gohelper.isNil(toolItem._goUsing) then
		gohelper.setActive(toolItem._goUsing, false)
	end

	if not self._gameModel then
		return
	end

	local expandedSnap = self:_snapshotToolExpanded()

	self._gameModel:propagate()
	self._gameModel:autoLinkPendingInputs()
	self:_schedulePointContainerHide(self:_diffNewlyExpandedToolIds(expandedSnap))
	self:_refreshMapVisual()
	self:_refreshToolsBar()

	local isClear = self._gameModel:isGameClear()

	logWarn(string.format("[EvelynGame] _onToolUsingAnimDone: checking isGameClear=%s", tostring(isClear)))

	if isClear then
		logWarn(string.format("[EvelynGame] GameClear detected, focusing end node. gameId=%s", tostring(self.viewParam and self.viewParam.gameId)))
		self:_focusEndNode()
	end
end

function EvelynGameView:_onToolPointContainerHideDone(toolItem)
	if not toolItem or gohelper.isNil(toolItem._goPoint) then
		return
	end

	toolItem._pointHideTask = nil
	toolItem._pointContainerHidden = true

	gohelper.setActive(toolItem._goPoint, false)
end

function EvelynGameView:_clearToolUsingAnim()
	TaskDispatcher.cancelTask(self._onToolUsingAnimDone, self)

	if self._toolUsingTweenId then
		ZProj.TweenHelper.KillById(self._toolUsingTweenId, false)

		self._toolUsingTweenId = nil
	end

	local toolId = self._toolUsingToolId

	self._toolUsingToolId = nil

	if not toolId then
		return
	end

	local toolItem = self._toolItemDict and self._toolItemDict[toolId]

	if toolItem and toolItem._goUsing and not gohelper.isNil(toolItem._goUsing) then
		gohelper.setActive(toolItem._goUsing, false)
	end

	if toolItem and toolItem._imageUsing and not gohelper.isNil(toolItem._imageUsing) then
		toolItem._imageUsing.fillAmount = 0
	end

	if toolItem and toolItem._pointHideTask then
		TaskDispatcher.cancelTask(toolItem._pointHideTask)

		toolItem._pointHideTask = nil
	end
end

function EvelynGameView:_getLinkDragLineItem()
	if self._linkDragLineItem then
		return self._linkDragLineItem
	end

	local setting = self.viewContainer:getSetting()
	local dragRootGo = self._goMapRoot.transform.parent.gameObject
	local cloneGo = self:getResInst(setting.otherRes[5], dragRootGo)

	cloneGo.name = "link_drag_line"

	local lineItem = MonoHelper.addNoUpdateLuaComOnceToGo(cloneGo, EvelynLineItem)

	gohelper.setActive(cloneGo, false)

	self._linkDragLineItem = lineItem

	return lineItem
end

function EvelynGameView:_updateLinkDragLine(fromX, fromY, toX, toY)
	local lineItem = self._linkDragLineItem

	if not lineItem then
		return
	end

	local dragRootTrs = self._goMapRoot.transform.parent
	local angleDeg = self:_calcLineAngle(fromX, fromY, toX, toY)

	lineItem:refresh(fromX, fromY, toX, toY, angleDeg, dragRootTrs)
end

function EvelynGameView:_focusEndNode()
	logWarn("[EvelynGame] _focusEndNode called")

	if self._gameClearFinishing or self._focusEndTweenId then
		return
	end

	self:_clearCamMove()
	self:_clearIntroZoom()
	AudioMgr.instance:trigger(AudioEnum4_1.Evelyn.play_ui_atlantis_level_pass)

	local endNodeId
	local pointType = EvelynEnum.PointType

	for nodeId, item in pairs(self._nodeItemDict or {}) do
		if item.nodeCo and item.nodeCo.type == pointType.End then
			endNodeId = nodeId

			break
		end
	end

	if not endNodeId then
		self:_beginCompleteAnim()

		return
	end

	EvelynHelper.lockScreen("evelyn_complete", true)

	local nodeX, nodeY = self._gameModel:getNodePos(endNodeId)
	local targetScale = EvelynEnum.CompleteScale
	local cx, cy = self:_getScreenCenterInParent()
	local targetAnchorX = cx - nodeX * targetScale
	local targetAnchorY = cy - nodeY * targetScale
	local lowX, highX, lowY, highY = self:_calcClampRange(targetScale)

	if lowX then
		targetAnchorX = highX < lowX and cx or Mathf.Clamp(targetAnchorX, lowX, highX)
		targetAnchorY = highY < lowY and cy or Mathf.Clamp(targetAnchorY, lowY, highY)
	end

	local duration = EvelynEnum.AnimTime.BeforeComplete
	local mapTrs = self._goMapRoot.transform

	self._focusEndTweenId = ZProj.TweenHelper.DOAnchorPos(mapTrs, targetAnchorX, targetAnchorY, duration, self._onFocusEndDone, self, nil, EaseType.OutQuad)

	ZProj.TweenHelper.DOScale(mapTrs, targetScale, targetScale, 1, duration)
	TaskDispatcher.runRepeat(self._onFocusLineUpdate, self, 0, -1)
end

function EvelynGameView:_onFocusLineUpdate()
	if not self._goMapRoot then
		return
	end

	self._mapScale = self._goMapRoot.transform.localScale.x

	self:_syncMapBg()
	self:_refreshAllLineTransforms()
end

function EvelynGameView:_onFocusEndDone()
	self._focusEndTweenId = nil

	TaskDispatcher.cancelTask(self._onFocusLineUpdate, self)

	self._mapScale = EvelynEnum.CompleteScale

	self:_clampMapPos()
	self:_beginCompleteAnim()
end

function EvelynGameView:_beginCompleteAnim()
	logWarn(string.format("[EvelynGame] _beginCompleteAnim called, gameClearFinishing=%s", tostring(self._gameClearFinishing)))

	if self._gameClearFinishing then
		return
	end

	self._gameClearFinishing = true

	local duration = EvelynEnum.AnimTime.Complete
	local gameId = self.viewParam and self.viewParam.gameId
	local guideId = gameId and EvelynEnum.GameId2Guide[gameId]

	if guideId and not GuideModel.instance:isGuideFinish(guideId) and GuideModel.instance:isGuideRunning(guideId) then
		duration = EvelynEnum.AnimTime.GuideComplete
	end

	logWarn(string.format("[EvelynGame] Starting complete anim delay, duration=%s", tostring(duration)))
	TaskDispatcher.runDelay(self._onCompleteAnimDone, self, duration)
end

function EvelynGameView:_onCompleteAnimDone()
	logWarn(string.format("[EvelynGame] _onCompleteAnimDone called, gameClearFinishing=%s", tostring(self._gameClearFinishing)))

	if not self._gameClearFinishing then
		return
	end

	EvelynHelper.lockScreen("evelyn_complete", false)

	if not self._gameModel then
		logWarn("[EvelynGame] _onCompleteAnimDone: gameModel is nil, aborting")

		self._gameClearFinishing = false

		return
	end

	local episodeId = self.viewParam and self.viewParam.episodeId
	local gameId = self.viewParam and self.viewParam.gameId

	logWarn(string.format("[EvelynGame] _onCompleteAnimDone: gameId=%s, episodeId=%s", tostring(gameId), tostring(episodeId)))
	EvelynController.instance:dispatchEvent(EvelynEvent.GuideFinishEpisode, gameId)

	if not self._gameClearFinishing then
		logWarn("[EvelynGame] _onCompleteAnimDone: gameClearFinishing cleared during dispatch, aborting")

		return
	end

	local guideId = gameId and EvelynEnum.GameId2Guide[gameId]
	local isGuideFinish = guideId and GuideModel.instance:isGuideFinish(guideId)
	local isGuideRunning = guideId and GuideModel.instance:isGuideRunning(guideId)

	logWarn(string.format("[EvelynGame] _onCompleteAnimDone: guideId=%s, isGuideFinish=%s, isGuideRunning=%s", tostring(guideId), tostring(isGuideFinish), tostring(isGuideRunning)))

	if guideId and not isGuideFinish and isGuideRunning then
		logWarn("[EvelynGame] _onCompleteAnimDone: waiting for guide finish, not settling yet")

		return
	end

	logWarn("[EvelynGame] _onCompleteAnimDone: settling episode")
	self:sendGameStat(StatEnum.EvelynGameResult.Success)

	self._gameClearFinishing = false

	self:_settleEpisode(episodeId)
end

function EvelynGameView:onGuideFinish(guideId)
	logWarn(string.format("[EvelynGame] onGuideFinish called: guideId=%s, gameClearFinishing=%s", tostring(guideId), tostring(self._gameClearFinishing)))

	if not self._gameClearFinishing then
		return
	end

	if self._guideFinishDelayPending then
		return
	end

	local gameId = self.viewParam and self.viewParam.gameId

	if not gameId or not EvelynEnum.GameId2Guide[gameId] then
		logWarn(string.format("[EvelynGame] onGuideFinish: no gameId or no mapping, gameId=%s", tostring(gameId)))

		return
	end

	if EvelynEnum.Guide2GameId[guideId] ~= gameId then
		logWarn(string.format("[EvelynGame] onGuideFinish: guideId mapping mismatch, guideId=%s, gameId=%s", tostring(guideId), tostring(gameId)))

		return
	end

	logWarn(string.format("[EvelynGame] onGuideFinish: scheduling settle after GuideComplete=%s, episodeId=%s", tostring(EvelynEnum.AnimTime.GuideComplete), tostring(self.viewParam and self.viewParam.episodeId)))

	self._guideFinishDelayPending = true

	TaskDispatcher.runDelay(self._onGuideCompleteDelayDone, self, EvelynEnum.AnimTime.GuideComplete)
end

function EvelynGameView:_onGuideCompleteDelayDone()
	self._guideFinishDelayPending = nil

	if not self._gameClearFinishing then
		return
	end

	logWarn(string.format("[EvelynGame] _onGuideCompleteDelayDone: settling episode, episodeId=%s", tostring(self.viewParam and self.viewParam.episodeId)))
	self:sendGameStat(StatEnum.EvelynGameResult.Success)

	self._gameClearFinishing = false

	self:_settleEpisode(self.viewParam and self.viewParam.episodeId)
end

function EvelynGameView:_settleEpisode(episodeId)
	if not episodeId then
		return
	end

	local actId = EvelynModel.instance:getActId()
	local mo = actId and Activity220Model.instance:getById(actId)
	local episodeInfo = mo and mo:getEpisodeInfo(episodeId)
	local storyClear = episodeInfo and episodeInfo:getStoryClear()

	if storyClear and storyClear ~= 0 then
		self._settleMasking = true

		GameSceneMgr.instance:dispatchEvent(SceneEventName.SetLoadingTypeOnce, GameLoadingState.LoadingBlackView2)
		GameSceneMgr.instance:dispatchEvent(SceneEventName.OpenLoading, SceneType.Main)
		EvelynController.instance:finishEpisodeLevel(episodeId)
		GameSceneMgr.instance:dispatchEvent(SceneEventName.WaitViewOpenCloseLoading, ViewName.StoryFrontView)
	else
		EvelynController.instance:finishEpisodeLevel(episodeId)
		ViewMgr.instance:closeView(ViewName.EvelynGameView)
	end
end

function EvelynGameView:_onOpenViewFinish(viewName)
	if not self._settleMasking then
		return
	end

	if viewName == ViewName.StoryFrontView then
		self._settleMasking = nil

		GameSceneMgr.instance:dispatchEvent(SceneEventName.CloseLoading, SceneType.Main)
		ViewMgr.instance:closeView(ViewName.EvelynGameView)
	end
end

function EvelynGameView:sendGameStat(operationType)
	if self._statSent then
		return
	end

	self._statSent = true

	local episodeId = self.viewParam and self.viewParam.episodeId

	if not episodeId then
		return
	end

	local nowTime = ServerTime.now()
	local useTime = math.max(0, nowTime - (self._statStartTime or nowTime))
	local shownNodeIds = self._gameModel and self._gameModel:getShownNodeIds() or {}

	StatController.instance:track(StatEnum.EventName.EvelynGame, {
		[StatEnum.EventProperties.EvelynGameEpisode] = tostring(episodeId),
		[StatEnum.EventProperties.EvelynGameOperationType] = operationType,
		[StatEnum.EventProperties.EvelynGameUseTime] = useTime,
		[StatEnum.EventProperties.EvelynGameShownNodes] = shownNodeIds
	})
end

function EvelynGameView:_isScaleOperationDisabled()
	return not GuideModel.instance:isGuideFinish(EvelynEnum.GuideDisableScaleOperationBefore)
end

function EvelynGameView:_clearCompleteAnim()
	TaskDispatcher.cancelTask(self._onCompleteAnimDone, self)
	TaskDispatcher.cancelTask(self._onGuideCompleteDelayDone, self)

	self._guideFinishDelayPending = nil

	if self._focusEndTweenId then
		ZProj.TweenHelper.KillById(self._focusEndTweenId, false)

		self._focusEndTweenId = nil
	end

	TaskDispatcher.cancelTask(self._onFocusLineUpdate, self)
	EvelynHelper.lockScreen("evelyn_complete", false)

	self._gameClearFinishing = false
end

function EvelynGameView:_btnResetOnClick()
	if not self._gameModel then
		return
	end

	if self._gameClearFinishing then
		return
	end

	GameFacade.showMessageBox(MessageBoxIdDefine.V4a1EvelynGameReset, MsgBoxEnum.BoxType.Yes_No, function()
		self:_doResetGame()
	end)
end

function EvelynGameView:_doResetGame()
	self:sendGameStat(StatEnum.EvelynGameResult.Reset)

	self._statStartTime = ServerTime.now()
	self._statSent = false

	self:_cancelPlaceMode()
	self:_clearPlaceFeedback()
	self:_clearToolUsingAnim()

	for _, item in pairs(self._nodeItemDict or {}) do
		if item._finishAnimPlayed then
			item._finishAnimPlayed = nil
		end

		for _, pointItem in ipairs(item._pointItemList or {}) do
			if pointItem._hideTask then
				TaskDispatcher.cancelTask(pointItem._hideTask)

				pointItem._hideTask = nil
			end

			pointItem._pendingHide = nil
			pointItem._consumed = nil
			pointItem._isPlaying = nil
		end

		item._prevLinkedCount = nil
		item._pointContainerHidden = nil

		if item._pointHideTask then
			TaskDispatcher.cancelTask(item._pointHideTask)

			item._pointHideTask = nil
		end
	end

	self._gameModel:resetMap()
	self:_clearIntroZoom()
	self:_clearCamMove()

	self._camReturnX, self._camReturnY = nil

	local initScale = self._minMapScale + (MaxMapScale - self._minMapScale) * EvelynEnum.MapOriginSize

	self:_setMapScale(self._minMapScale)
	self:_resetMapPos()

	self._introTargetScale = initScale

	self:_startIntroSequence(EvelynEnum.AnimTime.ResetAnimDuration)

	if self._viewAnimator then
		self._viewAnimator:Play(EvelynEnum.AnimatorName.Reset, 0, 0)
	end

	for _, barItem in ipairs(self._toolBarItems or {}) do
		barItem._wasVisible = nil
	end

	self:_setCollapsed()
	self:_setToolsBarShown(true)
end

function EvelynGameView:_btnAnalysisOnClick()
	if not self._gameModel then
		return
	end

	if self._gameClearFinishing then
		return
	end

	if self._placeModeToolId then
		self:_cancelPlaceMode()

		return
	end

	local toolIds = self._gameModel:getToolIds()

	table.sort(toolIds)

	local firstUnplacedToolId

	for _, toolId in ipairs(toolIds) do
		if not self._gameModel:isToolPlaced(toolId) then
			firstUnplacedToolId = toolId

			break
		end
	end

	local targetToolId

	if firstUnplacedToolId then
		local nodeCo = self._gameModel:getNodeCo(firstUnplacedToolId)

		if not nodeCo or self._gameModel:isSubTypeUnlocked(nodeCo.subType) then
			targetToolId = firstUnplacedToolId
		else
			targetToolId = self:_pickLowestUnlockedToolId()
		end
	else
		targetToolId = self:_pickLowestUnlockedToolId()
	end

	if targetToolId then
		self:_openToolPanelView(targetToolId)
	end
end

function EvelynGameView:_pickLowestUnlockedToolId()
	if not self._gameModel then
		return nil
	end

	local lowestUnlockedSubType

	for _, subType in ipairs(self._gameModel:getSubTypeList()) do
		if self._gameModel:isSubTypeUnlocked(subType) then
			lowestUnlockedSubType = subType
		end
	end

	if not lowestUnlockedSubType then
		return nil
	end

	local layerToolIds = self._gameModel:getSubTypeToolIds(lowestUnlockedSubType)

	if #layerToolIds <= 0 then
		return nil
	end

	table.sort(layerToolIds)

	for _, toolId in ipairs(layerToolIds) do
		if not self._gameModel:isToolPlaced(toolId) then
			return toolId
		end
	end

	return layerToolIds[#layerToolIds]
end

function EvelynGameView:_setToolsBarShown(shown)
	self._toolsBarShown = shown

	if self._toolsAnimator then
		local animName = shown and EvelynEnum.AnimatorName.Open or EvelynEnum.AnimatorName.Close

		self._toolsAnimator:Play(animName, 0, 0)
	end

	if self._goarrow then
		local angle = shown and 0 or 180

		self._goarrow.transform.localEulerAngles = Vector3(0, 0, angle)
	end

	if self._btnToolsImage then
		self._btnToolsImage.enabled = shown
	end
end

function EvelynGameView:_btnToolsOnClick()
	self:_setToolsBarShown(self._toolsBarShown ~= true)
end

function EvelynGameView:_onMapDragBegin(param, pointerEventData)
	local parentTrs = self._goMapRoot.transform.parent

	if not parentTrs then
		return
	end

	local touchPos = recthelper.screenPosToAnchorPos(pointerEventData.position, parentTrs)
	local mapX, mapY = recthelper.getAnchor(self._goMapRoot.transform)

	self._mapDragOffsetX = mapX - touchPos.x
	self._mapDragOffsetY = mapY - touchPos.y
end

function EvelynGameView:_onMapDrag(param, pointerEventData)
	local parentTrs = self._goMapRoot.transform.parent

	if not parentTrs then
		return
	end

	local touchPos = recthelper.screenPosToAnchorPos(pointerEventData.position, parentTrs)

	recthelper.setAnchor(self._goMapRoot.transform, touchPos.x + (self._mapDragOffsetX or 0), touchPos.y + (self._mapDragOffsetY or 0))
	self:_clampMapPos()
end

function EvelynGameView:_calcResetAnchor(scale)
	if not self._gameModel then
		return nil
	end

	local originX, originY = self._gameModel:getMapOriginPos()

	if originX then
		return originX, originY
	end

	if not self._gameModel:getNodeCo(EvelynEnum.FirstNodeId) then
		logError(string.format("EvelynGameView:_calcResetAnchor error, no node config, nodeId:%s", tostring(EvelynEnum.FirstNodeId)))

		return nil
	end

	local nodeX, nodeY = self._gameModel:getNodePos(EvelynEnum.FirstNodeId)
	local rootGo = gohelper.findChild(self.viewGO, "root")

	if not rootGo then
		return nil
	end

	local cx, cy = self:_getScreenCenterInParent()
	local targetX = cx - recthelper.getWidth(rootGo.transform) * 0.25

	return targetX - nodeX * scale, cy - nodeY * scale
end

function EvelynGameView:_resetMapPos()
	if not self._goMapRoot or not self._gameModel then
		return
	end

	local scale = self._mapScale or MaxMapScale
	local anchorX, anchorY = self:_calcResetAnchor(scale)

	if not anchorX then
		return
	end

	recthelper.setAnchor(self._goMapRoot.transform, anchorX, anchorY)

	self._mapDragOffsetX = nil
	self._mapDragOffsetY = nil

	self:_clampMapPos()

	local lp = self._goMapRoot.transform.localPosition
	local oX, oY = self._gameModel:getMapOriginPos()

	logWarn(string.format("[Evelyn][Intro] ResetPos originPos:(%s,%s) anchor:(%.1f,%.1f) scale:%.3f localPos:(%.1f,%.1f)", tostring(oX), tostring(oY), anchorX, anchorY, scale, lp.x, lp.y))
end

function EvelynGameView:_focusToolNode(nodeId)
	if not self._goMapRoot or not self._gameModel then
		return
	end

	if not self._gameModel:getNodeCo(nodeId) then
		return
	end

	local nodeX, nodeY = self._gameModel:getNodePos(nodeId)
	local scale = self._mapScale or MaxMapScale
	local cx, cy = self:_getScreenCenterInParent()

	recthelper.setAnchor(self._goMapRoot.transform, cx - nodeX * scale, cy - nodeY * scale)

	self._mapDragOffsetX = nil
	self._mapDragOffsetY = nil

	self:_clampMapPos()
end

function EvelynGameView:_beginPlaceMode(toolId)
	if not self._gameModel then
		return
	end

	if self._gameModel:isToolPlaced(toolId) then
		return
	end

	self:_cancelPlaceMode()

	local item = self._toolItemDict and self._toolItemDict[toolId]

	if not item or not item._goBtnPlace then
		return
	end

	self._placeModeToolId = toolId

	self:_focusToolNode(toolId)
	gohelper.setActive(item._goBtnPlace, true)
	gohelper.setActive(item._goBtnPlaceLight, true)
	gohelper.setActive(self._btnClosePlace, true)
end

function EvelynGameView:_onPlaceBtnClick()
	local toolId = self._placeModeToolId

	if not toolId then
		return
	end

	if self._gameModel and self._gameModel:isToolPlaced(toolId) then
		self:_cancelPlaceMode()

		return
	end

	local placed = self:_placeTool(toolId)

	self:_cancelPlaceMode()

	if placed then
		AudioMgr.instance:trigger(AudioEnum4_1.Evelyn.play_ui_atlantis_tool_down)
		self:_beginPlaceFeedback(toolId)
	end
end

function EvelynGameView:_beginPlaceFeedback(toolId)
	self:_clearPlaceFeedback()

	local item = self._toolItemDict and self._toolItemDict[toolId]

	if not item or not item._goCorrect or gohelper.isNil(item.go) then
		return
	end

	self._placeFeedbackItem = item

	gohelper.setActive(item._goCorrect, true)
	TaskDispatcher.runDelay(self._onPlaceFeedbackDone, self, EvelynEnum.AnimTime.ToolDragSuccess)
end

function EvelynGameView:_onPlaceFeedbackDone()
	local item = self._placeFeedbackItem

	self._placeFeedbackItem = nil

	if not item or gohelper.isNil(item.go) then
		return
	end

	gohelper.setActive(item._goCorrect, false)
end

function EvelynGameView:_clearPlaceFeedback()
	TaskDispatcher.cancelTask(self._onPlaceFeedbackDone, self)

	local item = self._placeFeedbackItem

	self._placeFeedbackItem = nil

	if not item or gohelper.isNil(item.go) then
		return
	end

	gohelper.setActive(item._goCorrect, false)
end

function EvelynGameView:_cancelPlaceMode()
	local toolId = self._placeModeToolId

	if not toolId then
		return
	end

	local item = self._toolItemDict and self._toolItemDict[toolId]

	if item and item._goBtnPlace then
		gohelper.setActive(item._goBtnPlace, false)
		gohelper.setActive(item._goBtnPlaceLight, false)
	end

	gohelper.setActive(self._btnClosePlace, false)

	self._placeModeToolId = nil
end

function EvelynGameView:_calcClampRange(scale)
	local rootW = self._rootWidth
	local rootH = self._rootHeight

	if not rootW or not rootH or rootW <= 0 or rootH <= 0 or not self._gameModel then
		return nil
	end

	local cx, cy = self:_getScreenCenterInParent()
	local minX, maxX, minY, maxY = self._gameModel:getNodeBounds()
	local mapW = self._gameModel:getMapWidth()
	local mapH = self._gameModel:getMapHeight()

	minX = math.min(minX, -mapW * 0.5)
	maxX = math.max(maxX, mapW * 0.5)
	minY = math.min(minY, -mapH * 0.5)
	maxY = math.max(maxY, mapH * 0.5)

	local extra = MapClampExtra
	local aLowX = cx - rootW * 0.5 - extra - minX * scale
	local aHighX = cx + rootW * 0.5 + extra - maxX * scale
	local aLowY = cy - rootH * 0.5 - extra - minY * scale
	local aHighY = cy + rootH * 0.5 + extra - maxY * scale
	local bLowX = cx + rootW * 0.5 - extra - maxX * scale
	local bHighX = cx - rootW * 0.5 + extra - minX * scale
	local bLowY = cy + rootH * 0.5 - extra - maxY * scale
	local bHighY = cy - rootH * 0.5 + extra - minY * scale
	local lowX = math.min(aLowX, bLowX)
	local highX = math.max(aHighX, bHighX)
	local lowY = math.min(aLowY, bLowY)
	local highY = math.max(aHighY, bHighY)

	return lowX, highX, lowY, highY
end

function EvelynGameView:_clampMapPos(skipClamp)
	if not self._goMapRoot then
		return
	end

	local lowX, highX, lowY, highY = self:_calcClampRange(self._mapScale or MaxMapScale)

	if not lowX then
		return
	end

	local mapX, mapY = recthelper.getAnchor(self._goMapRoot.transform)
	local cx, cy = self:_getScreenCenterInParent()

	if not skipClamp then
		local clampX = highX < lowX and cx or Mathf.Clamp(mapX, lowX, highX)
		local clampY = highY < lowY and cy or Mathf.Clamp(mapY, lowY, highY)

		if clampX ~= mapX or clampY ~= mapY then
			recthelper.setAnchor(self._goMapRoot.transform, clampX, clampY)
		end
	end

	self:_syncMapBg()

	local finalX, finalY = recthelper.getAnchor(self._goMapRoot.transform)
	local scale = self._mapScale or MaxMapScale

	if finalX ~= self._lastLineMapX or finalY ~= self._lastLineMapY or scale ~= self._lastLineMapScale then
		self._lastLineMapX = finalX
		self._lastLineMapY = finalY
		self._lastLineMapScale = scale

		self:_refreshAllLineTransforms()

		if self._curDetailItem and not gohelper.isNil(self._curDetailItem.go) then
			self:_positionDetailPanel(self._curDetailItem)
		end
	end
end

function EvelynGameView:_calcMaxMapOffset(scale)
	if not self._gameModel then
		return 0, 0
	end

	local rootW = self._rootWidth or 0
	local rootH = self._rootHeight or 0

	if rootW <= 0 or rootH <= 0 then
		return 0, 0
	end

	local minX, maxX, minY, maxY = self._gameModel:getNodeBounds()
	local mapW = self._gameModel:getMapWidth()
	local mapH = self._gameModel:getMapHeight()

	minX = math.min(minX, -mapW * 0.5)
	maxX = math.max(maxX, mapW * 0.5)
	minY = math.min(minY, -mapH * 0.5)
	maxY = math.max(maxY, mapH * 0.5)

	local boundHalfW = math.max(math.abs(minX), math.abs(maxX)) * scale
	local boundHalfH = math.max(math.abs(minY), math.abs(maxY)) * scale
	local offsetX = math.max(0, boundHalfW - rootW * 0.5)
	local offsetY = math.max(0, boundHalfH - rootH * 0.5)

	return offsetX, offsetY
end

function EvelynGameView:_syncMapBg()
	if not self.goMapBg or gohelper.isNil(self.goMapBg) then
		return
	end

	local rootW = self._rootWidth
	local rootH = self._rootHeight
	local bgW = self._bgInitWidth
	local bgH = self._bgInitHeight

	if not rootW or not rootH or rootW <= 0 or rootH <= 0 then
		return
	end

	if not bgW or not bgH or bgW <= 0 or bgH <= 0 then
		return
	end

	local scale = self._mapScale or MaxMapScale
	local bgTrs = self.goMapBg.transform
	local minScale = self._minMapScale or MinMapScale
	local bgScale = 1 + (scale - minScale) * EvelynEnum.MapBgScaleValue

	if bgScale < 1 then
		bgScale = 1
	end

	bgTrs.localScale = Vector3(bgScale, bgScale, 1)

	local mapX, mapY = recthelper.getAnchor(self._goMapRoot.transform)
	local renderedW = bgW * bgScale
	local renderedH = bgH * bgScale
	local bgOffsetLimit = EvelynEnum.BgOffsetLimit or 0
	local maxOffsetX = math.max(0, (renderedW - rootW) * 0.5 - bgOffsetLimit)
	local maxOffsetY = math.max(0, (renderedH - rootH) * 0.5)
	local bgX, bgY

	if maxOffsetX <= 0.01 or maxOffsetY <= 0.01 then
		bgX = 0
		bgY = 0
	else
		bgX = mapX * EvelynEnum.MapBgMoveValue
		bgY = mapY * EvelynEnum.MapBgMoveValue
		bgX = Mathf.Clamp(bgX, -maxOffsetX, maxOffsetX)
		bgY = Mathf.Clamp(bgY, -maxOffsetY, maxOffsetY)
	end

	recthelper.setAnchor(bgTrs, bgX, bgY)
	logWarn(string.format("[Evelyn][MapBg] bgSize:(%.1f,%.1f) bgScale:%.3f rendered:(%.1f,%.1f) screen:(%.1f,%.1f) mapScale:%.3f mapPos:(%.1f,%.1f) bgPos:(%.1f,%.1f) maxOff:(%.1f,%.1f) range:[%.1f,%.1f]x[%.1f,%.1f]", bgW, bgH, bgScale, renderedW, renderedH, rootW, rootH, scale, mapX, mapY, bgX, bgY, maxOffsetX, maxOffsetY, -maxOffsetX, maxOffsetX, -maxOffsetY, maxOffsetY))
end

function EvelynGameView:_onUpdate()
	if self._gameModel and not self._stepPending and self._gameModel:hasNodeReadyToAppear() then
		self:_stepToolUnlock()
	end

	if self._introActive and self:_isIntroIdle() then
		self:_beginIntroZoom()
	end

	if UnityEngine.Input.GetKeyUp(UnityEngine.KeyCode.Escape) then
		if self._placeModeToolId then
			self:_cancelPlaceMode()
		elseif self._curDetailItem then
			self:_onCloseDetailClick()
		end
	end

	self:_updateLinkEdgeMove()
	self:_updateToolDragEdgeMove()
	self:_updateLinkTargetArrows()
	self:_updateLinkTargetDetails()
	self:_updateToolDragSlotArrows()

	if not self._isScrollWheelEnabled then
		return
	end

	if self:_isScaleOperationDisabled() then
		return
	end

	if self._scrollTools and self._scrollTools.gameObject.activeInHierarchy and UnityEngine.RectTransformUtility.RectangleContainsScreenPoint(self._scrollTools.transform, UnityEngine.Input.mousePosition, CameraMgr.instance:getUICamera()) then
		return
	end

	local scrollDelta = UnityEngine.Input.mouseScrollDelta

	if scrollDelta and scrollDelta.y ~= 0 then
		self:_setMapScale((self._mapScale or MaxMapScale) + scrollDelta.y * MapWheelScaleRate)
	end
end

function EvelynGameView:_btndownOnClick()
	if self:_isScaleOperationDisabled() then
		return
	end

	self:_setMapScale((self._mapScale or MaxMapScale) - MapScaleStep)
end

function EvelynGameView:_btnupOnClick()
	if self:_isScaleOperationDisabled() then
		return
	end

	self:_setMapScale((self._mapScale or MaxMapScale) + MapScaleStep)
end

function EvelynGameView:_onMapSliderValueChanged(param, value)
	if self:_isScaleOperationDisabled() then
		return
	end

	local minScale = self._minMapScale or MinMapScale

	self:_setMapScale(minScale + (MaxMapScale - minScale) * value)
end

function EvelynGameView:_getScreenCenterInParent()
	local parentTrs = self._goMapRoot and self._goMapRoot.transform.parent

	if not parentTrs then
		return 0, 0
	end

	return recthelper.screenPosToAnchorPos2(Vector2(UnityEngine.Screen.width * 0.5, UnityEngine.Screen.height * 0.5), parentTrs)
end

function EvelynGameView:_setMapScale(scale, skipClamp)
	if not self._goMap then
		return
	end

	local minScale = self._minMapScale or MinMapScale

	if scale < minScale then
		scale = minScale
	end

	if scale > MaxMapScale then
		scale = MaxMapScale
	end

	local oldScale = self._mapScale

	if oldScale and oldScale ~= scale then
		local mapX, mapY = recthelper.getAnchor(self._goMap.transform)
		local cx, cy = self:_getScreenCenterInParent()
		local ratio = scale / oldScale

		mapX = cx + (mapX - cx) * ratio
		mapY = cy + (mapY - cy) * ratio

		recthelper.setAnchor(self._goMap.transform, mapX, mapY)
	end

	self._mapScale = scale
	self._goMap.transform.localScale = Vector3(scale, scale, 1)

	self:_clampMapPos(skipClamp)

	if oldScale and oldScale ~= scale then
		local mapWorldPos = self._goMapRoot.transform.position

		if not self._rootGo then
			self._rootGo = gohelper.findChild(self.viewGO, "root")
		end

		if self._rootGo then
			local screenWorldPos = self._rootGo.transform.position
			local cx, cy = self:_getScreenCenterInParent()

			logWarn(string.format("[Evelyn][ScaleDebug] mapCenter:(%.3f,%.3f) screenCenter:(%.3f,%.3f) diff:(%.3f,%.3f) scaleAnchor:(%.3f,%.3f) scale:%.3f->%.3f", mapWorldPos.x, mapWorldPos.y, screenWorldPos.x, screenWorldPos.y, mapWorldPos.x - screenWorldPos.x, mapWorldPos.y - screenWorldPos.y, cx, cy, oldScale, scale))
		end
	end

	self:_syncMapBg()
	self:_refreshMapSlider(scale, minScale)
	self:_syncLinkDragSessionOnScaleChange(oldScale, scale)
	self:_syncToolDragSessionOnScaleChange()
end

function EvelynGameView:_onScaleControlDown()
	if self:_isScaleOperationDisabled() then
		return
	end

	AudioMgr.instance:trigger(AudioEnum.UI.UI_Common_Click)
end

function EvelynGameView:_refreshMapSlider(scale, minScale)
	if not self._mapSlider then
		return
	end

	if minScale >= MaxMapScale then
		self._mapSlider.slider:SetValueWithoutNotify(1)

		return
	end

	self._mapSlider.slider:SetValueWithoutNotify((scale - minScale) / (MaxMapScale - minScale))
end

function EvelynGameView:_refreshTargetText()
	local mapCo = self._gameModel and self._gameModel:getMapCo()

	if self._txtTarget and mapCo and not string.nilorempty(mapCo.desc) then
		self._txtTarget.text = mapCo.desc
	end
end

function EvelynGameView:onGuideStepStart(guideId, stepId)
	local tipKey = EvelynEnum.GuideTips[guideId] and EvelynEnum.GuideTips[guideId][stepId]

	if not tipKey or not self._txtTarget then
		return
	end

	self._txtTarget.text = luaLang(tipKey)
	self._guideTipActive = true
end

function EvelynGameView:onGuideStepFinish(guideId, stepId)
	if not self._guideTipActive then
		return
	end

	if not EvelynEnum.GuideTips[guideId] or not EvelynEnum.GuideTips[guideId][stepId] then
		return
	end

	self._guideTipActive = nil

	if not self._txtTarget then
		return
	end

	local mapCo = self._gameModel and self._gameModel:getMapCo()

	self._txtTarget.text = mapCo and mapCo.desc or ""
end

function EvelynGameView:_stepToolUnlock()
	if not self._gameModel then
		return
	end

	self._stepPending = nil

	local nextId = self._gameModel:getNextNodeReadyToAppear()

	if not nextId then
		if self._camReturnX then
			self:_moveCamQuickTo(self._camReturnX, self._camReturnY, false)

			self._camReturnX, self._camReturnY = nil
		end

		self:_clearStepDelay()

		return
	end

	if not self._introActive and not self:_isNodeInCamera(nextId) then
		local scale = self._mapScale or MaxMapScale
		local nx, ny = self._gameModel:getNodePos(nextId)
		local cx, cy = self:_getScreenCenterInParent()

		self:_moveCamQuickTo(cx - nx * scale, cy - ny * scale, true)
	end

	local expandedSnap = self:_snapshotToolExpanded()

	self._gameModel:tryShowNextNode()

	local newlyExpandedIds = self:_diffNewlyExpandedToolIds(expandedSnap)

	if #newlyExpandedIds > 0 then
		self:_schedulePointContainerHide(newlyExpandedIds)
	end

	self:_refreshToolsBar()
	self:_refreshMapVisual()

	if self._gameModel:hasNodeReadyToAppear() then
		self._stepPending = true

		TaskDispatcher.runDelay(self._stepToolUnlock, self, EvelynEnum.AnimTime.ToolStepInterval)
	else
		if self._camReturnX then
			self:_moveCamQuickTo(self._camReturnX, self._camReturnY, false)

			self._camReturnX, self._camReturnY = nil
		end

		self:_clearStepDelay()
	end

	if self._gameModel:isGameClear() then
		logWarn(string.format("[EvelynGame] _stepToolUnlock: GameClear detected after dequeue, gameId=%s", tostring(self.viewParam and self.viewParam.gameId)))
		self:_focusEndNode()
	end
end

function EvelynGameView:_clearStepDelay()
	self._stepPending = nil

	TaskDispatcher.cancelTask(self._stepToolUnlock, self)
end

function EvelynGameView:_clearCamMove()
	if self._camMoveTweenId then
		ZProj.TweenHelper.KillById(self._camMoveTweenId, false)

		self._camMoveTweenId = nil
	end

	TaskDispatcher.cancelTask(self._onCamSyncTick, self)
end

function EvelynGameView:_clearIntroZoom()
	if self._introTweenId or self._introScaleTweenId then
		local lp = self._goMapRoot and self._goMapRoot.transform.localPosition

		logWarn(string.format("[Evelyn][Intro] ZoomKilled phase:%s localPos:(%.1f,%.1f)", self._introTweenId and "2-move" or "1-zoom", lp and lp.x or 0, lp and lp.y or 0))
	end

	if self._introTweenId then
		ZProj.TweenHelper.KillById(self._introTweenId, false)

		self._introTweenId = nil
	end

	if self._introScaleTweenId then
		ZProj.TweenHelper.KillById(self._introScaleTweenId, false)

		self._introScaleTweenId = nil
	end

	TaskDispatcher.cancelTask(self._onIntroSyncTick, self)
	self:_releaseIntroLock()
end

function EvelynGameView:_acquireIntroLock()
	if self._introLocking then
		return
	end

	self._introLocking = true

	EvelynHelper.lockScreen(IntroLockKey, true)
end

function EvelynGameView:_releaseIntroLock()
	if not self._introLocking then
		return
	end

	self._introLocking = nil

	EvelynHelper.lockScreen(IntroLockKey, false)
end

function EvelynGameView:_startIntroSequence(waitAnimDuration)
	self._introActive = true
	self._introWaitUntil = ServerTime.now() + (waitAnimDuration or 0)

	if self._goMapRoot then
		local lp = self._goMapRoot.transform.localPosition

		logWarn(string.format("[Evelyn][Intro] SequenceStart waitAnim:%.2fs localPos:(%.1f,%.1f)", waitAnimDuration or 0, lp.x, lp.y))
	end
end

function EvelynGameView:_isIntroIdle()
	if not self._gameModel then
		return false
	end

	if self._introWaitUntil and ServerTime.now() < self._introWaitUntil then
		return false
	end

	if self._gameModel:hasNodeReadyToAppear() then
		return false
	end

	if self._stepPending then
		return false
	end

	if self._toolUsingToolId then
		return false
	end

	if self._camMoveTweenId then
		return false
	end

	if self._introTweenId or self._introScaleTweenId then
		return false
	end

	if self._gameClearFinishing or self._focusEndTweenId then
		return false
	end

	if self._linkDragSession or self._dragSession or self._placeModeToolId then
		return false
	end

	return true
end

function EvelynGameView:_onCamSyncTick()
	self:_clampMapPos()
end

function EvelynGameView:_onIntroSyncTick()
	self._mapScale = self._goMapRoot.transform.localScale.x

	self:_syncMapBg()
	self:_refreshAllLineTransforms()
	self:_refreshMapSlider(self._mapScale, self._minMapScale or MinMapScale)
end

function EvelynGameView:_beginIntroZoom()
	if not self._goMapRoot then
		return
	end

	local mapTrs = self._goMapRoot.transform
	local targetScale = self._introTargetScale or self._minMapScale or MinMapScale

	self:_clearIntroZoom()
	self:_clearCamMove()

	local fromScale = self._mapScale or mapTrs.localScale.x

	self:_acquireIntroLock()

	self._introScaleTweenId = ZProj.TweenHelper.DOTweenFloat(fromScale, targetScale, EvelynEnum.AnimTime.IntroZoomDuration, self._onIntroScaleFrame, self._onIntroScalePhaseDone, self, nil, EaseType.OutQuad)

	local lp1 = mapTrs.localPosition
	local ax1, ay1 = recthelper.getAnchor(mapTrs)

	logWarn(string.format("[Evelyn][Intro] Phase1ZoomBegin from:%.3f to:%.3f localPos:(%.1f,%.1f) anchor:(%.1f,%.1f)", fromScale, targetScale, lp1.x, lp1.y, ax1, ay1))
end

function EvelynGameView:_onIntroScaleFrame(scaleValue)
	self:_setMapScale(scaleValue, true)
end

function EvelynGameView:_onIntroScalePhaseDone()
	self._introScaleTweenId = nil

	if not self._goMapRoot then
		return
	end

	local mapTrs = self._goMapRoot.transform
	local targetScale = self._introTargetScale or self._minMapScale or MinMapScale
	local toX, toY = self:_calcResetAnchor(targetScale)

	if not toX then
		toX, toY = recthelper.getAnchor(mapTrs)
	end

	self._introTweenId = ZProj.TweenHelper.DOAnchorPos(mapTrs, toX, toY, EvelynEnum.AnimTime.IntroMoveDuration, self._onIntroZoomDone, self, nil, EaseType.OutQuad)

	TaskDispatcher.runRepeat(self._onIntroSyncTick, self, 0, -1)

	local lp2 = mapTrs.localPosition
	local ax2, ay2 = recthelper.getAnchor(mapTrs)
	local orgX, orgY

	if self._gameModel then
		orgX, orgY = self._gameModel:getMapOriginPos()
	end

	logWarn(string.format("[Evelyn][Intro] Phase2MoveBegin originPos:(%s,%s) to:(%.1f,%.1f) localPos:(%.1f,%.1f) anchor:(%.1f,%.1f) scale:%.3f", tostring(orgX), tostring(orgY), toX, toY, lp2.x, lp2.y, ax2, ay2, targetScale))
end

function EvelynGameView:_onIntroZoomDone()
	self._introTweenId = nil
	self._introScaleTweenId = nil
	self._introActive = nil
	self._introWaitUntil = nil

	TaskDispatcher.cancelTask(self._onIntroSyncTick, self)
	self:_releaseIntroLock()

	self._mapScale = self._introTargetScale or self._mapScale

	self:_clampMapPos(true)
	self:_refreshMapSlider(self._mapScale, self._minMapScale or MinMapScale)

	if self._goMapRoot then
		local lp = self._goMapRoot.transform.localPosition
		local ax, ay = recthelper.getAnchor(self._goMapRoot.transform)

		logWarn(string.format("[Evelyn][Intro] Done localPos:(%.1f,%.1f) anchor:(%.1f,%.1f) scale:%.3f", lp.x, lp.y, ax, ay, self._mapScale or 0))
	end
end

function EvelynGameView:_moveCamQuickTo(x, y, keepReturn)
	if not self._goMapRoot then
		return
	end

	self:_clearIntroZoom()

	if keepReturn and not self._camReturnX then
		self._camReturnX, self._camReturnY = recthelper.getAnchor(self._goMapRoot.transform)
	end

	local lowX, highX, lowY, highY = self:_calcClampRange(self._mapScale or MaxMapScale)

	if lowX then
		local cx, cy = self:_getScreenCenterInParent()

		x = highX < lowX and cx or Mathf.Clamp(x, lowX, highX)
		y = highY < lowY and cy or Mathf.Clamp(y, lowY, highY)
	end

	self:_clearCamMove()

	local mapTrs = self._goMapRoot.transform

	self._camMoveTweenId = ZProj.TweenHelper.DOAnchorPos(mapTrs, x, y, EvelynEnum.AnimTime.CamMoveDuration, self._onCamMoveDone, self, nil, EaseType.OutQuad)

	TaskDispatcher.runRepeat(self._onCamSyncTick, self, 0, -1)
end

function EvelynGameView:_onCamMoveDone()
	self._camMoveTweenId = nil

	TaskDispatcher.cancelTask(self._onCamSyncTick, self)
	self:_clampMapPos()
end

function EvelynGameView:_isNodeInCamera(nodeId)
	if not self._gameModel or not self._goMapRoot then
		return true
	end

	local scale = self._mapScale or MaxMapScale
	local mapX, mapY = recthelper.getAnchor(self._goMapRoot.transform)
	local nx, ny = self._gameModel:getNodePos(nodeId)
	local cx, cy = self:_getScreenCenterInParent()
	local sx, sy = mapX + nx * scale - cx, mapY + ny * scale - cy
	local halfW = (self._rootWidth or 1920) * 0.5 - 60
	local halfH = (self._rootHeight or 1080) * 0.5 - 60

	return sx >= -halfW and sx <= halfW and sy >= -halfH and sy <= halfH
end

return EvelynGameView
