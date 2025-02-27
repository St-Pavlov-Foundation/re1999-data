module("modules.logic.versionactivity2_6.dicehero.rpc.DiceHeroRpc", package.seeall)

slot0 = class("DiceHeroRpc", BaseRpc)

function slot0.sendDiceHeroGetInfo(slot0, slot1, slot2)
	return slot0:sendMsg(DiceHeroModule_pb.DiceHeroGetInfoRequest(), slot1, slot2)
end

function slot0.onReceiveDiceHeroGetInfoReply(slot0, slot1, slot2)
	if slot1 == 0 then
		DiceHeroModel.instance:initInfo(slot2.info)
	end
end

function slot0.sendDiceHeroEnterStory(slot0, slot1, slot2, slot3, slot4)
	slot5 = DiceHeroModule_pb.DiceHeroEnterStoryRequest()
	slot5.levelId = slot1
	slot5.chapter = slot2

	return slot0:sendMsg(slot5, slot3, slot4)
end

function slot0.onReceiveDiceHeroEnterStoryReply(slot0, slot1, slot2)
	if slot1 == 0 then
		DiceHeroModel.instance:initInfo(slot2.info)
	end
end

function slot0.sendDiceHeroGetReward(slot0, slot1, slot2, slot3, slot4)
	slot5 = DiceHeroModule_pb.DiceHeroGetRewardRequest()

	for slot9, slot10 in ipairs(slot1) do
		table.insert(slot5.index, slot10)
	end

	slot5.chapter = slot2

	return slot0:sendMsg(slot5, slot3, slot4)
end

function slot0.onReceiveDiceHeroGetRewardReply(slot0, slot1, slot2)
	if slot1 == 0 then
		DiceHeroModel.instance:initInfo(slot2.info)
	end
end

function slot0.sendDiceHeroEnterFight(slot0, slot1, slot2, slot3)
	DiceHeroModel.instance.lastEnterLevelId = slot1
	slot4 = DiceHeroModule_pb.DiceHeroEnterFightRequest()
	slot4.levelId = slot1

	return slot0:sendMsg(slot4, slot2, slot3)
end

function slot0.onReceiveDiceHeroEnterFightReply(slot0, slot1, slot2)
	if slot1 == 0 then
		DiceHeroFightModel.instance:setGameData(slot2.fight)
	end
end

function slot0.sendDiceHeroResetDice(slot0, slot1, slot2, slot3)
	slot4 = DiceHeroModule_pb.DiceHeroResetDiceRequest()

	for slot8, slot9 in pairs(slot1) do
		table.insert(slot4.diceUids, slot9)
	end

	return slot0:sendMsg(slot4, slot2, slot3)
end

function slot0.onReceiveDiceHeroResetDiceReply(slot0, slot1, slot2)
	if slot1 == 0 then
		DiceHeroController.instance:dispatchEvent(DiceHeroEvent.StepStart)
		DiceHeroHelper.instance:startFlow(DiceHeroHelper.instance:buildFlow(slot2.steps))
	end
end

function slot0.sendDiceHeroConfirmDice(slot0, slot1, slot2)
	return slot0:sendMsg(DiceHeroModule_pb.DiceHeroConfirmDiceRequest(), slot1, slot2)
end

function slot0.onReceiveDiceHeroConfirmDiceReply(slot0, slot1, slot2)
	if slot1 == 0 then
		DiceHeroFightModel.instance:getGameData().confirmed = true

		DiceHeroController.instance:dispatchEvent(DiceHeroEvent.ConfirmDice)
		DiceHeroController.instance:dispatchEvent(DiceHeroEvent.StepStart)
		DiceHeroHelper.instance:startFlow(DiceHeroHelper.instance:buildFlow(slot2.steps))
	end
end

function slot0.sendDiceHeroUseSkill(slot0, slot1, slot2, slot3, slot4, slot5, slot6, slot7)
	slot8 = DiceHeroModule_pb.DiceHeroUseSkillRequest()
	slot8.type = slot1
	slot8.skillId = slot2
	slot8.toId = slot3

	for slot12, slot13 in ipairs(slot4) do
		table.insert(slot8.diceUids, slot13)
	end

	slot8.pattern = slot5

	return slot0:sendMsg(slot8, slot6, slot7)
end

function slot0.onReceiveDiceHeroUseSkillReply(slot0, slot1, slot2)
	if slot1 == 0 then
		for slot7, slot8 in ipairs(slot2.skillId) do
			DiceHeroStatHelper.instance:addUseCard(slot8)

			if DiceHeroFightModel.instance:getGameData().skillCardsBySkillId[slot8] then
				slot9.curRoundUse = slot9.curRoundUse + 1
			end
		end

		for slot7, slot8 in ipairs(slot2.diceUids) do
			if DiceHeroHelper.instance:getDice(slot8) then
				slot9:markDeleted()
			end
		end

		DiceHeroController.instance:dispatchEvent(DiceHeroEvent.StepStart)
		DiceHeroHelper.instance:startFlow(DiceHeroHelper.instance:buildFlow(slot2.steps))
	end
end

function slot0.sendDiceHeroEndRound(slot0, slot1, slot2)
	return slot0:sendMsg(DiceHeroModule_pb.DiceHeroEndRoundRequest(), slot1, slot2)
end

function slot0.onReceiveDiceHeroEndRoundReply(slot0, slot1, slot2)
	if slot1 == 0 then
		DiceHeroController.instance:dispatchEvent(DiceHeroEvent.StepStart)
		DiceHeroHelper.instance:buildFlow(slot2.steps):addWork(DiceHeroLastStepWork.New(slot2.fight))

		if #slot2.afterSteps > 0 then
			DiceHeroHelper.instance.afterFlow = DiceHeroHelper.instance:buildFlow(slot2.afterSteps)
		end

		DiceHeroHelper.instance:startFlow(slot3)
	end
end

function slot0.sendDiceGiveUp(slot0, slot1, slot2, slot3)
	slot4 = DiceHeroModule_pb.DiceGiveUpRequest()
	slot4.chapter = slot1

	return slot0:sendMsg(slot4, slot2, slot3)
end

function slot0.onReceiveDiceGiveUpReply(slot0, slot1, slot2)
	if slot1 == 0 then
		DiceHeroStatHelper.instance:sendReset()
		GameFacade.showToast(ToastEnum.DiceHeroDiceResetSuccess)
		DiceHeroModel.instance:initInfo(slot2.info)
	end
end

function slot0.onReceiveDiceFightSettlePush(slot0, slot1, slot2)
	if slot1 == 0 then
		slot3 = false

		if slot2.status == DiceHeroEnum.GameStatu.Win and lua_dice_level.configDict[DiceHeroModel.instance.lastEnterLevelId] and DiceHeroModel.instance:getGameInfo(slot5.chapter).currLevel == slot4 and not slot6.allPass then
			slot3 = true
		end

		DiceHeroModel.instance:initInfo(slot2.info)

		DiceHeroFightModel.instance.finishResult = slot2.status
		DiceHeroFightModel.instance.isFirstWin = slot3
	end
end

slot0.instance = slot0.New()

return slot0
