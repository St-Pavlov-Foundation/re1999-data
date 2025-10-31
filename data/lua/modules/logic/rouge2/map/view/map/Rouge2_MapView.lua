-- chunkname: @modules/logic/rouge2/map/view/map/Rouge2_MapView.lua

module("modules.logic.rouge2.map.view.map.Rouge2_MapView", package.seeall)

local Rouge2_MapView = class("Rouge2_MapView", BaseView)

function Rouge2_MapView:onInitView()
	self._txtTitleName = gohelper.findChildText(self.viewGO, "Top/#txt_TitleName")
	self._goNormalAttribute = gohelper.findChild(self.viewGO, "Left/#go_Attribute_Normal")
	self._goPathSelectAttribute = gohelper.findChild(self.viewGO, "Left/#go_Attribute_PathSelect")
	self._goMask = gohelper.findChild(self.viewGO, "#go_Mask")
	self._goFocusPos = gohelper.findChild(self.viewGO, "#go_focusposition")
	self.goswitchmapanim = gohelper.findChild(self.viewGO, "#go_excessive")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function Rouge2_MapView:addEvents()
	self:addEventCb(Rouge2_MapController.instance, Rouge2_MapEvent.OnPopGuideView, self._onPopGuideView, self)
end

function Rouge2_MapView:removeEvents()
	return
end

function Rouge2_MapView:_editableInitView()
	self.viewRectTr = self.viewGO:GetComponent(gohelper.Type_RectTransform)

	local screenPosX = recthelper.uiPosToScreenPos2(self._goFocusPos.transform)

	Rouge2_MapModel.instance:setFocusScreenPosX(screenPosX)

	self.animator = self.viewGO:GetComponent(gohelper.Type_Animator)
	self.openRightView = false

	gohelper.setActive(self.goswitchmapanim, false)
	self:addEventCb(Rouge2_MapController.instance, Rouge2_MapEvent.onBeforeChangeMapInfo, self.onBeforeChangeMapInfo, self)
	self:addEventCb(Rouge2_MapController.instance, Rouge2_MapEvent.onChangeMapInfo, self.onChangeMapInfo, self)
	self:addEventCb(Rouge2_MapController.instance, Rouge2_MapEvent.onCreateMapDoneFlowDone, self.onCreateMapDoneFlowDone, self)
	self:addEventCb(ViewMgr.instance, ViewEvent.OnOpenView, self.onOpenView, self)
	self:addEventCb(ViewMgr.instance, ViewEvent.OnCloseView, self.onCloseView, self)
	self:addEventCb(ViewMgr.instance, ViewEvent.OnCloseViewFinish, self.onCloseViewFinish, self)
	self:addEventCb(Rouge2_MapController.instance, Rouge2_MapEvent.onUpdateBagInfo, self.onUpdateBagInfo, self)
	self:addEventCb(Rouge2_MapController.instance, Rouge2_MapEvent.onPopViewDone, self.onPopViewDone, self)
	self:addEventCb(Rouge2_MapController.instance, Rouge2_MapEvent.onClearInteract, self.onClearInteract, self)
	NavigateMgr.instance:addEscape(self.viewName, Rouge2_MapHelper.backToMainScene, nil)
	Rouge2_AttributeToolBar.Load(self._goNormalAttribute, Rouge2_Enum.AttributeToolType.Enter_Attr_Detail)
	Rouge2_AttributeToolBar.Load(self._goPathSelectAttribute, Rouge2_Enum.AttributeToolType.Enter)
end

function Rouge2_MapView:_initNeedPlayOpenAnimView()
	if self.needPlayOpenAnimViewDict then
		return
	end

	self.needPlayOpenAnimViewDict = {
		[ViewName.Rouge2_MapChoiceView] = true,
		[ViewName.Rouge2_MapExploreChoiceView] = true,
		[ViewName.Rouge2_MapPieceChoiceView] = true
	}
end

function Rouge2_MapView:onOpenView(viewName)
	self:_initNeedPlayOpenAnimView()

	if self.needPlayOpenAnimViewDict[viewName] then
		self.animator:Play("close", 0, 0)
	end
end

