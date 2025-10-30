﻿-- chunkname: @modules/logic/mainuiswitch/view/MainUISwitchInfoBlurMaskView.lua

module("modules.logic.mainuiswitch.view.MainUISwitchInfoBlurMaskView", package.seeall)

local MainUISwitchInfoBlurMaskView = class("MainUISwitchInfoBlurMaskView", BaseView)

function MainUISwitchInfoBlurMaskView:onInitView()
	self._root = gohelper.findChild(self.viewGO, "root")
	self._gorawImage = gohelper.findChild(self._root, "RawImage")
	self._rawImage = gohelper.onceAddComponent(self._gorawImage, gohelper.Type_RawImage)

	if self._editableInitView then
		self:_editableInitView()
	end
end

function MainUISwitchInfoBlurMaskView:addEvents()
	self:addEventCb(ViewMgr.instance, ViewEvent.OnCloseView, self._onCloseView, self)
	self:addEventCb(MainUISwitchController.instance, MainUISwitchEvent.PreviewSwitchUIVisible, self._onSwitchUIVisible, self)
end

function MainUISwitchInfoBlurMaskView:removeEvents()
	self:removeEventCb(ViewMgr.instance, ViewEvent.OnCloseView, self._onCloseView, self)
	self:removeEventCb(MainUISwitchController.instance, MainUISwitchEvent.PreviewSwitchUIVisible, self._onSwitchUIVisible, self)
end

local MainUISwitchInfoViewName = ViewName.MainUISwitchInfoView

function MainUISwitchInfoBlurMaskView:_editableInitView()
	return
end

function MainUISwitchInfoBlurMaskView:_onSwitchUIVisible(visible)
	if visible then
		gohelper.addChildPosStay(self.viewGO, self._root)
	elseif ViewMgr.instance:isOpen(MainUISwitchInfoViewName) then
		local contains = ViewMgr.instance:getContainer(MainUISwitchInfoViewName)

		if contains and contains.viewGO then
			gohelper.addChildPosStay(contains.viewGO, self._root)
			self._root.transform:SetAsFirstSibling()
		end
	end
end

function MainUISwitchInfoBlurMaskView:_onCloseView(viewName)
	if viewName == MainUISwitchInfoViewName then
		self:closeThis()
	end
end

function MainUISwitchInfoBlurMaskView:onOpen()
	local sceneId = self.viewParam and self.viewParam.sceneId or MainSceneSwitchModel.instance:getCurSceneId()

	gohelper.setActive(self._gorawImage, false)
	self:_onShowSceneInfo(sceneId)
end

function MainUISwitchInfoBlurMaskView:_onShowSceneInfo(id)
	self._sceneId = id

	MainSceneSwitchCameraController.instance:showScene(id, self._showSceneFinished, self)
end

function MainUISwitchInfoBlurMaskView:_showSceneFinished(rt)
	gohelper.setActive(self._gorawImage, true)
	MainSceneSwitchInfoDisplayView.adjustRt(self._rawImage, rt)
	ViewMgr.instance:openView(MainUISwitchInfoViewName, self.viewParam)
end

function MainUISwitchInfoBlurMaskView.adjustRt(rawImage, rt)
	rawImage.texture = rt

	rawImage:SetNativeSize()

	local width = rt.width
	local root = ViewMgr.instance:getUIRoot().transform
	local containerWidth = recthelper.getWidth(root)
	local scale = containerWidth / width

	transformhelper.setLocalScale(rawImage.transform, scale, scale, 1)
end

function MainUISwitchInfoBlurMaskView:onDestroyView()
	MainSceneSwitchCameraController.instance:clear()
end

return MainUISwitchInfoBlurMaskView
