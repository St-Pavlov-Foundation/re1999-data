module("modules.logic.versionactivity2_8.molideer.view.game.MoLiDeErResultTargetItem", package.seeall)

local var_0_0 = class("MoLiDeErResultTargetItem", LuaCompBase)

function var_0_0.init(arg_1_0, arg_1_1)
	arg_1_0.viewGO = arg_1_1
	arg_1_0._txttaskdesc = gohelper.findChildText(arg_1_0.viewGO, "#txt_taskdesc")
	arg_1_0._gounfinish = gohelper.findChild(arg_1_0.viewGO, "result/#go_unfinish")
	arg_1_0._gofinish = gohelper.findChild(arg_1_0.viewGO, "result/#go_finish")

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0._editableInitView(arg_2_0)
	return
end

function var_0_0.refreshUI(arg_3_0, arg_3_1, arg_3_2, arg_3_3, arg_3_4)
	local var_3_0 = string.splitToNumber(arg_3_2, "#")
	local var_3_1 = var_3_0[1]

	if var_3_1 == MoLiDeErEnum.TargetType.RoundFinishAll or var_3_1 == MoLiDeErEnum.TargetType.RoundFinishAny then
		local var_3_2 = MoLiDeErHelper.getRealRound(var_3_0[2], arg_3_4)

		arg_3_1 = GameUtil.getSubPlaceholderLuaLang(arg_3_1, {
			var_3_2
		})
	end

	local var_3_3 = arg_3_3 and MoLiDeErEnum.ResultTargetColor.Success or MoLiDeErEnum.ResultTargetColor.Fail

	arg_3_1 = string.format("<color=%s>%s</color>", var_3_3, arg_3_1)
	arg_3_0._txttaskdesc.text = arg_3_1

	gohelper.setActive(arg_3_0._gofinish, arg_3_3)
	gohelper.setActive(arg_3_0._gounfinish, not arg_3_3)
end

function var_0_0.setActive(arg_4_0, arg_4_1)
	gohelper.setActive(arg_4_0.viewGO, arg_4_1)
end

function var_0_0.onDestroy(arg_5_0)
	return
end

return var_0_0
