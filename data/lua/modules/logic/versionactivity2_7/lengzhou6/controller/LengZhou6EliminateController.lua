module("modules.logic.versionactivity2_7.lengzhou6.controller.LengZhou6EliminateController", package.seeall)

slot0 = class("LengZhou6EliminateController", BaseController)

function slot0.onInit(slot0)
end

function slot0.enterLevel(slot0, slot1)
	slot0:initEliminateData(slot1)
	slot0:resetCurEliminateCount()
end

function slot0.initEliminateData(slot0, slot1)
	slot3 = LengZhou6EliminateConfig.instance:getEliminateChessLevelConfig(slot1)

	if LengZhou6GameModel.instance:getRecordServerData() and slot2._data and slot2._data.chessData and tabletool.len(slot2._data.chessData) > 0 then
		slot3 = slot2._data.chessData
	end

	LocalEliminateChessModel.instance:initByData(slot3)
end

function slot0.exchangeCell(slot0, slot1, slot2, slot3, slot4)
	slot0:recordExchangePos(slot1, slot2, slot3, slot4)
	LocalEliminateChessModel.instance:_exchangeCell(slot1, slot2, slot3, slot4)
	slot0:exchangeCellShow(slot1, slot2, slot3, slot4, EliminateEnum.AniTime.Move)

	if not LocalEliminateChessModel.instance:exchangeCell(slot1, slot2, slot3, slot4, false) then
		if #slot0._lastExchangePos > 0 then
			slot0:buildSeqFlow(EliminateStepUtil.createStep(EliminateEnum.StepWorkType.EliminateChessRevert))
		end
	else
		slot0:buildSeqFlow(EliminateStepUtil.createStep(EliminateEnum.StepWorkType.CheckEliminate, true))
	end

	return slot5
end

function slot0.revertRecord(slot0)
	slot1, slot2, slot3, slot4 = slot0:getRecordExchangePos()

	LocalEliminateChessModel.instance:_exchangeCell(slot1, slot2, slot3, slot4)
	slot0:exchangeCellShow(slot1, slot2, slot3, slot4, EliminateEnum.AniTime.MoveRevert)
	slot0:clearRecord()
	slot0:setFlowEndState(true)
end

function slot0.eliminateCheck(slot0, slot1)
	if LocalEliminateChessModel.instance:check(true, false) then
		LocalEliminateChessModel.instance:checkEliminate()
		slot0:handleEliminate()
		slot0:handleDrop()
		LocalEliminateChessModel.instance:getEliminateRecordShowData():reset()

		slot4 = nil

		if isDebugBuild then
			slot0:buildSeqFlow(EliminateStepUtil.createStep(EliminateEnum.StepWorkType.EliminateChessDebug2_7))
		end

		slot0:calCurEliminateCount()
		slot0:dispatchEvent(LengZhou6Event.ShowCombos, slot0._eliminateCount)
		LengZhou6GameController.instance:playerSettle()
		LengZhou6GameModel.instance:setCurGameStep(LengZhou6Enum.BattleStep.addBuff)
		slot0:buildSeqFlow(EliminateStepUtil.createStep(EliminateEnum.StepWorkType.CheckEliminate, slot1))
	else
		LengZhou6GameController.instance:gameUpdateRound(slot1)
		slot0:buildSeqFlow(EliminateStepUtil.createStep(EliminateEnum.StepWorkType.EliminateChessUpdateGameInfo))
		slot0:setFlowEndState(true)
	end

	slot0:clearRecord()

	return slot2
end

function slot0.calCurEliminateCount(slot0)
	slot3 = true

	for slot7, slot8 in pairs(LocalEliminateChessModel.instance:getCurEliminateRecordData():getEliminateTypeMap()) do
		if slot8[1] ~= nil and slot9.eliminateType == EliminateEnum_2_7.eliminateType.base then
			slot3 = false

			break
		end

		if slot3 then
			slot0._eliminateCount = slot0._eliminateCount + #slot8
		end
	end

	if not slot3 then
		slot0._eliminateCount = slot0._eliminateCount + 1
	end
end

function slot0.dispatchShowAssess(slot0)
	slot1 = nil

	for slot5 = 1, #EliminateEnum_2_7.AssessLevel do
		if EliminateEnum_2_7.AssessLevel[slot5] <= slot0._eliminateCount then
			slot1 = slot5
		end
	end

	if slot1 ~= nil then
		slot0:dispatchEvent(LengZhou6Event.ShowAssess, slot1)
	end

	return slot1
