module("modules.logic.fight.controller.FightASFDMgr", package.seeall)

slot0 = class("FightASFDMgr", FightUserDataBaseClass)
slot0.LoadingStatus = {
	NotLoad = 1,
	Loaded = 3,
	Loading = 2
}

function slot0.init(slot0)
	uv0.super.init(slot0)

	slot0.stepMoArrivedCount = {}
	slot0.effectWrap2EntityIdDict = {}
	slot0.sideEmitterWrap = nil
	slot0.missileWrapList = {}
	slot0.missileMoverList = {}
	slot0.explosionWrapList = {}
	slot0.playHitAnimEntityIdDict = {}
	slot0.startAnimLoadingStatus = uv0.LoadingStatus.NotLoad
	slot0.endAnimLoadingStatus = uv0.LoadingStatus.NotLoad

	slot0:addEventCb(FightController.instance, FightEvent.AddUseCard, slot0.onAddUseCard, slot0)
	slot0:addEventCb(FightController.instance, FightEvent.OnMySideRoundEnd, slot0.onMySideRoundEnd, slot0)
	slot0:addEventCb(FightController.instance, FightEvent.BeforePlayUniqueSkill, slot0.onBeforePlayUniqueSkill, slot0)
	slot0:addEventCb(FightController.instance, FightEvent.AfterPlayUniqueSkill, slot0.onAfterPlayUniqueSkill, slot0)
end

function slot0.playAudio(slot0, slot1)
	if not slot1 then
		return
	end

	if slot1 ~= 0 then
		AudioMgr.instance:trigger(slot1)
	end
end

function slot0.onBeforePlayUniqueSkill(slot0)
	if slot0.bornEffectWrap then
		slot0.bornEffectWrap:setActive(false)
	end
end

function slot0.onAfterPlayUniqueSkill(slot0)
	if slot0.bornEffectWrap then
		slot0.bornEffectWrap:setActive(true)
	end
end

function slot0.getASFDEntityMo(slot0, slot1)
	if not slot1 then
		return
	end

	if not FightPlayCardModel.instance:getUsedCards() then
		return
	end

	for slot6, slot7 in ipairs(slot1) do
		if slot2[slot7] and FightDataHelper.entityMgr:getById(slot8.uid) and slot10:isASFDEmitter() then
			return slot10
		end
	end
end

function slot0.onAddUseCard(slot0, slot1)
	if not slot0:getASFDEntityMo(slot1) then
		return
	end

	if not FightHelper.getEntity(slot2.id) then
		logError("没有找到发射奥术飞弹的实体" .. tostring(slot3))

		return
	end

	slot5 = FightASFDHelper.getBornCo(slot3)
	slot0.curBornCo = slot5
	slot0.bornEntity = slot4
	slot0.bornEffectWrap = slot4.effect:addGlobalEffect(FightASFDConfig.instance:getASFDCoRes(slot5))

	FightRenderOrderMgr.instance:addEffectWrapByOrder(slot3, slot0.bornEffectWrap, FightRenderOrderMgr.MaxOrder)
	slot0.bornEffectWrap:setLocalPos(FightASFDHelper.getEmitterPos(slot2.side))

	if slot5.scale == 0 then
		slot7 = 1
	end

	slot0.bornEffectWrap:setEffectScale(slot7)
	slot0:playAudio(slot5.audio)

	slot0.effectWrap2EntityIdDict[slot0.bornEffectWrap] = slot3
end

function slot0.onMySideRoundEnd(slot0)
	slot0:clearBornEffect()
end

function slot0.createEmitterWrap(slot0, slot1)
	if not slot1 then
		return
	end

	if not FightDataHelper.entityMgr:getById(slot1.fromId) then
		logError("没有找到发射奥术飞弹的实体 mo")

		return
	end

	if slot0.sideEmitterWrap then
		return
	end

	if not FightHelper.getEntity(slot2) then
		logError("没有找到发射奥术飞弹的实体")

		return
	end

	FightController.instance:dispatchEvent(FightEvent.ASFD_OnStart, slot4, FightASFDConfig.instance.skillId, slot1)
	slot0:clearBornEffect(true)

	slot5 = FightASFDHelper.getEmitterCo(slot2)
	slot7 = slot4.effect:addGlobalEffect(FightASFDConfig.instance:getASFDCoRes(slot5))

	FightRenderOrderMgr.instance:addEffectWrapByOrder(slot2, slot7, FightRenderOrderMgr.MaxOrder)
	slot7:setLocalPos(FightASFDHelper.getEmitterPos(slot3.side))

	if slot5.scale == 0 then
		slot8 = 1
	end

	slot7:setEffectScale(slot8)
	slot0:playAudio(slot5.audio)

	slot0.sideEmitterWrap = slot7
	slot0.effectWrap2EntityIdDict[slot7] = slot2

	slot0:preloadEmitterRemoveRes(slot5)
	slot0:playStartASFDAnim()

	return slot7
