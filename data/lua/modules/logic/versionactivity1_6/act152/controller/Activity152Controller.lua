module("modules.logic.versionactivity1_6.act152.controller.Activity152Controller", package.seeall)

local var_0_0 = class("Activity152Controller", BaseController)

function var_0_0.onInit(arg_1_0)
	return
end

function var_0_0.reInit(arg_2_0)
	if arg_2_0._popupFlow then
		arg_2_0._popupFlow:destroy()

		arg_2_0._popupFlow = nil
	end

	TaskDispatcher.cancelTask(arg_2_0._checkGiftUnlock, arg_2_0)
end

function var_0_0.addConstEvents(arg_3_0)
	ActivityController.instance:registerCallback(ActivityEvent.RefreshActivityState, arg_3_0._checkActivityInfo, arg_3_0)
	MainController.instance:registerCallback(MainEvent.OnMainPopupFlowFinish, arg_3_0._startCheckGiftUnlock, arg_3_0)
	GameStateMgr.instance:registerCallback(GameStateEvent.onApplicationPause, arg_3_0._onApplicationPause, arg_3_0)
end

function var_0_0._checkActivityInfo(arg_4_0)
	if ActivityModel.instance:isActOnLine(ActivityEnum.Activity.NewYearEve) then
		Activity152Rpc.instance:sendGet152InfoRequest(ActivityEnum.Activity.NewYearEve)
	end
end

function var_0_0._onApplicationPause(arg_5_0, arg_5_1)
	if arg_5_1 then
		arg_5_0:_startCheckGiftUnlock()
	end
end

function var_0_0._startCheckGiftUnlock(arg_6_0)
	if not ActivityModel.instance:isActOnLine(ActivityEnum.Activity.NewYearEve) then
		return
	end

	if arg_6_0._popupFlow then
		arg_6_0._popupFlow:destroy()

		arg_6_0._popupFlow = nil
	end

	local var_6_0 = Activity152Model.instance:getPresentUnaccepted()

	TaskDispatcher.cancelTask(arg_6_0._checkGiftUnlock, arg_6_0)

	local var_6_1 = #var_6_0 > 0 and 0.5 or Activity152Model.instance:getNextUnlockLimitTime() + 0.5

	if var_6_1 > 0 then
		TaskDispatcher.runDelay(arg_6_0._checkGiftUnlock, arg_6_0, var_6_1)
	end
end

function var_0_0._checkGiftUnlock(arg_7_0)
	arg_7_0._popupFlow = FlowSequence.New()

	arg_7_0._popupFlow:addWork(Activity152PatFaceWork.New())
	arg_7_0._popupFlow:registerDoneListener(arg_7_0._stopShowSequence, arg_7_0)
	arg_7_0._popupFlow:start()
end

function var_0_0._stopShowSequence(arg_8_0)
	if arg_8_0._popupFlow then
		arg_8_0._popupFlow:destroy()

		arg_8_0._popupFlow = nil
	end

	arg_8_0:_startCheckGiftUnlock()
end

function var_0_0.openNewYearGiftView(arg_9_0, arg_9_1)
	ViewMgr.instance:openView(ViewName.NewYearEveGiftView, arg_9_1)
end

var_0_0.instance = var_0_0.New()

return var_0_0
