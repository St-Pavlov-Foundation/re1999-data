﻿-- chunkname: @modules/common/global/gamestate/GameLanguageMgr.lua

module("modules.common.global.gamestate.GameLanguageMgr", package.seeall)

local GameLanguageMgr = class("GameLanguageMgr")

function GameLanguageMgr:ctor()
	local curLang = LangSettings.shortcutTab[GameConfig:GetCurLangType()]

	self._languageType = self:getStoryIndexByShortCut(curLang)
	self._voiceType = self:getStoryIndexByShortCut(SettingsController.instance:getStoryVoiceType())
end

function GameLanguageMgr:getLanguageTypeStoryIndex()
	return self._languageType
end

function GameLanguageMgr:setLanguageTypeByStoryIndex(index)
	self._languageType = index
end

function GameLanguageMgr:setVoiceTypeByStoryIndex(index)
	self._voiceType = index
end

function GameLanguageMgr:getVoiceTypeStoryIndex()
	if self._voiceType then
		local isS01Story = StoryModel.instance:isS01Story()

		if not isS01Story then
			if self._voiceType == LanguageEnum.LanguageStoryType.JP or self._voiceType == LanguageEnum.LanguageStoryType.KR then
				return LanguageEnum.LanguageStoryType.EN
			else
				return self._voiceType
			end
		end

		return self._voiceType
	else
		local curVoiceShortCut = SettingsController.instance:getStoryVoiceType()
		local voiceType = self:getStoryIndexByShortCut(curVoiceShortCut)
		local isS01Story = StoryModel.instance:isS01Story()

		if not isS01Story then
			if voiceType == LanguageEnum.LanguageStoryType.JP or voiceType == LanguageEnum.LanguageStoryType.KR then
				return LanguageEnum.LanguageStoryType.EN
			else
				return voiceType
			end
		end

		return voiceType
	end
end

function GameLanguageMgr:getShortCutByStoryIndex(index)
	local langId = bit.lshift(1, index - 1)

	return LangSettings.shortcutTab[langId]
end

function GameLanguageMgr:setStoryIndexByShortCut(shortcut)
	local langId = LangSettings[shortcut]
	local index = langId and math.log(langId) / math.log(2) + 1

	self._languageType = index
end

function GameLanguageMgr:getStoryIndexByShortCut(shortcut)
	local langId = LangSettings[shortcut]
	local index = langId and math.log(langId) / math.log(2) + 1

	return index or 1
end

function GameLanguageMgr:isAudioLangBankExist(audioId, audioLang)
	local audioCfg = AudioConfig.instance:getAudioCOById(audioId)

	if audioCfg then
		local bnkName = audioCfg.bankName

		ZProj.AudioManager.Instance:LoadBank(bnkName)

		local curLang = ZProj.AudioManager.Instance:GetLangByBankName(bnkName)

		ZProj.AudioManager.Instance:UnloadBank(bnkName)

		return curLang == audioLang, curLang
	end

	return false, GameConfig:GetDefaultVoiceShortcut()
end

GameLanguageMgr.instance = GameLanguageMgr.New()

return GameLanguageMgr
