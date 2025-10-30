﻿-- chunkname: @modules/audio/AudioMgr.lua

module("modules.audio.AudioMgr", package.seeall)

local AudioMgr = class("AudioMgr")

AudioMgr.GMOpenLog = nil
AudioMgr.Evt_ChangeFinish = 1
AudioMgr.Evt_Trigger = 2

function AudioMgr:ctor()
	return
end

function AudioMgr:init(onInited, onInitedObj)
	AudioEnum1_5.activate()
	AudioEnum1_6.activate()
	AudioEnum1_7.activate()
	AudioEnum1_8.activate()
	AudioEnum1_9.activate()
	AudioEnum2_0.activate()
	AudioEnum2_1.activate()
	AudioEnum2_2.activate()
	AudioEnum2_3.activate()
	AudioEnum2_4.activate()
	AudioEnum2_5.activate()

	self._onInited = onInited
	self._onInitedObj = onInitedObj
	self.csharpInst = ZProj.AudioManager.Instance

	AudioConfig.instance:InitCSByConfig(self.csharpInst)
	self.csharpInst:InitFromLua(self._onInitCS, self)
end

function AudioMgr:_setAutoSwitchDefault(target)
	self.csharpInst.autoSwitchToDefault = target == LangSettings.shortcutTab[LangSettings.jp] or target == LangSettings.shortcutTab[LangSettings.kr]
end

function AudioMgr:_onInitCS(success)
	local voiceType = GameConfig:GetCurVoiceShortcut()

	logNormal("AudioMgr:init, voiceType = " .. voiceType)
	self:changeLang(voiceType)

	if self._onInited then
		local cb = self._onInited
		local cbObj = self._onInitedObj

		self._onInited = nil
		self._onInitedObj = nil

		if cbObj then
			cb(cbObj, success)
		else
			cb(success)
		end
	end
end

function AudioMgr:initSoundVolume()
	local musicValue = SettingsModel.instance:getMusicValue()
	local voiceValue = SettingsModel.instance:getVoiceValue()
	local effectValue = SettingsModel.instance:getEffectValue()
	local globalVolume = SettingsModel.instance:getGlobalAudioVolume()

	self:setRTPCValue(AudioEnum.Volume.Music_Volume, musicValue)
	self:setRTPCValue(AudioEnum.Volume.Voc_Volume, voiceValue)
	self:setRTPCValue(AudioEnum.Volume.SFX_Volume, effectValue)
	self:setRTPCValue(AudioEnum.Volume.Global_Volume, globalVolume)

	if voiceValue > 0 then
		self:setState(self:getIdFromString("Voc_Volume_M"), self:getIdFromString("no"))
	else
		self:setState(self:getIdFromString("Voc_Volume_M"), self:getIdFromString("yes"))
	end
end

function AudioMgr:changeEarMode()
	local isEarConnect = SDKMgr.instance:isEarphoneContact()

	logNormal("isEarConnect : " .. tostring(isEarConnect))
	self:setRTPCValue(AudioEnum.EarRTPC, isEarConnect and 0 or 1)
end

function AudioMgr:trigger(audioId, go)
	local playingId = self.csharpInst:TriggerAudio(audioId, go)

	self:dispatchEvent(AudioMgr.Evt_Trigger, audioId)

	return playingId
end

function AudioMgr:triggerEx(audioId, flag, go)
	local playingId = self.csharpInst:TriggerAudioEx(audioId, flag, go)

	self:dispatchEvent(AudioMgr.Evt_Trigger, audioId)

	return playingId
end

function AudioMgr:getSourcePlayPosition(playingId)
	return self.csharpInst:GetSourcePlayPosition(playingId)
end

function AudioMgr:getLangByAudioId(id)
	return self.csharpInst:GetLangByAudioId(id)
end

function AudioMgr:setSwitch(switchGroup, switchState, go)
	self.csharpInst:SetSwitch(switchGroup, switchState, go)
	self:addNormalLog("#00BBFF", "触发Switch : " .. tostring(switchGroup) .. ", " .. tostring(switchState))
end

function AudioMgr:setState(stateGroup, stateState)
	self.csharpInst:SetState(stateGroup, stateState)
end

function AudioMgr:getSwitch(switchGroup, go)
	return self.csharpInst:GetSwitch(switchGroup, go)
end

function AudioMgr:getIdFromString(str)
	self._idCache = self._idCache or {}

	local id = self._idCache[str]

	if not id then
		id = self.csharpInst:GetIDFromString(str)
		self._idCache[str] = id
	end

	return id
end

function AudioMgr:setRTPCValue(rtpcName, floatValue)
	if not self.csharpInst then
		return
	end

	self.csharpInst:SetRTPCValue(rtpcName, floatValue)
end

function AudioMgr:setRTPCValueByPlayingID(rtpcID, value, playingID, valueChangeDuration, fadeCurve, bypassInternalValueInterpolation)
	if not self.csharpInst then
		return
	end

	if valueChangeDuration then
		self.csharpInst:SetRTPCValueByPlayingID(rtpcID, value, playingID, valueChangeDuration, fadeCurve, bypassInternalValueInterpolation)
	else
		self.csharpInst:SetRTPCValueByPlayingID(rtpcID, value, playingID)
	end
end

function AudioMgr:setGameObjectOutputBusVolume(gameObject, volume)
	self.csharpInst:SetGameObjectOutputBusVolume(gameObject, volume)
end

function AudioMgr:stopPlayingID(playingID)
	self.csharpInst:StopPlayingID(playingID)
end

function AudioMgr:getRTPCValue(rtpcID, playingID, valueType)
	return self.csharpInst:GetRTPCValue(rtpcID, playingID, valueType)
end

function AudioMgr:changeLang(target)
	self:_setAutoSwitchDefault(target)
	self.csharpInst:UnloadUnusedBanks()
	self.csharpInst:SwitchLanguage(target, self._onChangeFinish, self)
end

function AudioMgr:_onChangeFinish()
	logNormal("_onChangeFinish ----------------->!")
	self:changeEarMode()
	self:dispatchEvent(AudioMgr.Evt_ChangeFinish)
end

function AudioMgr:getCurLang()
	return self.csharpInst:GetCurLang()
end

function AudioMgr:clearUnusedBanks()
	self.csharpInst:UnloadUnusedBanks()
end

function AudioMgr:addAudioLog(audioId, color, desc)
	if audioId and AudioMgr.GMOpenLog then
		local audioCO = AudioConfig.instance:getAudioCOById(audioId)
		local audioEvt = audioCO and audioCO.eventName or "event=nil"

		logNormal(string.format("<color=%s>GMAudioLog %s：%d %s</color>\n%s", color, desc, audioId, audioEvt, debug.traceback()))
	end
end

function AudioMgr:addNormalLog(color, desc)
	if AudioMgr.GMOpenLog then
		logNormal(string.format("<color=%s>GMAudioLog %s</color>\n%s", color, desc, debug.traceback()))
	end
end

function AudioMgr:useDefaultBGM()
	return VersionValidator.instance:isInReviewing() and BootNativeUtil.isIOS()
end

AudioMgr.instance = AudioMgr.New()

LuaEventSystem.addEventMechanism(AudioMgr.instance)

return AudioMgr
