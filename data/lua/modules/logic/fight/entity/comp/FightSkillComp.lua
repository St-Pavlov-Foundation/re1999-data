module("modules.logic.fight.entity.comp.FightSkillComp", package.seeall)

slot0 = class("FightSkillComp", LuaCompBase)
slot0.FrameEventHandlerCls = {
	[0] = FightTLEventMove,
	FightTLEventTargetEffect,
	FightTLEventAtkSpineLookDir,
	FightTLEventDefHit,
	FightTLEventDefFreeze,
	FightTLEventAtkEffect,
	FightTLEventAtkFlyEffect,
	FightTLEventAtkFullEffect,
	FightTLEventDefEffect,
	FightTLEventAtkAction,
	FightTLEventPlayAudio,
	FightTLEventCreateSpine,
	FightTLEventCameraShake,
	FightTLEventEntityVisible,
	FightTLEventSceneMask,
	FightTLEventCameraTrace,
	FightTLEventPlayVideo,
	FightTLEventEntityScale,
	FightTLEventRefreshRenderOrder,
	FightTLEventCameraRotate,
	FightTLEventUIVisible,
	FightTLEventEntityRenderOrder,
	FightTLEventEntityRotate,
	FightTLEventSpineMaterial,
	FightTLEventBloomMaterial,
	FightTLEventDisableSpineRotate,
	FightTLEventHideScene,
	FightTLEventSpeed,
	FightTLEventDefEffect,
	FightTLEventDefHeal,
	FightTLEventUniqueCameraNew,
	FightTLEventEntityAnim,
	FightTLEventEntityTexture,
	FightTLEventJoinSameSkillStart,
	FightTLEventPlayNextSkill,
	FightTLEventSameSkillJump,
	FightTLEventCameraDistance,
	FightTLEventInvokeEntityDead,
	FightTLEventSetSceneObjVisible,
	FightTLEventSetSpinePos,
	FightTLEventSetTimelineTime,
	FightTLEventPlaySceneAnimator,
	FightTLEventPlayServerEffect,
	FightTLEventChangeScene,
	FightTLEventMarkSceneDefaultRoot,
	FightTLEventSceneMove,
	FightTLEventCatapult,
	FightTLEventStressTrigger,
	FightTLEventFloatBuffBySkillEffect,
	FightTLEventLYSpecialSpinePlayAniName,
	FightTLEventInvokeSummon,
	FightTLEventInvokeLookBack,
	FightTLEventSetFightViewPartVisible,
	FightTLEventALFCardEffect,
	FightTLEventPlayEffectByOperation,
	[1001] = FightTLEventObjFly
}

function slot0.ctor(slot0, slot1)
	slot0.entity = slot1
	slot0.timeScale = 1
	slot0.workComp = FightWorkComponent.New()
	slot0.sameSkillParam = {}
	slot0.sameSkillStartParam = {}
end

function slot0.playTimeline(slot0, slot1, slot2)
	if not slot0:registTimelineWork(slot1, slot2) then
		return
	end

	slot3:start()
end

function slot0.registTimelineWork(slot0, slot1, slot2)
	return slot0.workComp:registWork(FightWorkTimelineItem, slot0.entity, slot1, slot2)
end

function slot0.registPlaySkillWork(slot0, slot1, slot2)
	FightHelper.logForPCSkillEditor("++++++++++++++++ entityId_ " .. slot0.entity.id .. " play skill_" .. slot1)

	if slot2 == nil then
		logError("找不到fightStepData, 请检查代码")

		return
	end

	if not lua_skill.configDict[slot1] then
		logError("技能表找不到id:" .. slot1)

		return
	end

	slot5 = slot0.entity:getMO() and slot4.skin

	if slot2 and slot4 and slot2.fromId == slot4.id then
		slot5 = FightHelper.processSkinByStepData(slot2, slot4)
	end

	return slot0:registTimelineWork(FightHelper.detectReplaceTimeline(FightConfig.instance:getSkinSkillTimeline(slot5, slot1), slot2), slot2)
end

function slot0.playSkill(slot0, slot1, slot2)
	if not slot0:registPlaySkillWork(slot1, slot2) then
		return
	end

	slot3:start()
end

function slot0.skipSkill(slot0)
	for slot5, slot6 in ipairs(slot0.workComp:getAliveWorkList()) do
		slot6:skipSkill()
	end
end

function slot0.stopSkill(slot0)
	for slot5, slot6 in ipairs(slot0.workComp:getAliveWorkList()) do
		slot6:disposeSelf()
	end
