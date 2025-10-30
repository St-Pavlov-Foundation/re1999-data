﻿-- chunkname: @modules/logic/fight/entity/comp/specialeffect/FightEntitySpecialEffectBuffLayer.lua

module("modules.logic.fight.entity.comp.specialeffect.FightEntitySpecialEffectBuffLayer", package.seeall)

local FightEntitySpecialEffectBuffLayer = class("FightEntitySpecialEffectBuffLayer", FightEntitySpecialEffectBase)
local defaultReleaseTime = 3000

function FightEntitySpecialEffectBuffLayer:initClass()
	self._effectWraps = {}
	self._buffId2Config = {}
	self._oldLayer = {}
	self._buffType = {}
	self.hideEffectWhenPlaying = {}

	self:addEventCb(FightController.instance, FightEvent.SetBuffEffectVisible, self._onSetBuffEffectVisible, self)
	self:addEventCb(FightController.instance, FightEvent.OnBuffUpdate, self._onBuffUpdate, self)
	self:addEventCb(FightController.instance, FightEvent.BeforeDeadEffect, self._onBeforeDeadEffect, self)
	self:addEventCb(FightController.instance, FightEvent.BeforeEnterStepBehaviour, self._onBeforeEnterStepBehaviour, self)
	self:addEventCb(FightController.instance, FightEvent.SkillEditorRefreshBuff, self._onSkillEditorRefreshBuff, self)
	self:addEventCb(FightController.instance, FightEvent.OnSkillPlayStart, self._onSkillPlayStart, self)
	self:addEventCb(FightController.instance, FightEvent.OnSkillPlayFinish, self._onSkillPlayFinish, self, LuaEventSystem.High)
end

function FightEntitySpecialEffectBuffLayer:_onBeforeEnterStepBehaviour()
	local entityMO = self._entity:getMO()

	if entityMO then
		local buffDic = entityMO:getBuffDic()

		for i, v in pairs(buffDic) do
			self:_onBuffUpdate(self._entity.id, FightEnum.EffectType.BUFFADD, v.buffId, v.uid)
		end
	end
end

function FightEntitySpecialEffectBuffLayer:_onSkillEditorRefreshBuff()
	self:_releaseAllEffect()
	self:_onBeforeEnterStepBehaviour()
end

function FightEntitySpecialEffectBuffLayer:_onSetBuffEffectVisible(entityId, state, sign)
	if self._entity.id == entityId and self._effectWraps then
		for buffId, v in pairs(self._effectWraps) do
			for i, effectWrap in pairs(v) do
				effectWrap:setActive(state, sign or "FightEntitySpecialEffectBuffLayer")
			end
		end
	end
end

function FightEntitySpecialEffectBuffLayer:_onSkillPlayStart(entity, curSkillId, fightStepData)
	local entityMO = entity:getMO()

	if entityMO and entityMO.id == self._entity.id then
		if FightCardDataHelper.isBigSkill(curSkillId) then
			self:_onSetBuffEffectVisible(entityMO.id, false, "FightEntitySpecialEffectBuffLayer_onSkillPlayStart")
		end

		for uniqueId, effectWrap in pairs(self.hideEffectWhenPlaying) do
			effectWrap:setActive(false, "FightEntitySpecialEffectBuffLayerHideWhenPlaying")
		end
	end
end

function FightEntitySpecialEffectBuffLayer:_onSkillPlayFinish(entity, curSkillId, fightStepData)
	local entityMO = entity:getMO()

	if entityMO and entityMO.id == self._entity.id then
		if FightCardDataHelper.isBigSkill(curSkillId) then
			self:_onSetBuffEffectVisible(entityMO.id, true, "FightEntitySpecialEffectBuffLayer_onSkillPlayStart")
		end

		for uniqueId, effectWrap in pairs(self.hideEffectWhenPlaying) do
			effectWrap:setActive(true, "FightEntitySpecialEffectBuffLayerHideWhenPlaying")
		end
	end
end

function FightEntitySpecialEffectBuffLayer.sortList(item1, item2)
	return item1.layer > item2.layer
end

