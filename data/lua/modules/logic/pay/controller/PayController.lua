module("modules.logic.pay.controller.PayController", package.seeall)

local var_0_0 = class("PayController", BaseController)

function var_0_0.onInit(arg_1_0)
	return
end

function var_0_0.reInit(arg_2_0)
	return
end

function var_0_0.onInitFinish(arg_3_0)
	return
end

function var_0_0.addConstEvents(arg_4_0)
	SDKMgr.instance:setPayCallBack(arg_4_0._onPayCallback, arg_4_0)
	arg_4_0:registerCallback(PayEvent.GetSignSuccess, arg_4_0._onGetSignSuccess, arg_4_0)
	arg_4_0:registerCallback(PayEvent.GetSignFailed, arg_4_0._onGetSignFailed, arg_4_0)
	arg_4_0:registerCallback(PayEvent.PayFinished, arg_4_0._onPayFinished, arg_4_0)
	arg_4_0:registerCallback(PayEvent.PayFailed, arg_4_0._onPayFailed, arg_4_0)
end

function var_0_0.startPay(arg_5_0, arg_5_1, arg_5_2)
	if not GameChannelConfig.isXfsdk() and PayModel.instance:getSandboxEnable() ~= true then
		return
	end

	UIBlockMgr.instance:startBlock("charging")
	ChargeRpc.instance:sendNewOrderRequest(arg_5_1, arg_5_2)
end

function var_0_0._onGetSignSuccess(arg_6_0)
	UIBlockMgr.instance:endBlock("charging")

	if GameFacade.isKOLTest() then
		return
	end

	local var_6_0 = StatModel.instance:getPayInfo()

	if PayModel.instance:getSandboxEnable() then
		ViewMgr.instance:openView(ViewName.SDKSandboxPayView, {
			payInfo = PayModel.instance:getGamePayInfo()
		})
	else
		SDKMgr.instance:payGoods(var_6_0)
	end
end

function var_0_0._onGetSignFailed(arg_7_0)
	UIBlockMgr.instance:endBlock("charging")
	PayModel.instance:clearOrderInfo()
end

function var_0_0._onPayFinished(arg_8_0)
	PayModel.instance:clearOrderInfo()
end

function var_0_0._onPayFailed(arg_9_0)
	PayModel.instance:clearOrderInfo()
end

function var_0_0._onPayCallback(arg_10_0, arg_10_1, arg_10_2)
	if arg_10_1 == PayEnum.PayResultCode.PayFinish then
		-- block empty
	elseif arg_10_1 == PayEnum.PayResultCode.PayCancel then
		-- block empty
	elseif arg_10_1 == PayEnum.PayResultCode.PayInfoFail then
		-- block empty
	elseif arg_10_1 == PayEnum.PayResultCode.PayError then
		-- block empty
	elseif arg_10_1 == PayEnum.PayResultCode.PayOrderCancel then
		-- block empty
	elseif arg_10_1 == PayEnum.PayResultCode.PayChannelFail then
		-- block empty
	else
		logNormal("支付异常 : " .. arg_10_1 .. ":" .. arg_10_2)
		GameFacade.showToast(ToastEnum.PayError, arg_10_2, arg_10_1)
		var_0_0.instance:dispatchEvent(PayEvent.PayFailed)
	end
end

function var_0_0.onReceiveMaterialChangePush(arg_11_0, arg_11_1)
	if not arg_11_1 or #arg_11_1 == 0 then
		return
	end

	local var_11_0 = PayModel.instance:getQuickUseInfo()

	if not var_11_0 then
		return
	end

	local var_11_1 = {}

	for iter_11_0, iter_11_1 in ipairs(arg_11_1) do
		local var_11_2 = iter_11_1.materilType
		local var_11_3 = iter_11_1.materilId
		local var_11_4 = iter_11_1.quantity or 0

		var_11_1[var_11_2] = var_11_1[var_11_2] or {}

		local var_11_5 = var_11_1[var_11_2][var_11_3] or 0

		var_11_1[var_11_2][var_11_3] = var_11_5 + var_11_4
	end

	local var_11_6 = {}

	for iter_11_2, iter_11_3 in ipairs(var_11_0.itemList) do
		local var_11_7 = iter_11_3[1]
		local var_11_8 = iter_11_3[2]
		local var_11_9 = iter_11_3[3]

		if var_11_1[var_11_7] and var_11_1[var_11_7][var_11_8] then
			var_11_6[var_11_7] = var_11_6[var_11_7] or {}

			local var_11_10 = var_11_6[var_11_7][var_11_8]

			if not var_11_10 then
				local var_11_11 = var_11_1[var_11_7][var_11_8]

				var_11_10 = math.min(ItemModel.instance:getItemQuantity(var_11_7, var_11_8) or 0, var_11_11)
				var_11_6[var_11_7][var_11_8] = var_11_10
			end

			if var_11_10 - var_11_9 < 0 then
				var_11_9 = var_11_10
				var_11_10 = 0
			end

			if var_11_9 > 0 then
				local var_11_12 = var_11_9 == 1
				local var_11_13 = var_11_12 and MessageBoxIdDefine.ChargeStoreQuickUseTip or MessageBoxIdDefine.ChargeStoreQuickUseTipWithNum
				local var_11_14 = ItemModel.instance:getItemConfig(var_11_7, var_11_8)
				local var_11_15 = {
					var_11_14.name,
					not var_11_12 and var_11_9 or nil
				}
				local var_11_16 = {
					messageBoxId = var_11_13,
					msg = MessageBoxConfig.instance:getMessage(var_11_13),
					msgBoxType = MsgBoxEnum.BoxType.Yes_No,
					yesCallback = function()
						local var_12_0 = {
							{
								materialId = var_11_8,
								quantity = var_11_9
							}
						}

						CharacterModel.instance:setGainHeroViewShowState(false)
						CharacterModel.instance:setGainHeroViewNewShowState(false)
						ItemRpc.instance:sendUseItemRequest(var_12_0, 0)
					end,
					extra = var_11_15
				}

				PopupController.instance:addPopupView(PopupEnum.PriorityType.ChargeStoreQuickUseTip, ViewName.MessageBoxView, var_11_16)
			end

			var_11_6[var_11_7][var_11_8] = var_11_10
		end
	end
end

var_0_0.instance = var_0_0.New()

return var_0_0
