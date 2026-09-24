-- chunkname: @modules/logic/story/view/bgTrans/StoryBgTransBloom.lua

module("modules.logic.story.view.bgTrans.StoryBgTransBloom", package.seeall)

local StoryBgTransBloom = class("StoryBgTransBloom", StoryBgTransBase)

function StoryBgTransBloom:ctor()
	StoryBgTransBloom.super.ctor(self)
end

local baseTime = 0.25
local defaultController = "story_bloomchange"

function StoryBgTransBloom:init()
	StoryBgTransBloom.super.init(self)
	self:setBgTransType(StoryEnum.BgTransType.Bloom1)
end

function StoryBgTransBloom:setBgTransType(type)
	self._transType = type
	self._transMo = StoryBgEffectTransModel.instance:getStoryBgEffectTransByType(self._transType)

	local controller = self._transMo and self._transMo.ppController

	if string.nilorempty(controller) then
		controller = defaultController
	end

	self._bloomAnimPath = ResUrl.getStoryPostProcessAnim(controller)
	self._resList = {
		self._bloomAnimPath
	}
end

function StoryBgTransBloom:start(callback, callbackObj)
	StoryBgTransBloom.super.start(self)

	self._finishedCallback = callback
	self._finishedCallbackObj = callbackObj

	self:loadRes()
	GameUtil.setActiveUIBlock("bgTrans", true, false)
end

function StoryBgTransBloom:onLoadFinished()
	StoryBgTransBloom.super.onLoadFinished(self)
	StoryTool.enablePostProcess(true)

	local assetItem = self._loader:getAssetItem(self._bloomAnimPath)
	local anim = assetItem and assetItem:GetResource()

	if anim then
		StoryPostProcessAnimMgr.instance:play(StoryPostProcessAnimMgr.Target.UI, self, anim, {
			stateName = "trans",
			speed = self._transMo.transTime > 0.01 and baseTime / self._transMo.transTime or 1
		})
	else
		logError("bloom 转场后处理动画加载失败: " .. tostring(self._bloomAnimPath))
	end

	TaskDispatcher.runDelay(self.onSwitchBg, self, self._transMo.transTime)
end

function StoryBgTransBloom:onSwitchBg()
	StoryBgTransBloom.super.onSwitchBg(self)
	TaskDispatcher.runDelay(self.onTransFinished, self, self._transMo.transTime)
end

function StoryBgTransBloom:onTransFinished()
	StoryBgTransBloom.super.onTransFinished(self)

	if self._finishedCallback then
		self._finishedCallback(self._finishedCallbackObj)
	end

	self:_clearTrans()
end

function StoryBgTransBloom:_clearTrans()
	GameUtil.setActiveUIBlock("bgTrans", false, false)
	StoryPostProcessAnimMgr.instance:stop(self)

	self._finishedCallback = nil
	self._finishedCallbackObj = nil
end

function StoryBgTransBloom:destroy()
	StoryBgTransBloom.super.destroy(self)
	TaskDispatcher.cancelTask(self.onSwitchBg, self)
	TaskDispatcher.cancelTask(self.onTransFinished, self)
	self:_clearTrans()
end

return StoryBgTransBloom
