module("modules.logic.versionactivity2_8.dungeonboss.view.VersionActivity2_8BossStoryEyeView", package.seeall)

local var_0_0 = class("VersionActivity2_8BossStoryEyeView", BaseView)

function var_0_0.onInitView(arg_1_0)
	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	return
end

function var_0_0.removeEvents(arg_3_0)
	return
end

function var_0_0._editableInitView(arg_4_0)
	return
end

function var_0_0.onUpdateParam(arg_5_0)
	return
end

function var_0_0.onOpen(arg_6_0)
	arg_6_0:addEventCb(HeroGroupController.instance, HeroGroupEvent.OnHeroGroupExit, arg_6_0._onHeroGroupExit, arg_6_0)
	arg_6_0:addEventCb(FightController.instance, FightEvent.ModifyDelayTime, arg_6_0._onModifyDelayTime, arg_6_0)
	NavigateMgr.instance:addEscape(arg_6_0.viewName, arg_6_0._onEscHandler, arg_6_0)
end

function var_0_0._onEscHandler(arg_7_0)
	return
end

function var_0_0._onModifyDelayTime(arg_8_0, arg_8_1)
	if arg_8_0._animLength then
		arg_8_1.time = arg_8_0._animLength
	end
end

function var_0_0._onHeroGroupExit(arg_9_0)
	local var_9_0 = arg_9_0.viewGO:GetComponent("Animator")

	if var_9_0 then
		var_9_0:Play("end", 0, 0)
	end

	arg_9_0:_playCameraAnim()
	TaskDispatcher.runDelay(arg_9_0._animDone, arg_9_0, arg_9_0._animLength)
end

function var_0_0._playCameraAnim(arg_10_0)
	arg_10_0._cameraAnimator = CameraMgr.instance:getCameraRootAnimator()
	arg_10_0._rawController = arg_10_0._cameraAnimator.runtimeAnimatorController
	arg_10_0._rawEnabled = arg_10_0._cameraAnimator.enabled
	arg_10_0._cameraAnimator.enabled = true

	local var_10_0 = arg_10_0.viewContainer:getRes(arg_10_0.viewContainer._viewSetting.otherRes[1])

	arg_10_0._cameraAnimator.runtimeAnimatorController = var_10_0

	local var_10_1 = "bossstory_camera_eye"

	arg_10_0._cameraAnimator:Play(var_10_1, 0, 0)

	arg_10_0._animLength = 2.2

	AudioMgr.instance:trigger(AudioEnum2_8.BossStory.play_ui_fuleyuan_boss_eye_open)
end

function var_0_0._animDone(arg_11_0)
	arg_11_0:closeThis()
end

function var_0_0.onClose(arg_12_0)
	if arg_12_0._cameraAnimator then
		arg_12_0._cameraAnimator.enabled = arg_12_0._rawEnabled
		arg_12_0._cameraAnimator.runtimeAnimatorController = arg_12_0._rawController
	end

	TaskDispatcher.cancelTask(arg_12_0._animDone, arg_12_0)
end

function var_0_0.onDestroyView(arg_13_0)
	return
end

return var_0_0
