module("modules.logic.versionactivity1_9.fairyland.view.comp.FairyLandWordComp", package.seeall)

local var_0_0 = class("FairyLandWordComp", LuaCompBase)

var_0_0.WordInterval = 3.5
var_0_0.WordTxtPosYOffset = 5
var_0_0.WordTxtPosXOffset = 2
var_0_0.WordTxtInterval = 0.1
var_0_0.WordTxtOpen = 0.5
var_0_0.WordTxtIdle = 1.1
var_0_0.WordTxtClose = 0.5
var_0_0.WordLine2Delay = 1

function var_0_0.ctor(arg_1_0, arg_1_1)
	arg_1_0._co = arg_1_1.co
	arg_1_0._res1 = arg_1_1.res1
	arg_1_0._res2 = arg_1_1.res2
end

function var_0_0.init(arg_2_0, arg_2_1)
	arg_2_0.go = arg_2_1

	arg_2_0:createTxt()
end

function var_0_0.createTxt(arg_3_0)
	local var_3_0 = var_0_0.WordTxtOpen + var_0_0.WordTxtIdle + var_0_0.WordTxtClose

	arg_3_0._allAnimWork = {}

	local var_3_1 = arg_3_0._co.question
	local var_3_2 = string.format("——%s", arg_3_0._co.answer)
	local var_3_3 = LuaUtil.getUCharArr(var_3_1) or {}
	local var_3_4 = 0
	local var_3_5 = 1

	for iter_3_0 = 1, #var_3_3 do
		local var_3_6, var_3_7 = arg_3_0:getRes(arg_3_0.go, arg_3_0._res1)

		var_3_7.text = var_3_3[iter_3_0]

		transformhelper.setLocalPosXY(var_3_6.transform, var_3_4, var_3_5 % 2 == 1 and -var_0_0.WordTxtPosYOffset or var_0_0.WordTxtPosYOffset)

		var_3_4 = var_3_4 + var_3_7.preferredWidth + var_0_0.WordTxtPosXOffset

		table.insert(arg_3_0._allAnimWork, {
			playAnim = "open",
			anim = var_3_6,
			time = (var_3_5 - 1) * var_0_0.WordTxtInterval
		})

		var_3_5 = var_3_5 + 1
	end

	local var_3_8 = LuaUtil.getUCharArr(var_3_2) or {}

	for iter_3_1 = 1, #var_3_8 do
		local var_3_9, var_3_10 = arg_3_0:getRes(arg_3_0.go, arg_3_0._res2)

		var_3_10.text = var_3_8[iter_3_1]

		transformhelper.setLocalPosXY(var_3_9.transform, var_3_4, var_3_5 % 2 == 1 and -var_0_0.WordTxtPosYOffset or var_0_0.WordTxtPosYOffset)

		var_3_4 = var_3_4 + var_3_10.preferredWidth + var_0_0.WordTxtPosXOffset

		table.insert(arg_3_0._allAnimWork, {
			playAnim = "open",
			anim = var_3_9,
			time = (var_3_5 - 1) * var_0_0.WordTxtInterval
		})

		var_3_5 = var_3_5 + 1
	end

	local var_3_11 = var_3_0 + var_0_0.WordTxtInterval * (#var_3_3 - 1)
	local var_3_12 = 0

	if #var_3_8 > 0 then
		var_3_12 = var_3_0 + var_0_0.WordTxtInterval * (#var_3_8 - 1)
	end

	local var_3_13 = math.max(var_3_11, var_3_12)

	table.sort(arg_3_0._allAnimWork, var_0_0.sortAnim)
	recthelper.setAnchor(arg_3_0.go.transform, -var_3_4 + 40, 0)
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
	elseif var_4_0.playAnim == "open" then
		var_4_0.anim.enabled = true
	else
		var_4_0.anim:Play(var_4_0.playAnim, 0, 0)
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
	local var_6_0 = gohelper.clone(arg_6_2, arg_6_1)
	local var_6_1 = gohelper.findChildTextMesh(var_6_0, "txt")
	local var_6_2 = var_6_0:GetComponent(var_0_1)

	gohelper.setActive(var_6_0, true)
	var_6_2:Play("open", 0, 0)
	var_6_2:Update(0)

	var_6_2.enabled = false

	return var_6_2, var_6_1
end

function var_0_0.onDestroy(arg_7_0)
	TaskDispatcher.cancelTask(arg_7_0.nextStep, arg_7_0)
end

return var_0_0
