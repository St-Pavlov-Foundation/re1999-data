module("modules.logic.fight.entity.comp.skill.FightTLEventCameraDistance", package.seeall)

local var_0_0 = class("FightTLEventCameraDistance", FightTimelineTrackItem)

function var_0_0.onTrackStart(arg_1_0, arg_1_1, arg_1_2, arg_1_3)
	arg_1_0.conditionState = FightHelper.detectTimelinePlayEffectCondition(arg_1_1, arg_1_3[5])

	if not arg_1_0.conditionState then
		return
	end

	arg_1_0.tweenComp = arg_1_0:addComponent(FightTweenComponent)

	local var_1_0 = CameraMgr.instance:getVirtualCameraGO()
	local var_1_1 = GameSceneMgr.instance:getCurScene().camera
	local var_1_2 = arg_1_3[1]
	local var_1_3 = arg_1_3[2]
	local var_1_4 = var_1_3 == "1"
	local var_1_5 = var_1_3 == "2"

	arg_1_0.holdPosAfterTraceEnd = arg_1_3[3] == "1"

	if var_1_4 then
		local var_1_6 = var_1_1:getDefaultCameraOffset()

		arg_1_0.tweenComp:DOLocalMove(var_1_0.transform, var_1_6.x, var_1_6.y, var_1_6.z, arg_1_2)
	elseif var_1_5 then
		FightWorkFocusMonster.setVirtualCameDamping(0, 0, 0)
		var_1_1:setSceneCameraOffset()
		FightWorkFocusMonster.setVirtualCameDamping(1, 1, 1)
	elseif not string.nilorempty(var_1_2) then
		local var_1_7 = string.splitToNumber(var_1_2, ",")

		if var_1_7[1] and var_1_7[2] and var_1_7[3] then
			arg_1_0.tweenComp:DOLocalMove(var_1_0.transform, var_1_7[1], var_1_7[2], var_1_7[3], arg_1_2)
		else
			logError("相机统一距离参数错误（3个数字用逗号分隔）：" .. var_1_2)
		end
	else
		var_1_1:setSceneCameraOffset()
	end

	local var_1_8 = arg_1_3[4]

	if not string.nilorempty(var_1_8) then
		local var_1_9 = CameraMgr.instance:getCameraRootGO()
		local var_1_10 = gohelper.findChild(var_1_9, "main/VirtualCameras/light/direct"):GetComponent(typeof(UnityEngine.Light))

		arg_1_0.light = var_1_10

		local var_1_11 = var_1_10.color
		local var_1_12 = tonumber(var_1_8)
		local var_1_13 = Color.New(var_1_11.r, var_1_11.g, var_1_11.b, var_1_12)

		arg_1_0.tweenComp:DOTweenFloat(var_1_11.a, var_1_12, arg_1_2, arg_1_0.frameCallback, nil, arg_1_0, var_1_13)
	end
end

function var_0_0.frameCallback(arg_2_0, arg_2_1, arg_2_2)
	arg_2_2.a = arg_2_1
	arg_2_0.light.color = arg_2_2
end

function var_0_0.onTrackEnd(arg_3_0)
	return
end

function var_0_0.onDestructor(arg_4_0)
	arg_4_0:revertCameraPos()
end

function var_0_0.revertCameraPos(arg_5_0)
	if not arg_5_0.conditionState then
		return
	end

	if not arg_5_0.holdPosAfterTraceEnd then
		GameSceneMgr.instance:getCurScene().camera:setSceneCameraOffset()
	end
end

return var_0_0
