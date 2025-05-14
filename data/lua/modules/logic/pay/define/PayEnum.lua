module("modules.logic.pay.define.PayEnum", package.seeall)

local var_0_0 = _M

var_0_0.PayResultCode = {
	PayCancel = 901,
	PayOrderCancel = 904,
	PayError = 903,
	PayInfoFail = 902,
	PayFinish = 200,
	PayChannelFail = 905
}

return var_0_0
