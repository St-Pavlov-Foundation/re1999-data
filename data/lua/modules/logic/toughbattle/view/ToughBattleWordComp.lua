module("modules.logic.toughbattle.view.ToughBattleWordComp", package.seeall)

local var_0_0 = class("ToughBattleWordComp", LuaCompBase)

function var_0_0.ctor(arg_1_0, arg_1_1)
	arg_1_0._co = arg_1_1.co
	arg_1_0._res = arg_1_1.res
end

function var_0_0.init(arg_2_0, arg_2_1)
	arg_2_0.go = arg_2_1
	arg_2_0._sign = gohelper.findChild(arg_2_1, "sign")
	arg_2_0._line1 = gohelper.findChild(arg_2_1, "line1")
	arg_2_0._line2 = gohelper.findChild(arg_2_1, "line2")

	arg_2_0:createTxt()
end

function var_0_0.createTxt(arg_3_0)
	local var_3_0 = ToughBattleEnum.WordTxtOpen + ToughBattleEnum.WordTxtIdle + ToughBattleEnum.WordTxtClose

	arg_3_0._allAnimWork = {}

	local var_3_1, var_3_2 = arg_3_0:getRes(arg_3_0._sign, true)

	var_3_2:LoadImage(ResUrl.getSignature(arg_3_0._co.sign))

	local var_3_3 = string.split(arg_3_0._co.desc, "\n")
	local var_3_4 = LuaUtil.getUCharArr(var_3_3[1]) or {}
	local var_3_5 = 0

	for iter_3_0 = 1, #var_3_4 do
		local var_3_6, var_3_7 = arg_3_0:getRes(arg_3_0._line1, false)

		var_3_7.text = var_3_4[iter_3_0]

		transformhelper.setLocalPosXY(var_3_6.transform, var_3_5, iter_3_0 % 2 == 1 and -ToughBattleEnum.WordTxtPosYOffset or ToughBattleEnum.WordTxtPosYOffset)

		var_3_5 = var_3_5 + var_3_7.preferredWidth + ToughBattleEnum.WordTxtPosXOffset

		table.insert(arg_3_0._allAnimWork, {
			playAnim = "open",
			anim = var_3_6,
			time = (iter_3_0 - 1) * ToughBattleEnum.WordTxtInterval
		})
		table.insert(arg_3_0._allAnimWork, {
			playAnim = "close",
			anim = var_3_6,
			time = (iter_3_0 - 1) * ToughBattleEnum.WordTxtInterval + var_3_0 - ToughBattleEnum.WordTxtClose
		})
	end

	local var_3_8 = 0
	local var_3_9 = LuaUtil.getUCharArr(var_3_3[2]) or {}

	for iter_3_1 = 1, #var_3_9 do
		local var_3_10, var_3_11 = arg_3_0:getRes(arg_3_0._line2, false)

		var_3_11.text = var_3_9[iter_3_1]

		transformhelper.setLocalPosXY(var_3_10.transform, var_3_8, iter_3_1 % 2 == 1 and -ToughBattleEnum.WordTxtPosYOffset or ToughBattleEnum.WordTxtPosYOffset)

		var_3_8 = var_3_8 + var_3_11.preferredWidth + ToughBattleEnum.WordTxtPosXOffset

		table.insert(arg_3_0._allAnimWork, {
			playAnim = "open",
			anim = var_3_10,
			time = (iter_3_1 - 1) * ToughBattleEnum.WordTxtInterval + ToughBattleEnum.WordLine2Delay
		})
		table.insert(arg_3_0._allAnimWork, {
			playAnim = "close",
			anim = var_3_10,
			time = (iter_3_1 - 1) * ToughBattleEnum.WordTxtInterval + ToughBattleEnum.WordLine2Delay + var_3_0 - ToughBattleEnum.WordTxtClose
		})
	end

	table.insert(arg_3_0._allAnimWork, {
		playAnim = "open",
		time = 0,
		anim = var_3_1
	})

	local var_3_12 = var_3_0 + ToughBattleEnum.WordTxtInterval * (#var_3_4 - 1)
	local var_3_13 = 0

	if #var_3_9 > 0 then
		var_3_13 = var_3_0 + ToughBattleEnum.WordTxtInterval * (#var_3_9 - 1)
	end

	local var_3_14 = math.max(var_3_12, var_3_13)

	table.insert(arg_3_0._allAnimWork, {
		playAnim = "close",
		anim = var_3_1,
		time = var_3_14 - ToughBattleEnum.WordTxtClose
	})
	table.insert(arg_3_0._allAnimWork, {
		destroy = true,
		time = var_3_14
	})
	table.sort(arg_3_0._allAnimWork, var_0_0.sortAnim)
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
