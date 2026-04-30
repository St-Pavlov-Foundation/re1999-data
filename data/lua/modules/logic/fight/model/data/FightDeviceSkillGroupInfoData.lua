-- chunkname: @modules/logic/fight/model/data/FightDeviceSkillGroupInfoData.lua

module("modules.logic.fight.model.data.FightDeviceSkillGroupInfoData", package.seeall)

local FightDeviceSkillGroupInfoData = FightDataClass("FightDeviceSkillGroupInfoData")

function FightDeviceSkillGroupInfoData:onConstructor(proto)
	self.skills = {}

	for _, v in ipairs(proto.skills) do
		table.insert(self.skills, FightDeviceSkillInfoData.New(v))
	end
end

return FightDeviceSkillGroupInfoData
