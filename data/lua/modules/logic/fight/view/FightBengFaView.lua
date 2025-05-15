module("modules.logic.fight.view.FightBengFaView", package.seeall)

local var_0_0 = class("FightBengFaView", FightBaseView)

function var_0_0.onConstructor(arg_1_0, arg_1_1)
	arg_1_0.bloodView = arg_1_1
	arg_1_0.bloodViewGO = arg_1_1.viewGO
	arg_1_0.bloodViewRoot = arg_1_1.root
	arg_1_0.bengFaRoot = gohelper.create2d(arg_1_0.bloodViewGO, "bengFaRoot")

	arg_1_0:setRootAnchor(arg_1_0.bengFaRoot)

	arg_1_0.bengFaChangeRoot = gohelper.create2d(arg_1_0.bloodViewGO, "bengFaChangeRoot")

	arg_1_0:setRootAnchor(arg_1_0.bengFaChangeRoot)
	arg_1_0:com_registFightEvent(FightEvent.Blood2BengFa, arg_1_0.onBlood2BengFa)
	arg_1_0:com_registFightEvent(FightEvent.BloodPool_MaxValueChange, arg_1_0.onMaxValueChange)
	arg_1_0:com_registFightEvent(FightEvent.BloodPool_ValueChange, arg_1_0.onValueChange)
end

function var_0_0.setRootAnchor(arg_2_0, arg_2_1)
	local var_2_0 = arg_2_1.transform

	var_2_0.anchorMin = Vector2.zero
	var_2_0.anchorMax = Vector2.one
	var_2_0.offsetMin = Vector2.zero
	var_2_0.offsetMax = Vector2.zero
end

function var_0_0.onValueChange(arg_3_0, arg_3_1)
	if arg_3_1 ~= FightEnum.TeamType.MySide then
		return
	end

	arg_3_0:refreshBlood()
end

function var_0_0.onMaxValueChange(arg_4_0, arg_4_1)
	if arg_4_1 ~= FightEnum.TeamType.MySide then
		return
	end

	arg_4_0:refreshBlood()
end

function var_0_0.onBlood2BengFa(arg_5_0, arg_5_1)
	local var_5_0 = arg_5_1.effectNum1 == 1

	arg_5_0.curVisible = var_5_0
	arg_5_0.actEffectData = arg_5_1

	if arg_5_0.lastVisible ~= var_5_0 then
		gohelper.setActive(arg_5_0.bengFaRoot, var_5_0)
		gohelper.setActive(arg_5_0.bloodViewRoot, not var_5_0)

		if not arg_5_0.changeLoad then
			arg_5_0.changeLoad = true

			arg_5_0:com_loadAsset("ui/viewres/fight/fight_switch_bloodview.prefab", arg_5_0.onChangeEffectLoaded)
		elseif arg_5_0.changeEffect then
			gohelper.setActive(arg_5_0.normal2NuoDiKa, arg_5_0.curVisible)
			gohelper.setActive(arg_5_0.nuoDiKa2Normal, not arg_5_0.curVisible)
		end
	end

	if var_5_0 then
		if arg_5_0.viewGO then
			arg_5_0:refreshUI()
		elseif not arg_5_0.load then
			arg_5_0.load = true

			arg_5_0:com_loadAsset("ui/viewres/fight/fight_nuodika_bloodview.prefab", arg_5_0.onLoaded)
		end

		AudioMgr.instance:trigger(20280403)
	end

	arg_5_0.lastVisible = var_5_0
end

function var_0_0.onChangeEffectLoaded(arg_6_0, arg_6_1, arg_6_2)
	if not arg_6_1 then
		return
	end

	local var_6_0 = arg_6_2:GetResource()

	arg_6_0.changeEffect = gohelper.clone(var_6_0, arg_6_0.bengFaChangeRoot)
	arg_6_0.nuoDiKa2Normal = gohelper.findChild(arg_6_0.changeEffect, "normal")
	arg_6_0.normal2NuoDiKa = gohelper.findChild(arg_6_0.changeEffect, "ndk")

	gohelper.setActive(arg_6_0.normal2NuoDiKa, arg_6_0.curVisible)
	gohelper.setActive(arg_6_0.nuoDiKa2Normal, not arg_6_0.curVisible)
