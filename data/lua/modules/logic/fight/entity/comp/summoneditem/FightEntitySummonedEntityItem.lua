-- chunkname: @modules/logic/fight/entity/comp/summoneditem/FightEntitySummonedEntityItem.lua

module("modules.logic.fight.entity.comp.summoneditem.FightEntitySummonedEntityItem", package.seeall)

local FightEntitySummonedEntityItem = class("FightEntitySummonedEntityItem", FightBaseClass)

function FightEntitySummonedEntityItem:onConstructor(entity, data, config)
	self.entity = entity
	self.entityData = entity.entityData

	if not self.entityData then
		return
	end

	self.data = data
	self.config = config
	self.uid = data.uid

	local replaceConfig = lua_fight_entity_summoned_replace_by_skin.configDict[config.keyForEntiySummon][self.entityData.skin]

	replaceConfig = replaceConfig or lua_fight_entity_summoned_replace_by_skin.configDict[config.keyForEntiySummon][0]
	self.skin = replaceConfig.keyForEntiySummonSkinId
	self.skinConfig = lua_monster_skin

	local stanceConfig = lua_fight_summoned_stance.configDict[config.stanceId]

	if stanceConfig then
		local tab = stanceConfig["pos" .. data.stanceIndex]

		self.posX, self.posY, self.posZ = tab[1] or 0, tab[2] or 0, tab[3] or 0
	else
		self.posX, self.posY, self.posZ = 0, 0, 0
	end

	self:com_registFightEvent(FightEvent.SummonedDelete, self.onSummonedDelete)
	self:com_registMsg(FightMsgId.GetSummonedEntity, self.onGetSummonedEntity)
	self:showSpine()
end

function FightEntitySummonedEntityItem:onGetSummonedEntity(entityId)
	if entityId == self.entity.id then
		FightMsgMgr.replyMsg(FightMsgId.GetSummonedEntity, self.summonedEntity)
	end
end

function FightEntitySummonedEntityItem:showSpine()
	local fakeEntityData = FightEntityMO.New()

	self.fakeEntityData = fakeEntityData

	fakeEntityData:init(FightDef_pb.FightEntityInfo())

	fakeEntityData.uid = "summonedFakeEntity" .. FightObject.Counter
	fakeEntityData.id = fakeEntityData.uid
	fakeEntityData.skin = self.skin
	fakeEntityData.side = self.entityData.side
	fakeEntityData.IS_SUMMONED_ENTITY = true
	fakeEntityData.SUMMONED_ENTITY_FROM_ID = self.entity.id
	self._containerGO = self.entity.go
	self.summonedEntity = self:newClass(FightSummonedFakeEntityObject, fakeEntityData.id, fakeEntityData)

	local flow = self:com_registFlowSequence()

	flow:addWork(self.summonedEntity:registLoadSpineWork())
	flow:registWork(FightWorkFunction, self.setSpinePos, self)
	flow:start()
end

function FightEntitySummonedEntityItem:setSpinePos()
	local obj = self.summonedEntity.spine:getSpineGO()

	if obj then
		transformhelper.setLocalPos(obj.transform, self.posX, self.posY, self.posZ)
	end

	self.summonedEntity:setAlpha(0, 0)
	self.summonedEntity:setAlpha(1, 1)
end

function FightEntitySummonedEntityItem:onSummonedDelete()
	self:disposeSelf()
end

function FightEntitySummonedEntityItem:onDestructor()
	return
end

return FightEntitySummonedEntityItem
