module("modules.logic.fight.model.data.FightOperationDataMgr", package.seeall)

slot0 = FightDataClass("FightOperationDataMgr", FightDataMgrBase)

function slot0.onConstructor(slot0)
	slot0.actPoint = 0
	slot0.moveNum = 0
	slot0.extraMoveAct = 0
	slot0.operationList = {}
	slot0.extraMoveUsedCount = 0
	slot0.playerFinisherSkillUsedCount = nil
	slot0.curSelectEntityId = 0
end

function slot0.getOpList(slot0)
	return slot0.operationList
end

function slot0.dealCardInfoPush(slot0, slot1)
	slot0.actPoint = slot1.actPoint
	slot0.moveNum = slot1.moveNum
	slot0.extraMoveAct = slot1.extraMoveAct
end

function slot0.isUnlimitMoveCard(slot0)
	return slot0.extraMoveAct == -1
end

function slot0.clearClientSimulationData(slot0)
	tabletool.clear(slot0.operationList)

	slot0.extraMoveUsedCount = 0
	slot0.playerFinisherSkillUsedCount = nil
end

function slot0.onCancelOperation(slot0)
	slot0:clearClientSimulationData()

	for slot5, slot6 in pairs(FightDataHelper.entityMgr:getAllEntityData()) do
		slot6:resetSimulateExPoint()
	end
end

function slot0.onStageChanged(slot0, slot1)
	slot0:clearClientSimulationData()

	if slot1 == FightStageMgr.StageType.Play and slot0.dataMgr.stageMgr:getCurStageParam() == FightStageMgr.PlayType.Normal then
		slot0.extraMoveAct = 0
	end
end

function slot0.addOperation(slot0, slot1)
	table.insert(slot0.operationList, slot1)
end

function slot0.newOperation(slot0)
	slot1 = FightOperationItemData.New()

	table.insert(slot0.operationList, slot1)

	return slot1
end

function slot0.getEntityOps(slot0, slot1, slot2)
	slot3 = {}

	for slot7, slot8 in ipairs(slot0.operationList) do
		if slot8.belongToEntityId == slot1 and (not slot2 or slot8.operType == slot2) then
			table.insert(slot3, slot8)
		end
	end

	return slot3
end

function slot0.getShowOpActList(slot0)
	slot1 = {}

	for slot5, slot6 in ipairs(slot0.operationList) do
		if slot0:canShowOpAct(slot6) then
			table.insert(slot1, slot6)
		end
	end

	return slot1
end

function slot0.canShowOpAct(slot0, slot1)
	if not slot1:isMoveUniversal() and (not slot1:isMoveCard() or not slot0:isUnlimitMoveCard() or slot1:isPlayCard()) then
		return true
	end
end

function slot0.getPlayCardOpList(slot0)
	slot1 = {}

	for slot5, slot6 in ipairs(slot0.operationList) do
		if FightCardDataHelper.checkOpAsPlayCardHandle(slot6) then
			table.insert(slot1, slot6)
		end
	end

	return slot1
end

function slot0.getMoveCardOpList(slot0)
	slot1 = {}

	for slot5, slot6 in ipairs(slot0.operationList) do
		if slot6:isMoveCard() then
			table.insert(slot1, slot6)
		end
	end

	return slot1
end

function slot0.getMoveCardOpCostActList(slot0)
	slot1 = {}

	for slot5, slot6 in ipairs(slot0.operationList) do
		if slot6:isMoveCard() then
			table.insert(slot1, slot6)
		end
	end

	return slot1
end

function slot0.isCardOpEnd(slot0)
	if #slot0.dataMgr.handCardMgr.handCard == 0 then
		return true
	end

	slot3 = slot0.dataMgr.fieldMgr
	slot6 = 0

	for slot10, slot11 in ipairs(slot0.operationList) do
		if slot11:isPlayCard() then
			slot5 = 0 + slot11.costActPoint
		elseif slot11:isMoveCard() then
			if not slot0:isUnlimitMoveCard() and slot0.extraMoveAct < slot6 + 1 then
				slot5 = slot5 + slot11.costActPoint
			end
		end
	end

	slot7 = slot0.actPoint

	if slot3:isSeason2() then
		slot7 = 1

		if #slot4 >= 1 then
			return true
		end
	end

	if slot7 <= slot5 then
		return true
	end

	if FightCardDataHelper.allFrozenCard(slot1) then
		return true
	end

	return false
end

function slot0.getLeftExtraMoveCount(slot0)
	if slot0.extraMoveAct < 0 then
		return slot0.extraMoveAct
	end

	return slot0.extraMoveAct - slot0.extraMoveUsedCount
end

function slot0.setCurSelectEntityId(slot0, slot1)
	slot0.curSelectEntityId = slot1
end

function slot0.resetCurSelectEntityIdDefault(slot0)
	if FightModel.instance:isAuto() then
		if FightHelper.canSelectEnemyEntity(slot0.curSelectEntityId) then
			slot0:setCurSelectEntityId(slot0.curSelectEntityId)
		else
			slot0:setCurSelectEntityId(0)
		end
	else
		if FightDataHelper.entityMgr:getById(slot0.curSelectEntityId) and slot1:isStatusDead() then
			slot1 = nil
		end

		if slot1 and slot1.side == FightEnum.EntitySide.MySide then
			slot0.curSelectEntityId = 0
			slot1 = nil
		end

		if slot0.curSelectEntityId ~= 0 and slot1 ~= nil and not (slot1 and slot1:hasBuffFeature(FightEnum.BuffType_CantSelect)) and not (slot1 and slot1:hasBuffFeature(FightEnum.BuffType_CantSelectEx)) then
			return
		end

		for slot9 = #FightDataHelper.entityMgr:getEnemyNormalList(), 1, -1 do
			if slot5[slot9]:hasBuffFeature(FightEnum.BuffType_CantSelect) or slot10:hasBuffFeature(FightEnum.BuffType_CantSelectEx) then
				table.remove(slot5, slot9)
			end
		end

		if #slot5 > 0 then
			table.sort(slot5, function (slot0, slot1)
				return slot0.position < slot1.position
			end)
			slot0:setCurSelectEntityId(slot5[1].id)
		end
	end
end

function slot0.getSelectEnemyPosLOrR(slot0, slot1)
	for slot6 = #FightDataHelper.entityMgr:getEnemyNormalList(), 1, -1 do
		if slot2[slot6]:hasBuffFeature(FightEnum.BuffType_CantSelect) or slot7:hasBuffFeature(FightEnum.BuffType_CantSelectEx) then
			table.remove(slot2, slot6)
		end
	end

	if #slot2 > 0 then
		table.sort(slot2, function (slot0, slot1)
			return slot0.position < slot1.position
		end)

		for slot6 = 1, #slot2 do
			if slot2[slot6].id == slot0.curSelectEntityId then
				if slot1 == 1 and slot6 < #slot2 then
					return slot2[slot6 + 1].id
				elseif slot1 == 2 and slot6 > 1 then
					return slot2[slot6 - 1].id
				end
			end
		end
	end
end

function slot0.applyNextRoundActPoint(slot0)
	slot0.actPoint = slot0.dataMgr.roundMgr.curRoundData.actPoint or slot0.actPoint
end

return slot0