end

function slot0.resetCurEliminateCount(slot0)
	slot0._eliminateCount = 0
end

function slot0.setDieType(slot0)
end

function slot0.handleEliminate(slot0)
	slot1 = LocalEliminateChessModel.instance:getEliminateRecordShowData()
	slot3 = slot1:getEliminate()
	slot5 = FlowParallel.New()

	for slot10 = 1, #slot1:getChangeType() / 3 do
		FlowParallel.New():addWork(EliminateStepUtil.createStep(EliminateEnum.StepWorkType.ChangeState, {
			x = slot2[slot10 * 3 - 2],
			y = slot2[slot10 * 3 - 1],
			fromState = slot2[slot10 * 3]
		}))
	end

	for slot11 = 1, #slot3 / 3 do
		slot5:addWork(EliminateStepUtil.createStep(EliminateEnum.StepWorkType.DieEffect, {
			x = slot3[slot11 * 3 - 2],
			y = slot3[slot11 * 3 - 1],
			skillEffect = slot3[slot11 * 3]
		}))
	end

	slot9 = AudioEnum2_7.LengZhou6.play_ui_yuzhou_lzl_boom

	if LocalEliminateChessModel.instance:getEliminateDieEffect() and slot8 == LengZhou6Enum.SkillEffect.EliminationRange then
		slot9 = AudioEnum2_7.LengZhou6.play_ui_yuzhou_lzl_explosion

		LocalEliminateChessModel.instance:setEliminateDieEffect(nil)
	end

	if slot8 and slot8 == LengZhou6Enum.SkillEffect.EliminationCross then
		slot9 = AudioEnum2_7.LengZhou6.play_ui_yuzhou_lzl_combustion

		LocalEliminateChessModel.instance:setEliminateDieEffect(nil)
	end

	slot5:addWork(EliminateStepUtil.createStep(EliminateEnum.StepWorkType.PlayAudio, slot9))
	slot0:buildSeqFlow(slot4)
	slot0:buildSeqFlow(slot5)
end

function slot0.handleDrop(slot0)
	slot1 = LocalEliminateChessModel.instance:getEliminateRecordShowData()

	if not slot1:getMove() or not slot1:getNew() then
		return
	end

	slot4 = {}

	for slot10 = 1, #slot2 / 4 do
		slot15 = LengZhou6EliminateChessItemController.instance:getChessItem(slot2[slot10 * 4 - 3], slot2[slot10 * 4 - 2])

		FlowParallel.New():addWork(EliminateStepUtil.createStep(EliminateEnum.StepWorkType.Move, EliminateStepUtil.createOrGetMoveStepTable(slot15, EliminateEnum.AniTime.Drop, EliminateEnum.AnimType.drop)))

		slot4[#slot4 + 1] = {
			x = slot2[slot10 * 4 - 1],
			y = slot2[slot10 * 4],
			viewItem = slot15
		}
	end

	for slot10 = 1, #slot3 / 2 do
		slot11 = slot3[slot10 * 2 - 1]
		slot12 = slot3[slot10 * 2]
		slot14 = LengZhou6EliminateChessItemController.instance:createChess(slot11, slot12)

		slot14:initData(LocalEliminateChessModel.instance:getCell(slot11, slot12))
		slot5:addWork(EliminateStepUtil.createStep(EliminateEnum.StepWorkType.Move, EliminateStepUtil.createOrGetMoveStepTable(slot14, EliminateEnum.AniTime.Drop, EliminateEnum.AnimType.drop)))

		slot4[#slot4 + 1] = {
			x = slot11,
			y = slot12,
			viewItem = slot14
		}
	end

	slot0:buildSeqFlow(slot5)
	slot0:buildSeqFlow(EliminateStepUtil.createStep(EliminateEnum.StepWorkType.Arrange_XY, slot4))
end

