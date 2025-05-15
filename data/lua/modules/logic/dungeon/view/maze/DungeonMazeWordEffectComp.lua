module("modules.logic.dungeon.view.maze.DungeonMazeWordEffectComp", package.seeall)

local var_0_0 = class("DungeonMazeWordEffectComp", LuaCompBase)

function var_0_0.ctor(arg_1_0, arg_1_1)
	arg_1_0._co = arg_1_1.co
	arg_1_0._res = arg_1_1.res
	arg_1_0._done = arg_1_1.done
end

function var_0_0.init(arg_2_0, arg_2_1)
	arg_2_0.go = arg_2_1
	arg_2_0._line1 = gohelper.findChild(arg_2_1, "item/line1")
	arg_2_0._line2 = gohelper.findChild(arg_2_1, "item/line2")
	arg_2_0._effect = gohelper.findChild(arg_2_1, "item/effect")
	arg_2_0._animEffect = arg_2_0._effect:GetComponent(gohelper.Type_Animator)

	arg_2_0:createTxt()
end

function var_0_0.createTxt(arg_3_0)
	local var_3_0 = Season166Enum.WordTxtOpen + Season166Enum.WordTxtIdle + Season166Enum.WordTxtClose

	arg_3_0._allAnimWork = {}

	local var_3_1 = string.split(arg_3_0._co.desc, "\n")
	local var_3_2 = LuaUtil.getUCharArr(var_3_1[1]) or {}
	local var_3_3 = 0

	for iter_3_0 = 1, #var_3_2 do
		local var_3_4, var_3_5 = arg_3_0:getRes(arg_3_0._line1, false)

		var_3_5.text = var_3_2[iter_3_0]

		transformhelper.setLocalPosXY(var_3_4.transform, var_3_3, iter_3_0 % 2 == 1 and -Season166Enum.WordTxtPosYOffset or Season166Enum.WordTxtPosYOffset)

		var_3_3 = var_3_3 + var_3_5.preferredWidth + Season166Enum.WordTxtPosXOffset

		table.insert(arg_3_0._allAnimWork, {
			playAnim = "open",
			anim = var_3_4,
			time = (iter_3_0 - 1) * Season166Enum.WordTxtInterval
		})
		table.insert(arg_3_0._allAnimWork, {
			playAnim = "close",
			anim = var_3_4,
			time = (iter_3_0 - 1) * Season166Enum.WordTxtInterval + var_3_0 - Season166Enum.WordTxtClose
		})
	end

	local var_3_6 = 0
	local var_3_7 = LuaUtil.getUCharArr(var_3_1[2]) or {}

	for iter_3_1 = 1, #var_3_7 do
		local var_3_8, var_3_9 = arg_3_0:getRes(arg_3_0._line2, false)

		var_3_9.text = var_3_7[iter_3_1]

		transformhelper.setLocalPosXY(var_3_8.transform, var_3_6, iter_3_1 % 2 == 1 and -Season166Enum.WordTxtPosYOffset or Season166Enum.WordTxtPosYOffset)

		var_3_6 = var_3_6 + var_3_9.preferredWidth + Season166Enum.WordTxtPosXOffset

		table.insert(arg_3_0._allAnimWork, {
			playAnim = "open",
			anim = var_3_8,
			time = (iter_3_1 - 1) * Season166Enum.WordTxtInterval + Season166Enum.WordLine2Delay
		})
		table.insert(arg_3_0._allAnimWork, {
			playAnim = "close",
			anim = var_3_8,
			time = (iter_3_1 - 1) * Season166Enum.WordTxtInterval + Season166Enum.WordLine2Delay + var_3_0 - Season166Enum.WordTxtClose
		})
	end

	local var_3_10 = var_3_0 + Season166Enum.WordTxtInterval * (#var_3_2 - 1)
	local var_3_11 = 0

	if #var_3_7 > 0 then
		var_3_11 = var_3_0 + Season166Enum.WordTxtInterval * (#var_3_7 - 1)
	end

	local var_3_12 = math.max(var_3_10, var_3_11)

	table.insert(arg_3_0._allAnimWork, {
		showEndEffect = true,
		time = var_3_12 - Season166Enum.WordTxtClose
	})
	table.insert(arg_3_0._allAnimWork, {
		destroy = false,
		time = var_3_12
	})
	table.sort(arg_3_0._allAnimWork, Season166WordEffectComp.sortAnim)
	arg_3_0:nextStep()
end

function var_0_0.nextStep(arg_4_0)
	TaskDispatcher.cancelTask(arg_4_0.nextStep, arg_4_0)

	local var_4_0 = table.remove(arg_4_0._allAnimWork, 1)

	if not var_4_0 then
		return
	end

	if var_4_0.destroy then
		gohelper.destroy(arg_4_0.go)

		return
	elseif var_4_0.showEndEffect then
		arg_4_0._animEffect:Play(UIAnimationName.Close, 0, 0)
	elseif var_4_0.playAnim == "open" then
		var_4_0.anim.enabled = true
	end

	local var_4_1 = arg_4_0._allAnimWork[1]

	if not var_4_1 then
		return
	end

	TaskDispatcher.runDelay(arg_4_0.nextStep, arg_4_0, var_4_1.time - var_4_0.time)
end

function var_0_0.sortAnim(arg_5_0, arg_5_1)
	return arg_5_0.time < arg_5_1.time
end

local var_0_1 = typeof(UnityEngine.Animator)

function var_0_0.getRes(arg_6_0, arg_6_1, arg_6_2)
	local var_6_0 = gohelper.clone(arg_6_0._res, arg_6_1)
	local var_6_1 = gohelper.findChildSingleImage(var_6_0, "img")
	local var_6_2 = gohelper.findChildTextMesh(var_6_0, "txt")
	local var_6_3 = var_6_0:GetComponent(var_0_1)

	gohelper.setActive(var_6_1, arg_6_2)
	gohelper.setActive(var_6_2, not arg_6_2)
	gohelper.setActive(var_6_0, true)
	var_6_3:Play("open", 0, 0)
	var_6_3:Update(0)

	var_6_3.enabled = false

	return var_6_3, arg_6_2 and var_6_1 or var_6_2
end

function var_0_0.onDestroy(arg_7_0)
	TaskDispatcher.cancelTask(arg_7_0.nextStep, arg_7_0)
end

return var_0_0
