module("modules.logic.common.view.FixTmpBreakLine", package.seeall)

local var_0_0 = class("FixTmpBreakLine", LuaCompBase)

function var_0_0.initData(arg_1_0, arg_1_1)
	arg_1_0.textMeshPro = arg_1_1.gameObject:GetComponent(typeof(TMPro.TextMeshProUGUI))

	if arg_1_0.textMeshPro then
		arg_1_0.textMeshPro.richText = true
	end
end

function var_0_0.refreshTmpContent(arg_2_0, arg_2_1)
	if not arg_2_1 then
		return
	end

	arg_2_0:initData(arg_2_1)

	local var_2_0 = arg_2_0.textMeshPro.text

	if not arg_2_0:startsWith(var_2_0, "<nobr>") then
		var_2_0 = string.format("<nobr>%s", var_2_0)
	end

	local var_2_1 = string.gsub(var_2_0, " +", function(arg_3_0)
		return "<space=" .. string.len(arg_3_0) * ZProj.GameHelper.GetTmpCharWidth(arg_2_0.textMeshPro, 32) .. ">"
	end)

	arg_2_0.textMeshPro.text = var_2_1

	arg_2_0.textMeshPro:Rebuild(UnityEngine.UI.CanvasUpdate.PreRender)
end

function var_0_0.startsWith(arg_4_0, arg_4_1, arg_4_2)
	return string.sub(arg_4_1, 1, string.len(arg_4_2)) == arg_4_2
end

return var_0_0
