﻿-- chunkname: @modules/logic/bgmswitch/controller/BGMSwitchProgress.lua

module("modules.logic.bgmswitch.controller.BGMSwitchProgress", package.seeall)

local BGMSwitchProgress = class("BGMSwitchProgress")
local TickInterval = 0.03

function BGMSwitchProgress:playMainBgm(audioId)
	self._bgmCO = BGMSwitchConfig.instance:getBGMSwitchCoByAudioId(audioId)

	if not self._bgmCO then
		self._progressTimeSec = 0

		WeatherController.instance:unregisterCallback(WeatherEvent.WeatherChanged, self._onWeatherChange, self)
		AudioMgr.instance:unregisterCallback(AudioMgr.Evt_Trigger, self._onTriggerEvent, self)
		TaskDispatcher.cancelTask(self._onTick, self)

		return
	end

	WeatherController.instance:registerCallback(WeatherEvent.WeatherChanged, self._onWeatherChange, self)
	AudioMgr.instance:registerCallback(AudioMgr.Evt_Trigger, self._onTriggerEvent, self)
	TaskDispatcher.runRepeat(self._onTick, self, TickInterval)

	self._bgmAudioLength = BGMSwitchModel.instance:getReportBgmAudioLength(self._bgmCO)
	self._progressTimeSec = 0

	self:_updateGMProgress()
end

function BGMSwitchProgress:stopMainBgm()
	WeatherController.instance:unregisterCallback(WeatherEvent.WeatherChanged, self._onWeatherChange, self)
	AudioMgr.instance:unregisterCallback(AudioMgr.Evt_Trigger, self._onTriggerEvent, self)
	TaskDispatcher.cancelTask(self._onTick, self)

	self._progressTimeSec = 0

	self:_updateGMProgress()
end

function BGMSwitchProgress:getProgress()
	return self._progressTimeSec
end

function BGMSwitchProgress:_onWeatherChange()
	if self._bgmCO and self._bgmCO.isReport == 1 then
		local preLightMode = WeatherController.instance:getPrevLightMode()
		local curLightMode = WeatherController.instance:getCurLightMode()

		if preLightMode and curLightMode and preLightMode ~= curLightMode then
			self._bgmAudioLength = BGMSwitchModel.instance:getReportBgmAudioLength(self._bgmCO)
			self._progressTimeSec = 0
		end
	end
end

function BGMSwitchProgress:_onTriggerEvent(audioId)
	if audioId == AudioEnum.UI.Pause_MainMusic then
		TaskDispatcher.cancelTask(self._onTick, self)
		self:_updateGMProgress()
	elseif audioId == AudioEnum.UI.Resume_MainMusic then
		TaskDispatcher.runRepeat(self._onTick, self, TickInterval)
		self:_updateGMProgress()
	end
end

function BGMSwitchProgress:_onTick()
	local playingId = BGMSwitchController.instance:getPlayingId()

	if not playingId then
		return
	end

	local progressFromSource = AudioMgr.instance:getSourcePlayPosition(playingId) / 1000

	if progressFromSource < 0 then
		return
	end

	local audioLength = self._bgmAudioLength and self._bgmAudioLength > 0 and self._bgmAudioLength or 10
	local needChange = progressFromSource < self._progressTimeSec and self._progressTimeSec - progressFromSource > audioLength * 0.5

	if needChange or audioLength <= progressFromSource then
		local isServerRandom = BGMSwitchModel.instance:getUsedBgmIdFromServer() == BGMSwitchModel.RandomBgmId
		local hasOpenBGMView = ViewMgr.instance:isOpen(ViewName.BGMSwitchView)

		self._progressTimeSec = 0

		if isServerRandom and not hasOpenBGMView then
			BGMSwitchController.instance:checkStartMainBGM(false)
		end

		BGMSwitchController.instance:dispatchEvent(BGMSwitchEvent.BgmProgressEnd)
	else
		self._progressTimeSec = progressFromSource
	end

	self:_updateGMProgress()
end

BGMSwitchProgress.WeatherLight = {
	"白天",
	"阴天",
	"黄昏",
	"夜晚"
}
BGMSwitchProgress.WeatherEffect = {
	"天气无",
	"阳光明媚",
	"小雨",
	"大雨",
	"暴风雨",
	"小雪",
	"大雪",
	"大雾",
	"白天烟花",
	"夜晚烟花",
	"夜晚闪电"
}

function BGMSwitchProgress:_updateGMProgress()
	if not isDebugBuild then
		return
	end

	if PlayerPrefsHelper.getNumber(PlayerPrefsKey.GMToolViewBGMProgress, 0) == 0 then
		gohelper.setActive(self._progressGO, false)

		return
	end

	if not self._progressText then
		self._progressGO = GMController.instance:getGMNode("mainview", ViewMgr.instance:getUILayer(UILayerName.Top))
		self._progressGO.name = "bgm_progress"

		if self._progressGO then
			local img = gohelper.findChildImage(self._progressGO, "#btn_gm")

			img.raycastTarget = false
			img.color = Color.New(1, 1, 1, 0.3)

			recthelper.setWidth(img.transform, 500)

			self._progressText = gohelper.findChildText(self._progressGO, "#btn_gm/Text")
		end
	end

	local showUI = self._progressTimeSec ~= nil

	gohelper.setActive(self._progressGO, showUI)

	if showUI and self._progressText and self._bgmCO then
		local reportStr = ""

		if self._bgmCO.id == 1001 then
			local curReport = WeatherController.instance:getCurrReport()
			local lightMode = curReport and curReport.lightMode or 1
			local effect = curReport and curReport.effect or 1
			local lightName = BGMSwitchProgress.WeatherLight[lightMode] or lightMode
			local effectName = BGMSwitchProgress.WeatherEffect[effect] or effect

			reportStr = lightName .. "-" .. effectName
		end

		local progress = self._progressTimeSec > 0 and self._progressTimeSec or 0
		local length = self._bgmAudioLength

		self._progressText.text = string.format("bgm:%s %s\n%.1f/%.1f s", self._bgmCO.audioName, reportStr, progress, length)
	end
end

return BGMSwitchProgress
