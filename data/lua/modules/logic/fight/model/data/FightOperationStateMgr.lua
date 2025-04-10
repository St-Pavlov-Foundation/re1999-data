module("modules.logic.fight.model.data.FightOperationStateMgr", package.seeall)

slot0 = FightDataClass("FightOperationStateMgr", FightDataMgrBase)
slot0.StateType = {
	PlayHandCard = GameUtil.getEnumId(),
	PlayAssistBossCard = GameUtil.getEnumId(),
	PlayPlayerFinisherSkill = GameUtil.getEnumId(),
	MoveHandCard = GameUtil.getEnumId()
}

function slot0.onConstructor(slot0)
	slot0.operationStates = {}
end

function slot0.onCancelOperation(slot0)
	tabletool.clear(slot0.operationStates)
end

function slot0.onStageChanged(slot0)
	if #slot0.operationStates > 0 then
		logError("战斗阶段改变了，但是操作状态列表中还有值，")
	end

	tabletool.clear(slot0.operationStates)
end

function slot0.enterOperationState(slot0, slot1)
	table.insert(slot0.operationStates, slot1)
end

function slot0.exitOperationState(slot0, slot1)
	for slot5 = #slot0.operationStates, 1, -1 do
		if slot0.operationStates[slot5] == slot1 then
			table.remove(slot0.operationStates, slot5)
		end
	end
end

return slot0
