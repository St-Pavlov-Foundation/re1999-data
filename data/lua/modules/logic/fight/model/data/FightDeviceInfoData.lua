-- chunkname: @modules/logic/fight/model/data/FightDeviceInfoData.lua

module("modules.logic.fight.model.data.FightDeviceInfoData", package.seeall)

local FightDeviceInfoData = FightDataClass("FightDeviceInfoData")

function FightDeviceInfoData:onConstructor(proto)
	self.skills = {}

	for _, v in ipairs(proto.skills) do
		table.insert(self.skills, FightDeviceSkillGroupInfoData.New(v))
	end

	self.index = proto.index
	self.uid = proto.uid
	self.clientIndex = self.index
end

function FightDeviceInfoData:getCurSkillInfoData()
	local groupInfoData = self.skills[self.index]

	return groupInfoData.skills[1]
end

function FightDeviceInfoData:changeClientIndex(index)
	self.clientIndex = index

	FightController.instance:dispatchEvent(FightEvent.OnDevice_SwitchGroup, self.uid, self.clientIndex)
end

function FightDeviceInfoData:applyClientChange()
	self.index = self.clientIndex
end

function FightDeviceInfoData:resetClientChange()
	self.clientIndex = self.index
end

function FightDeviceInfoData:autoRoundSetIndex(index)
	self.index = index
	self.clientIndex = index
end

function FightDeviceInfoData:actEffectSetIndex(index)
	self.index = index
	self.clientIndex = index
end

return FightDeviceInfoData
