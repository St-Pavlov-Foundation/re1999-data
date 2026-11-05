-- chunkname: @modules/logic/fight/entity/comp/FightUpdateEntityMoComp.lua

module("modules.logic.fight.entity.comp.FightUpdateEntityMoComp", package.seeall)

local FightUpdateEntityMoComp = class("FightUpdateEntityMoComp", FightBaseClass)

function FightUpdateEntityMoComp:onConstructor(entity)
	self.entity = entity
	self.entityMo = self.entity:getMO()
end

function FightUpdateEntityMoComp:onLogicEnter()
	self:com_registFightEvent(FightEvent.AfterEffectWorkDone, self.onEffectWorkDone)
	self:com_registFightEvent(FightEvent.ResetCard, self.onResetCard)
end

function FightUpdateEntityMoComp:onEffectWorkDone()
	if self.entityMo then
		self.entityMo:updateHasFirstActFreeBuff()
	end
end

function FightUpdateEntityMoComp:onResetCard()
	if self.entityMo then
		self.entityMo:updateHasFirstActFreeBuff()
	end
end

function FightUpdateEntityMoComp:onDestructor()
	return
end

return FightUpdateEntityMoComp
