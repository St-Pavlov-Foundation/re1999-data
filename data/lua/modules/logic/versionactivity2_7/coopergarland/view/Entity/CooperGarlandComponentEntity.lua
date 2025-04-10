module("modules.logic.versionactivity2_7.coopergarland.view.Entity.CooperGarlandComponentEntity", package.seeall)

slot0 = class("CooperGarlandComponentEntity", LuaCompBase)

function slot0.ctor(slot0, slot1)
	slot0.mapId = slot1.mapId
	slot0.componentId = slot1.componentId
	slot0.componentType = slot1.componentType
	slot0.extraParam = string.splitToNumber(CooperGarlandConfig.instance:getMapComponentExtraParams(slot0.mapId, slot0.componentId), "#")
	slot0.spikeMoveSpeed = CooperGarlandConfig.instance:getAct192Const(CooperGarlandEnum.ConstId.SpikeMoveSpeed, true)
end

function slot0.init(slot0, slot1)
	slot0.go = slot1
	slot0.trans = slot1.transform
	slot0.animator = slot0.go:GetComponent(typeof(UnityEngine.Animator))

	if slot0.animator then
		slot0.animatorPlayer = ZProj.ProjAnimatorPlayer.Get(slot0.go)
	end

	slot0:onInit()
end

function slot0.onInit(slot0)
	slot1 = slot0.componentType == CooperGarlandEnum.ComponentType.Wall
	slot2, slot3 = CooperGarlandConfig.instance:getMapComponentPos(slot0.mapId, slot0.componentId)
	slot4 = CooperGarlandGameEntityMgr.instance:getCompPosZ(slot1)

	transformhelper.setLocalPos(slot0.trans, slot2, slot3, slot4)

	slot0.originalPos = {
		x = slot2,
		y = slot3,
		z = slot4
	}

	transformhelper.setEulerAngles(slot0.trans, 0, 0, CooperGarlandConfig.instance:getMapComponentRotation(slot0.mapId, slot0.componentId))

	slot6 = CooperGarlandConfig.instance:getMapComponentScale(slot0.mapId, slot0.componentId)

	transformhelper.setLocalScale(slot0.trans, slot6, slot6, 1)

	slot7, slot8 = CooperGarlandConfig.instance:getMapComponentSize(slot0.mapId, slot0.componentId)

	recthelper.setSize(slot0.trans, slot7, slot8)

	slot0._collider = gohelper.onceAddComponent(slot0.go, typeof(UnityEngine.BoxCollider))
	slot9, slot10 = CooperGarlandConfig.instance:getMapComponentColliderSize(slot0.mapId, slot0.componentId)
	slot0._collider.size = Vector3(slot9, slot10, CooperGarlandGameEntityMgr.instance:getCompColliderSizeZ())
	slot13, slot14 = CooperGarlandConfig.instance:getMapComponentColliderOffset(slot0.mapId, slot0.componentId)
	slot0._collider.center = Vector3(slot13, slot14, CooperGarlandGameEntityMgr.instance:getCompColliderOffsetZ(slot1))
	slot0._collider.isTrigger = not slot1 and not (slot0.componentType == CooperGarlandEnum.ComponentType.Door)

	if slot0.componentType == CooperGarlandEnum.ComponentType.Hole or slot0.componentType == CooperGarlandEnum.ComponentType.Spike then
		slot0._goRemoveModeVx = gohelper.findChild(slot0.go, "image_vx")
		slot0._click = ZProj.BoxColliderClickListener.Get(gohelper.findChild(slot0.go, "#go_click"))

		slot0._click:SetIgnoreUI(true)
	end

	slot0:reset()
end

function slot0.addEventListeners(slot0)
	if slot0._click then
		slot0._click:AddClickListener(slot0._onClick, slot0)
	end

	slot0:addEventCb(CooperGarlandController.instance, CooperGarlandEvent.OnBallKeyChange, slot0._onBallKeyChange, slot0)
	slot0:addEventCb(CooperGarlandController.instance, CooperGarlandEvent.OnRemoveModeChange, slot0._onRemoveModeChange, slot0)
	slot0:addEventCb(CooperGarlandController.instance, CooperGarlandEvent.OnGameStopChange, slot0._onGameStopChange, slot0)
end

function slot0.removeEventListeners(slot0)
	if slot0._click then
		slot0._click:RemoveClickListener()
	end

	slot0:removeEventCb(CooperGarlandController.instance, CooperGarlandEvent.OnBallKeyChange, slot0._onBallKeyChange, slot0)
	slot0:removeEventCb(CooperGarlandController.instance, CooperGarlandEvent.OnRemoveModeChange, slot0._onRemoveModeChange, slot0)
	slot0:removeEventCb(CooperGarlandController.instance, CooperGarlandEvent.OnGameStopChange, slot0._onGameStopChange, slot0)
end

function slot0._onClick(slot0)
	if slot0._isDead then
		return
	end

	if GuideModel.instance:getFlagValue(GuideModel.GuideFlag.CooperGarlandForceRemove) and slot0.componentId ~= tonumber(slot1) then
		return
	end

	CooperGarlandController.instance:removeComponent(slot0.mapId, slot0.componentId)
end

function slot0.onTriggerEnter(slot0, slot1)
	if slot0._isDead then
		return
	end

	CooperGarlandController.instance:triggerEnterComponent(slot0.mapId, slot0.componentId)
end