function Rouge2_MapView:onCloseView(viewName)
	self:_initNeedPlayOpenAnimView()

	if self.needPlayOpenAnimViewDict[viewName] then
		self.animator:Play("open", 0, 0)
	end

	self:tryTriggerActiveSkillGuide()
end

function Rouge2_MapView:onBeforeChangeMapInfo()
	if Rouge2_MapModel.instance:isNormalLayer() then
		gohelper.setActive(self.goswitchmapanim, false)

		return
	end

	gohelper.setActive(self.goswitchmapanim, true)
	TaskDispatcher.runDelay(self.onAnimDone, self, Rouge2_MapEnum.SwitchMapAnimDuration)
end

function Rouge2_MapView:onCreateMapDoneFlowDone()
	self:playNormalLayerAudio()
end

function Rouge2_MapView:onChangeMapInfo()
	self._txtTitleName.text = Rouge2_MapModel.instance:getMapName()

	self:refreshAttrTool()
end

function Rouge2_MapView:onAnimDone()
	gohelper.setActive(self.goswitchmapanim, false)
end

function Rouge2_MapView:onOpen()
	self._txtTitleName.text = Rouge2_MapModel.instance:getMapName()

	self:refreshAttrTool()
	Rouge2_MapController.instance:dispatchEvent(Rouge2_MapEvent.onFocusNormalLayerActor)
end

function Rouge2_MapView:onOpenFinish()
	self:tryTriggerActiveSkillGuide()
end

function Rouge2_MapView:playNormalLayerAudio()
	if Rouge2_MapModel.instance:isNormalLayer() then
		AudioMgr.instance:trigger(AudioEnum.UI.LineExpanded)
	end
end

function Rouge2_MapView:refreshAttrTool()
	local isPathSelect = Rouge2_MapModel.instance:isPathSelect()

	gohelper.setActive(self._goNormalAttribute, not isPathSelect)
	gohelper.setActive(self._goPathSelectAttribute, isPathSelect)
end

function Rouge2_MapView:_onPopGuideView(techniqueId)
	Rouge2_Controller.instance:openTechniqueView(tonumber(techniqueId))
end

function Rouge2_MapView:checkCanTriggerGuide()
	local isTop = Rouge2_MapHelper.checkMapViewOnTop()

	if not isTop then
		return
	end

	local isInteract = Rouge2_MapModel.instance:isInteractiving()

	if isInteract then
		return
	end

	local isPop = Rouge2_PopController.instance:isPopping()

	if isPop then
		return
	end

	return true
end

function Rouge2_MapView:tryTriggerActiveSkillGuide()
	local isGuideFinish = GuideModel.instance:isGuideFinish(32057)

	if isGuideFinish then
		return
	end

	local hasAnyNotUseSkill = Rouge2_BackpackModel.instance:hasAnyNotUseActiveSkill()

	if not hasAnyNotUseSkill then
		return
	end

	if not self:checkCanTriggerGuide() then
		return
	end

	Rouge2_MapController.instance:dispatchEvent(Rouge2_MapEvent.OnGuideGetActiveSkill)

	return true
end

function Rouge2_MapView:tryTriggerBXSBoxGuide()
	local isGuideFinish = GuideModel.instance:isGuideFinish(32059)

	if isGuideFinish or not Rouge2_Model.instance:isUseBXSCareer() then
		return
	end

	if not self:checkCanTriggerGuide() then
		return
	end

	Rouge2_MapController.instance:dispatchEvent(Rouge2_MapEvent.OnGuideBXSBox)

	return true
end

function Rouge2_MapView:tryTriggerMapGuides()
	local activeSkillGuide = self:tryTriggerActiveSkillGuide()

	if activeSkillGuide then
		return
	end

	self:tryTriggerBXSBoxGuide()
end

function Rouge2_MapView:onPopViewDone()
	self:tryTriggerMapGuides()
end

function Rouge2_MapView:onClearInteract()
	self:tryTriggerMapGuides()
end

function Rouge2_MapView:onCloseViewFinish()
	self:tryTriggerMapGuides()
end

function Rouge2_MapView:onUpdateBagInfo()
	self:tryTriggerMapGuides()
end

function Rouge2_MapView:onClose()
	TaskDispatcher.cancelTask(self.onAnimDone, self)
end

function Rouge2_MapView:onDestroyView()
	return
end

return Rouge2_MapView
