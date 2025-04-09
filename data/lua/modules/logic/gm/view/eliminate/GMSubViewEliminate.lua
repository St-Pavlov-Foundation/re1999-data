module("modules.logic.gm.view.eliminate.GMSubViewEliminate", package.seeall)

slot0 = class("GMSubViewEliminate", GMSubViewBase)

function slot0.ctor(slot0)
	slot0.tabName = "三消"
end

function slot0.addLineIndex(slot0)
	slot0.lineIndex = slot0.lineIndex + 1
end

function slot0.getLineGroup(slot0)
	return "L" .. slot0.lineIndex
end

function slot0.initViewContent(slot0)
	if slot0._inited then
		return
	end

	GMSubViewBase.initViewContent(slot0)

	slot0.lineIndex = 1

	slot0:addTitleSplitLine("冷周六玩法")
	slot0:addLineIndex()

	slot0._textLevel = slot0:addInputText(slot0:getLineGroup(), "1270209")

	slot0:addLineIndex()
	slot0:addButton(slot0:getLineGroup(), "进入玩法", slot0.enterGame, slot0)
	slot0:addButton(slot0:getLineGroup(), "打乱棋盘", slot0.randomCell, slot0)
	slot0:addLineIndex()
	slot0:addButton(slot0:getLineGroup(), "随机石化", slot0.petrifyEliminationBlock, slot0)
	slot0:addButton(slot0:getLineGroup(), "随机冰冻", slot0.freezeEliminationBlock, slot0)
	slot0:addButton(slot0:getLineGroup(), "随机致盲", slot0.contaminate, slot0)
	slot0:addLineIndex()

	slot0._textBuff = slot0:addInputText(slot0:getLineGroup(), "1,1")

	slot0:addButton(slot0:getLineGroup(), "指定冰冻", slot0.addBuff, slot0)
	slot0:addLineIndex()

	slot0._textChangeIndex = slot0:addInputText(slot0:getLineGroup(), "1,1")
	slot0._typeDropDown = slot0:addDropDown(slot0:getLineGroup(), "棋子类型：", EliminateEnum_2_7.AllChessType, slot0._onLangDropChange, slot0)

	slot0:addButton(slot0:getLineGroup(), "修改棋子类型", slot0.changeChessType, slot0)
	slot0:addLineIndex()

	slot0._textChangeStrongIndex = slot0:addInputText(slot0:getLineGroup(), "1,1")

	slot0:addButton(slot0:getLineGroup(), "强化棋子", slot0.changeToStrong, slot0)
	slot0:addLineIndex()

	slot0._textChangeDieSpeed = slot0:addInputText(slot0:getLineGroup(), "0.3")

	slot0:addButton(slot0:getLineGroup(), "修改棋子死亡步骤时间", slot0.changeDieSpeed, slot0)
	slot0:addLineIndex()
	slot0:addButton(slot0:getLineGroup(), "测试随机棋子【100】", slot0.testRound, slot0)
end

function slot0.initEliminate(slot0)
	LocalEliminateChessModel.instance:initByData({
		{
			1,
			3,
			2,
			5,
			4,
			1
		},
		{
			2,
			4,
			5,
			3,
			1,
			2
		},
		{
			3,
			1,
			4,
			2,
			5,
			3
		},
		{
			4,
			2,
			5,
			1,
			3,
			4
		},
		{
			5,
			3,
			1,
			4,
			2,
			5
		},
		{
			1,
			4,
			2,
			5,
			3,
			1
		}
	})
end

function slot0.eliminateEx(slot0)
	if #string.split(slot0._textEx:GetText(), ",") ~= 4 then
		return
	end

	LocalEliminateChessModel.instance:exchangeCell(tonumber(slot2[1]), tonumber(slot2[2]), tonumber(slot2[3]), tonumber(slot2[4]))
end