function slot0.updateAllItemPos(slot0, slot1)
	if slot1 == nil then
		return
	end

	slot2 = {}
	slot3 = FlowParallel.New()

	for slot8 = 1, #slot1 / 4 do
		slot11 = slot1[slot8 * 4 - 1]
		slot12 = slot1[slot8 * 4]

		slot3:addWork(EliminateStepUtil.createStep(EliminateEnum.StepWorkType.Move, EliminateStepUtil.createOrGetMoveStepTable(LengZhou6EliminateChessItemController.instance:getChessItem(slot1[slot8 * 4 - 3], slot1[slot8 * 4 - 2]), EliminateEnum.AniTime.Move, EliminateEnum.AnimType.move)))
		slot3:addWork(EliminateStepUtil.createStep(EliminateEnum.StepWorkType.Move, EliminateStepUtil.createOrGetMoveStepTable(LengZhou6EliminateChessItemController.instance:getChessItem(slot11, slot12), EliminateEnum.AniTime.Move, EliminateEnum.AnimType.move)))
		table.insert(slot2, {
			x = slot11,
			y = slot12
		})
	end

	slot0:buildSeqFlow(slot3)
	slot0:buildSeqFlow(EliminateStepUtil.createStep(EliminateEnum.StepWorkType.Arrange_XY, slot2))

	if isDebugBuild then
		slot0:buildSeqFlow(EliminateStepUtil.createStep(EliminateEnum.StepWorkType.EliminateChessDebug2_7))
	end

	slot0:buildSeqFlow(EliminateStepUtil.createStep(EliminateEnum.StepWorkType.CheckEliminate, false))
end

