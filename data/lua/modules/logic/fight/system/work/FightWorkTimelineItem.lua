module("modules.logic.fight.system.work.FightWorkTimelineItem", package.seeall)

slot0 = class("FightWorkTimelineItem", FightWorkItem)

function slot0.onConstructor(slot0, slot1, slot2, slot3)
	slot0.entity = slot1
	slot0.timelineName = slot2
	slot0.fightStepData = slot3
	slot0.skillId = slot0.fightStepData.actId
end

function slot0.onStart(slot0)
	slot0.timelineUrl = ResUrl.getSkillTimeline(slot0.timelineName)

	slot0:com_loadAsset(FightHelper.getRolesTimelinePath(slot0.timelineName), slot0.onTimelineLoaded, slot0)
	slot0:cancelFightWorkSafeTimer()
end

function slot0.onTimelineLoaded(slot0, slot1, slot2)
	if not slot1 then
		logError("timeline资源加载失败,路径:" .. slot0.timelineUrl)
		slot0:onDone(true)

		return
	end

	slot0.assetLoader = slot2

	FightHelper.logForPCSkillEditor("播放timeline:" .. slot0.timelineName)
	slot0:startTimeline()
end

function slot0.dealSpeed(slot0)
	FightHelper.setBossSkillSpeed(slot0.entity.id)
	FightHelper.setTimelineExclusiveSpeed(slot0.timelineName)
	FightModel.instance:updateRTPCSpeed()
end

function slot0.startTimeline(slot0)
	slot0:dealSpeed()

	slot0._startTime = Time.time

	slot0:beforePlayTimeline()

	slot0.timelineItem = slot0:newClass(FightSkillTimelineItem, slot0)

	slot0.timelineItem:play()
	FightMsgMgr.sendMsg(FightMsgId.PlayTimelineSkill, slot0.entity, slot0.skillId, slot0.fightStepData, slot0.timelineName)
	FightController.instance:dispatchEvent(FightEvent.OnSkillPlayStart, slot0.entity, slot0.skillId, slot0.fightStepData, slot0.timelineName)
end

function slot0.sameSkillPlaying(slot0)
	return false
end

function slot0.onUpdate(slot0)
	if slot0.timelineItem then
		slot0.timelineItem:onUpdate()
	end
end

function slot0.setTimeScale(slot0, slot1)
	if slot0.timelineItem then
		slot0.timelineItem:setTimeScale(slot1)
	end
end

function slot0.getBinder(slot0)
	return slot0.timelineItem and slot0.timelineItem.binder
end

function slot0.skipSkill(slot0)
	slot0.timelineItem:skipSkill()
	slot0.timelineItem:onTimelineEnd()
end

function slot0.onTimelineFinish(slot0)
	if not slot0.skipAfterTimelineFunc then
		slot0:afterPlayTimeline()
	end

	CameraMgr.instance:getCameraShake():StopShake()
	FightHelper.cancelBossSkillSpeed()
	FightHelper.cancelExclusiveSpeed()
	FightModel.instance:updateRTPCSpeed()
	FightMsgMgr.sendMsg(FightMsgId.PlayTimelineSkillFinish, slot0.entity, slot0.skillId, slot0.fightStepData, slot0._timelineName)
	FightController.instance:dispatchEvent(FightEvent.OnSkillPlayFinish, slot0.entity, slot0.skillId, slot0.fightStepData, slot0._timelineName)

	if not slot0.IS_DISPOSED then
		slot0:onDone(true)
	end
end

