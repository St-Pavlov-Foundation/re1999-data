module("modules.logic.pay.model.PayModel", package.seeall)

local var_0_0 = LuaUtil.class("PayModel", PayModelBase, PayModel_OverseasImpl, PayModel_NativesImpl)

function var_0_0.ctor(arg_1_0)
	return
end

var_0_0.instance = var_0_0.New()

return var_0_0
