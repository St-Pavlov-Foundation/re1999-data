module("modules.logic.fight.model.data.FightRoundData", package.seeall)

slot0 = FightDataClass("FightRoundData")

function slot0.onConstructor(slot0, slot1)
	if not slot1 then
		return
	end

	slot0.fightStep = slot0:buildFightStep(slot1.fightStep)

	if slot1:HasField("actPoint") then
		slot0.actPoint = slot1.actPoint
	end

	slot0.isFinish = slot1.isFinish

	if slot1:HasField("moveNum") then
		slot0.moveNum = slot1.moveNum
	end

	slot0.exPointInfo = {}

	for slot5, slot6 in ipairs(slot1.exPointInfo) do
		table.insert(slot0.exPointInfo, FightExPointInfoData.New(slot6))
	end

	slot0.aiUseCards = {}
	slot0.entityAiUseCards = {}

	for slot5, slot6 in ipairs(slot1.aiUseCards) do
		FightCardInfoData.New(slot6).clientData.custom_enemyCardIndex = slot5
		slot0.entityAiUseCards[slot7] = slot0.entityAiUseCards[slot6.uid] or {}

		table.insert(slot0.entityAiUseCards[slot7], slot8)
		table.insert(slot0.aiUseCards, slot8)
	end

	slot0.power = slot1.power
	slot0.skillInfos = {}

	for slot5, slot6 in ipairs(slot1.skillInfos) do
		table.insert(slot0.skillInfos, FightPlayerSkillInfoData.New(slot6))
	end

	slot0.beforeCards1 = {}

	for slot5, slot6 in ipairs(slot1.beforeCards1) do
		table.insert(slot0.beforeCards1, FightCardInfoData.New(slot6))
	end

	slot0.teamACards1 = {}

	for slot5, slot6 in ipairs(slot1.teamACards1) do
		table.insert(slot0.teamACards1, FightCardInfoData.New(slot6))
	end

	slot0.beforeCards2 = {}

	for slot5, slot6 in ipairs(slot1.beforeCards2) do
		table.insert(slot0.beforeCards2, FightCardInfoData.New(slot6))
	end

	slot0.teamACards2 = {}

	for slot5, slot6 in ipairs(slot1.teamACards2) do
		table.insert(slot0.teamACards2, FightCardInfoData.New(slot6))
	end

	slot0.nextRoundBeginStep = slot0:buildFightStep(slot1.nextRoundBeginStep)
	slot0.useCardList = {}

	for slot5, slot6 in ipairs(slot1.useCardList) do
		table.insert(slot0.useCardList, slot6)
	end

	slot0.curRound = slot1.curRound
	slot0.heroSpAttributes = {}

	for slot5, slot6 in ipairs(slot1.heroSpAttributes) do
		table.insert(slot0.heroSpAttributes, FightHeroSpAttributeInfoData.New(slot6))
	end

	slot0.lastChangeHeroUid = slot1.lastChangeHeroUid
end

function slot0.buildFightStep(slot0, slot1)
	slot2 = {}

	for slot6, slot7 in ipairs(slot1) do
		table.insert(slot2, FightStepData.New(slot7))
	end

	return slot2
end

function slot0.processRoundData(slot0)
	slot0.fightStep = slot0:processStepList(slot0.fightStep)
	slot0.nextRoundBeginStep = slot0:processStepList(slot0.nextRoundBeginStep)
end

function slot0.processStepList(slot0, slot1)
	slot0.stepIndex = 0
	slot0.stepList = {}
	slot0.effectSplitIndex = 0
	slot0.effectStepDeep = 0

	for slot5, slot6 in ipairs(slot1) do
		slot0:addStep(slot6)
	end

	return slot0.stepList
end

function slot0.addStep(slot0, slot1)
	slot0.stepIndex = slot0.stepIndex + 1
	slot1.custom_stepIndex = slot0.stepIndex

	table.insert(slot0.stepList, slot1)
	slot0:detectStepEffect(slot1.actEffect)
end

function slot0.detectStepEffect(slot0, slot1)
	slot2 = 1

	while slot1[slot2] do
		if slot1[slot2].effectType == FightEnum.EffectType.SPLITSTART then
			slot0.effectSplitIndex = slot0.effectSplitIndex + 1
		elseif slot3.effectType == FightEnum.EffectType.SPLITEND then
			slot0.effectSplitIndex = slot0.effectSplitIndex - 1
		end

		if slot3.effectType == FightEnum.EffectType.FIGHTSTEP then
			if slot0.effectSplitIndex > 0 then
				table.remove(slot1, slot2)

				slot2 = slot2 - 1
				slot0.effectStepDeep = slot0.effectStepDeep + 1

				slot0:addStep(slot3.fightStep)

				slot0.effectStepDeep = slot0.effectStepDeep - 1
			elseif uv0.needAddRoundStep(slot3.fightStep) then
				table.remove(slot1, slot2)

				slot2 = slot2 - 1

				slot0:addStep(slot4)
			else
				slot0:detectStepEffect(slot4.actEffect)
			end
		elseif slot0.effectSplitIndex > 0 and slot0.effectStepDeep == 0 then
			table.remove(slot1, slot2)

			slot2 = slot2 - 1
			slot4 = FightStepData.New()
			slot4.actType = FightEnum.ActType.EFFECT
			slot4.fromId = "0"
			slot4.toId = "0"
			slot4.actId = 0
			slot4.actEffect = {
				slot3
			}
			slot4.cardIndex = 0
			slot4.supportHeroId = 0
			slot4.fakeTimeline = false

			table.insert(slot0.stepList, slot4)
		end

		slot2 = slot2 + 1
	end
end

function slot0.getEnemyActPoint(slot0)
	return #slot0.aiUseCards
end

function slot0.getAIUseCardMOList(slot0)
	return slot0.aiUseCards
end

function slot0.getEntityAIUseCardMOList(slot0, slot1)
	return slot0.entityAiUseCards[slot1] or {}
end

function slot0.needAddRoundStep(slot0)
	if FightHelper.isTimelineStep(slot0) then
		return true
	end

	if slot0.actType == FightEnum.ActType.CHANGEHERO then
		return true
	elseif slot0.actType == FightEnum.ActType.CHANGEWAVE then
		return true
	end

	if slot0.fakeTimeline then
		return true
	end
end

return slot0
