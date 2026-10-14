-- chunkname: @modules/logic/story/view/bgEffs/StoryBgEffsEagleEye.lua

module("modules.logic.story.view.bgEffs.StoryBgEffsEagleEye", package.seeall)

local StoryBgEffsEagleEye = class("StoryBgEffsEagleEye", StoryBgEffsBase)

function StoryBgEffsEagleEye:ctor()
	StoryBgEffsEagleEye.super.ctor(self)
end

function StoryBgEffsEagleEye:init(bgCo)
	StoryBgEffsEagleEye.super.init(self, bgCo)

	self._eagleEyePrefabPath = "ui/viewres/story/bg/storybg_radialblur.prefab"

	table.insert(self._resList, self._eagleEyePrefabPath)

	self._effInTime = 0.5
	self._effKeepTime = bgCo.effTimes[GameLanguageMgr.instance:getVoiceTypeStoryIndex()]
	self._effLoaded = false
end

function StoryBgEffsEagleEye:onStartEffect()
	ViewMgr.instance:registerCallback(ViewEvent.OnOpenView, self._onOpenView, self)
	ViewMgr.instance:registerCallback(ViewEvent.OnCloseView, self._onCloseView, self)
end

function StoryBgEffsEagleEye:_onOpenView(viewName)
	local isSetTopView = StoryModel.instance:isSetTopView(viewName)

	if isSetTopView then
		self:_setViewTop(false)
	end
end

function StoryBgEffsEagleEye:_onCloseView(viewName)
	local isSetTopView = StoryModel.instance:isSetTopView(viewName)

	if isSetTopView then
		self:_setViewTop(true)
	end
end

function StoryBgEffsEagleEye:_setViewTop(set)
	if set then
		StoryViewMgr.instance:setStoryViewLayer(UnityLayer.UITop)
		StoryViewMgr.instance:setStoryLeadRoleSpineViewLayer(UnityLayer.UITop)
	else
		StoryViewMgr.instance:setStoryViewLayer(UnityLayer.UISecond)
		StoryViewMgr.instance:setStoryLeadRoleSpineViewLayer(UnityLayer.UIThird)
	end
end

function StoryBgEffsEagleEye:onLoadFinished()
	StoryBgEffsEagleEye.super.onLoadFinished(self)

	self._effLoaded = true

	self:playEffect()
end

function StoryBgEffsEagleEye:reset(bgCo)
	StoryBgEffsEagleEye.super.reset(self, bgCo)
	self:playEffect()
end

function StoryBgEffsEagleEye:playEffect()
	if not self._effLoaded then
		return
	end

	if not self._eagleEyeGo then
		local prefAssetItem = self._loader:getAssetItem(self._eagleEyePrefabPath)
		local parentGO = StoryViewMgr.instance:getStoryView()

		self._eagleEyeGo = gohelper.clone(prefAssetItem:GetResource(), parentGO)
		self._img = self._eagleEyeGo:GetComponent(gohelper.Type_Image)
		self._mat = self._img.material

		gohelper.setAsFirstSibling(self._eagleEyeGo)

		self.anim = gohelper.findComponentAnim(self._eagleEyeGo)
	end

	local blitEff = StoryViewMgr.instance:getStoryBlitEff()

	self._mat:SetTexture("_MainTex", blitEff.capturedTexture)
	StoryTool.enablePostProcess(true)
	self:_setViewTop(true)
	self.anim:Play("start", 0, 0)
	TaskDispatcher.runDelay(self.onEffKeepFinished, self, self._effInTime + self._effKeepTime)
end

function StoryBgEffsEagleEye:onEffKeepFinished()
	self.anim:Play("end", 0, 0)
	TaskDispatcher.runDelay(self.onEffOutFinished, self, self._effOutTime)
end

function StoryBgEffsEagleEye:onEffOutFinished()
	StoryBgEffsEagleEye.super.onEffOutFinished(self)
	self:callFinished()
end

function StoryBgEffsEagleEye:_clearEffs()
	self:_setViewTop(false)

	if self._eagleEyeGo then
		gohelper.destroy(self._eagleEyeGo)

		self._eagleEyeGo = nil
	end
end

function StoryBgEffsEagleEye:destroy()
	ViewMgr.instance:unregisterCallback(ViewEvent.OnOpenView, self._onOpenView, self)
	ViewMgr.instance:unregisterCallback(ViewEvent.OnCloseView, self._onCloseView, self)
	StoryBgEffsEagleEye.super.destroy(self)
	TaskDispatcher.cancelTask(self.onEffKeepFinished, self)
	TaskDispatcher.cancelTask(self.onEffOutFinished, self)
	self:_clearEffs()
end

return StoryBgEffsEagleEye