function FightEntitySpecialEffectBuffLayer:_onBuffUpdate(targetId, effectType, buffId, buffUid)
	if targetId ~= self._entity.id then
		return
	end

	if lua_fight_buff_layer_effect.configDict[buffId] then
		if effectType == FightEnum.EffectType.BUFFDEL or effectType == FightEnum.EffectType.BUFFDELNOEFFECT then
			local buffType = self._buffType[buffUid]

			if not buffType then
				return
			end

			if buffType == FightEnum.BuffType.LayerSalveHalo then
				return
			end

			self:_refreshEffect(buffId, nil, 0, effectType)

			return
		end

		local entityMO = self._entity:getMO()
		local buffMO = entityMO:getBuffMO(buffUid)

		if not buffMO then
			return
		end

		self._buffType[buffUid] = buffMO.type

		if buffMO.type == FightEnum.BuffType.LayerSalveHalo then
			return
		end

		if entityMO then
			local config = lua_fight_buff_layer_effect.configDict[buffId][entityMO.originSkin] or lua_fight_buff_layer_effect.configDict[buffId][0]

			if config then
				local list = {}

				for k, v in pairs(config) do
					table.insert(list, v)
				end

				table.sort(list, FightEntitySpecialEffectBuffLayer.sortList)

				local layer = buffMO and buffMO.layer or 0
				local buffConfig = lua_skill_buff.configDict[buffId]

				if FightSkillBuffMgr.instance:buffIsStackerBuff(buffConfig) then
					layer = FightSkillBuffMgr.instance:getStackedCount(targetId, buffMO)
				end

				self:_refreshEffect(buffId, list, layer, effectType)
			end
		end
	end
end

function FightEntitySpecialEffectBuffLayer:_refreshEffect(buffId, list, layer, effectType)
	if not self._effectWraps then
		return
	end

	if not self._effectWraps[buffId] then
		self._effectWraps[buffId] = {}
	end

	local oldLayer = self._oldLayer[buffId] or 0

	self._oldLayer[buffId] = layer

	if (effectType == FightEnum.EffectType.BUFFDEL or effectType == FightEnum.EffectType.BUFFDELNOEFFECT) and layer == 0 then
		local config = self._buffId2Config[buffId]

		if config and not string.nilorempty(config.destroyEffect) then
			local releaseTime = config.releaseDestroyEffectTime > 0 and config.releaseDestroyEffectTime or defaultReleaseTime
			local effectWrap = self._entity.effect:addHangEffect(config.destroyEffect, config.destroyEffectRoot, nil, releaseTime / 1000)

			effectWrap:setLocalPos(0, 0, 0)
			FightRenderOrderMgr.instance:onAddEffectWrap(self._entity.id, effectWrap)

			if config.destroyEffectAudio > 0 then
				AudioMgr.instance:trigger(config.destroyEffectAudio)
			end
		end

		self:_releaseBuffIdEffect(buffId)

		return
	end

	local config

	for i, v in ipairs(list) do
		if layer >= v.layer then
			config = v

			break
		end
	end

	if not config then
		self:_releaseBuffIdEffect(buffId)

		return
	end

	local keyLayer = config.layer
	local oldConfig = self._buffId2Config[buffId]

	self._buffId2Config[buffId] = config

	local isNew = oldConfig ~= config

	if not self._effectWraps[buffId][keyLayer] and not string.nilorempty(config.loopEffect) then
		local effectWrap = self._entity.effect:addHangEffect(config.loopEffect, config.loopEffectRoot)

		effectWrap:setLocalPos(0, 0, 0)
		FightRenderOrderMgr.instance:onAddEffectWrap(self._entity.id, effectWrap)

		self._effectWraps[buffId][keyLayer] = effectWrap

		effectWrap:setActive(false)

		if config.hideEffectWhenPlaying == 1 then
			self.hideEffectWhenPlaying[effectWrap.uniqueId] = effectWrap
		end
	end

	if isNew then
		local loopEffectWrap = self._effectWraps[buffId] and self._effectWraps[buffId][keyLayer]

		if loopEffectWrap then
			loopEffectWrap:setActive(false, "FightEntitySpecialEffectBuffLayer_newEffect")
		end

		self:_hideEffect(buffId)

		if not string.nilorempty(config.createEffect) then
			local releaseTime = config.releaseCreateEffectTime > 0 and config.releaseCreateEffectTime or defaultReleaseTime
			local effectWrap = self._entity.effect:addHangEffect(config.createEffect, config.createEffectRoot, nil, releaseTime / 1000)

			effectWrap:setLocalPos(0, 0, 0)
			FightRenderOrderMgr.instance:onAddEffectWrap(self._entity.id, effectWrap)

			if config.createAudio > 0 then
				AudioMgr.instance:trigger(config.createAudio)
			end
		end

		if config.delayTimeBeforeLoop > 0 then
			TaskDispatcher.runDelay(function()
				if loopEffectWrap then
					loopEffectWrap:setActive(true, "FightEntitySpecialEffectBuffLayer_newEffect")
				end

				self:_refreshEffectState(buffId)
			end, self, config.delayTimeBeforeLoop / 1000)
		else
			if loopEffectWrap then
				loopEffectWrap:setActive(true, "FightEntitySpecialEffectBuffLayer_newEffect")
			end

			self:_refreshEffectState(buffId)
		end
	else
		if config.loopEffectAudio > 0 then
			AudioMgr.instance:trigger(config.loopEffectAudio)
		end

		self:_refreshEffectState(buffId)

		if effectType == FightEnum.EffectType.BUFFUPDATE and oldLayer < layer then
			if not string.nilorempty(config.addLayerEffect) then
				local releaseTime = config.releaseAddLayerEffectTime > 0 and config.releaseAddLayerEffectTime or defaultReleaseTime
				local effectWrap = self._entity.effect:addHangEffect(config.addLayerEffect, config.addLayerEffectRoot, nil, releaseTime / 1000)

				effectWrap:setLocalPos(0, 0, 0)
				FightRenderOrderMgr.instance:onAddEffectWrap(self._entity.id, effectWrap)
			end

			if config.addLayerAudio > 0 then
				AudioMgr.instance:trigger(config.addLayerAudio)
			end
		end
	end