function slot0.afterPlayTimeline(slot0)
	FightSkillMgr.instance:afterTimeline(slot0.entity, slot0.fightStepData)
	slot0:_resetTargetHp()

	if slot0.timelineItem then
		slot0:_checkFloatTable(slot0.timelineItem.timelineContext.floatNum, "伤害")
		slot0:_checkFloatTable(slot0.timelineItem.timelineContext.healFloatNum, "回血")
	end

	if slot0.entity.buff then
		slot0.entity.buff:showBuffEffects("before_skill_timeline")
	end

	if slot0._hide_defenders_buff_effect then
		FightHelper.revertDefenderBuffEffect(slot0._hide_defenders_buff_effect, "before_skill_timeline")

		slot0._hide_defenders_buff_effect = nil
	end

	if not FightSkillMgr.instance:isPlayingAnyTimeline() then
		FightFloatMgr.instance:resetInterval()
		slot0:_cancelSideRenderOrder()
		GameSceneMgr.instance:getCurScene().camera:enablePostProcessSmooth(false)

		if slot0.fightStepData.hasPlayTimelineCamera then
			GameSceneMgr.instance:getCurScene().camera:resetParam()
		end

		GameSceneMgr.instance:getCurScene().entityMgr.enableSpineRotate = true

		if not slot0.entity:getMO() or not slot1:isPassiveSkill(slot0.skillId) then
			GameSceneMgr.instance:getCurScene().level:setFrontVisible(true)
		end

		FightController.instance:dispatchEvent(FightEvent.SetIsShowUI, true)
		FightController.instance:dispatchEvent(FightEvent.SetIsShowFloat, true)
		FightController.instance:dispatchEvent(FightEvent.SetIsShowNameUI, true)
	end
end

function slot0.beforePlayTimeline(slot0)
	slot0:setSideRenderOrder()

	if slot0.entity.buff then
		slot0.entity.buff:hideLoopEffects("before_skill_timeline")
	end

	slot4 = "before_skill_timeline"

	for slot4, slot5 in pairs(FightHelper.hideDefenderBuffEffect(slot0.fightStepData, slot4)) do
		slot0.hide_defenders_buff_effect = slot0.hide_defenders_buff_effect or {}

		table.insert(slot0.hide_defenders_buff_effect, slot5)
	end

	if not FightSkillMgr.instance:isPlayingAnyTimeline() then
		if not slot0.entity.skill:sameSkillPlaying() then
			FightFloatMgr.instance:removeInterval()
		end

		if not slot0.entity:getMO() or not slot1:isPassiveSkill(slot0.skillId) then
			GameSceneMgr.instance:getCurScene().level:setFrontVisible(false)
		end
	end

	FightSkillMgr.instance:beforeTimeline(slot0.entity, slot0.fightStepData)
end

function slot0.setSideRenderOrder(slot0)
	for slot6, slot7 in ipairs(FightHelper.getSideEntitys(slot0.entity:getSide(), true)) do
		slot8 = nil

		if FightEnum.AtkRenderOrderIgnore[FightModel.instance:getFightParam().battleId] and slot9[slot7:getSide()] and tabletool.indexOf(slot10, slot7:getMO().position) then
			slot8 = true
		end

		if not slot8 then
			slot1[slot6] = slot7.id
		end
	end

	for slot7, slot8 in pairs(FightRenderOrderMgr.sortOrder(FightEnum.RenderOrderType.StandPos, slot1)) do
		FightRenderOrderMgr.instance:setOrder(slot7, FightEnum.TopOrderFactor + slot8 - 1)
	end
end

function slot0._cancelSideRenderOrder(slot0)
	for slot5, slot6 in ipairs(FightHelper.getAllEntitys(slot0.entity:getSide())) do
		FightRenderOrderMgr.instance:cancelOrder(slot6.id)
	end

	FightRenderOrderMgr.instance:setSortType(FightEnum.RenderOrderType.StandPos)
end

function slot0._resetTargetHp(slot0)
	for slot4, slot5 in ipairs(slot0.fightStepData.actEffect) do
		if FightHelper.getEntity(slot5.targetId) and slot6.nameUI then
			slot6.nameUI:resetHp()
		end
	end
end

function slot0._checkFloatTable(slot0, slot1, slot2)
	if not slot1 then
		return
	end

	if not isDebugBuild then
		return
	end

	if Time.timeScale > 1 then
		return
	end

	if FightModel.instance:getSpeed() > 1.5 then
		return
	end

	for slot6, slot7 in pairs(slot1) do
		for slot11, slot12 in pairs(slot7) do
			if math.abs(slot12.ratio - 1) > 0.0001 then
				logError("技能" .. slot2 .. "系数之和为" .. slot12.ratio .. " " .. slot0.timelineName)
			end

			return
		end
	end
end

function slot0.clearWork(slot0)
end

return slot0
