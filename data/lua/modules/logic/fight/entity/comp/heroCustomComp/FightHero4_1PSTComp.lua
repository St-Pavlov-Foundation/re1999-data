-- chunkname: @modules/logic/fight/entity/comp/heroCustomComp/FightHero4_1PSTComp.lua

module("modules.logic.fight.entity.comp.heroCustomComp.FightHero4_1PSTComp", package.seeall)

local FightHero4_1PSTComp = class("FightHero4_1PSTComp", FightHeroCustomCompBase)

FightHero4_1PSTComp.SpecialEntityOrderOffset = -50

local Status = {
	Dying = 2,
	Dead = 3,
	Normal = 1
}

function FightHero4_1PSTComp:init(go)
	FightHero4_1PSTComp.super.init(self, go)

	self.entityMo = self.entity:getMO()
	self.skinId = self.entityMo and self.entityMo.skin
	self.entityId = self.entityMo and self.entityMo.uid
	self.status = Status.Dead
	self.buffActId = FightEnum.BuffActId.GuardianPuppet
	self.spineCo = self.skinId and lua_fight_sp_pst_muou.configDict[self.skinId]

	if not self.spineCo then
		self.spineCo = lua_fight_sp_pst_muou.configList[1]
	end

	self.specialEntityName = "SPECIAL_MOOU"
	self.specialEntityId = self.entityId .. "_" .. self.specialEntityName
	self.side = self.entityMo.side

	self:refreshSpine()
end

function FightHero4_1PSTComp:addEventListeners()
	self:addEventCb(FightController.instance, FightEvent.OnSpineLoaded, self.onSpineLoaded, self)
	self:addEventCb(FightController.instance, FightEvent.OnBuffUpdate, self.onBuffUpdate, self)
	self:addEventCb(FightController.instance, FightEvent.OnSkillPlayStart, self.onSkillPlayStart, self)
	self:addEventCb(FightController.instance, FightEvent.OnSkillPlayFinish, self.onSkillPlayFinish, self)
	self:addEventCb(FightController.instance, FightEvent.OnSetEntityRenderOrder, self.onSetEntityRenderOrder, self)
	self:addEventCb(FightController.instance, FightEvent.OnEntityPosChange, self.onEntityPosChange, self)
	self:addEventCb(FightController.instance, FightEvent.OnEntitySpinePosChange, self.onEntitySpinePosChange, self)
	self:addEventCb(FightController.instance, FightEvent.SetEntityAlpha, self.onSetEntityAlpha, self)
end

function FightHero4_1PSTComp:removeEventListeners()
	return
end

function FightHero4_1PSTComp:onSetEntityAlpha(entityId, active, duration)
	if entityId ~= self.entityId then
		return
	end

	if not self.specialEntity then
		return
	end

	local alpha = active and 1 or 0

	self.specialEntity:setAlpha(alpha, duration)
end

function FightHero4_1PSTComp:onEntitySpinePosChange(entityId, posX, posY, posZ)
	if self.entityId ~= entityId then
		return
	end

	if not self.specialEntity then
		return
	end

	self.specialEntity.spine:setLocalPos(posX, posY, posZ)
end

function FightHero4_1PSTComp:onEntityPosChange(entityId, posX, posY, posZ)
	if self.entityId ~= entityId then
		return
	end

	if not self.specialEntity then
		return
	end

	self.specialEntity:setSrcEntityPos(posX, posY, posZ)
end

function FightHero4_1PSTComp:onSetEntityRenderOrder(entityId, order)
	if entityId ~= self.entityId then
		return
	end

	if not self.specialEntity then
		return
	end

	self.specialEntity:setRenderOrder(order + FightHero4_1PSTComp.SpecialEntityOrderOffset)
end

function FightHero4_1PSTComp:onSkillPlayStart(entity, curSkillId, fightStepData)
	if not self.specialEntity then
		return
	end

	local entityMO = entity:getMO()

	if entityMO and FightCardDataHelper.isBigSkill(curSkillId) and entity.id ~= self.entity.id then
		self.specialEntity:setActive(false)
	end
end

function FightHero4_1PSTComp:onSkillPlayFinish(entity, curSkillId, fightStepData)
	if not self.specialEntity then
		return
	end

	local entityMO = entity:getMO()

	if entityMO and FightCardDataHelper.isBigSkill(curSkillId) and entity.id ~= self.entity.id then
		self.specialEntity:setActive(true)
	end
end

function FightHero4_1PSTComp:onSpineLoaded(spine)
	if spine.entityId == self.specialEntityId then
		self.specialSpineLoadDone = true

		self:showEntity()
	end
end

