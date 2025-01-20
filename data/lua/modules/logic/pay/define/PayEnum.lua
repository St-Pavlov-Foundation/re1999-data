module("modules.logic.pay.define.PayEnum", package.seeall)

slot0 = _M
slot0.PayResultCode = {
	PayCancel = 901,
	PayOrderCancel = 904,
	PayError = 903,
	PayInfoFail = 902,
	PayFinish = 200,
	PayChannelFail = 905
}

return slot0
