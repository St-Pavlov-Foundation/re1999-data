﻿-- chunkname: @modules/logic/room/entity/RoomCharacterFootPrintEntity.lua

module("modules.logic.room.entity.RoomCharacterFootPrintEntity", package.seeall)

local RoomCharacterFootPrintEntity = class("RoomCharacterFootPrintEntity", RoomBaseEntity)

function RoomCharacterFootPrintEntity:ctor(entityId)
	RoomCharacterFootPrintEntity.super.ctor(self)

	self.id = entityId
	self.entityId = self.id
	self._keyParamDict = {}
	self._resRightPath = RoomResHelper.getCharacterEffectPath(RoomCharacterEnum.CommonEffect.RightFoot)
	self._resRightAb = RoomResHelper.getCharacterEffectABPath(RoomCharacterEnum.CommonEffect.RightFoot)
	self._resLeftPath = RoomResHelper.getCharacterEffectPath(RoomCharacterEnum.CommonEffect.LeftFoot)
	self._resLeftAb = RoomResHelper.getCharacterEffectABPath(RoomCharacterEnum.CommonEffect.LeftFoot)
end

function RoomCharacterFootPrintEntity:getTag()
	return SceneTag.Untagged
end

function RoomCharacterFootPrintEntity:init(go)
	self.containerGO = gohelper.create3d(go, RoomEnum.EntityChildKey.ContainerGOKey)
	self.staticContainerGO = self.containerGO
	self.goTrs = go.transform

	RoomCharacterFootPrintEntity.super.init(self, go)
	RoomMapController.instance:registerCallback(RoomEvent.AddCharacterFootPrint, self._addFootPrintEffect, self)
end

function RoomCharacterFootPrintEntity:initComponents()
	self:addComp("effect", RoomEffectComp)
end

function RoomCharacterFootPrintEntity:onStart()
	RoomCharacterFootPrintEntity.super.onStart(self)
end

function RoomCharacterFootPrintEntity:setLocalPos(x, y, z)
	transformhelper.setLocalPos(self.goTrs, x, y, z)
end

function RoomCharacterFootPrintEntity:getMO()
	return nil
end

function RoomCharacterFootPrintEntity:beforeDestroy()
	RoomCharacterFootPrintEntity.super.beforeDestroy(self)
	RoomMapController.instance:unregisterCallback(RoomEvent.AddCharacterFootPrint, self._addFootPrintEffect, self)
end

function RoomCharacterFootPrintEntity:_addFootPrintEffect(rotationV3, position, isLeft)
	local delayDestroy = 5
	local effectKey = self:_findEffectKey()

	self.effect:addParams({
		[effectKey] = {
			res = isLeft and self._resLeftPath or self._resRightPath,
			ab = isLeft and self._resLeftAb or self._resRightAb,
			localPos = position,
			localRotation = rotationV3
		}
	}, delayDestroy)
	self.effect:refreshEffect()
end

function RoomCharacterFootPrintEntity:_findEffectKey()
	local index = 1

	while self.effect:isHasEffectGOByKey(self:_getKeyByIndex(index)) do
		index = index + 1
	end

	return self:_getKeyByIndex(index)
end

function RoomCharacterFootPrintEntity:_getKeyByIndex(index)
	if not self._keyParamDict[index] then
		self._keyParamDict[index] = string.format("footprint_%s", index)
	end

	return self._keyParamDict[index]
end

function RoomCharacterFootPrintEntity:onEffectRebuild()
	return
end

return RoomCharacterFootPrintEntity
