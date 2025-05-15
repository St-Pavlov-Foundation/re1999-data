module("modules.logic.versionactivity2_5.act182.controller.Activity182Controller", package.seeall)

local var_0_0 = class("Activity182Controller", BaseController)

function var_0_0.addConstEvents(arg_1_0)
	arg_1_0:addEventCb(ActivityController.instance, ActivityEvent.RefreshActivityState, arg_1_0.onRefreshActivity, arg_1_0)
end

function var_0_0.getCrazyActId(arg_2_0)
	for iter_2_0, iter_2_1 in pairs(Activity182Enum.CrazyActId) do
		if ActivityModel.instance:isActOnLine(iter_2_1) then
			return iter_2_1
		end
	end

	logError("目前没有正在开放的狂暴模式活动")
end

function var_0_0.onRefreshActivity(arg_3_0, arg_3_1)
	if arg_3_1 then
		local var_3_0 = false

		for iter_3_0, iter_3_1 in pairs(Activity182Enum.CrazyActId) do
			if arg_3_1 == iter_3_1 then
				var_3_0 = true

				break
			end
		end

		if var_3_0 then
			if AutoChessModel.instance.actId and arg_3_1 == AutoChessModel.instance.actId then
				AutoChessController.instance:exitGame()
			else
				local var_3_1 = Activity182Model.instance:getCurActId()

				Activity182Rpc.instance:sendGetAct182InfoRequest(var_3_1)
			end
		end
	end
end

var_0_0.instance = var_0_0.New()

return var_0_0