end

function slot0.isLastWork(slot0, slot1)
	return slot1 == slot0:getLastWork()
end

function slot0.getLastWork(slot0)
	slot1 = slot0.workComp:getAliveWorkList()

	return slot1[#slot1]
end

function slot0.getBinder(slot0)
	if not slot0:getLastWork() then
		return
	end

	return slot1:getBinder()
end

function slot0.getCurTimelineDuration(slot0)
	return slot0:getBinder() and slot1:GetDuration() or 0
end

function slot0.getCurFrameFloat(slot0)
	if not slot0:getBinder() then
		return
	end

	return slot1.CurFrameFloat
end

function slot0.getFrameFloatByTime(slot0, slot1)
	if not slot0:getBinder() then
		return
	end

	return slot2:GetFrameFloatByTime(slot1)
end

function slot0.setTimeScale(slot0, slot1)
	slot0.timeScale = slot1

	for slot6, slot7 in ipairs(slot0.workComp:getAliveWorkList()) do
		slot7:setTimeScale(slot1)
	end
end

function slot0.onUpdate(slot0)
	if not slot0.workComp then
		return
	end

	for slot5, slot6 in ipairs(slot0.workComp:getAliveWorkList()) do
		slot6:onUpdate()
	end
end

function slot0.beforeDestroy(slot0)
	slot0:stopSkill()
	slot0.workComp:disposeSelf()

	slot0.workComp = nil
end

function slot0.onDestroy(slot0)
	slot0.sameSkillParam = nil
end

function slot0.recordSameSkillStartParam(slot0, slot1, slot2)
	slot0.sameSkillStartParam[slot1.stepUid] = slot2
end

function slot0.recordFilterAtkEffect(slot0, slot1, slot2)
	if not slot0.sameSkillParam[slot2.stepUid] then
		slot0.sameSkillParam[slot2.stepUid] = {}
	end

	slot3.filter_atk_effects = {}

	for slot8, slot9 in ipairs(string.split(slot1, "#")) do
		slot3.filter_atk_effects[slot9] = true
	end
end

function slot0.atkEffectNeedFilter(slot0, slot1, slot2)
	if not slot0.sameSkillParam[slot2.stepUid] then
		return
	end

	if slot3.filter_atk_effects and slot3.filter_atk_effects[slot1] then
		return true
	end

	return false
end

function slot0.recordFilterFlyEffect(slot0, slot1, slot2)
	if not slot0.sameSkillParam[slot2.stepUid] then
		slot0.sameSkillParam[slot2.stepUid] = {}
	end

	slot3.filter_fly_effects = {}

	for slot8, slot9 in ipairs(string.split(slot1, "#")) do
		slot3.filter_fly_effects[slot9] = true
	end
end

function slot0.flyEffectNeedFilter(slot0, slot1, slot2)
	if not slot0.sameSkillParam[slot2.stepUid] then
		return
	end

	if slot3.filter_fly_effects and slot3.filter_fly_effects[slot1] then
		return true
	end

	return false
end

function slot0.clearSameSkillParam(slot0, slot1)
	if not slot0.sameSkillParam[slot1.stepUid] then
		return
	end

	slot3 = slot2.preStepData

	while slot3 do
		slot3 = slot0.sameSkillParam[slot3.stepUid] and slot0.sameSkillParam[slot4.stepUid].preStepData
		slot0.sameSkillStartParam[slot4.stepUid] = nil
		slot0.sameSkillParam[slot4.stepUid] = nil

		for slot9, slot10 in ipairs(slot0.workComp:getAliveWorkList()) do
			if slot10.fightStepData == slot4 then
				slot10:onDone(true)
			end
		end
	end

	slot0.sameSkillParam[slot1.stepUid] = nil
end

function slot0.stopCurTimelineWaitPlaySameSkill(slot0, slot1, slot2, slot3, slot4, slot5)
	if not slot0:getLastWork() then
		return
	end

	if not slot0.sameSkillParam[slot5.stepUid] then
		slot0.sameSkillParam[slot5.stepUid] = {}
	end

	slot7.curAnimState = slot2
	slot7.audio_id = slot3
	slot7.preStepData = slot4
	slot7.startParam = slot0.sameSkillStartParam[slot4.stepUid]

	slot6.timelineItem:stopCurTimelineWaitPlaySameSkill(slot1, slot2)
end

function slot0.sameSkillPlaying(slot0)
	return tabletool.len(slot0.sameSkillParam) > 0
end

return slot0
