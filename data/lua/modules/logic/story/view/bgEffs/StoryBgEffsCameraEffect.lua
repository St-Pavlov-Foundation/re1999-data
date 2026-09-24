-- chunkname: @modules/logic/story/view/bgEffs/StoryBgEffsCameraEffect.lua

module("modules.logic.story.view.bgEffs.StoryBgEffsCameraEffect", package.seeall)

local StoryBgEffsCameraEffect = class("StoryBgEffsCameraEffect", StoryBgEffsBase)
local UIBlockKey = "storyPostProcessEnding"

function StoryBgEffsCameraEffect:ctor()
	StoryBgEffsCameraEffect.super.ctor(self)
end

function StoryBgEffsCameraEffect:init(bgCo)
	StoryBgEffsCameraEffect.super.init(self, bgCo)

	self._effMo = StoryCameraEffectModel.instance:getStoryCameraEffectByType(bgCo.effDegree)

	local controllerName = self._effMo and self._effMo.controllerName

	if not string.nilorempty(controllerName) then
		self._cameraAnimPath = ResUrl.getStoryPostProcessAnim(controllerName)

		table.insert(self._resList, self._cameraAnimPath)
	end
end

function StoryBgEffsCameraEffect:onStartEffect()
	self:_setViewTop(true)
	ViewMgr.instance:registerCallback(ViewEvent.OnOpenView, self._onOpenView, self)
	ViewMgr.instance:registerCallback(ViewEvent.OnCloseViewFinish, self._onCloseView, self)
end

function StoryBgEffsCameraEffect:onLoadFinished()
	StoryBgEffsCameraEffect.super.onLoadFinished(self)

	self._effLoaded = true

	StoryTool.enablePostProcess(true)

	if not self._cameraAnimPath then
		return
	end

	local assetItem = self._loader:getAssetItem(self._cameraAnimPath)
	local anim = assetItem and assetItem:GetResource()

	if not anim then
		logError("后处理动画加载失败: " .. tostring(self._cameraAnimPath))

		return
	end

	self._played = StoryPostProcessAnimMgr.instance:play(self:_getTarget(), self, anim, {
		stateName = "start",
		autoRestore = self._effMo.autoRestore,
		keepRefresh = self._effMo.keepRefresh
	})
end

function StoryBgEffsCameraEffect:_getTarget()
	if self._effMo and self._effMo.target == 1 then
		return StoryPostProcessAnimMgr.Target.Scene
	end

	return StoryPostProcessAnimMgr.Target.UI
end

function StoryBgEffsCameraEffect:_onOpenView(viewName)
	local isSetTopView = StoryModel.instance:isSetTopView(viewName)

	if isSetTopView then
		self:_setViewTop(false)
	end
end

function StoryBgEffsCameraEffect:_onCloseView(viewName)
	local isSetTopView = StoryModel.instance:isSetTopView(viewName)

	if isSetTopView then
		self:_setViewTop(true)
	end
end

function StoryBgEffsCameraEffect:_setViewTop(set)
	local isDialogEff = self._effMo and self._effMo.dialogEff

	if not isDialogEff then
		if set then
			StoryViewMgr.instance:setStoryViewLayer(UnityLayer.UITop)
			StoryViewMgr.instance:setStoryLeadRoleSpineViewLayer(UnityLayer.UITop)
		else
			StoryViewMgr.instance:setStoryViewLayer(UnityLayer.UISecond)
			StoryViewMgr.instance:setStoryLeadRoleSpineViewLayer(UnityLayer.UIThird)
		end
	end

	local isHeroEff = self._effMo and self._effMo.heroEff

	if not isHeroEff then
		if set then
			StoryViewMgr.instance:setStoryHeroViewLayer(UnityLayer.UIThird)
		else
			StoryViewMgr.instance:setStoryHeroViewLayer(UnityLayer.UISecond)
		end
	end
end

function StoryBgEffsCameraEffect:reset(bgCo)
	StoryBgEffsCameraEffect.super.reset(self, bgCo)
	self:_setViewTop(true)

	if bgCo.effDegree > 0 then
		return
	end

	if not self._played then
		return
	end

	local playing = StoryPostProcessAnimMgr.instance:playState(self, "end")

	UIBlockMgr.instance:startBlock(UIBlockKey)

	local endTime = playing and (self._effMo and self._effMo.endTime or 1) or 0

	TaskDispatcher.runDelay(self._onEffFinished, self, endTime)
end

function StoryBgEffsCameraEffect:_onEffFinished()
	UIBlockMgr.instance:endBlock(UIBlockKey)
	self:_stopAnim()
	self:callFinished()
end

function StoryBgEffsCameraEffect:_stopAnim()
	if not self._played then
		return
	end

	self._played = false

	StoryPostProcessAnimMgr.instance:stop(self)
	StoryTool.enablePostProcess(true)
end

function StoryBgEffsCameraEffect:destroy()
	self:_setViewTop(false)
	ViewMgr.instance:unregisterCallback(ViewEvent.OnOpenView, self._onOpenView, self)
	ViewMgr.instance:unregisterCallback(ViewEvent.OnCloseViewFinish, self._onCloseView, self)
	TaskDispatcher.cancelTask(self._onEffFinished, self)
	UIBlockMgr.instance:endBlock(UIBlockKey)
	self:_stopAnim()
	StoryBgEffsCameraEffect.super.destroy(self)
end

return StoryBgEffsCameraEffect