function slot0.addBuff(slot0)
	if #string.split(slot0._textBuff:GetText(), ",") ~= 2 then
		return
	end

	slot3 = tonumber(slot2[1])
	slot4 = tonumber(slot2[2])

	LocalEliminateChessModel.instance:changeCellState(slot3, slot4, EliminateEnum.ChessState.Frost)
	LengZhou6EliminateController.instance:buildSeqFlow(EliminateStepUtil.createStep(EliminateEnum.StepWorkType.ChangeState, {
		x = slot3,
		y = slot4
	}))
	LengZhou6EliminateController.instance:buildSeqFlow(EliminateStepUtil.createStep(EliminateEnum.StepWorkType.EliminateCheckAndRefresh))
	LengZhou6EliminateController.instance:setFlowEndState(true)
end

function slot0.enterGame(slot0)
	LengZhou6Enum.enterGM = true
	LengZhou6Model.instance._activityId = 12702
	slot1 = tonumber(slot0._textLevel:GetText())

	LengZhou6Model.instance:setCurEpisodeId(slot1)
	LengZhou6Controller.instance:_enterGame(slot1)
end

function slot0.randomCell(slot0)
	LengZhou6EliminateController.instance:updateAllItemPos(LocalEliminateChessModel.instance:randomCell())
end

function slot0.eliminateCross(slot0)
	LocalEliminateChessModel.instance:eliminateCross(4, 4)
	LengZhou6EliminateController.instance:buildSeqFlow(EliminateStepUtil.createStep(EliminateEnum.StepWorkType.CheckEliminate, false))
end

function slot0.eliminateRange(slot0)
	LocalEliminateChessModel.instance:eliminateRange(3, 4, 3)
	LengZhou6EliminateController.instance:buildSeqFlow(EliminateStepUtil.createStep(EliminateEnum.StepWorkType.CheckEliminate, false))
end

function slot0.petrifyEliminationBlock(slot0)
	LengZhou6EffectUtils.instance._petrifyEliminationBlock({
		"PetrifyEliminationBlock",
		2
	})
	LengZhou6EliminateController.instance:buildSeqFlow(EliminateStepUtil.createStep(EliminateEnum.StepWorkType.EliminateCheckAndRefresh))
end

function slot0.freezeEliminationBlock(slot0)
	LengZhou6EffectUtils.instance._freezeEliminationBlock({
		"FreezeEliminationBlock",
		2
	})
	LengZhou6EliminateController.instance:buildSeqFlow(EliminateStepUtil.createStep(EliminateEnum.StepWorkType.EliminateCheckAndRefresh))
end

function slot0.contaminate(slot0)
	LengZhou6EffectUtils.instance._contaminate({
		"Contaminate",
		2
	})
	LengZhou6EliminateController.instance:buildSeqFlow(EliminateStepUtil.createStep(EliminateEnum.StepWorkType.CheckEliminate, false))
end

function slot0.generateUnsolvableBoard(slot0)
	LocalEliminateChessUtils.instance.generateUnsolvableBoard(6, 6)
end

function slot0.testRound(slot0)
	LocalEliminateChessModel.instance:testRound()
end

function slot0._onLangDropChange(slot0)
end

function slot0.changeChessType(slot0)
	if #string.split(slot0._textChangeIndex:GetText(), ",") ~= 2 then
		return
	end

	LengZhou6EliminateController.instance:changeCellType(tonumber(slot2[1]), tonumber(slot2[2]), EliminateEnum_2_7.AllChessType[slot0._typeDropDown:GetValue() + 1])
end

function slot0.changeToStrong(slot0)
	if #string.split(slot0._textChangeStrongIndex:GetText(), ",") ~= 2 then
		return
	end

	LengZhou6EliminateController.instance:changeCellState(tonumber(slot2[1]), tonumber(slot2[2]), EliminateEnum.ChessState.SpecialSkill)
end

function slot0.changeDieSpeed(slot0)
	EliminateEnum_2_7.DieStepTime = tonumber(slot0._textChangeDieSpeed:GetText())
end

return slot0
