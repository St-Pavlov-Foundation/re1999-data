﻿-- chunkname: @modules/logic/fight/entity/comp/FightSkinSpineAction.lua

module("modules.logic.fight.entity.comp.FightSkinSpineAction", package.seeall)

local FightSkinSpineAction = class("FightSkinSpineAction", LuaCompBase)

function FightSkinSpineAction:ctor(entity)
	self.entity = entity
	self._effectWraps = {}
	self.lock = false
end

function FightSkinSpineAction:init(go)
	self._spine = self.entity.spine
end

function FightSkinSpineAction:addEventListeners()
	self._spine:addAnimEventCallback(self._onAnimEvent, self)
end

function FightSkinSpineAction:removeEventListeners()
	self._spine:removeAnimEventCallback(self._onAnimEvent, self)
end

function FightSkinSpineAction:_onAnimEvent(actionName, eventName, eventArgs)
	if self.lock then
		return
	end

	local entityMO = self.entity:getMO()

	if not entityMO then
		return
	end

	local spineActionDict = FightConfig.instance:getSkinSpineActionDict(entityMO.skin, actionName)

	if not spineActionDict then
		return
	end

	local spineActionCO = spineActionDict[actionName]

	if eventName == SpineAnimEvent.ActionStart then
		self:_removeEffect()

		local play_audio = true

		if actionName == SpineAnimState.die or actionName == SpineAnimState.born then
			if FightDataHelper.entityMgr:isSub(entityMO.id) then
				play_audio = false
			end

			if actionName == SpineAnimState.born and FightAudioMgr.instance.enterFightVoiceHeroID and FightAudioMgr.instance.enterFightVoiceHeroID ~= entityMO.modelId then
				play_audio = false
			end
		end

		if spineActionCO then
			self:_playActionEffect(spineActionCO)

			if play_audio then
				self:_playActionAudio(spineActionCO)
			end

			if spineActionCO.effectRemoveTime > 0 then
				TaskDispatcher.cancelTask(self._removeEffect, self)
				TaskDispatcher.runDelay(self._removeEffect, self, spineActionCO.effectRemoveTime)
			end
		end
	elseif eventName == SpineAnimEvent.ActionComplete and spineActionCO and spineActionCO.effectRemoveTime == 0 then
		self:_removeEffect()
	end
end

function FightSkinSpineAction:_removeEffect()
	TaskDispatcher.cancelTask(self._removeEffect, self)

	for i, effectWrap in ipairs(self._effectWraps) do
		self.entity.effect:removeEffect(effectWrap)
	end

	self._effectWraps = {}
end

function FightSkinSpineAction:_playActionEffect(spineActionCO)
	if not string.nilorempty(spineActionCO.effect) then
		local effectList = string.split(spineActionCO.effect, "#")
		local hangPoint = string.split(spineActionCO.effectHangPoint, "#")

		for i, path in ipairs(effectList) do
			local effectWrap = self.entity.effect:addHangEffect(path, hangPoint[i])

			effectWrap:setLocalPos(0, 0, 0)
			FightRenderOrderMgr.instance:onAddEffectWrap(self.entity.id, effectWrap)
			table.insert(self._effectWraps, effectWrap)
		end
	end
end

function FightSkinSpineAction:_playActionAudio(spineActionCO)
	if spineActionCO.audioId and spineActionCO.audioId > 0 then
		local entityMO = self.entity:getMO()

		if not entityMO then
			return
		end

		local audioLang
		local heroId = self.entity:getMO().modelId

		if not heroId then
			return
		end

		local charVoiceLangId, langStr, usingDefaultLang = SettingsRoleVoiceModel.instance:getCharVoiceLangPrefValue(heroId)
		local charVoiceLang = LangSettings.shortcutTab[charVoiceLangId]

		if not string.nilorempty(charVoiceLang) and not usingDefaultLang then
			audioLang = charVoiceLang
		end

		FightAudioMgr.instance:playAudioWithLang(spineActionCO.audioId, audioLang)
	end
end

function FightSkinSpineAction:onDestroy()
	self:_removeEffect()
end

return FightSkinSpineAction
