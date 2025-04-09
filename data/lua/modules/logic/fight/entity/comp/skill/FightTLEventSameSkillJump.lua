module("modules.logic.fight.entity.comp.skill.FightTLEventSameSkillJump", package.seeall)

slot0 = class("FightTLEventSameSkillJump", FightTimelineTrackItem)

function slot0.onTrackStart(slot0, slot1, slot2, slot3)
	if not FightModel.instance:canParallelSkill(slot1) then
		return
	end

	if not string.nilorempty(slot3[1]) then
		CameraMgr.instance:getCameraRootAnimator().enabled = true

		FightController.instance:registerCallback(FightEvent.BeforePlaySameSkill, slot0._onBeforePlaySameSkill, slot0)

		slot0.fightStepData = slot1
		slot0._paramsArr = slot3

		FightController.instance:dispatchEvent(FightEvent.CheckPlaySameSkill, slot1)
	end
end

function slot0._onBeforePlaySameSkill(slot0, slot1, slot2)
	if not string.nilorempty(slot0._paramsArr[1]) and not slot0._done then
		slot0._jump_type = tonumber(slot0._paramsArr[1]) or 0
		slot0.audioId = slot0.fightStepData.atkAudioId
		slot0._done = true
		slot0._animComp = CameraMgr.instance:getCameraRootAnimator()
		slot0._animComp.enabled = false
		slot0._attacker = FightHelper.getEntity(slot0.fightStepData.fromId)

		AudioEffectMgr.instance:stopAudio(slot0.audioId, 0)

		slot0.curAnimState = slot0._attacker.spine.curAnimState

		if slot0._attacker.spine:hasAnimation(SpineAnimState.posture) then
			slot0._attacker.spine:play(SpineAnimState.posture, true)
		end

		if not string.nilorempty(slot0._paramsArr[2]) then
			for slot7, slot8 in ipairs(string.splitToNumber(slot0._paramsArr[2], "#")) do
				slot0.fightStepData.cusParam_lockTimelineTypes = slot0.fightStepData.cusParam_lockTimelineTypes or {}
				slot0.fightStepData.cusParam_lockTimelineTypes[slot8] = true
			end
		end

		if slot0._paramsArr[3] == "1" then
			slot0.fightStepData.cus_Param_invokeSpineActTimelineEnd = true
		end

		if not string.nilorempty(slot0._paramsArr[4]) then
			slot0._attacker.skill:recordFilterAtkEffect(slot0._paramsArr[4], slot2)
		end

		if not string.nilorempty(slot0._paramsArr[5]) then
			slot0._attacker.skill:recordFilterFlyEffect(slot0._paramsArr[5], slot2)
		end

		slot0._attacker.skill:stopCurTimelineWaitPlaySameSkill(slot0._jump_type, slot0.curAnimState, slot0.audioId, slot1, slot2)
	end
end

function slot0.onDestructor(slot0)
	slot0._done = nil
	slot0._animComp = nil

	FightController.instance:unregisterCallback(FightEvent.BeforePlaySameSkill, slot0._onBeforePlaySameSkill, slot0)
end

return slot0
