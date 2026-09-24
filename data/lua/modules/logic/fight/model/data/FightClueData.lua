-- chunkname: @modules/logic/fight/model/data/FightClueData.lua

module("modules.logic.fight.model.data.FightClueData", package.seeall)

local FightClueData = FightDataClass("FightClueData")

function FightClueData:onConstructor(proto)
	self.uid = proto and proto.uid or 0
	self.entityUid = proto and proto.entityUid or 0
	self.clueId = proto and proto.clueId or 0
end

function FightClueData:updateByInfo(info)
	if not info then
		return
	end

	self.uid = info.uid
	self.entityUid = info.entityUid
	self.clueId = info.clueId
end

return FightClueData
