module("modules.logic.versionactivity1_4.act136.view.Activity136View", package.seeall)

local var_0_0 = class("Activity136View", BaseView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._btnclose = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#btn_close")
	arg_1_0._txtremainTime = gohelper.findChildText(arg_1_0.viewGO, "timebg/#txt_remainTime")
	arg_1_0._goUninvite = gohelper.findChild(arg_1_0.viewGO, "#go_inviteContent/#go_uninvite")
	arg_1_0._btnInvite = gohelper.findChildButton(arg_1_0.viewGO, "#go_inviteContent/#go_uninvite/#btn_invite")
	arg_1_0._goInvited = gohelper.findChild(arg_1_0.viewGO, "#go_inviteContent/#go_invited")

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0._btnclose:AddClickListener(arg_2_0._btncloseOnClick, arg_2_0)
	arg_2_0._btnInvite:AddClickListener(arg_2_0._btnInviteOnClick, arg_2_0)
	Activity136Controller.instance:registerCallback(Activity136Event.ActivityDataUpdate, arg_2_0.refresh, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	arg_3_0._btnclose:RemoveClickListener()
	arg_3_0._btnInvite:RemoveClickListener()
	Activity136Controller.instance:unregisterCallback(Activity136Event.ActivityDataUpdate, arg_3_0.refresh, arg_3_0)
end

function var_0_0._editableInitView(arg_4_0)
	return
end

function var_0_0._btncloseOnClick(arg_5_0)
	arg_5_0:closeThis()
end

function var_0_0._btnInviteOnClick(arg_6_0)
	Activity136Controller.instance:openActivity136ChoiceView()
end

function var_0_0.onOpen(arg_7_0)
	arg_7_0:refresh()
	TaskDispatcher.cancelTask(arg_7_0.refreshRemainTime, arg_7_0)
	TaskDispatcher.runRepeat(arg_7_0.refreshRemainTime, arg_7_0, TimeUtil.OneMinuteSecond)
end

function var_0_0.refresh(arg_8_0)
	arg_8_0:refreshStatus()
	arg_8_0:refreshRemainTime()
end

function var_0_0.refreshStatus(arg_9_0)
	local var_9_0 = Activity136Model.instance:hasReceivedCharacter()

	gohelper.setActive(arg_9_0._goInvited, var_9_0)
	gohelper.setActive(arg_9_0._goUninvite, not var_9_0)
end

function var_0_0.refreshRemainTime(arg_10_0)
	local var_10_0 = Activity136Model.instance:getCurActivity136Id()
	local var_10_1, var_10_2 = ActivityModel.instance:getActMO(var_10_0):getRemainTimeStr3()

	arg_10_0._txtremainTime.text = string.format(luaLang("remain"), var_10_1)

	if var_10_2 then
		TaskDispatcher.cancelTask(arg_10_0.refreshRemainTime, arg_10_0)
	end
end

function var_0_0.onClose(arg_11_0)
	if arg_11_0.viewParam and arg_11_0.viewParam.callback then
		arg_11_0.viewParam.callback(arg_11_0.viewParam.callbackObj)
	end

	TaskDispatcher.cancelTask(arg_11_0.refreshRemainTime, arg_11_0)
end

return var_0_0
