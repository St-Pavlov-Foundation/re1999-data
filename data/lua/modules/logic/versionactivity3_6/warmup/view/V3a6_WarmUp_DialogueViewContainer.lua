-- chunkname: @modules/logic/versionactivity3_6/warmup/view/V3a6_WarmUp_DialogueViewContainer.lua

module("modules.logic.versionactivity3_6.warmup.view.V3a6_WarmUp_DialogueViewContainer", package.seeall)

local V3a6_WarmUp_DialogueViewContainer = class("V3a6_WarmUp_DialogueViewContainer", Activity125ViewBaseContainer)
local kTabContainerId_NavigateButtonsView = 1
local ti = table.insert
local sf = string.format

function V3a6_WarmUp_DialogueViewContainer:actId()
	return V3a6_WarmUpConfig.instance:actId()
end

function V3a6_WarmUp_DialogueViewContainer:getCutsceneResUrl(bShownCutscene)
	local episodeId = self._level
	local resName = bShownCutscene and string.format("v3a6_warmup_day%s_2", episodeId) or string.format("v3a6_warmup_day%s_1", episodeId)

	return ResUrl.getV3a6WarmUpSingleBg(resName)
end

function V3a6_WarmUp_DialogueViewContainer:buildViews()
	self:resetData(self.viewParam.level)

	self._mainView = V3a6_WarmUp_DialogueView.New()

	return {
		self._mainView,
		TabViewGroup.New(kTabContainerId_NavigateButtonsView, "#go_topleft")
	}
end

function V3a6_WarmUp_DialogueViewContainer:onContainerClose()
	self:_saveAuto(self._bAuto)
	V3a6_WarmUp_DialogueViewContainer.super.onContainerClose(self)
end

function V3a6_WarmUp_DialogueViewContainer:onContainerCloseFinish()
	V3a6_WarmUp_DialogueViewContainer.super.onContainerCloseFinish(self)
	AudioMgr.instance:trigger(AudioEnum.UI.stop_ui_feichi_yure_caption_20200115)

	local episodeId = self._level

	if self._willSetLocalIsPlayed and not self:checkLocalIsPlay(episodeId) then
		self:setLocalIsPlay(episodeId)
		Activity125Controller.instance:dispatchEvent(Activity125Event.OnGameFinished, self._level)
	end
end

function V3a6_WarmUp_DialogueViewContainer:buildTabViews(tabContainerId)
	if tabContainerId == kTabContainerId_NavigateButtonsView then
		self._navigationView = NavigateButtonsView.New({
			true,
			false,
			false
		})

		return {
			self._navigationView
		}
	end
end

function V3a6_WarmUp_DialogueViewContainer:resetData(level)
	self._level = assert(level)
	self._dialogCOList = V3a6_WarmUpConfig.instance:dialogCOList(level)
	self._count = V3a6_WarmUpConfig.instance:getDialogCount(level)
	self._index = 1
	self._bAuto = self:_getSavedAuto()
	self._bFastForwarding = false
	self._willSetLocalIsPlayed = false
end

function V3a6_WarmUp_DialogueViewContainer:curIndex()
	return self._index - 1
end

function V3a6_WarmUp_DialogueViewContainer:count()
	return self._count or 0
end

function V3a6_WarmUp_DialogueViewContainer:curDialogCO()
	return self._dialogCOList[self:curIndex()]
end

function V3a6_WarmUp_DialogueViewContainer:peak()
	return self._dialogCOList[self._index]
end

function V3a6_WarmUp_DialogueViewContainer:pop()
	if self._index > self._count or self._count <= 0 then
		return
	end

	local CO = self._dialogCOList[self._index]

	self._index = self._index + 1

	return CO
end

function V3a6_WarmUp_DialogueViewContainer:doSkip()
	self._bFastForwarding = true

	local tmpSave = self._bAuto

	self._bAuto = false

	self._mainView:fastForwardToEnd()

	self._bAuto = tmpSave
end

function V3a6_WarmUp_DialogueViewContainer:bFastForwarding()
	return self._bFastForwarding
end

function V3a6_WarmUp_DialogueViewContainer:isAuto()
	if self._bFastForwarding then
		return false
	end

	return self._bAuto
end

function V3a6_WarmUp_DialogueViewContainer:isManually()
	if self._bFastForwarding then
		return false
	end

	return not self:isAuto()
end

function V3a6_WarmUp_DialogueViewContainer:startAuto()
	self._bAuto = true

	self._mainView:onChangedAuto(self._bAuto)
end

function V3a6_WarmUp_DialogueViewContainer:stopAuto()
	self._bAuto = false

	self._mainView:onChangedAuto(self._bAuto)
end

function V3a6_WarmUp_DialogueViewContainer:markDoneSlient()
	self._willSetLocalIsPlayed = true
end

local kEpisode = "V3a6_WarmUp_Dialogue|"

function V3a6_WarmUp_DialogueViewContainer:_getPrefsKey()
	return self:getPrefsKeyPrefix() .. kEpisode
end

function V3a6_WarmUp_DialogueViewContainer:_saveAuto(bAuto)
	if self:_getSavedAuto() == bAuto then
		return
	end

	local key = self:_getPrefsKey()

	self:saveInt(key, bAuto and 1 or 0)
end

function V3a6_WarmUp_DialogueViewContainer:_getSavedAuto()
	local key = self:_getPrefsKey()
	local value = self:getInt(key, 0)

	return value ~= 0
end

function V3a6_WarmUp_DialogueViewContainer:dump(refStrBuf, depth)
	depth = depth or 0

	local tab = string.rep("\t", depth)

	ti(refStrBuf, tab .. sf("level = %s", tostring(self._level)))
	ti(refStrBuf, tab .. sf("bAuto? = %s", self._bAuto and "true" or "false"))

	local curDialogCO = self:curDialogCO()

	if curDialogCO then
		ti(refStrBuf, tab .. sf("%s(%s/%s): %s", curDialogCO.id, self._index, self._count, curDialogCO.desc))
	else
		ti(refStrBuf, tab .. sf("None DialogCO (%s/%s)", self._index, self._count))
	end
end

return V3a6_WarmUp_DialogueViewContainer
