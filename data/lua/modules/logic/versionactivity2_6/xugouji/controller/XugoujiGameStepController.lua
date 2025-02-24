module("modules.logic.versionactivity2_6.xugouji.controller.XugoujiGameStepController", package.seeall)

slot0 = class("XugoujiGameStepController", BaseController)
slot1 = VersionActivity2_6Enum.ActivityId.Xugouji

function slot0.ctor(slot0)
	slot0._stepList = {}
	slot0._stepPool = nil
	slot0._curStep = nil
	slot0.muteAutoNext = false
end

function slot0.insertStepList(slot0, slot1)
	Activity188Model.instance:setGameState(XugoujiEnum.GameStatus.UnOperatable)

	for slot6 = 1, #slot1 do
		slot0:insertStep(slot1[slot6])
	end
end

function slot0.insertStep(slot0, slot1)
	if slot0:buildStep(slot1) then
		slot0._stepList = slot0._stepList or {}

		table.insert(slot0._stepList, slot2)
	end

	if slot0._curStep == nil then
		slot0:nextStep()
	end
end

slot0.StepClzMap = {
	[XugoujiEnum.GameStepType.HpUpdate] = XugoujiGameStepHpUpdate,
	[XugoujiEnum.GameStepType.UpdateCardStatus] = XugoujiGameStepCardUpdate,
	[XugoujiEnum.GameStepType.Result] = XugoujiGameStepResult,
	[XugoujiEnum.GameStepType.ChangeTurn] = XugoujiGameStepChangeTurn,
	[XugoujiEnum.GameStepType.NewCards] = XugoujiGameStepNewCards,
	[XugoujiEnum.GameStepType.GotCardPair] = XugoujiGameStepPairsUpdate,
	[XugoujiEnum.GameStepType.OperateNumUpdate] = XugoujiGameStepOperateNumUpdate,
	[XugoujiEnum.GameStepType.BuffUpdate] = XugoujiGameStepBuffUpdate,
	[XugoujiEnum.GameStepType.UpdateCardEffectStatus] = XugoujiGameStepCardEffectStatue
}

function slot0.buildStep(slot0, slot1)
	slot2 = cjson.decode(slot1.param)
	slot3 = uv0.StepClzMap[slot2.stepType]

	if slot2.stepType == XugoujiEnum.GameStepType.NextMap then
		logNormal("stepClz actId = " .. uv1)
	end

	if slot3 then
		slot4 = nil
		slot0._stepPool = slot0._stepPool or {}

		if slot0._stepPool[slot3] ~= nil and #slot0._stepPool[slot3] >= 1 then
			slot5 = #slot0._stepPool[slot3]
			slot4 = slot0._stepPool[slot3][slot5]
			slot0._stepPool[slot3][slot5] = nil
		else
			slot4 = slot3.New()
		end

		slot4:init(slot2)

		return slot4
	end
end

function slot0.nextStep(slot0)
	slot0:recycleCurStep()

	slot0._doingStepAction = #slot0._stepList > 0

	if not slot0._doingStepAction then
		Activity188Model.instance:setGameState(XugoujiEnum.GameStatus.Operatable)
	end

	if not slot0._isStepStarting then
		slot0._isStepStarting = true

		while slot0._stepList and #slot0._stepList > 0 and slot0._curStep == nil do
			slot0._curStep = slot0._stepList[1]

			table.remove(slot0._stepList, 1)
			slot0._curStep:start()
		end

		slot0._isStepStarting = false
	end
end

function slot0.recycleCurStep(slot0)
	if slot0._curStep then
		slot0._curStep:dispose()

		slot0._stepPool[slot0._curStep.class] = slot0._stepPool[slot0._curStep.class] or {}

		table.insert(slot0._stepPool[slot0._curStep.class], slot0._curStep)

		slot0._curStep = nil
	end
end

function slot0.disposeAllStep(slot0)
	if slot0._curStep then
		slot0._curStep:dispose()

		slot0._curStep = nil
	end

	if slot0._stepList then
		for slot4, slot5 in pairs(slot0._stepList) do
			slot5:dispose()
		end

		slot0._stepList = nil
	end

	slot0._stepPool = nil
	slot0._isStepStarting = false
end

function slot0.clear(slot0)
	slot0._stepList = nil
	slot0._curStep = nil

	slot0:disposeAllStep()
end

slot0.instance = slot0.New()

return slot0
