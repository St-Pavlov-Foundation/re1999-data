module("modules.logic.stat.rpc.StatRpc", package.seeall)

local var_0_0 = class("StatRpc", BaseRpc)

function var_0_0.sendClientStatBaseInfoRequest(arg_1_0, arg_1_1)
	local var_1_0 = StatModule_pb.ClientStatBaseInfoRequest()

	var_1_0.info = arg_1_1

	return arg_1_0:sendMsg(var_1_0)
end

function var_0_0.onReceiveClientStatBaseInfoReply(arg_2_0, arg_2_1, arg_2_2)
	return
end

function var_0_0.onReceiveStatInfoPush(arg_3_0, arg_3_1, arg_3_2)
	if arg_3_1 == 0 then
		StatModel.instance:setRoleType(arg_3_2.userTag)

		if string.nilorempty(arg_3_2.userTag) == false then
			SDKMgr.instance:updateRole(StatModel.instance:generateRoleInfo())
		end
	end
end

var_0_0.instance = var_0_0.New()

return var_0_0
