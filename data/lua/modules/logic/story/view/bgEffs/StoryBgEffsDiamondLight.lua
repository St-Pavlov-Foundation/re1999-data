-- chunkname: @modules/logic/story/view/bgEffs/StoryBgEffsDiamondLight.lua

module("modules.logic.story.view.bgEffs.StoryBgEffsDiamondLight", package.seeall)

local StoryBgEffsDiamondLight = class("StoryBgEffsDiamondLight", StoryBgEffsBase)

function StoryBgEffsDiamondLight:ctor()
	StoryBgEffsDiamondLight.super.ctor(self)
end

function StoryBgEffsDiamondLight:init(bgCo)
	StoryBgEffsDiamondLight.super.init(self, bgCo)

	self._cameraAnimPath = "ui/animations/dynamic/v3a2_kongjianzheshe.controller"
	self._effPrefPath = "ui/viewres/story/bg/v3a2_zuanshiguangban.prefab"

	table.insert(self._resList, self._cameraAnimPath)
	table.insert(self._resList, self._effPrefPath)

	self._effLoaded = false
end

function StoryBgEffsDiamondLight:start(callback, callbackObj)
	StoryBgEffsDiamondLight.super.start(self)
	self:_setViewTop(true)
	ViewMgr.instance:registerCallback(ViewEvent.OnOpenView, self._onOpenView, self)
	ViewMgr.instance:registerCallback(ViewEvent.OnCloseView, self._onCloseView, self)
	self:loadRes()
end

function StoryBgEffsDiamondLight:onLoadFinished()
	StoryBgEffsDiamondLight.super.onLoadFinished(self)

	self._effLoaded = true

	StoryTool.enablePostProcess(true)

	local bgFrontGo = StoryViewMgr.instance:getStoryFrontBgGo()
	local prefAssetItem = self._loader:getAssetItem(self._effPrefPath)

	self._diamondlightGo = gohelper.clone(prefAssetItem:GetResource(), bgFrontGo)
	self._diamondlightAnim = self._diamondlightGo:GetComponent(typeof(UnityEngine.Animator))

	self._diamondlightAnim:Play("start", 0, 0)
	self._diamondlightAnim:SetBool("isEnd", false)
end

function StoryBgEffsDiamondLight:reset(bgCo)
	StoryBgEffsDiamondLight.super.reset(self, bgCo)

	if bgCo.effDegree == 0 then
		StoryTool.enablePostProcess(true)
		self:_setViewTop(true)

		return
	end

	if not self._effLoaded then
		return
	end

	if self._diamondlightAnim then
		self._diamondlightAnim:SetBool("isEnd", true)
	end
end

function StoryBgEffsDiamondLight:_onOpenView(viewName)
	local setting = ViewMgr.instance:getSetting(viewName)

	if setting.layer == UILayerName.Message or setting.layer == UILayerName.IDCanvasPopUp then
		self:_setViewTop(false)
	end
end

function StoryBgEffsDiamondLight:_onCloseView(viewName)
	local setting = ViewMgr.instance:getSetting(viewName)

	if setting.layer == UILayerName.Message or setting.layer == UILayerName.IDCanvasPopUp then
		self:_setViewTop(true)
	end
end

function StoryBgEffsDiamondLight:_setViewTop(set)
	if set then
		StoryViewMgr.instance:setStoryViewLayer(UnityLayer.UITop)
		StoryViewMgr.instance:setStoryLeadRoleSpineViewLayer(UnityLayer.UITop)
	else
		StoryViewMgr.instance:setStoryViewLayer(UnityLayer.UISecond)
		StoryViewMgr.instance:setStoryLeadRoleSpineViewLayer(UnityLayer.UIThird)
	end
end

function StoryBgEffsDiamondLight:destroy()
	StoryBgEffsDiamondLight.super.destroy(self)
	ViewMgr.instance:unregisterCallback(ViewEvent.OnOpenView, self._onOpenView, self)
	ViewMgr.instance:unregisterCallback(ViewEvent.OnCloseView, self._onCloseView, self)

	if self._diamondlightGo then
		gohelper.destroy(self._diamondlightGo)

		self._diamondlightGo = nil
	end
end

return StoryBgEffsDiamondLight