end

function slot0.preloadEmitterRemoveRes(slot0, slot1)
	loadAbAsset(FightHelper.getEffectUrlWithLod(FightASFDHelper.getASFDEmitterRemoveRes(slot1)), true)
end

function slot0.emitMissile(slot0, slot1, slot2)
	if not slot1 then
		return slot0:emitterFail(slot1)
	end

	slot0.curStepMo = slot1
	slot0.stepMoArrivedCount[slot1] = {
		0,
		0
	}
	slot3 = true

	if not ((not slot2 or slot2.splitNum <= 0 or slot0:emitterFissionMissile(slot1, slot2)) and slot0:emitterNormalMissile(slot1, slot2)) then
		return slot0:emitterFail(slot1)
	end
end

function slot0.emitterNormalMissile(slot0, slot1, slot2)
	if not slot1 then
		return
	end

	if slot0:_emitterOneMissile(slot1, FightASFDHelper.getMissileTargetId(slot1), slot2) then
		slot0.stepMoArrivedCount[slot1][1] = slot0.stepMoArrivedCount[slot1][1] + 1

		return true
	end
end

function slot0.emitterFissionMissile(slot0, slot1, slot2)
	if not slot1 then
		return
	end

	slot0.targetDict = slot0.targetDict or {}

	tabletool.clear(slot0.targetDict)

	for slot6, slot7 in ipairs(slot1.actEffectMOs) do
		if FightASFDHelper.isDamageEffect(slot7.effectType) then
			slot0.targetDict[slot7.targetId] = true
		end
	end

	slot3 = true

	for slot7, slot8 in pairs(slot0.targetDict) do
		if slot0:_emitterOneMissile(slot1, slot7, slot2) then
			slot3 = false
			slot0.stepMoArrivedCount[slot1][1] = slot0.stepMoArrivedCount[slot1][1] + 1

			slot9:setEffectScale(FightASFDConfig.instance.fissionScale)
		end
	end

	tabletool.clear(slot0.targetDict)

	return not slot3
end

function slot0._emitterOneMissile(slot0, slot1, slot2, slot3)
	if not FightHelper.getEntity(slot1.fromId) then
		logError("没有找到发射奥术飞弹的实体, entityId : " .. tostring(slot4))

		return
	end

	if not FightHelper.getEntity(slot2) then
		logError("没有找到奥术飞弹 命中实体, toId : " .. tostring(slot2))

		return
	end

	slot7 = FightASFDHelper.getMissileCo(slot4)
	slot8 = FightASFDConfig.instance:getASFDCoRes(slot7)
	slot9 = slot5.effect:addGlobalEffect(slot8)

	FightRenderOrderMgr.instance:addEffectWrapByOrder(slot4, slot9, FightRenderOrderMgr.MaxOrder)

	slot10 = FightASFDFlyPathHelper.getMissileMover(slot5, slot7, slot9, slot2, slot3, slot0.onArrived, slot0)
	slot10.missileWrap = slot9
	slot10.stepMo = slot1
	slot10.toId = slot2
	slot10.asfdContext = slot3
	slot10.missileRes = slot8

	if slot7.scale == 0 then
		slot11 = 1
	end

	slot9:setEffectScale(slot11)
	slot0:playAudio(slot7.audio)
	table.insert(slot0.missileMoverList, slot10)
	table.insert(slot0.missileWrapList, slot9)

	slot0.effectWrap2EntityIdDict[slot9] = slot4

	return slot9
end

