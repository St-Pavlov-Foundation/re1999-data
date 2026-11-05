-- chunkname: @modules/logic/fight/model/data/FightHealInfoData.lua

module("modules.logic.fight.model.data.FightHealInfoData", package.seeall)

local FightHealInfoData = FightDataClass("FightHealInfoData")

function FightHealInfoData:onConstructor(proto)
	self:initClientField()

	self.toUid = proto.toUid
	self.healHp = proto.healHp
	self.realHealHp = proto.realHealHp

	if proto:HasField("fromUid") then
		self.fromUid = proto.fromUid
	end

	if proto:HasField("reason") then
		self:parseReason(proto.reason)
	end
end

function FightHealInfoData:parseReason(reason)
	self.type = reason.type
	self.skillId = reason.skillId
	self.effectId = reason.effectId
	self.configEffect = reason.configEffect
	self.buffUid = reason.buffUid
	self.buffActId = reason.buffActId
end

function FightHealInfoData:initClientField()
	self.client_healHp = 0
end

return FightHealInfoData
