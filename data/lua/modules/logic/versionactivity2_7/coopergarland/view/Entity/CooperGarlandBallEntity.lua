module("modules.logic.versionactivity2_7.coopergarland.view.Entity.CooperGarlandBallEntity", package.seeall)

slot0 = class("CooperGarlandBallEntity", LuaCompBase)

function slot0.ctor(slot0, slot1)
	slot0.mapId = slot1.mapId
end

function slot0.init(slot0, slot1)
	slot0.go = slot1
	slot0.trans = slot1.transform
	slot0.ballRoot = slot0.trans.parent
	slot0._rigidBody = slot0.go:GetComponent(typeof(UnityEngine.Rigidbody))
	slot0._goFireVx = gohelper.findChild(slot0.ballRoot.gameObject, "vx/#go_fire")
	slot0._goBornVx = gohelper.findChild(slot0.ballRoot.gameObject, "vx/#go_born")
	slot0._goDieVx = gohelper.findChild(slot0.ballRoot.gameObject, "vx/#go_die")

	slot0:onInit()
end

function slot0.onInit(slot0)
	slot0._rigidBody.drag = CooperGarlandConfig.instance:getAct192Const(CooperGarlandEnum.ConstId.BallDrag, true)
	slot0._rigidBody.angularDrag = CooperGarlandConfig.instance:getAct192Const(CooperGarlandEnum.ConstId.BallAngularDrag, true)

	slot0:setVisible()
	AudioMgr.instance:setRTPCValue(AudioEnum2_7.CooperGarlandBallRTPC, 0)
	slot0:playLoopAudio(AudioEnum2_7.CooperGarland.play_ui_yuzhou_ball_loop)
end

function slot0.addEventListeners(slot0)
	slot0:addEventCb(CooperGarlandController.instance, CooperGarlandEvent.OnBallKeyChange, slot0._onBallKeyChange, slot0)
end

function slot0.removeEventListeners(slot0)
	slot0:removeEventCb(CooperGarlandController.instance, CooperGarlandEvent.OnBallKeyChange, slot0._onBallKeyChange, slot0)
end

function slot0._onBallKeyChange(slot0)
	if not slot0._isVisible then
		return
	end

	slot0:refreshKeyStatus()
end

function slot0.refreshKeyStatus(slot0)
	if CooperGarlandGameModel.instance:getBallHasKey() then
		AudioMgr.instance:trigger(AudioEnum2_7.CooperGarland.play_ui_yuzhou_ball_fire)
	end

	gohelper.setActive(slot0._goFireVx, slot1)
	slot0:playLoopAudio(slot1 and AudioEnum2_7.CooperGarland.play_ui_yuzhou_ball_fire_loop or AudioEnum2_7.CooperGarland.play_ui_yuzhou_ball_loop)
end

function slot0.setVisible(slot0, slot1, slot2)
	slot3 = {
		z = 0,
		x = 0,
		y = 0
	}

	if slot1 then
		slot3 = slot0.ballRoot.parent:InverseTransformPoint(slot1)
		slot0._showWorldPos = slot1
	end

	slot3.z = CooperGarlandGameEntityMgr.instance:getBallPosZ()

	transformhelper.setLocalPos(slot0.ballRoot, slot3.x, slot3.y, slot3.z)
	transformhelper.setLocalPos(slot0.trans, 0, 0, 0)

	slot0._isVisible = slot1 and true or false

	gohelper.setActive(slot0.ballRoot, slot0._isVisible)
	slot0:checkFreeze()

	if slot0._isVisible then
		slot0:playBornVx(slot2)
		slot0:refreshKeyStatus()
	end
end

function slot0.checkFreeze(slot0, slot1)
	if slot0._isFreeze == (CooperGarlandGameModel.instance:getIsStopGame() or not slot0._isVisible) then
		return
	end

	slot0._isFreeze = slot3
	slot4 = Vector3.zero
	slot5 = Vector3.zero

	if slot0._isFreeze then
		slot6 = slot0._rigidBody.velocity
		slot7 = slot0._rigidBody.angularVelocity
		slot0._recordSpeed = {
			vX = slot6.x,
			vY = slot6.y,
			vZ = slot6.z,
			angularVX = slot7.x,
			angularVY = slot7.y,
			angularVZ = slot7.z
		}
	else
		if slot1 and slot0._recordSpeed then
			slot4 = Vector3(slot0._recordSpeed.vX, slot0._recordSpeed.vY, slot0._recordSpeed.vZ)
			slot5 = Vector3(slot0._recordSpeed.angularVX, slot0._recordSpeed.angularVY, slot0._recordSpeed.angularVZ)
		end

		slot0._recordSpeed = nil
	end

	slot0._rigidBody.useGravity = not slot0._isFreeze
	slot0._rigidBody.isKinematic = slot0._isFreeze
	slot0._rigidBody.velocity = slot4
	slot0._rigidBody.angularVelocity = slot5
end

function slot0.reset(slot0)
	slot0._recordSpeed = nil

	slot0:refreshKeyStatus()
	slot0:setVisible(slot0._showWorldPos, true)
end

function slot0.isCanTriggerComp(slot0)
	return slot0._isVisible and not slot0._isFreeze
end

function slot0.getVelocity(slot0)
	return slot0._rigidBody and slot0._rigidBody.velocity or Vector3.zero
end

function slot0.playBornVx(slot0, slot1)
	gohelper.setActive(slot0._goBornVx, false)
	gohelper.setActive(slot0._goBornVx, true)

	if slot1 then
		AudioMgr.instance:trigger(AudioEnum2_7.CooperGarland.play_ui_yuzhou_ball_reset)
	end
end

function slot0.playDieVx(slot0)
	gohelper.setActive(slot0._goDieVx, false)
	gohelper.setActive(slot0._goDieVx, true)
end

function slot0.playLoopAudio(slot0, slot1)
	if slot0._loopAudioId == slot1 then
		return
	end

	slot0:stopLoopAudio()

	slot0._loopAudioId = slot1

	AudioMgr.instance:trigger(slot0._loopAudioId)
end

function slot0.stopLoopAudio(slot0)
	AudioMgr.instance:trigger(AudioEnum2_7.CooperGarland.stop_ui_yuzhou_ball_loop)
	AudioMgr.instance:trigger(AudioEnum2_7.CooperGarland.stop_ui_yuzhou_ball_fire_loop)

	slot0._loopAudioId = nil
end

function slot0.destroy(slot0)
	slot0._recordSpeed = nil

	slot0:stopLoopAudio()
	gohelper.destroy(slot0.ballRoot.gameObject)
end

function slot0.onDestroy(slot0)
end

return slot0
