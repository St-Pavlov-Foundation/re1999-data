module("modules.logic.sdk.controller.SDKController", package.seeall)

local var_0_0 = class("SDKController", BaseController)

function var_0_0.onInit(arg_1_0)
	return
end

function var_0_0.reInit(arg_2_0)
	return
end

function var_0_0.addConstEvents(arg_3_0)
	return
end

function var_0_0.openSDKExitView(arg_4_0, arg_4_1, arg_4_2)
	local var_4_0 = {
		loginCallback = arg_4_1,
		exitCallback = arg_4_2
	}

	ViewMgr.instance:openView(ViewName.SDKExitGameView, var_4_0)
end

var_0_0.instance = var_0_0.New()

return var_0_0
