-- chunkname: @modules/logic/fight/model/data/FightDeviceSkillInfoData.lua

module("modules.logic.fight.model.data.FightDeviceSkillInfoData", package.seeall)

local FightDeviceSkillInfoData = FightDataClass("FightDeviceSkillInfoData")

function FightDeviceSkillInfoData:onConstructor(proto)
	self.skillId = proto.skillId
	self.costType = proto.costType
	self.costValue = proto.costValue
end

return FightDeviceSkillInfoData
