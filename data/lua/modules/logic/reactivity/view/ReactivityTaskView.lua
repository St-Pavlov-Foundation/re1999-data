module("modules.logic.reactivity.view.ReactivityTaskView", package.seeall)

local var_0_0 = class("ReactivityTaskView", BaseView)
local var_0_1 = 0.8

function var_0_0.onInitView(arg_1_0)
	arg_1_0.txtTime = gohelper.findChildTextMesh(arg_1_0.viewGO, "Left/LimitTime/image_LimitTimeBG/#txt_LimitTime")
	arg_1_0._btnactivitystore = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "Left/Prop/#btn_shop")
	arg_1_0._txtstorenum = gohelper.findChildTextMesh(arg_1_0.viewGO, "Left/Prop/txt_PropName/#txt_PropNum")

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	if arg_2_0._btnactivitystore then
		arg_2_0:addClickCb(arg_2_0._btnactivitystore, arg_2_0.btnActivityStoreOnClick, arg_2_0)
	end
end

function var_0_0.removeEvents(arg_3_0)
	return
end

function var_0_0._editableInitView(arg_4_0)
	arg_4_0:addEventCb(TaskController.instance, TaskEvent.SuccessGetBonus, arg_4_0.refreshTask, arg_4_0)
	arg_4_0:addEventCb(TaskController.instance, TaskEvent.OnFinishTask, arg_4_0.refreshTask, arg_4_0)
	arg_4_0:addEventCb(TaskController.instance, TaskEvent.UpdateTaskList, arg_4_0.refreshTask, arg_4_0)
	arg_4_0:addEventCb(CurrencyController.instance, CurrencyEvent.CurrencyChange, arg_4_0.refreshActivityCurrency, arg_4_0)
end

function var_0_0.btnActivityStoreOnClick(arg_5_0)
	ReactivityController.instance:openReactivityStoreView(arg_5_0.actId)
end

function var_0_0.onOpen(arg_6_0)
	arg_6_0.actId = arg_6_0.viewParam.actId

	TaskDispatcher.runRepeat(arg_6_0.refreshRemainTime, arg_6_0, TimeUtil.OneMinuteSecond)
	arg_6_0:refreshRemainTime()
	arg_6_0:refreshTask()
	arg_6_0:refreshActivityCurrency()
	UIBlockMgr.instance:startBlock(UIBlockKey.WaitItemAnimeDone)
	TaskDispatcher.runDelay(arg_6_0._delayEndBlock, arg_6_0, var_0_1)
	AudioMgr.instance:trigger(AudioEnum.UI.Act1_6DungeonEnterTaskView)
end

function var_0_0._delayEndBlock(arg_7_0)
	UIBlockMgr.instance:endBlock(UIBlockKey.WaitItemAnimeDone)
end

function var_0_0.refreshActivityCurrency(arg_8_0)
	local var_8_0 = ReactivityModel.instance:getActivityCurrencyId(arg_8_0.actId)
	local var_8_1 = CurrencyModel.instance:getCurrency(var_8_0)
	local var_8_2 = var_8_1 and var_8_1.quantity or 0

	if arg_8_0._txtstorenum then
		arg_8_0._txtstorenum.text = GameUtil.numberDisplay(var_8_2)
	end
end

function var_0_0.refreshRemainTime(arg_9_0)
	local var_9_0 = ActivityModel.instance:getActMO(arg_9_0.actId):getRealEndTimeStamp() - ServerTime.now()

	if var_9_0 > 0 then
		local var_9_1 = TimeUtil.SecondToActivityTimeFormat(var_9_0)

		arg_9_0.txtTime.text = var_9_1
	else
		arg_9_0.txtTime.text = luaLang("ended")
	end
end

function var_0_0.refreshTask(arg_10_0)
	ReactivityTaskModel.instance:refreshList(arg_10_0.actId)
end

function var_0_0.onClose(arg_11_0)
	TaskDispatcher.cancelTask(arg_11_0.refreshRemainTime, arg_11_0)
	TaskDispatcher.cancelTask(arg_11_0._delayEndBlock, arg_11_0)
	arg_11_0:_delayEndBlock()
end

function var_0_0.onDestroyView(arg_12_0)
	return
end

return var_0_0