end

function FightEntitySpecialEffectBuffLayer:_refreshEffectState(buffId)
	if not self then
		return
	end

	if self._effectWraps then
		local effectDic = self._effectWraps[buffId]

		if effectDic then
			local entityMO = self._entity:getMO()
			local layer = self._buffId2Config[buffId].layer
			local config = lua_fight_buff_layer_effect.configDict[buffId]

			config = config and config[entityMO.skin]
			config = config and config[layer]

			local lE = config and config.lE == 1

			for k, v in pairs(effectDic) do
				if lE then
					v:setActive(k <= layer)
				else
					v:setActive(k == layer)
				end
			end
		end
	end
end

function FightEntitySpecialEffectBuffLayer:_hideEffect(buffId)
	if self._effectWraps then
		local effectDic = self._effectWraps[buffId]

		if effectDic then
			for k, v in pairs(effectDic) do
				v:setActive(false)
			end
		end
	end
end

function FightEntitySpecialEffectBuffLayer:_releaseAllEffect()
	if self._effectWraps then
		for k, v in pairs(self._effectWraps) do
			self:_releaseBuffIdEffect(k)
		end

		self._effectWraps = nil
	end
end

function FightEntitySpecialEffectBuffLayer:_releaseBuffIdEffect(buffId)
	if self._effectWraps then
		for k, v in pairs(self._effectWraps[buffId]) do
			self:_releaseEffect(v)
		end

		self._effectWraps[buffId] = nil
	end
end

function FightEntitySpecialEffectBuffLayer:_releaseEffect(effectWrap)
	self._entity.effect:removeEffect(effectWrap)
	FightRenderOrderMgr.instance:onRemoveEffectWrap(self._entity.id, effectWrap)

	self.hideEffectWhenPlaying[effectWrap.uniqueId] = nil
end

function FightEntitySpecialEffectBuffLayer:_onBeforeDeadEffect(entityId)
	if entityId == self._entity.id then
		self:_releaseAllEffect()
	end
end

function FightEntitySpecialEffectBuffLayer:releaseSelf()
	self:_releaseAllEffect()
end

return FightEntitySpecialEffectBuffLayer
