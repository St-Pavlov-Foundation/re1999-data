﻿-- chunkname: @modules/logic/fight/entity/comp/specialskineffect/FightEntitySpecialSkinEffect307301_buff4150002.lua

module("modules.logic.fight.entity.comp.specialskineffect.FightEntitySpecialSkinEffect307301_buff4150002", package.seeall)

local FightEntitySpecialSkinEffect307301_buff4150002 = class("FightEntitySpecialSkinEffect307301_buff4150002", FightEntitySpecialEffectBase)

function FightEntitySpecialSkinEffect307301_buff4150002:initClass()
	self:addEventCb(FightController.instance, FightEvent.SetEntityAlpha, self._onSetEntityAlpha, self)
	self:addEventCb(FightController.instance, FightEvent.SetBuffEffectVisible, self._onSetBuffEffectVisible, self)
	self:addEventCb(FightController.instance, FightEvent.OnBuffUpdate, self._onBuffUpdate, self)
	self:addEventCb(FightController.instance, FightEvent.BeforeEnterStepBehaviour, self._onBeforeEnterStepBehaviour, self)
	self:addEventCb(FightController.instance, FightEvent.BeforeDeadEffect, self._onBeforeDeadEffect, self)
end

function FightEntitySpecialSkinEffect307301_buff4150002:_releaseEffect()
	if self._effectWrap then
		self._entity.effect:removeEffect(self._effectWrap)
		FightRenderOrderMgr.instance:onRemoveEffectWrap(self._entity.id, self._effectWrap)

		self._effectWrap = nil
	end
end

local effectName = "v1a5_kerandian/kerandian_innate_1"

function FightEntitySpecialSkinEffect307301_buff4150002:_createEffect()
	self._effectWrap = self._effectWrap or self._entity.effect:addHangEffect(effectName, ModuleEnum.SpineHangPoint.mountweapon)

	FightRenderOrderMgr.instance:onAddEffectWrap(self._entity.id, self._effectWrap)
	self._effectWrap:setLocalPos(0, 0, 0)
end

function FightEntitySpecialSkinEffect307301_buff4150002:_onBuffUpdate(targetId, effectType, buffId, buffUid)
	if targetId ~= self._entity.id then
		return
	end

	if buffId == 4150002 then
		local hasBuff = self._entity.buff and self._entity.buff:haveBuffId(buffId)

		if hasBuff then
			self:_createEffect()
		else
			self:_releaseEffect()
		end
	end
end

function FightEntitySpecialSkinEffect307301_buff4150002:_onBeforeEnterStepBehaviour()
	local entityMO = self._entity:getMO()

	if entityMO then
		local buffDic = entityMO:getBuffDic()

		for i, v in pairs(buffDic) do
			self:_onBuffUpdate(self._entity.id, FightEnum.EffectType.BUFFADD, v.buffId, v.uid)
		end
	end
end

function FightEntitySpecialSkinEffect307301_buff4150002:_onSetEntityAlpha(entityId, state)
	self:_onSetBuffEffectVisible(entityId, state, "_onSetEntityAlpha")
end

function FightEntitySpecialSkinEffect307301_buff4150002:_onSetBuffEffectVisible(entityId, state, sign)
	if self._entity.id == entityId and self._effectWrap then
		self._effectWrap:setActive(state, sign or "FightEntitySpecialSkinEffect307301_buff4150002")
	end
end

function FightEntitySpecialSkinEffect307301_buff4150002:_onBeforeDeadEffect(entityId)
	if entityId == self._entity.id then
		self:_releaseEffect()
	end
end

function FightEntitySpecialSkinEffect307301_buff4150002:releaseSelf()
	self:_releaseEffect()
end

return FightEntitySpecialSkinEffect307301_buff4150002
