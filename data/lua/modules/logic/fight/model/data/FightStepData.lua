module("modules.logic.fight.model.data.FightStepData", package.seeall)

slot0 = FightDataClass("FightStepData")
slot1 = 1

function slot0.onConstructor(slot0, slot1)
	slot0:initClientParam()

	if not slot1 then
		return
	end

	slot0.actType = slot1.actType
	slot0.fromId = slot1.fromId
	slot0.toId = slot1.toId
	slot0.actId = slot1.actId
	slot0.actEffect = slot0:buildActEffect(slot1.actEffect)
	slot0.cardIndex = slot1.cardIndex or 0
	slot0.supportHeroId = slot1.supportHeroId or 0
	slot0.fakeTimeline = slot1.fakeTimeline
end

function slot0.initClientParam(slot0)
	slot0.stepUid = uv0
	uv0 = uv0 + 1
	slot0.atkAudioId = nil
	slot0.editorPlaySkill = nil
	slot0.isParallelStep = false
	slot0.cusParam_lockTimelineTypes = nil
	slot0.cus_Param_invokeSpineActTimelineEnd = nil
	slot0.hasPlay = nil
	slot0.custom_stepIndex = nil
	slot0.custom_ingoreParallelSkill = nil
end

function slot0.buildActEffect(slot0, slot1)
	slot2 = {}

	for slot6, slot7 in ipairs(slot1) do
		table.insert(slot2, FightActEffectData.New(slot7))
	end

	return slot2
end

return slot0
