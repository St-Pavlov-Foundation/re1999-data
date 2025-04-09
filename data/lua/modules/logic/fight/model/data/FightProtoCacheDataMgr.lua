module("modules.logic.fight.model.data.FightProtoCacheDataMgr", package.seeall)

slot0 = FightDataClass("FightProtoCacheDataMgr", FightDataMgrBase)

function slot0.onConstructor(slot0)
	slot0.roundProtoList = {}
	slot0.fightProtoList = {}
end

function slot0.addFightProto(slot0, slot1)
	table.insert(slot0.fightProtoList, slot1)
end

function slot0.addRoundProto(slot0, slot1)
	table.insert(slot0.roundProtoList, slot1)
end

function slot0.getLastRoundProto(slot0)
	return slot0.roundProtoList[#slot0.roundProtoList]
end

function slot0.getPreRoundProto(slot0)
	return slot0.roundProtoList[#slot0.roundProtoList - 1]
end

function slot0.getLastRoundNum(slot0)
	if slot0:getPreRoundProto() then
		return slot1.curRound
	end
end

function slot0.getRoundNumByRoundProto(slot0, slot1)
	slot2 = nil

	for slot6, slot7 in ipairs(slot0.roundProtoList) do
		if slot7 == slot1 then
			slot2 = slot0.roundProtoList[slot6 - 1]

			break
		end
	end

	if slot2 then
		return slot2.curRound
	end
end

return slot0
