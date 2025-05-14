module("modules.logic.explore.view.ExploreGuideDialogueView", package.seeall)

local var_0_0 = class("ExploreGuideDialogueView", BaseView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._btnfullscreen = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#btn_fullscreen")
	arg_1_0._gochoicelist = gohelper.findChild(arg_1_0.viewGO, "#go_choicelist")
	arg_1_0._gochoiceitem = gohelper.findChild(arg_1_0.viewGO, "#go_choicelist/#go_choiceitem")
	arg_1_0._txttalkinfo = gohelper.findChildText(arg_1_0.viewGO, "go_normalcontent/txt_contentcn")
	arg_1_0._txttalker = gohelper.findChildText(arg_1_0.viewGO, "#txt_talker")

	gohelper.setActive(arg_1_0._gochoicelist, false)

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0._btnfullscreen:AddClickListener(arg_2_0.onClickFull, arg_2_0)
	GuideController.instance:registerCallback(GuideEvent.OnClickSpace, arg_2_0.onClickFull, arg_2_0)
	GuideController.instance:registerCallback(GuideEvent.OneKeyFinishGuides, arg_2_0.closeThis, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	GuideController.instance:unregisterCallback(GuideEvent.OnClickSpace, arg_3_0.onClickFull, arg_3_0)
	GuideController.instance:unregisterCallback(GuideEvent.OneKeyFinishGuides, arg_3_0.closeThis, arg_3_0)
	arg_3_0._btnfullscreen:RemoveClickListener()
end

function var_0_0.onClickFull(arg_4_0)
	if arg_4_0._hasIconDialogItem:isPlaying() then
		arg_4_0._hasIconDialogItem:conFinished()

		return
	end

	local var_4_0 = arg_4_0.viewParam.closeCallBack
	local var_4_1 = arg_4_0.viewParam.guideKey

	if not arg_4_0.viewParam.noClose then
		arg_4_0:closeThis()
	end

	var_4_0(var_4_1)
end

function var_0_0.onOpen(arg_5_0)
	AudioMgr.instance:trigger(AudioEnum.UI.play_ui_activity_course_open)
	arg_5_0:_refreshView()
end

function var_0_0.onUpdateParam(arg_6_0)
	arg_6_0:_refreshView()
end

function var_0_0._refreshView(arg_7_0)
	local var_7_0 = string.gsub(arg_7_0.viewParam.tipsContent, " ", " ")

	if not arg_7_0._hasIconDialogItem then
		arg_7_0._hasIconDialogItem = MonoHelper.addLuaComOnceToGo(arg_7_0.viewGO, TMPFadeIn)
	end

	arg_7_0._hasIconDialogItem:playNormalText(var_7_0)

	arg_7_0._txttalker.text = arg_7_0.viewParam.tipsTalker
end

return var_0_0
