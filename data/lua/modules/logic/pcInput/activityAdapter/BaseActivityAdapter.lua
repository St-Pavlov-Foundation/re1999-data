module("modules.logic.pcInput.activityAdapter.BaseActivityAdapter", package.seeall)

local var_0_0 = class("BaseActivityAdapter")

function var_0_0.ctor(arg_1_0)
	arg_1_0.keytoFunction = {}
	arg_1_0.activitid = nil
	arg_1_0._registeredKey = {}
end

function var_0_0.registerFunction(arg_2_0)
	local var_2_0 = PCInputModel.instance:getActivityKeys(arg_2_0.activitid)

	if not var_2_0 then
		return
	end

	arg_2_0._registeredKey = var_2_0

	for iter_2_0, iter_2_1 in pairs(var_2_0) do
		PCInputController.instance:registerKey(iter_2_1[4], ZProj.PCInputManager.PCInputEvent.KeyUp)
	end
end

function var_0_0.unRegisterFunction(arg_3_0)
	for iter_3_0, iter_3_1 in pairs(arg_3_0._registeredKey) do
		PCInputController.instance:unregisterKey(iter_3_1[4], ZProj.PCInputManager.PCInputEvent.KeyUp)
	end

	arg_3_0._registeredKey = {}
end

function var_0_0.OnkeyUp(arg_4_0, arg_4_1)
	local var_4_0 = PCInputModel.instance:getkeyidBykeyName(arg_4_0.activitid, arg_4_1)

	if not var_4_0 then
		return
	end

	local var_4_1 = arg_4_0.keytoFunction[var_4_0]

	if var_4_1 then
		var_4_1()
	end
end

function var_0_0.OnkeyDown(arg_5_0, arg_5_1)
	local var_5_0 = PCInputModel.instance:getkeyidBykeyName(arg_5_0.activitid, arg_5_1)

	if not var_5_0 then
		logError("keyName not exist in keyBinding")

		return
	end

	local var_5_1 = arg_5_0.keytoFunction[var_5_0]

	if var_5_1 then
		var_5_1()
	end
end

function var_0_0.destroy(arg_6_0)
	arg_6_0:unRegisterFunction()
end

return var_0_0
