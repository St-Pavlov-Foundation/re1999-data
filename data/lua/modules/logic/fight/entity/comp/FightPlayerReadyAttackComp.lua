﻿-- chunkname: @modules/logic/fight/entity/comp/FightPlayerReadyAttackComp.lua

module("modules.logic.fight.entity.comp.FightPlayerReadyAttackComp", package.seeall)

local FightPlayerReadyAttackComp = class("FightPlayerReadyAttackComp", LuaCompBase)

function FightPlayerReadyAttackComp:ctor(entity)
	self.entity = entity
end

function FightPlayerReadyAttackComp:addEventListeners()
	self:addEventCb(FightController.instance, FightEvent.OnPlayHandCard, self._onPlayHandCard, self)
	self:addEventCb(FightController.instance, FightEvent.OnRevertCard, self._onRevertCard, self)
	self:addEventCb(FightController.instance, FightEvent.OnResetCard, self._onResetCard, self)
	self:addEventCb(FightController.instance, FightEvent.BeforePlaySkill, self._beforePlaySkill, self)
	self:addEventCb(FightController.instance, FightEvent.StageChanged, self._onStageChange, self)
end

function FightPlayerReadyAttackComp:removeEventListeners()
	self:removeEventCb(FightController.instance, FightEvent.OnPlayHandCard, self._onPlayHandCard, self)
	self:removeEventCb(FightController.instance, FightEvent.OnRevertCard, self._onRevertCard, self)
	self:removeEventCb(FightController.instance, FightEvent.OnResetCard, self._onResetCard, self)
	self:removeEventCb(FightController.instance, FightEvent.BeforePlaySkill, self._beforePlaySkill, self)
	self:removeEventCb(FightController.instance, FightEvent.StageChanged, self._onStageChange, self)
end

function FightPlayerReadyAttackComp:onDestroy()
	self:_clearReadyAttackWork()
end

function FightPlayerReadyAttackComp:_onPlayHandCard(cardInfoMO)
	if cardInfoMO.uid ~= self.entity.id then
		return
	end

	local ops = FightDataHelper.operationDataMgr:getEntityOps(cardInfoMO.uid, FightEnum.CardOpType.PlayCard)

	if #ops > 0 and not self._readyAttackWork then
		local entityMO = FightDataHelper.entityMgr:getById(cardInfoMO.uid)
		local allOps = entityMO and FightDataHelper.operationDataMgr:getOpList()
		local buffList = allOps and FightBuffHelper.simulateBuffList(entityMO, allOps[#allOps])

		if FightViewHandCardItemLock.canUseCardSkill(cardInfoMO.uid, cardInfoMO.skillId, buffList) then
			self._readyAttackWork = FightReadyAttackWork.New()

			self._readyAttackWork:onStart(self.entity)
		end
	end
end

function FightPlayerReadyAttackComp:_onRevertCard(cardOp)
	if cardOp.belongToEntityId ~= self.entity.id then
		return
	end

	if cardOp:isPlayCard() then
		local ops = FightDataHelper.operationDataMgr:getEntityOps(self.entity.id)

		if (not ops or #ops == 0) and self._readyAttackWork then
			self.entity:resetAnimState()
			self:_clearReadyAttackWork()
		end
	end
end

function FightPlayerReadyAttackComp:_onResetCard()
	if self._readyAttackWork then
		self.entity:resetAnimState()
		self:_clearReadyAttackWork()
	end
end

function FightPlayerReadyAttackComp:_beforePlaySkill(entity, skillId, fightStepData)
	if self.entity == entity then
		self:_clearReadyAttackWork()
	end
end

function FightPlayerReadyAttackComp:_onStageChange()
	self:_clearReadyAttackWork()
end

function FightPlayerReadyAttackComp:_clearReadyAttackWork()
	if self._readyAttackWork then
		self._readyAttackWork:onStop()

		self._readyAttackWork = nil
	end
end

return FightPlayerReadyAttackComp