function slot0.pullOut(slot0, slot1)
	for slot5, slot6 in ipairs(slot0.alfResidualEffectList) do
		slot7 = slot6[1]
		slot8 = slot6[2]

		if FightHelper.getEntity(slot6[3]) then
			slot10.effect:removeEffect(slot7)
		end

		FightRenderOrderMgr.instance:onRemoveEffectWrap(slot9, slot7)

		if slot10 and lua_fight_sp_effect_alf.configDict[slot8] then
			slot12 = slot10.effect:addHangEffect(slot11.pullOutRes, ModuleEnum.SpineHangPoint.mountbody, nil, 1)

			slot12:setLocalPos(0, 0, 0)
			FightRenderOrderMgr.instance:addEffectWrapByOrder(slot9, slot12, FightRenderOrderMgr.MaxOrder)
			slot0:playAudio(slot11.audioId)
		end
	end

	tabletool.clear(slot0.alfResidualEffectList)
end

function slot0.emitterFail(slot0, slot1)
	return slot0:onASFDArrived(slot1)
end

function slot0.onArrived(slot0, slot1)
	slot5 = slot0.stepMoArrivedCount[slot1.stepMo] or {
		1,
		0
	}
	slot5[2] = slot5[2] + 1

	slot0:tryAddALFResidualEffectData(slot1.missileRes, slot1)
	slot0:createExplosionEffect(slot2, slot1.toId, slot1.asfdContext)
	slot0:playHitAction(slot1.toId)
	slot0:floatDamage(slot1.stepMo, slot1.toId)
	slot0:clearMover(slot1)

	if slot5[1] <= slot5[2] then
		slot0.stepMoArrivedCount[slot2] = nil

		return slot0:onASFDArrived(slot2)
	end
end

function slot0.tryAddALFResidualEffectData(slot0, slot1, slot2)
	if not lua_fight_sp_effect_alf.configDict[slot1] then
		return
	end

	FightDataHelper.ASFDDataMgr:addEntityResidualData(slot2.toId, {
		missileRes = slot1,
		entityId = slot2.toId,
		startPos = slot2:getLastStartPos(),
		endPos = slot2:getLastEndPos()
	})
end

function slot0.onASFDArrived(slot0, slot1)
	return FightController.instance:dispatchEvent(FightEvent.ASFD_OnASFDArrivedDone, slot1)
end

function slot0.createExplosionEffect(slot0, slot1, slot2, slot3)
	if not FightHelper.getEntity(slot2) then
		return
	end

	slot5 = FightASFDHelper.getExplosionCo(slot1 and slot1.fromId)
	slot6 = FightASFDConfig.instance.explosionDuration / FightModel.instance:getSpeed()
	slot8 = slot4.effect:addHangEffect(FightASFDConfig.instance:getASFDCoRes(slot5), ModuleEnum.SpineHangPoint.mountbody, nil, slot6)

	slot8:setLocalPos(0, 0, 0)
	slot8:setEffectScale(FightASFDHelper.getASFDExplosionScale(slot1, slot5, slot2))
	slot0:playAudio(slot5.audio)
	FightRenderOrderMgr.instance:addEffectWrapByOrder(slot2, slot8, FightRenderOrderMgr.MaxOrder)

	slot0.effectWrap2EntityIdDict[slot8] = slot2

	table.insert(slot0.explosionWrapList, slot8)
	TaskDispatcher.cancelTask(slot0.onExplosionEffectDone, slot0)
	TaskDispatcher.runDelay(slot0.onExplosionEffectDone, slot0, slot6)
end

function slot0.onExplosionEffectDone(slot0)
	FightController.instance:dispatchEvent(FightEvent.ASFD_OnASFDExplosionDone)
end

function slot0.playHitAction(slot0, slot1)
	if not FightHelper.getEntity(slot1) then
		return
	end

	slot3 = FightHelper.processEntityActionName(slot2, "hit")

	slot2.spine:play(slot3, false, true, true)
	slot2.spine:removeAnimEventCallback(slot0._onAnimEvent, slot0)
	slot2.spine:addAnimEventCallback(slot0._onAnimEvent, slot0, {
		slot2,
		slot3
	})

	slot0.playHitAnimEntityIdDict[slot1] = true
end

function slot0._onAnimEvent(slot0, slot1, slot2, slot3, slot4)
	slot5 = slot4[1]

	if slot2 == SpineAnimEvent.ActionComplete and slot1 == slot4[2] then
		slot5.spine:removeAnimEventCallback(slot0._onAnimEvent, slot0)
		slot5:resetAnimState()
	end
end

function slot0.floatDamage(slot0, slot1, slot2)
	slot3 = FightWorkFlowSequence.New(slot1)

	slot0:addDamageWork(slot3, slot1, slot2)

	slot4 = FightStepEffectWork.New()

	slot4:setFlow(slot3)
	slot4:onStartInternal()
