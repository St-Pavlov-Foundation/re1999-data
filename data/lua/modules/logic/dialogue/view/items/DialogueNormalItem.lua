module("modules.logic.dialogue.view.items.DialogueNormalItem", package.seeall)

local var_0_0 = class("DialogueNormalItem", DialogueItem)

function var_0_0.initView(arg_1_0)
	arg_1_0.simageAvatar = gohelper.findChildSingleImage(arg_1_0.go, "rolebg/#image_avatar")
	arg_1_0.txtName = gohelper.findChildText(arg_1_0.go, "#txt_name")
	arg_1_0.txtContent = gohelper.findChildText(arg_1_0.go, "content_bg/#txt_content")
	arg_1_0.goLoading = gohelper.findChild(arg_1_0.go, "content_bg/#go_loading")
	arg_1_0.contentBgRectTr = gohelper.findChildComponent(arg_1_0.go, "content_bg", gohelper.Type_RectTransform)
	arg_1_0.txtRectTr = arg_1_0.txtContent:GetComponent(gohelper.Type_RectTransform)
end

function var_0_0.refresh(arg_2_0)
	arg_2_0.simageAvatar:LoadImage(ResUrl.getHeadIconSmall(arg_2_0.stepCo.avatar))

	arg_2_0.txtName.text = arg_2_0.stepCo.name
	arg_2_0.txtContent.text = arg_2_0.stepCo.content

	AudioMgr.instance:trigger(AudioEnum.Dialogue.play_ui_wulu_duihua)
end

function var_0_0.calculateHeight(arg_3_0)
	local var_3_0 = arg_3_0.txtContent.preferredWidth

	if var_3_0 <= DialogueEnum.MessageTxtMaxWidth then
		local var_3_1 = DialogueEnum.MessageTxtOneLineHeight + DialogueEnum.MessageBgOffsetHeight

		recthelper.setSize(arg_3_0.contentBgRectTr, var_3_0 + DialogueEnum.MessageBgOffsetWidth, var_3_1)
		recthelper.setSize(arg_3_0.txtRectTr, var_3_0, DialogueEnum.MessageTxtOneLineHeight)

		arg_3_0.height = Mathf.Max(DialogueEnum.MinHeight[DialogueEnum.Type.LeftMessage], var_3_1 + DialogueEnum.MessageNameHeight)

		return
	end

	local var_3_2 = DialogueEnum.MessageTxtMaxWidth
	local var_3_3 = arg_3_0.txtContent.preferredHeight
	local var_3_4 = var_3_3 + DialogueEnum.MessageBgOffsetHeight

	recthelper.setSize(arg_3_0.contentBgRectTr, DialogueEnum.MessageTxtMaxWidth + DialogueEnum.MessageBgOffsetWidth, var_3_4)
	recthelper.setSize(arg_3_0.txtRectTr, var_3_2, var_3_3)

	arg_3_0.height = Mathf.Max(DialogueEnum.MinHeight[DialogueEnum.Type.LeftMessage], var_3_4 + DialogueEnum.MessageNameHeight)
end

function var_0_0.logHeight(arg_4_0)
	logError(string.format("【%s】", arg_4_0.stepCo.id) .. " : " .. arg_4_0.txtContent.preferredHeight)
	logError(string.format("【%s】", arg_4_0.stepCo.id) .. " : " .. arg_4_0.txtContent.preferredWidth)
	logError(string.format("【%s】", arg_4_0.stepCo.id) .. " : " .. arg_4_0.txtContent.renderedWidth)
	logError(string.format("【%s】", arg_4_0.stepCo.id) .. " : " .. arg_4_0.txtContent.renderedHeight)
end

function var_0_0.onDestroy(arg_5_0)
	arg_5_0.simageAvatar:UnLoadImage()
end

return var_0_0
