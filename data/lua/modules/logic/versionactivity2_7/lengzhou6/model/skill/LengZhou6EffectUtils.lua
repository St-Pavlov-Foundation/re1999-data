module("modules.logic.versionactivity2_7.lengzhou6.model.skill.LengZhou6EffectUtils", package.seeall)

slot0 = class("LengZhou6EffectUtils")

function slot0.ctor(slot0)
	slot0._defineList = {
		[LengZhou6Enum.SkillEffect.DamageUpByIntensified] = uv0._damageUpByIntensified,
		[LengZhou6Enum.SkillEffect.HealUpByIntensified] = uv0._healUpByIntensified,
		[LengZhou6Enum.SkillEffect.EliminationDecreaseCd] = uv0._eliminationDecreaseCd,
		[LengZhou6Enum.SkillEffect.AddBuffByIntensified] = uv0._addBuffByIntensified,
		[LengZhou6Enum.SkillEffect.DamageUpByType] = uv0._damageUpByType,
		[LengZhou6Enum.SkillEffect.SuccessiveElimination] = uv0._successiveElimination,
		[LengZhou6Enum.SkillEffect.EliminationLevelUp] = uv0._eliminationLevelUp,
		[LengZhou6Enum.SkillEffect.EliminationCross] = uv0._eliminationCross,
		[LengZhou6Enum.SkillEffect.EliminationDoubleAttack] = uv0._eliminationDoubleAttack,
		[LengZhou6Enum.SkillEffect.EliminationRange] = uv0._eliminationRange,
		[LengZhou6Enum.SkillEffect.AddBuff] = uv0._addBuff,
		[LengZhou6Enum.SkillEffect.DealsDamage] = uv0._dealsDamage,
		[LengZhou6Enum.SkillEffect.Contaminate] = uv0._contaminate,
		[LengZhou6Enum.SkillEffect.Shuffle] = uv0._shuffle,
		[LengZhou6Enum.SkillEffect.FreezeEliminationBlock] = uv0._freezeEliminationBlock,
		[LengZhou6Enum.SkillEffect.PetrifyEliminationBlock] = uv0._petrifyEliminationBlock,
		[LengZhou6Enum.SkillEffect.Heal] = uv0._heal
	}
end

function slot0._damageUpByIntensified(slot0)
	if LengZhou6GameModel.instance:getPlayer() ~= nil then
		slot1:getDamageComp():setEliminateTypeExDamage(slot0[2], tonumber(slot0[3]))
	end
end

function slot0._healUpByIntensified(slot0)
	if LengZhou6GameModel.instance:getPlayer() ~= nil then
		slot1:getTreatmentComp():setEliminateTypeExTreatment(slot0[2], tonumber(slot0[3]))
	end
end

function slot0._eliminationDecreaseCd(slot0)
	if LengZhou6GameModel.instance:getPlayer() ~= nil then
		slot2 = LengZhou6GameModel.instance:getCurEliminateSpEliminateCount(slot0[2]) or 0
		slot4 = nil

		for slot9 = 1, #slot1:getActiveSkills() do
			if 0 < slot3[slot9]:getCd() then
				slot4 = slot10
				slot5 = slot11
			end
		end

		if slot4 ~= nil then
			for slot9 = 1, slot2 do
				slot4:setCd(slot4:getCd() - tonumber(slot0[3]))
			end
		end
	end
end

function slot0._addBuffByIntensified(slot0)
	slot3 = tonumber(slot0[3])
	slot4 = tonumber(slot0[4])
	slot5 = tonumber(slot0[5])

	for slot9 = 1, LengZhou6GameModel.instance:getCurEliminateSpEliminateCount(slot0[2]) or 0 do
		for slot13 = 1, slot4 do
			if slot5 == LengZhou6Enum.entityCamp.player then
				LengZhou6BuffSystem.instance:addBuffToPlayer(slot3)
			end

			if slot5 == LengZhou6Enum.entityCamp.enemy then
				LengZhou6BuffSystem.instance:addBuffToEnemy(slot3)
			end
		end
	end