function FightHero4_1PSTComp:onBuffUpdate(entityId, effectType, buffId, buffUid)
	if entityId ~= self.entityId then
		return
	end

	local buffCo = lua_skill_buff.configDict[buffId]

	if not buffCo then
		return
	end

	local featuresSplit = self.entityMo:getFeaturesSplitInfoByBuffId(buffId)

	if not featuresSplit then
		return
	end

	for _, oneFeature in ipairs(featuresSplit) do
		if oneFeature[1] == self.buffActId then
			self:refreshSpine()

			return
		end
	end
end

function FightHero4_1PSTComp:refreshSpine()
	if not self.spineCo then
		return
	end

	local isDead = self.entityMo:isStatusDead()

	if not isDead and self.entityMo:hasBuffActId(self.buffActId) then
		self:createSpine()
	else
		self:removeSpine()
	end
end

function FightHero4_1PSTComp:createSpine()
	if self.specialEntity then
		self:showEntity()

		return
	end

	local resPath = string.format("roles/%s.prefab", self.spineCo.spineRes)

	self.specialEntity = FightGameMgr.entityMgr:buildTempSpine(resPath, self.specialEntityId, self.side, nil, FightEntitySpecialMuOu, self.specialEntityName)

	self.specialEntity:setSrcEntityMo(self.entityMo)
	self.specialEntity:setSpecialCo(self.spineCo)
	self.specialEntity.spine:addAnimEventCallback(self.onAnimEvent, self)
	self:showEntity()
end

function FightHero4_1PSTComp:showEntity()
	if not self.specialSpineLoadDone then
		return
	end

	if not self.specialEntity then
		return
	end

	if self.status == Status.Normal then
		return
	end

	if self.status == Status.Dying then
		TaskDispatcher.cancelTask(self._removeSpine, self)
	end

	self.status = Status.Normal

	self.specialEntity:resetStandPos()
	self.specialEntity:setScale(self.spineCo.scale)
	self:showSpecialEntityNameUi()
	self.specialEntity.spine:playAnim(self.spineCo.actionName, false, true)

	self.bornEffect = self.specialEntity.effect:addHangEffect(self.spineCo.bornEffect, self.spineCo.bornHangPoint, nil, self.spineCo.bornDuration)

	self.bornEffect:setLocalPos(0, 0, 0)
	FightRenderOrderMgr.instance:onAddEffectWrap(self.specialEntityId, self.bornEffect)

	local bornAudio = self.spineCo.bornAudio

	if bornAudio > 0 then
		AudioMgr.instance:trigger(bornAudio)
	end
end

function FightHero4_1PSTComp:onAnimEvent(actionName, eventName)
	if eventName == SpineAnimEvent.ActionComplete and actionName ~= "idle" then
		self.specialEntity:resetAnimState(true)
	end
end

function FightHero4_1PSTComp:removeSpine()
	if not self.specialEntity then
		self:_removeSpine()

		return
	end

	if self.status == Status.Dying then
		return
	end

	self.status = Status.Dying

	self.specialEntity.spine:playAnim("die", false, true)

	self.dieEffect = self.specialEntity.effect:addHangEffect(self.spineCo.dieEffect, self.spineCo.dieHangPoint, nil, self.spineCo.dieDuration)

	self.dieEffect:setLocalPos(0, 0, 0)
	FightRenderOrderMgr.instance:onAddEffectWrap(self.specialEntityId, self.dieEffect)

	local dieAudio = self.spineCo.dieAudio

	if dieAudio > 0 then
		AudioMgr.instance:trigger(dieAudio)
	end

	TaskDispatcher.cancelTask(self._removeSpine, self)
	TaskDispatcher.runDelay(self._removeSpine, self, self.spineCo.dieDuration)
end

function FightHero4_1PSTComp:_removeSpine()
	if self.specialEntity then
		self.specialEntity.spine:removeAnimEventCallback(self.onAnimEvent, self)
		FightGameMgr.entityMgr:delEntity(self.specialEntityId)

		self.specialEntity = nil
		self.specialSpineLoadDone = nil
	end

	self:hideSpecialEntityNameUi()

	self.status = Status.Dead
end

function FightHero4_1PSTComp:showSpecialEntityNameUi()
	if not self.nameUiComp then
		self.nameUiComp = FightPSTMuOuNameUI.New()

		self.nameUiComp:init(self.entityMo)
	end

	self.nameUiComp:setSpecialEntity(self.specialEntity)
	self.nameUiComp:setActive(true)
end

function FightHero4_1PSTComp:hideSpecialEntityNameUi()
	if not self.nameUiComp then
		return
	end

	self.nameUiComp:setSpecialEntity(nil)
	self.nameUiComp:setActive(false)
end

function FightHero4_1PSTComp:onDestroy()
	self:_removeSpine()

	if self.nameUiComp then
		self.nameUiComp:destroy()
	end

	TaskDispatcher.cancelTask(self._removeSpine, self)
	FightHero4_1PSTComp.super.onDestroy(self)
end

return FightHero4_1PSTComp
