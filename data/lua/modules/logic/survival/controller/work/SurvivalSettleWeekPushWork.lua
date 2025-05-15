module("modules.logic.survival.controller.work.SurvivalSettleWeekPushWork", package.seeall)

local var_0_0 = class("SurvivalSettleWeekPushWork", BaseWork)

function var_0_0.ctor(arg_1_0, arg_1_1)
	arg_1_0._msg = arg_1_1
end

function var_0_0.onStart(arg_2_0, arg_2_1)
	SurvivalModel.instance:setSurvivalSettleInfo(arg_2_0._msg)

	local var_2_0 = SurvivalShelterModel.instance:getWeekInfo()

	if var_2_0 and var_2_0.intrudeBox and var_2_0.intrudeBox.fight then
		var_2_0.intrudeBox.fight:setWin()
	end

	UIBlockHelper.instance:endBlock(SurvivalEnum.SurvivalIntrudeAbandonBlock)

	local var_2_1 = GameSceneMgr.instance:getCurSceneType()
	local var_2_2 = GameSceneMgr.instance:getCurScene()

	if var_2_1 == SceneType.Fight then
		GameSceneMgr.instance:registerCallback(SceneEventName.EnterSceneFinish, arg_2_0._onEnterOneSceneFinish, arg_2_0)
	elseif var_2_1 == SceneType.SurvivalShelter then
		if GameSceneMgr.instance:isLoading() then
			GameSceneMgr.instance:registerCallback(SceneEventName.EnterSceneFinish, arg_2_0._onEnterOneSceneFinish, arg_2_0)
		else
			arg_2_0:_onEnterOneSceneFinish(var_2_1)
		end
	else
		arg_2_0:showSettle(true)
	end
end

function var_0_0._onEnterOneSceneFinish(arg_3_0, arg_3_1)
	if arg_3_1 ~= SceneType.SurvivalShelter then
		arg_3_0:showSettle(false)

		return
	end

	GameUtil.setActiveUIBlock(arg_3_0._msg, true, false)
	TaskDispatcher.runDelay(arg_3_0._tweenToPlayerPos, arg_3_0, 0.5)
end

function var_0_0._tweenToPlayerPos(arg_4_0)
	local var_4_0 = GameSceneMgr.instance:getCurScene()
	local var_4_1 = var_4_0 and var_4_0.unit and var_4_0.unit:getPlayer()

	if not var_4_1 then
		arg_4_0:showSettle(false)

		return
	end

	var_4_1:focusEntity(0.5, arg_4_0.playEntityAnim, arg_4_0)
end

function var_0_0.playEntityAnim(arg_5_0)
	local var_5_0 = GameSceneMgr.instance:getCurScene()
	local var_5_1 = var_5_0 and var_5_0.unit and var_5_0.unit:getPlayer()

	if not var_5_1 then
		arg_5_0:showSettle(false)

		return
	end

	local var_5_2 = SurvivalModel.instance:getSurvivalSettleInfo()

	if var_5_2 and var_5_2.win or false then
		var_5_1:playAnim("jump2")
		TaskDispatcher.runDelay(arg_5_0.onPlayerAnimFinish, arg_5_0, 1)
	else
		var_5_1:playAnim("die")
		TaskDispatcher.runDelay(arg_5_0.onPlayerAnimFinish, arg_5_0, 2)
	end
end

function var_0_0.onPlayerAnimFinish(arg_6_0)
	local var_6_0 = GameSceneMgr.instance:getCurScene()
	local var_6_1 = var_6_0 and var_6_0.unit and var_6_0.unit:getPlayer()

	if var_6_1 then
		local var_6_2 = SurvivalModel.instance:getSurvivalSettleInfo()

		if var_6_2 and var_6_2.win or false then
			var_6_1:playAnim("idle")
		end
	end

	arg_6_0:showSettle(true)
end

function var_0_0.showSettle(arg_7_0, arg_7_1)
	GameUtil.setActiveUIBlock(arg_7_0._msg, false, true)
	SurvivalController.instance:enterSurvivalSettle()
	arg_7_0:onDone(arg_7_1)
end

function var_0_0.clearWork(arg_8_0)
	TaskDispatcher.cancelTask(arg_8_0._tweenToPlayerPos, arg_8_0)
	TaskDispatcher.cancelTask(arg_8_0.onPlayerAnimFinish, arg_8_0)
	GameSceneMgr.instance:unregisterCallback(SceneEventName.EnterSceneFinish, arg_8_0._onEnterOneSceneFinish, arg_8_0)
end

return var_0_0