end

function slot0._damageUpByType(slot0)
	if LengZhou6GameModel.instance:getPlayer() ~= nil then
		slot3 = string.splitToNumber(slot0[3], ",")

		slot1:getDamageComp():setSpEliminateRate(slot3[1], slot3[2], slot3[3])
	end
end

function slot0._successiveElimination(slot0)
	LengZhou6GameModel.instance:setLineEliminateRate(tonumber(slot0[2]) / 1000)
end

function slot0._eliminationLevelUp(slot0)
	slot5 = {}
	slot6 = {}

	if tonumber(slot0[3]) < #LocalEliminateChessModel.instance:getAllEliminateIdPos(EliminateEnum_2_7.ChessTypeToIndex[slot0[2]]) then
		for slot10 = 1, slot2 do
			slot11 = math.random(1, #slot4)

			table.insert(slot5, slot4[slot11].x)
			table.insert(slot6, slot4[slot11].y)
		end
	else
		for slot10 = 1, #slot4 do
			table.insert(slot5, slot4[slot10].x)
			table.insert(slot6, slot4[slot10].y)
		end
	end

	slot7 = FlowParallel.New()

	for slot11 = 1, #slot5 do
		slot12 = slot5[slot11]
		slot13 = slot6[slot11]

		LocalEliminateChessModel.instance:changeCellState(slot12, slot13, EliminateEnum.ChessState.SpecialSkill)
		slot7:addWork(EliminateStepUtil.createStep(EliminateEnum.StepWorkType.ChangeState, {
			x = slot12,
			y = slot13
		}))
	end

	LengZhou6EliminateController.instance:buildSeqFlow(slot7)
end

function slot0._eliminationCross(slot0, slot1)
	LocalEliminateChessModel.instance:eliminateCross(slot0, slot1)
	LengZhou6EliminateController.instance:buildSeqFlow(EliminateStepUtil.createStep(EliminateEnum.StepWorkType.CheckEliminate, false))
end

function slot0._eliminationDoubleAttack()
	LengZhou6GameModel.instance:setEnemySettleCount(2)
end

function slot0._eliminationRange(slot0, slot1)
	LocalEliminateChessModel.instance:eliminateRange(slot0, slot1, 3)
	LengZhou6EliminateController.instance:buildSeqFlow(EliminateStepUtil.createStep(EliminateEnum.StepWorkType.CheckEliminate, false))
end

function slot0._addBuff(slot0)
	for slot6 = 1, tonumber(slot0[3]) do
		LengZhou6BuffSystem.instance:addBuffToEnemy(tonumber(slot0[2]))
	end
end

function slot0._dealsDamage(slot0, slot1)
	LengZhou6GameModel.instance:getPlayer():changeHp(-(tonumber(slot0[2]) + (slot1 ~= nil and slot1 or 0)))
end

function slot0._contaminate(slot0, slot1)
	slot3 = slot1 ~= nil and slot1 or 0
	slot3, slot4 = LocalEliminateChessModel.instance:getCellRowAndCol()
	slot9 = true

	for slot9 = 1, #uv0.getRandomXYSet(slot3, slot4, tonumber(slot0[2]) + slot3, slot9, LengZhou6Enum.SkillEffect.Contaminate) do
		LengZhou6EliminateController.instance:dispatchEvent(LengZhou6Event.ShowEffect, slot5[slot9].x, slot5[slot9].y, EliminateEnum_2_7.ChessEffect.pollution)
	end
end

function slot0._shuffle()
	LengZhou6EliminateController.instance:updateAllItemPos(LocalEliminateChessModel.instance:randomCell())
end

function slot0._freezeEliminationBlock(slot0, slot1)
	slot3 = slot1 ~= nil and slot1 or 0
	slot3, slot4 = LocalEliminateChessModel.instance:getCellRowAndCol()
	slot5 = FlowParallel.New()
	slot10 = true

	for slot10 = 1, #uv0.getRandomXYSet(slot3, slot4, tonumber(slot0[2]) + slot3, slot10, LengZhou6Enum.SkillEffect.FreezeEliminationBlock) do
		slot11 = slot6[slot10].x
		slot12 = slot6[slot10].y

		LocalEliminateChessModel.instance:changeCellState(slot11, slot12, EliminateEnum.ChessState.Frost)
		slot5:addWork(EliminateStepUtil.createStep(EliminateEnum.StepWorkType.ChangeState, {
			x = slot11,
			y = slot12
		}))
	end

	LengZhou6EliminateController.instance:buildSeqFlow(slot5)
	LengZhou6EliminateController.instance:setFlowEndState(true)
end

function slot0._petrifyEliminationBlock(slot0, slot1)
	slot3, slot4 = LocalEliminateChessModel.instance:getCellRowAndCol()
	slot5, slot6 = LengZhou6Controller.instance:getFixChessPos()

	if slot5 then
		slot2 = tonumber(slot0[2]) + (slot1 ~= nil and slot1 or 0) - 1
	end

	slot7 = uv0.getRandomXYSet(slot3, slot4, slot2, true, LengZhou6Enum.SkillEffect.PetrifyEliminationBlock)

	if slot5 and slot6 ~= nil then
		table.insert(slot7, {
			x = slot6.x,
			y = slot6.y
		})
	end

	slot8 = FlowParallel.New()

	for slot12 = 1, #slot7 do
		slot8:addWork(EliminateStepUtil.createStep(EliminateEnum.StepWorkType.ChessItemUpdateInfo, {
			x = slot7[slot12].x,
			y = slot7[slot12].y
		}))
	end

	LengZhou6EliminateController.instance:buildSeqFlow(slot8)
	LengZhou6EliminateController.instance:setFlowEndState(true)
end

function slot0._heal(slot0, slot1)
	LengZhou6GameModel.instance:getEnemy():changeHp(tonumber(slot0[2]) + (slot1 ~= nil and slot1 or 0))
end

function slot0.getRandomXYSet(slot0, slot1, slot2, slot3, slot4)
	slot5 = {}

	for slot9 = 1, 100 do
		if #slot5 == slot2 then
			break
		end

		slot10 = math.random(1, slot0)
		slot11 = math.random(1, slot1)
		slot12 = true

		if slot3 then
			slot13 = LocalEliminateChessModel.instance:getCell(slot10, slot11)
			slot14 = LocalEliminateChessModel.instance:getSpEffect(slot10, slot11)

			if slot4 == LengZhou6Enum.SkillEffect.Contaminate and slot14 ~= nil then
				slot12 = false
			end

			if slot4 == LengZhou6Enum.SkillEffect.FreezeEliminationBlock and (slot14 ~= nil or slot13.id == EliminateEnum.InvalidId or slot13:getEliminateID() == EliminateEnum_2_7.ChessType.stone) then
				slot12 = false
			end

			if slot4 == LengZhou6Enum.SkillEffect.PetrifyEliminationBlock and (slot14 ~= nil and slot14 == EliminateEnum_2_7.ChessEffect.frost or slot13.id == EliminateEnum.InvalidId) then
				slot12 = false
			end
		end

		if slot12 then
			for slot16 = 1, #slot5 do
				if slot10 == slot5[slot16].x and slot5[slot16].y == slot11 then
					slot12 = false
				end
			end
		end

		if slot12 then
			table.insert(slot5, {
				x = slot10,
				y = slot11
			})
		end
	end

	return slot5
end

function slot0.getHandleFunc(slot0, slot1)
	return slot0._defineList[slot1]
end

slot0.instance = slot0.New()

return slot0
