-- chunkname: @modules/logic/fight/system/work/FightWorkEffectHeal.lua

module("modules.logic.fight.system.work.FightWorkEffectHeal", package.seeall)

local FightWorkEffectHeal = class("FightWorkEffectHeal", FightEffectBase)

function FightWorkEffectHeal:onStart()
	if not self.actEffectData then
		self:onDone(true)

		return
	end

	local entity = FightHelper.getEntity(self.actEffectData.targetId)

	if entity then
		if not entity.nameUI then
			self:onDone(true)

			return
		end

		local prevHp = entity.nameUI:getHp()
		local effectNum = self.actEffectData.effectNum
		local floatType = self.actEffectData.effectType == FightEnum.EffectType.HEALCRIT and FightEnum.FloatType.crit_heal or FightEnum.FloatType.heal

		FightFloatMgr.instance:float(entity.id, floatType, effectNum, nil, self.actEffectData.effectNum1 == 1)
		entity.nameUI:addHp(effectNum)
		FightController.instance:dispatchEvent(FightEvent.OnHpChange, entity, effectNum)

		local nowHp = entity.nameUI:getHp()

		if prevHp <= 0 and nowHp > 0 and not FightSkillMgr.instance:isPlayingAnyTimeline() then
			entity.nameUI:setActive(true)
		end

		local configEffect = self.actEffectData.configEffect

		if configEffect == FightEnum.BehaviourId.FakeHpToHeal then
			FightController.instance:dispatchEvent(FightEvent.OnTrigger_HSY_FakeHPEffect, self.actEffectData.targetId)
		end

		self:_playNarcissusHealEffect(entity)
	end

	FightGameMgr.triggerBuffMgr:triggerBuffEffect(self.actEffectData)
	self:onDone(true)
end

function FightWorkEffectHeal:_playNarcissusHealEffect(entity)
	local healInfo = self.actEffectData.healInfo

	if not healInfo or healInfo.buffActId ~= FightEnum.BuffActId.NarcissusHeal then
		return
	end

	if not entity.effect then
		return
	end

	local config
	local buffMo = FightDataHelper.calMgr:getBuffMo(tostring(healInfo.buffUid))

	if buffMo then
		local fromEntity = FightDataHelper.entityMgr:getById(buffMo.fromUid)

		config = fromEntity and lua_fight_na_xi_suo_si_heal_effect.configDict[fromEntity.skin]
	end

	config = config or lua_fight_na_xi_suo_si_heal_effect.configDict[0]

	if not config then
		return
	end

	local effectWrap = entity.effect:addHangEffect(config.effect, config.effectHang, nil, config.duration)

	effectWrap:setLocalPos(0, 0, 0)
	FightRenderOrderMgr.instance:onAddEffectWrap(entity.id, effectWrap)

	if config.audio ~= 0 then
		AudioMgr.instance:trigger(config.audio)
	end
end

return FightWorkEffectHeal
