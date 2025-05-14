module("modules.logic.versionactivity2_1.aergusi.view.AergusiDialogSystemMessageItem", package.seeall)

local var_0_0 = class("AergusiDialogSystemMessageItem", AergusiDialogItem)

function var_0_0.initView(arg_1_0)
	arg_1_0._txtSystemMessage = gohelper.findChildText(arg_1_0.go, "#txt_systemmessage")
	arg_1_0._goline = gohelper.findChild(arg_1_0.go, "line")
	arg_1_0._txtSystemMessageGrey = gohelper.findChildText(arg_1_0.go, "#txt_systemmessage_grey")
	arg_1_0._golinegrey = gohelper.findChild(arg_1_0.go, "line_grey")
	arg_1_0.go.name = string.format("systemmessageitem_%s_%s", arg_1_0.stepCo.id, arg_1_0.stepCo.stepId)
end

function var_0_0.refresh(arg_2_0)
	local var_2_0 = AergusiDialogModel.instance:getCurDialogGroup()

	gohelper.setActive(arg_2_0._txtSystemMessage.gameObject, var_2_0 == arg_2_0.stepCo.id)
	gohelper.setActive(arg_2_0._txtSystemMessageGrey.gameObject, var_2_0 ~= arg_2_0.stepCo.id)
	gohelper.setActive(arg_2_0._goline, var_2_0 == arg_2_0.stepCo.id)
	gohelper.setActive(arg_2_0._golinegrey, var_2_0 ~= arg_2_0.stepCo.id)

	if var_2_0 == arg_2_0.stepCo.id then
		arg_2_0._txtSystemMessage.text = arg_2_0.stepCo.content
	else
		arg_2_0._txtSystemMessageGrey.text = arg_2_0.stepCo.content
	end
end

function var_0_0.calculateHeight(arg_3_0)
	arg_3_0.height = AergusiEnum.MinHeight[arg_3_0.type]
end

function var_0_0.onDestroy(arg_4_0)
	return
end

return var_0_0
