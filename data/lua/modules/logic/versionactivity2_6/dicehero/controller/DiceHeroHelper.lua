module("modules.logic.versionactivity2_6.dicehero.controller.DiceHeroHelper", package.seeall)

slot0 = class("DiceHeroHelper")

function slot0.ctor(slot0)
	slot0._entityDict = {}
	slot0._cardDict = {}
	slot0._diceDict = {}
	slot0._diceTextureDict = {}
	slot0._effectItem = nil
	slot0._effectPool = {}
	slot0.flow = nil
	slot0.afterFlow = nil
end

function slot0.buildFlow(slot0, slot1)
	FlowSequence.New():addWork(DiceHeroFirstStepWork.New())

	for slot6, slot7 in ipairs(slot1) do
		slot8 = DiceHeroFightStepMo.New()

		slot8:init(slot7)
		FlowParallel.New():addWork(DiceHeroActionWork.New(slot8))

		slot10 = FlowSequence.New()

		for slot14, slot15 in ipairs(slot8.effect) do
			if _G[string.format("DiceHero%sWork", DiceHeroEnum.FightEffectTypeToName[slot15.effectType] or "")] then
				slot10:addWork(slot18.New(slot15))
			end
		end

		slot9:addWork(slot10)
		slot2:addWork(slot9)
	end

	return slot2
end

function slot0.startFlow(slot0, slot1)
	if slot0.flow then
		logError("已有Flow执行中")
	end

	slot0.flow = slot1

	slot0.flow:registerDoneListener(slot0.flowDone, slot0)
	slot0.flow:start()
end

function slot0.flowDone(slot0)
	slot0.flow = nil

	DiceHeroFightModel.instance:getGameData():onStepEnd()
	DiceHeroController.instance:dispatchEvent(DiceHeroEvent.StepEnd)

	if DiceHeroFightModel.instance.finishResult ~= DiceHeroEnum.GameStatu.None then
		ViewMgr.instance:openView(ViewName.DiceHeroResultView, {
			status = DiceHeroFightModel.instance.finishResult
		})
		DiceHeroStatHelper.instance:sendFightEnd(DiceHeroFightModel.instance.finishResult, DiceHeroFightModel.instance.isFirstWin)

		DiceHeroFightModel.instance.finishResult = DiceHeroEnum.GameStatu.None
	end
end

function slot0.isInFlow(slot0)
	return slot0.flow ~= nil
end

function slot0.isNotInFlow(slot0)
	return not slot0:isInFlow()
end

function slot0.isShowCarNum(slot0, slot1)
	return slot1 == DiceHeroEnum.SkillEffectType.Damage1 or slot1 == DiceHeroEnum.SkillEffectType.Damage2 or slot1 == DiceHeroEnum.SkillEffectType.ChangeShield1 or slot1 == DiceHeroEnum.SkillEffectType.ChangeShield2 or slot1 == DiceHeroEnum.SkillEffectType.ChangePower1 or slot1 == DiceHeroEnum.SkillEffectType.ChangePower2
end

function slot0.setEffectItem(slot0, slot1)
	slot0._effectItem = slot1
end

function slot0.doEffect(slot0, slot1, slot2, slot3, slot4)
	slot5 = table.remove(slot0._effectPool) or MonoHelper.addNoUpdateLuaComOnceToGo(gohelper.cloneInPlace(slot0._effectItem), DiceHeroEffectItem)

	gohelper.setActive(slot5.go, true)
	slot5:initData(slot1, slot2, slot3, slot4)

	return slot5
end

function slot0.returnEffectItemToPool(slot0, slot1)
	gohelper.setActive(slot1.go, false)
	table.insert(slot0._effectPool, slot1)
end

function slot0.registerEntity(slot0, slot1, slot2)
	slot0._entityDict[slot1] = slot2
end

function slot0.unregisterEntity(slot0, slot1)
	slot0._entityDict[slot1] = nil
end

function slot0.getEntity(slot0, slot1)
	return slot0._entityDict[slot1]
end

function slot0.registerCard(slot0, slot1, slot2)
	slot0._cardDict[slot1] = slot2
end

function slot0.unregisterCard(slot0, slot1)
	slot0._cardDict[slot1] = nil
end

function slot0.getCard(slot0, slot1)
	return slot0._cardDict[slot1]
end

function slot0.registerDice(slot0, slot1, slot2)
	slot0._diceDict[slot1] = slot2
end

function slot0.unregisterDice(slot0, slot1)
	slot0._diceDict[slot1] = nil
end

function slot0.getDice(slot0, slot1)
	return slot0._diceDict[slot1]
end

function slot0.checkChapter(slot0, slot1)
	return tostring(slot1) == tostring(DiceHeroModel.instance.guideChapter)
end

function slot0.checkLevel(slot0, slot1)
	return tostring(slot1) == tostring(DiceHeroModel.instance.guideLevel)
end

function slot0.setDiceTexture(slot0, slot1, slot2)
	slot0._diceTextureDict[slot1] = slot2
end

function slot0.getDiceTexture(slot0, slot1)
	return slot0._diceTextureDict[slot1]
end

function slot0.clear(slot0)
	if slot0.flow then
		slot0.flow:onDestroyInternal()

		slot0.flow = nil
	end

	if slot0.afterFlow then
		slot0.afterFlow:onDestroyInternal()

		slot0.afterFlow = nil
	end

	slot0._entityDict = {}
	slot0._cardDict = {}
	slot0._diceDict = {}
	slot0._diceTextureDict = {}
	slot0._effectItem = nil
	slot0._effectPool = {}
end

slot0.instance = slot0.New()

return slot0
