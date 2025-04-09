module("modules.logic.fight.model.data.FightRoundDataMgr", package.seeall)

slot0 = FightDataClass("FightRoundDataMgr", FightDataMgrBase)

function slot0.onConstructor(slot0)
	slot0.dataList = {}

	if isDebugBuild then
		slot0.originDataList = {}
	end

	slot0.curRoundData = nil
	slot0.originCurRoundData = nil
	slot0.enterData = nil
end

function slot0.setRoundData(slot0, slot1)
	slot0.curRoundData = slot1

	table.insert(slot0.dataList, slot1)
end

function slot0.setOriginRoundData(slot0, slot1)
	slot0.originCurRoundData = slot1

	table.insert(slot0.originDataList, slot0.originCurRoundData)
end

function slot0.getRoundData(slot0)
	return slot0.curRoundData
end

function slot0.getPreRoundData(slot0)
	return slot0.dataList[#slot0.dataList - 1]
end

function slot0.getOriginRoundData(slot0)
	return slot0.originCurRoundData
end

function slot0.getOriginPreRoundData(slot0)
	return slot0.originDataList[#slot0.originDataList - 1]
end

function slot0.onCancelOperation(slot0)
end

function slot0.onStageChanged(slot0)
end

return slot0