end

function slot0.addDamageWork(slot0, slot1, slot2, slot3)
	if not (slot2 and slot2.actEffectMOs) then
		return
	end

	for slot8, slot9 in ipairs(slot4) do
		if FightASFDHelper.isDamageEffect(slot9.effectType) and slot9.targetId == slot3 then
			if FightStepBuilder.ActEffectWorkCls[slot10] then
				slot1:registWork(slot11, slot2, slot9)
			end
		elseif slot10 == FightEnum.EffectType.FIGHTSTEP then
			slot0:addDamageWork(slot1, slot9.cus_stepMO, slot3)
		end
	end
end

function slot0.onContinueASFDFlowDone(slot0)
	slot0.curStepMo = nil

	TaskDispatcher.cancelTask(slot0.onExplosionEffectDone, slot0)
end

function slot0.onASFDFlowDone(slot0, slot1)
	slot0.curStepMo = nil

	slot0:clearBornEffect(true)
	slot0:clearEmitterEffect(slot1)
	slot0:clearMissileEffect()
	slot0:clearExplosionEffect()
	tabletool.clear(slot0.effectWrap2EntityIdDict)
	TaskDispatcher.cancelTask(slot0.onExplosionEffectDone, slot0)
	slot0:resetSpineAnim()
	tabletool.clear(slot0.stepMoArrivedCount)
end

function slot0.clearBornEffect(slot0, slot1)
	if not slot0.bornEffectWrap then
		return
	end

	slot0:removeEffect(slot0.bornEffectWrap)

	slot0.bornEffectWrap = nil

	if not slot1 then
		slot0:createBornRemoveEffect()
	end

	slot0.curBornCo = nil
	slot0.bornEntity = nil
end

function slot0.createBornRemoveEffect(slot0)
	if slot0.curBornCo and slot0.bornEntity then
		slot2 = slot0.bornEntity.effect:addGlobalEffect(FightASFDHelper.getASFDBornRemoveRes(slot0.curBornCo), nil, 1)

		FightRenderOrderMgr.instance:addEffectWrapByOrder(slot0.bornEntity.id, slot2, FightRenderOrderMgr.MaxOrder)
		slot2:setLocalPos(FightASFDHelper.getEmitterPos(slot0.bornEntity:getMO().side))

		if slot0.curBornCo.scale == 0 then
			slot4 = 1
		end

		slot2:setEffectScale(slot4)
	end
end

function slot0.clearEmitterEffect(slot0, slot1)
	if not slot0.sideEmitterWrap then
		return
	end

	slot0:removeEffect(slot0.sideEmitterWrap)
	slot0:createRemoveEmitterEffect(slot1)
	slot0:playEndASFDAnim()

	slot0.sideEmitterWrap = nil
end

function slot0.createRemoveEmitterEffect(slot0, slot1)
	if not slot1 then
		return
	end

	if not FightDataHelper.entityMgr:getById(slot1.fromId) then
		return
	end

	if not FightHelper.getEntity(slot2) then
		return
	end

	slot5 = FightASFDHelper.getEmitterCo(slot2)
	slot7 = slot4.effect:addGlobalEffect(FightASFDHelper.getASFDEmitterRemoveRes(slot5), nil, 1)

	FightRenderOrderMgr.instance:addEffectWrapByOrder(slot2, slot7, FightRenderOrderMgr.MaxOrder)
	slot7:setLocalPos(FightASFDHelper.getEmitterPos(slot3.side))

	if slot5.scale == 0 then
		slot8 = 1
	end

	slot7:setEffectScale(slot8)
end

function slot0.clearMissileEffect(slot0)
	if slot0.missileWrapList then
		for slot4, slot5 in ipairs(slot0.missileWrapList) do
			slot0:removeEffect(slot5)
		end

		tabletool.clear(slot0.missileWrapList)
	end

	if slot0.missileMoverList then
		for slot4, slot5 in ipairs(slot0.missileMoverList) do
			slot0:clearMover(slot5)
		end

		tabletool.clear(slot0.missileMoverList)
	end
end

function slot0.clearMover(slot0, slot1)
	if not slot1 then
		return
	end

	slot1:unregisterCallback(UnitMoveEvent.Arrive, slot0.onArrived, slot0)

	slot1.missileWrap = nil
	slot1.stepMo = nil
	slot1.toId = nil
	slot1.asfdContext = nil
	slot1.missileRes = nil
