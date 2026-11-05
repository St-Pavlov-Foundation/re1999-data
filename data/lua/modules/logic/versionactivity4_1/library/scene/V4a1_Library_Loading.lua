-- chunkname: @modules/logic/versionactivity4_1/library/scene/V4a1_Library_Loading.lua

module("modules.logic.versionactivity4_1.library.scene.V4a1_Library_Loading", package.seeall)

local V4a1_Library_Loading = class("V4a1_Library_Loading", BaseView)

function V4a1_Library_Loading:onInitView()
	if self._editableInitView then
		self:_editableInitView()
	end
end

function V4a1_Library_Loading:addEvents()
	return
end

function V4a1_Library_Loading:removeEvents()
	return
end

local CSAnimatorPlayer = SLFramework.AnimatorPlayer
local kDurationOpenAnim = 1
local kDelayCloseViewSec = 0.5

function V4a1_Library_Loading:_editableInitView()
	self:addEventCb(GameSceneMgr.instance, SceneEventName.DelayCloseLoading, self._onDelayCloseLoading, self)
end

local kBlock_Click = "V4a1_Library_Loading:onOpen"
local kTimeout = 9.99

function V4a1_Library_Loading:onUpdateParam()
	GameGCMgr.instance:dispatchEvent(GameGCEvent.SetBanGc, self.viewName, false)
	UIBlockMgrExtend.setNeedCircleMv(false)
	UIBlockHelper.instance:startBlock(kBlock_Click, kTimeout, self.viewName)
end

function V4a1_Library_Loading:onOpen()
	kDurationOpenAnim = math.max(kDurationOpenAnim, 0.01)

	TaskDispatcher.runDelay(self._onOpenAnimDone, self, kDurationOpenAnim)
	self:onUpdateParam()
end

function V4a1_Library_Loading:_onOpenAnimDone()
	GameSceneMgr.instance:dispatchEvent(SceneEventName.LoadingAnimEnd)
end

function V4a1_Library_Loading:_onDelayCloseLoading()
	if kDelayCloseViewSec > 0 then
		TaskDispatcher.runDelay(self.closeThis, self, kDelayCloseViewSec)
	else
		self:closeThis()
	end
end

function V4a1_Library_Loading:onClose()
	TaskDispatcher.cancelTask(self._onOpenAnimDone, self)
	TaskDispatcher.cancelTask(self.closeThis, self)
	UIBlockHelper.instance:endBlock(kBlock_Click)
end

function V4a1_Library_Loading:onDestroyView()
	TaskDispatcher.cancelTask(self._onOpenAnimDone, self)
	TaskDispatcher.cancelTask(self.closeThis, self)
	GameGCMgr.instance:dispatchEvent(GameGCEvent.SetBanGc, self.viewName, true)
	UIBlockMgrExtend.setNeedCircleMv(true)
end

return V4a1_Library_Loading