function slot0.recordExchangePos(slot0, slot1, slot2, slot3, slot4)
	if not slot0._lastExchangePos then
		slot0._lastExchangePos = {}
	end

	slot0._lastExchangePos[#slot0._lastExchangePos + 1] = slot1
	slot0._lastExchangePos[#slot0._lastExchangePos + 1] = slot2
	slot0._lastExchangePos[#slot0._lastExchangePos + 1] = slot3
	slot0._lastExchangePos[#slot0._lastExchangePos + 1] = slot4
end

function slot0.getRecordExchangePos(slot0)
	return slot0._lastExchangePos[1], slot0._lastExchangePos[2], slot0._lastExchangePos[3], slot0._lastExchangePos[4]
end

function slot0.clearRecord(slot0)
	if slot0._lastExchangePos == nil then
		return
	end

	tabletool.clear(slot0._lastExchangePos)
end

function slot0.exchangeCellShow(slot0, slot1, slot2, slot3, slot4, slot5)
	slot6 = {}

	slot0:buildSeqFlow(slot0:buildParallelFlow(EliminateStepUtil.createStep(EliminateEnum.StepWorkType.Move, EliminateStepUtil.createOrGetMoveStepTable(LengZhou6EliminateChessItemController.instance:getChessItem(slot1, slot2), slot5, EliminateEnum.AnimType.move)), EliminateStepUtil.createStep(EliminateEnum.StepWorkType.Move, EliminateStepUtil.createOrGetMoveStepTable(LengZhou6EliminateChessItemController.instance:getChessItem(slot3, slot4), slot5, EliminateEnum.AnimType.move))))

	slot6[#slot6 + 1] = {
		x = slot3,
		y = slot4,
		viewItem = LengZhou6EliminateChessItemController.instance:getChessItem(slot1, slot2)
	}
	slot6[#slot6 + 1] = {
		x = slot1,
		y = slot2,
		viewItem = LengZhou6EliminateChessItemController.instance:getChessItem(slot3, slot4)
	}

	slot0:buildSeqFlow(EliminateStepUtil.createStep(EliminateEnum.StepWorkType.Arrange_XY, slot6))

	if isDebugBuild then
		slot0:buildSeqFlow(EliminateStepUtil.createStep(EliminateEnum.StepWorkType.EliminateChessDebug2_7))
	end
end

function slot0.createInitMoveStepAndUpdatePos(slot0)
	LengZhou6EliminateChessItemController.instance:tempClearAllChess()
	LengZhou6EliminateChessItemController.instance:InitChess()
	slot0:createInitMoveStep()
end

function slot0.createInitMoveStep(slot0)
	slot2 = FlowParallel.New()

	for slot6, slot7 in ipairs(LengZhou6EliminateChessItemController.instance:getChess()) do
		for slot11, slot12 in pairs(slot7) do
			slot2:addWork(EliminateStepUtil.createStep(EliminateEnum.StepWorkType.Move, EliminateStepUtil.createOrGetMoveStepTable(slot12, EliminateEnum_2_7.InitDropTime * slot11, EliminateEnum.AnimType.init)))
		end
	end

	slot0:buildSeqFlow(slot2)
	slot0:setFlowEndState(true)
end

function slot0.buildSeqFlow(slot0, slot1)
	slot2 = slot0._seqStepFlow == nil
	slot0._seqStepFlow = slot0._seqStepFlow or FlowSequence.New()

	if slot1 then
		slot0._seqStepFlow:addWork(slot1)
	end

	if slot2 and slot0._seqStepFlow ~= nil then
		slot0:startSeqStepFlow()
	end

	return slot0._seqStepFlow
end

function slot0.buildParallelFlow(slot0, ...)
	slot1 = FlowParallel.New()

	if (... ~= nil and select("#", ...) or 0) > 0 then
		for slot7 = 1, slot3 do
			slot1:addWork(select(slot7, ...))
		end
	end

	return slot1
end

function slot0.getCurSeqStepFlow(slot0)
	return slot0._seqStepFlow
end

function slot0.startSeqStepFlow(slot0)
	if slot0._seqStepFlow ~= nil then
		slot0._seqStepFlow:registerDoneListener(slot0.seqFlowDone, slot0)
		slot0:dispatchEvent(LengZhou6Event.PerformBegin)
		slot0:setPerformIsFinish(false)
		slot0._seqStepFlow:start()
	end
end

function slot0.checkPerformEndState(slot0)
	if slot0._flowFullEnd and slot0._seqStepFlow == nil then
		slot0:dispatchEvent(LengZhou6Event.PerformEnd)
		slot0:setPerformIsFinish(true)
	end
end

function slot0.getPerformIsFinish(slot0)
	return slot0._performIsFinish
end

function slot0.setPerformIsFinish(slot0, slot1)
	slot0._performIsFinish = slot1
end

function slot0.setFlowEndState(slot0, slot1)
	slot0._flowFullEnd = slot1

	slot0:checkPerformEndState()
end

function slot0.seqFlowDone(slot0)
	slot0._seqStepFlow = nil

	slot0:checkPerformEndState()
end

function slot0.clearFlow(slot0)
	if slot0._seqStepFlow then
		slot0._seqStepFlow:onDestroyInternal()

		slot0._seqStepFlow = nil
	end
end

function slot0.checkAndSetNeedResetData(slot0, slot1)
	EliminateChessModel.instance:setNeedResetData(slot1)

	if (slot0._turnInfo == nil or #slot0._turnInfo == 0) and EliminateChessModel.instance:getNeedResetData() ~= nil then
		uv0.instance:buildSeqFlow(EliminateStepUtil.createStep(EliminateEnum.StepWorkType.RefreshEliminate))
	end
end

function slot0.checkState(slot0)
	if EliminateChessModel.instance:getMovePoint() <= 0 then
		uv0.instance:clearFlow()
		uv0.instance:buildSeqFlow(EliminateStepUtil.createStep(EliminateEnum.StepWorkType.EndShowView, {
			time = EliminateEnum.ShowEndTime,
			cb = function ()
				EliminateLevelController.instance:changeRoundToTeamChess()
			end,
			needShowEnd = EliminateLevelModel.instance:needPlayShowView()
		}))

		return true
	end

	return false
end

function slot0.clear(slot0)
	slot0:clearFlow()

	slot0._flowFullEnd = false

	EliminateStepUtil.releaseMoveStepTable()

	slot0._lastExchangePos = nil

	LocalEliminateChessModel.instance:clear()
	LengZhou6EliminateChessItemController.instance:clear()
end

function slot0.changeCellType(slot0, slot1, slot2, slot3)
	if slot1 == nil or slot2 == nil or slot3 == nil then
		return
	end

	if LocalEliminateChessModel.instance:changeCellId(slot1, slot2, EliminateEnum_2_7.ChessTypeToIndex[slot3]) ~= nil then
		LengZhou6EliminateChessItemController.instance:getChessItem(slot1, slot2):initData(slot4)
		LocalEliminateChessModel.instance:addChangePoints(slot1, slot2)
		slot0:buildSeqFlow(EliminateStepUtil.createStep(EliminateEnum.StepWorkType.CheckEliminate, true))
	end
end

function slot0.changeCellState(slot0, slot1, slot2, slot3)
	if slot1 == nil or slot2 == nil or slot3 == nil then
		return
	end

	LocalEliminateChessModel.instance:changeCellState(slot1, slot2, slot3)
	slot0:buildSeqFlow(EliminateStepUtil.createStep(EliminateEnum.StepWorkType.ChangeState, {
		x = slot1,
		y = slot2
	}))
	slot0:buildSeqFlow(EliminateStepUtil.createStep(EliminateEnum.StepWorkType.CheckEliminate, true))
end

slot0.instance = slot0.New()

return slot0
