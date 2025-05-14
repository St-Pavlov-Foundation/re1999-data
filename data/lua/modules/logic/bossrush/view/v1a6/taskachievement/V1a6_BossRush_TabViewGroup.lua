module("modules.logic.bossrush.view.v1a6.taskachievement.V1a6_BossRush_TabViewGroup", package.seeall)

local var_0_0 = class("V1a6_BossRush_TabViewGroup", TabViewGroup)

function var_0_0._setVisible(arg_1_0, arg_1_1, arg_1_2)
	local var_1_0 = arg_1_0._tabCanvasGroup[arg_1_1]

	if not var_1_0 then
		local var_1_1 = arg_1_0._tabViews[arg_1_1].viewGO

		var_1_0 = gohelper.onceAddComponent(var_1_1, typeof(UnityEngine.CanvasGroup))
		arg_1_0._tabCanvasGroup[arg_1_1] = var_1_0
	end

	var_1_0.interactable = arg_1_2
	var_1_0.blocksRaycasts = arg_1_2
end

return var_0_0