end

function var_0_0.onLoaded(arg_7_0, arg_7_1, arg_7_2)
	if not arg_7_1 then
		return
	end

	local var_7_0 = arg_7_2:GetResource()

	arg_7_0.viewGO = gohelper.clone(var_7_0, arg_7_0.bengFaRoot)

	local var_7_1 = arg_7_0.viewGO

	arg_7_0.bengFaText = gohelper.findChildText(var_7_1, "root/heart/unbroken/#txt_num")
	arg_7_0.bottomNumTxt = gohelper.findChildText(var_7_1, "root/num/bottom/#txt_num")
	arg_7_0.leftMaxTxt = gohelper.findChildText(arg_7_0.viewGO, "root/num/left/#txt_num1")
	arg_7_0.leftCurTxt = gohelper.findChildText(arg_7_0.viewGO, "root/num/left/#txt_num1/#txt_num2")
	arg_7_0.leftEffMaxTxt = gohelper.findChildText(arg_7_0.viewGO, "root/num/left/#txt_num1eff")
	arg_7_0.leftEffCurTxt = gohelper.findChildText(arg_7_0.viewGO, "root/num/left/#txt_num1eff/#txt_num2")

	gohelper.setActive(gohelper.findChild(var_7_1, "root/num/bottom/txt_preparation"), false)

	arg_7_0.imageHeart = gohelper.findChildImage(var_7_1, "root/heart/unbroken/#image_heart")
	arg_7_0.imageHeartPre = gohelper.findChildImage(var_7_1, "root/heart/unbroken/#image_heart_broken")
	arg_7_0.imageHeartMat = arg_7_0.imageHeart.material
	arg_7_0.imageHeartPreMat = arg_7_0.imageHeartPre.material
	arg_7_0.heightPropertyId = UnityEngine.Shader.PropertyToID("_LerpOffset")
	arg_7_0.leftPart = gohelper.findChild(var_7_1, "root/num/left")

	gohelper.setActive(arg_7_0.leftPart, false)
	arg_7_0:refreshUI()
end

function var_0_0.refreshUI(arg_8_0)
	local var_8_0 = arg_8_0.actEffectData.effectNum

	arg_8_0.bengFaText.text = var_8_0 == 0 and "" or var_8_0

	arg_8_0:refreshBlood()
end

function var_0_0.refreshBlood(arg_9_0)
	if not arg_9_0.bottomNumTxt then
		return
	end

	local var_9_0 = FightDataHelper.getBloodPool(FightEnum.TeamType.MySide)
	local var_9_1 = var_9_0.value
	local var_9_2 = var_9_0.max
	local var_9_3 = string.format("%s/%s", var_9_1, var_9_2)

	arg_9_0.bottomNumTxt.text = var_9_3

	local var_9_4 = var_9_1 / var_9_2

	arg_9_0.imageHeartMat:SetFloat(arg_9_0.heightPropertyId, var_9_4)
	arg_9_0.imageHeartPreMat:SetFloat(arg_9_0.heightPropertyId, var_9_4)
	gohelper.setActive(arg_9_0.leftPart, true)

	arg_9_0.leftCurTxt.text = var_9_1
	arg_9_0.leftMaxTxt.text = var_9_2
	arg_9_0.leftEffCurTxt.text = var_9_1
	arg_9_0.leftEffMaxTxt.text = var_9_2

	arg_9_0:com_registSingleTimer(arg_9_0.hideLeftPart, 1)
end

function var_0_0.hideLeftPart(arg_10_0)
	gohelper.setActive(arg_10_0.leftPart, false)
end

function var_0_0.onDestroyView(arg_11_0)
	return
end

return var_0_0