function slot0.onTriggerExit(slot0, slot1)
	if slot0._isDead then
		return
	end

	CooperGarlandController.instance:triggerExitComponent(slot0.mapId, slot0.componentId)
end

function slot0._onBallKeyChange(slot0)
	if slot0._isDead then
		return
	end

	slot0:refreshDoorCollider()
end

function slot0._onRemoveModeChange(slot0)
	if slot0._isDead then
		return
	end

	slot0:refreshRemoveMode()
end

function slot0._onGameStopChange(slot0)
	if slot0.componentType ~= CooperGarlandEnum.ComponentType.Spike or #slot0.extraParam <= 0 then
		return
	end

	if CooperGarlandGameModel.instance:getIsStopGame() then
		slot0:killTween()
	elseif not slot0.moveTweenId then
		slot3, slot4, slot5 = transformhelper.getLocalPos(slot0.trans)

		slot0:beginMove(slot0.extraParam[1] == CooperGarlandEnum.Const.SpikeMoveDirX and slot3 or slot4, slot0._moveParam and slot0._moveParam.from, slot0._moveParam and slot0._moveParam.to)
	end
end

function slot0.refresh(slot0)
	slot0:refreshDoorCollider()
	slot0:refreshRemoveMode()
end

function slot0.refreshDoorCollider(slot0)
	if not (slot0.componentType == CooperGarlandEnum.ComponentType.Door) then
		return
	end

	if slot0._collider then
		slot0._collider.isTrigger = CooperGarlandGameModel.instance:getBallHasKey()
	end
end

function slot0.refreshRemoveMode(slot0)
	gohelper.setActive(slot0._goRemoveModeVx, CooperGarlandGameModel.instance:getIsRemoveMode())
end

function slot0.beginMove(slot0, slot1, slot2, slot3)
	if CooperGarlandGameModel.instance:getIsStopGame() or slot0.moveTweenId or slot0.componentType ~= CooperGarlandEnum.ComponentType.Spike or #slot0.extraParam <= 0 then
		return
	end

	slot6 = slot0.extraParam[1] == CooperGarlandEnum.Const.SpikeMoveDirX
	slot7 = slot3 or slot0.extraParam[2]
	slot8 = slot2 or slot6 and slot0.originalPos.x or slot0.originalPos.y
	slot0._moveParam = {
		dir = slot5,
		from = slot8,
		to = slot7
	}

	if slot6 then
		slot0.moveTweenId = ZProj.TweenHelper.DOAnchorPosX(slot0.trans, slot7, math.abs(slot7 - (slot1 or slot8)) / slot0.spikeMoveSpeed, slot0._movePingPong, slot0, slot0._moveParam, EaseType.Linear)
	else
		slot0.moveTweenId = ZProj.TweenHelper.DOAnchorPosY(slot0.trans, slot7, slot9, slot0._movePingPong, slot0, slot0._moveParam, EaseType.Linear)
	end
end

function slot0._movePingPong(slot0, slot1)
	slot2 = slot1.dir
	slot3 = slot1.from
	slot4 = slot1.to
	slot0._moveParam = {
		dir = slot2,
		from = slot4,
		to = slot3
	}

	if slot2 == CooperGarlandEnum.Const.SpikeMoveDirX then
		slot0.moveTweenId = ZProj.TweenHelper.DOAnchorPosX(slot0.trans, slot3, math.abs(slot3 - slot4) / slot0.spikeMoveSpeed, slot0._movePingPong, slot0, slot0._moveParam, EaseType.Linear)
	else
		slot0.moveTweenId = ZProj.TweenHelper.DOAnchorPosY(slot0.trans, slot3, slot5, slot0._movePingPong, slot0, slot0._moveParam, EaseType.Linear)
	end
end

function slot0.setRemoved(slot0)
	slot0._isDead = true

	slot0:killTween()

	if slot0.animatorPlayer then
		slot0.animator.speed = 1

		slot0.animatorPlayer:Play("out", slot0._playRemoveAnimFinish, slot0)
	else
		slot0:_playRemoveAnimFinish()
	end
end

function slot0._playRemoveAnimFinish(slot0)
	gohelper.setActive(slot0.go, false)
end

function slot0.getWorldPos(slot0)
	return slot0.trans and slot0.trans.position
end

function slot0.reset(slot0)
	if CooperGarlandGameModel.instance:isFinishedStoryComponent(slot0.mapId, slot0.componentId) then
		return
	end

	slot0._isDead = false
	slot0._moveParam = nil

	slot0:refresh()
	slot0:killTween()
	transformhelper.setLocalPos(slot0.trans, slot0.originalPos.x, slot0.originalPos.y, slot0.originalPos.z)
	slot0:beginMove()
	gohelper.setActive(slot0.go, true)

	if slot0.animator then
		slot0.animator.enabled = true
		slot0.animator.speed = 0

		slot0.animator:Play("out", 0, 0)
	end
end

function slot0.killTween(slot0)
	if slot0.moveTweenId then
		ZProj.TweenHelper.KillById(slot0.moveTweenId)

		slot0.moveTweenId = nil
	end
end

function slot0.getIsRemoved(slot0)
	return slot0._isDead
end

function slot0.destroy(slot0)
	slot0:killTween()
	slot0:removeEventListeners()

	slot0._moveParam = nil

	gohelper.destroy(slot0.go)
end

function slot0.onDestroy(slot0)
end

return slot0
