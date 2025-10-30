﻿-- chunkname: @modules/logic/fight/entity/comp/specialeffect/FightEntitySpecialEffectBuffLayerNaNa.lua

module("modules.logic.fight.entity.comp.specialeffect.FightEntitySpecialEffectBuffLayerNaNa", package.seeall)

local FightEntitySpecialEffectBuffLayerNaNa = class("FightEntitySpecialEffectBuffLayerNaNa", FightEntitySpecialEffectBase)

function FightEntitySpecialEffectBuffLayerNaNa:initClass()
	self.entity = self._entity
	self.entityId = self.entity.id
	self.curEffectWrap = nil

	self:addEventCb(FightController.instance, FightEvent.OnBuffUpdate, self.onBuffUpdate, self)
end

function FightEntitySpecialEffectBuffLayerNaNa:onBuffUpdate(entityId, effectType, buffId, buffUid)
	if entityId ~= self.entityId then
		return
	end

	if effectType ~= FightEnum.EffectType.BUFFUPDATE and effectType ~= FightEnum.EffectType.BUFFADD then
		return
	end

	local buffCo = lua_skill_buff.configDict[buffId]
	local buffTypeId = buffCo and buffCo.typeId

	if not buffTypeId then
		return
	end

	local buffTypeCoDict = lua_fight_buff_layer_effect_nana.configDict[buffTypeId]

	if not buffTypeCoDict then
		return
	end

	local entityMo = self.entity and self.entity:getMO()

	if not entityMo then
		return
	end

	local skin = entityMo.originSkin
	local skinCoDict = skin and buffTypeCoDict[skin]

	skinCoDict = skinCoDict or buffTypeCoDict[0]

	local buffMo = entityMo:getBuffMO(buffUid)

	if not buffMo then
		return
	end

	local layer = buffMo.exInfo
	local layerEffectNaNaCo = skinCoDict[layer]

	if not layerEffectNaNaCo then
		logError(string.format("Z战斗配置-buff层数特效娜娜表没找到buffTypeId = `%s`, skinId = `%s`, layer = `%s` 的配置", buffTypeId, skin, layer))

		return
	end

	self:removeEffect()

	local effect = layerEffectNaNaCo.effect
	local hangPoint = layerEffectNaNaCo.effectRoot
	local audio = layerEffectNaNaCo.effectAudio
	local duration = layerEffectNaNaCo.duration

	self.curEffectWrap = self.entity.effect:addHangEffect(effect, hangPoint, nil, duration)

	self.curEffectWrap:setLocalPos(0, 0, 0)
	FightRenderOrderMgr.instance:onAddEffectWrap(entityId, self.curEffectWrap)

	if audio > 0 then
		FightAudioMgr.instance:playAudio(audio)
	end
end

function FightEntitySpecialEffectBuffLayerNaNa:removeEffect()
	if self.curEffectWrap then
		self.entity.effect:removeEffect(self.curEffectWrap)
		FightRenderOrderMgr.instance:onRemoveEffectWrap(self.entityId, self.curEffectWrap)

		self.curEffectWrap = nil
	end
end

function FightEntitySpecialEffectBuffLayerNaNa:releaseSelf()
	self:removeEffect()
	FightEntitySpecialEffectBuffLayerNaNa.super.releaseSelf(self)
end

function FightEntitySpecialEffectBuffLayerNaNa:disposeSelf()
	FightEntitySpecialEffectBuffLayerNaNa.super.disposeSelf(self)
end

return FightEntitySpecialEffectBuffLayerNaNa