end

function slot0.clearExplosionEffect(slot0)
	if not slot0.explosionWrapList then
		return
	end

	for slot4, slot5 in ipairs(slot0.explosionWrapList) do
		slot0:removeEffect(slot5)
	end

	tabletool.clear(slot0.explosionWrapList)
end

function slot0.removeEffect(slot0, slot1)
	if not slot1 then
		return
	end

	if FightHelper.getEntity(slot0.effectWrap2EntityIdDict[slot1]) then
		slot3.effect:removeEffect(slot1)
	end

	FightRenderOrderMgr.instance:onRemoveEffectWrap(slot2, slot1)
end

function slot0.resetSpineAnim(slot0)
	if not slot0.playHitAnimEntityIdDict then
		return
	end

	for slot4, slot5 in pairs(slot0.playHitAnimEntityIdDict) do
		if FightHelper.getEntity(slot4) then
			slot6.spine:removeAnimEventCallback(slot0._onAnimEvent, slot0)
			slot6:resetAnimState()
		end
	end

	tabletool.clear(slot0.playHitAnimEntityIdDict)
end

function slot0.playStartASFDAnim(slot0)
	if slot0.startAnimLoadingStatus == uv0.LoadingStatus.NotLoad then
		loadAbAsset(FightASFDConfig.instance.startAnimAbUrl, false, slot0.loadStartAnimCallback, slot0)

		slot0.startAnimLoadingStatus = uv0.LoadingStatus.Loading

		return
	end

	if slot0.startAnimLoadingStatus == uv0.LoadingStatus.Loading then
		return
	end

	if CameraMgr.instance:getCameraRootAnimator() then
		slot1.enabled = true
		slot1.runtimeAnimatorController = slot0.startAnimController

		slot1:Play("v2a4_asfd_start", 0, 0)
	end
end

function slot0.loadStartAnimCallback(slot0, slot1)
	if not slot1.IsLoadSuccess then
		slot0.startAnimLoadingStatus = uv0.LoadingStatus.NotLoad

		return
	end

	slot0.startAnimLoadingStatus = uv0.LoadingStatus.Loaded
	slot0.startAssetItem = slot1

	slot1:Retain()

	slot0.startAnimController = slot1:GetResource(FightASFDConfig.instance.startAnim)

	return slot0:playStartASFDAnim()
end

function slot0.playEndASFDAnim(slot0)
	if slot0.endAnimLoadingStatus == uv0.LoadingStatus.NotLoad then
		loadAbAsset(FightASFDConfig.instance.endAnimAbUrl, false, slot0.loadEndAnimCallback, slot0)

		slot0.endAnimLoadingStatus = uv0.LoadingStatus.Loading

		return
	end

	if slot0.endAnimLoadingStatus == uv0.LoadingStatus.Loading then
		return
	end

	if CameraMgr.instance:getCameraRootAnimator() then
		slot1.enabled = true
		slot1.runtimeAnimatorController = slot0.endAnimController

		slot1:Play("v2a4_asfd_end", 0, 0)
	end
end

function slot0.loadEndAnimCallback(slot0, slot1)
	if not slot1.IsLoadSuccess then
		slot0.endAnimLoadingStatus = uv0.LoadingStatus.NotLoad

		return
	end

	slot0.endAnimLoadingStatus = uv0.LoadingStatus.Loaded
	slot0.endAssetItem = slot1

	slot1:Retain()

	slot0.endAnimController = slot1:GetResource(FightASFDConfig.instance.endAnim)

	return slot0:playEndASFDAnim()
end

function slot0.removeLoader(slot0)
	removeAssetLoadCb(FightASFDConfig.instance.startAnimAbUrl, slot0.loadStartAnimCallback, slot0)

	if slot0.startAssetItem then
		slot0.startAssetItem:Release()

		slot0.startAssetItem = nil
	end

	removeAssetLoadCb(FightASFDConfig.instance.endAnimAbUrl, slot0.loadEndAnimCallback, slot0)

	if slot0.endAssetItem then
		slot0.endAssetItem:Release()

		slot0.endAssetItem = nil
	end
end

function slot0.dispose(slot0)
	slot0:onASFDFlowDone()
	slot0:removeLoader()
	uv0.super.dispose(slot0)
end

return slot0
