﻿-- chunkname: @modules/logic/versionactivity2_7/warmup/view/V2a7_WarmUpLeftView.lua

module("modules.logic.versionactivity2_7.warmup.view.V2a7_WarmUpLeftView", package.seeall)

local V2a7_WarmUpLeftView = class("V2a7_WarmUpLeftView", BaseView)

function V2a7_WarmUpLeftView:onInitView()
	if self._editableInitView then
		self:_editableInitView()
	end
end

function V2a7_WarmUpLeftView:addEvents()
	self._itemClick:AddClickListener(self._onItemClick, self)
end

function V2a7_WarmUpLeftView:removeEvents()
	self._itemClick:RemoveClickListener()
end

local kFirstLocked = -1
local kFirstUnlocked = 0
local kHasDragged = 1
local csAnimatorPlayer = SLFramework.AnimatorPlayer
local States = {
	Clicked = 1
}
local kCount = 5

function V2a7_WarmUpLeftView:ctor()
	self._draggedState = kFirstLocked
end

function V2a7_WarmUpLeftView:_editableInitView()
	self._middleGo = gohelper.findChild(self.viewGO, "Middle")
	self._openGo = gohelper.findChild(self._middleGo, "open")
	self._unopenGo = gohelper.findChild(self._middleGo, "unopen")
	self._godrag = gohelper.findChild(self._unopenGo, "drag")
	self._guideGo = gohelper.findChild(self._unopenGo, "guide")
	self._simagepic = gohelper.findChildSingleImage(self._openGo, "#simage_pic")
	self._animatorPlayer = csAnimatorPlayer.Get(self._middleGo)
	self._animtor = self._animatorPlayer.animator
	self._animEvent = gohelper.onceAddComponent(self._middleGo, gohelper.Type_AnimationEventWrap)
	self._itemClick = gohelper.getClickWithAudio(self._godrag)

	self:_setActive_drag(true)
end

function V2a7_WarmUpLeftView:onOpen()
	self._animEvent:AddEventListener("play_ui_yuzhou_fax_earcap", self._play_ui_yuzhou_fax_earcap, self)
	self._animEvent:AddEventListener("play_ui_min_day_night", self._play_ui_min_day_night, self)
	self._animEvent:AddEventListener("play_ui_yuzhou_fax_beep", self._play_ui_yuzhou_fax_beep, self)
	self._animEvent:AddEventListener("play_ui_yuzhou_fax_print", self._play_ui_yuzhou_fax_print, self)
end

function V2a7_WarmUpLeftView:onDataUpdateFirst()
	if isDebugBuild then
		assert(self.viewContainer:getEpisodeCount() <= kCount, "invalid config json_activity125 actId: " .. self.viewContainer:actId())
	end

	local isDone = self:_checkIsDone()

	self._draggedState = isDone and kFirstUnlocked or kFirstLocked
end

function V2a7_WarmUpLeftView:onDataUpdate()
	self:_refresh()
end

function V2a7_WarmUpLeftView:onSwitchEpisode()
	local isDone = self:_checkIsDone()

	if self._draggedState == kFirstUnlocked and not isDone then
		self._draggedState = kFirstLocked - 1
	elseif self._draggedState < kFirstLocked and isDone then
		self._draggedState = kFirstUnlocked
	end

	self:_refresh()
end

function V2a7_WarmUpLeftView:_episodeId()
	return self.viewContainer:getCurSelectedEpisode()
end

function V2a7_WarmUpLeftView:_episode2Index(episodeId)
	return self.viewContainer:episode2Index(episodeId or self:_episodeId())
end

function V2a7_WarmUpLeftView:_checkIsDone(episodeId)
	return self.viewContainer:checkIsDone(episodeId or self:_episodeId())
end

function V2a7_WarmUpLeftView:_saveStateDone(isDone, episodeId)
	self.viewContainer:saveStateDone(episodeId or self:_episodeId(), isDone)
end

function V2a7_WarmUpLeftView:_saveState(value, episodeId)
	assert(value ~= 1999, "please call _saveStateDone instead")
	self.viewContainer:saveState(episodeId or self:_episodeId(), value)
