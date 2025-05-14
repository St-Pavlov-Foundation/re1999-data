module("modules.logic.versionactivity2_6.common.VersionActivity2_6JumpHandleFunc", package.seeall)

local var_0_0 = class("VersionActivity2_6JumpHandleFunc")

function var_0_0.jumpTo12601(arg_1_0)
	VersionActivity2_6EnterController.instance:openVersionActivityEnterView()

	return JumpEnum.JumpResult.Success
end

function var_0_0.jumpTo12602(arg_2_0, arg_2_1)
	local var_2_0 = arg_2_1[2]

	VersionActivity2_6EnterController.instance:openVersionActivityEnterView(nil, nil, var_2_0)

	return JumpEnum.JumpResult.Success
end

function var_0_0.jumpTo12605(arg_3_0, arg_3_1)
	local var_3_0 = arg_3_1[2]

	VersionActivity2_6EnterController.instance:openVersionActivityEnterView(nil, nil, var_3_0)

	return JumpEnum.JumpResult.Success
end

function var_0_0.jumpTo12603(arg_4_0, arg_4_1)
	VersionActivity2_6DungeonController.instance:openStoreView()

	return JumpEnum.JumpResult.Success
end

function var_0_0.jumpTo12606(arg_5_0, arg_5_1)
	local var_5_0 = arg_5_1[2]

	VersionActivity2_6EnterController.instance:openVersionActivityEnterView(nil, nil, var_5_0)

	return JumpEnum.JumpResult.Success
end

function var_0_0.jumpTo12618(arg_6_0, arg_6_1)
	local var_6_0 = arg_6_1[2]

	VersionActivity2_6EnterController.instance:openVersionActivityEnterView(nil, nil, var_6_0)

	return JumpEnum.JumpResult.Success
end

return var_0_0