end

function V2a7_WarmUpLeftView:_getState(defaultValue, episodeId)
	return self.viewContainer:getState(episodeId or self:_episodeId(), defaultValue)
end

function V2a7_WarmUpLeftView:_setActive_drag(isActive)
	gohelper.setActive(self._godrag, isActive)
end

function V2a7_WarmUpLeftView:_setActive_guide(isActive)
	gohelper.setActive(self._guideGo, isActive)
end

function V2a7_WarmUpLeftView:_refresh()
	local isDone = self:_checkIsDone()
	local resUrl = self.viewContainer:getImgResUrl(self:_episode2Index())

	self._simagepic:LoadImage(resUrl)

	if isDone then
		self:_setActive_guide(false)
		self:_setActive_drag(false)
		self:_playAnimOpend()
	else
		local state = self:_getState()

		if state == 0 then
			self:_setActive_guide(self._draggedState <= kFirstLocked)
			self:_setActive_drag(true)
			self:_playAnimIdle()
		elseif States.Clicked == state then
			self:_setActive_guide(false)
			self:_setActive_drag(false)
			self:_playAnimOpend()
			self:_playAnimAfterClicked()
		else
			logError("[V2a7_WarmUpLeftView] invalid state: " .. tostring(state))
		end
	end
end

function V2a7_WarmUpLeftView:onClose()
	self._animEvent:RemoveAllEventListener()
end

function V2a7_WarmUpLeftView:onDestroyView()
	return
end

function V2a7_WarmUpLeftView:_playAnimIdle(cb, cbObj)
	self:_playAnim(UIAnimationName.Unopen, cb, cbObj)
end

function V2a7_WarmUpLeftView:_playAnimOpend(cb, cbObj)
	self:_playAnim(UIAnimationName.Open, cb, cbObj)
end

function V2a7_WarmUpLeftView:_playAnimClick(cb, cbObj)
	self:_playAnim(UIAnimationName.Click, cb, cbObj)
end

function V2a7_WarmUpLeftView:_playAnim(name, cb, cbObj)
	self._animatorPlayer:Play(name, cb or function()
		return
	end, cbObj)
end

function V2a7_WarmUpLeftView:_onItemClick()
	self:_setActive_drag(false)
	self:_play_ui_yuzhou_fax_earcap()
	self:_saveState(States.Clicked)
	self:_playAnimAfterClicked()
	self.viewContainer:setLocalIsPlayCurByUser()
end

local kBlock_Click = "V2a7_WarmUpLeftView:kBlock_Click"
local kTimeout = 9.99

function V2a7_WarmUpLeftView:_playAnimAfterClicked()
	UIBlockMgrExtend.setNeedCircleMv(false)
	UIBlockHelper.instance:startBlock(kBlock_Click, kTimeout, self.viewName)
	self.viewContainer:addNeedWaitCount()
	self:_playAnimClick(function()
		UIBlockHelper.instance:endBlock(kBlock_Click)
		UIBlockMgrExtend.setNeedCircleMv(true)
		self:_saveStateDone(true)
	end)
	self.viewContainer:openDesc()
end

function V2a7_WarmUpLeftView:_play_ui_yuzhou_fax_earcap()
	AudioMgr.instance:trigger(AudioEnum2_7.WarmUp.play_ui_yuzhou_fax_earcap)
end

function V2a7_WarmUpLeftView:_play_ui_min_day_night()
	AudioMgr.instance:trigger(AudioEnum2_7.WarmUp.play_ui_min_day_night)
end

function V2a7_WarmUpLeftView:_play_ui_yuzhou_fax_beep()
	AudioMgr.instance:trigger(AudioEnum2_7.WarmUp.play_ui_yuzhou_fax_beep)
end

function V2a7_WarmUpLeftView:_play_ui_yuzhou_fax_print()
	AudioMgr.instance:trigger(AudioEnum2_7.WarmUp.play_ui_yuzhou_fax_print)
end

return V2a7_WarmUpLeftView
