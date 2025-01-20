module("modules.logic.pay.controller.PayController", package.seeall)

slot0 = class("PayController", BaseController)

function slot0.onInit(slot0)
end

function slot0.reInit(slot0)
end

function slot0.onInitFinish(slot0)
end

function slot0.addConstEvents(slot0)
	SDKMgr.instance:setPayCallBack(slot0._onPayCallback, slot0)
	slot0:registerCallback(PayEvent.GetSignSuccess, slot0._onGetSignSuccess, slot0)
	slot0:registerCallback(PayEvent.GetSignFailed, slot0._onGetSignFailed, slot0)
	slot0:registerCallback(PayEvent.PayFinished, slot0._onPayFinished, slot0)
	slot0:registerCallback(PayEvent.PayFailed, slot0._onPayFailed, slot0)
end

function slot0.startPay(slot0, slot1, slot2)
	if not GameChannelConfig.isXfsdk() and PayModel.instance:getSandboxEnable() ~= true then
		return
	end

	UIBlockMgr.instance:startBlock("charging")
	ChargeRpc.instance:sendNewOrderRequest(slot1, slot2)
end

function slot0._onGetSignSuccess(slot0)
	UIBlockMgr.instance:endBlock("charging")

	if GameFacade.isKOLTest() then
		return
	end

	slot1 = StatModel.instance:getPayInfo()

	if PayModel.instance:getSandboxEnable() then
		ViewMgr.instance:openView(ViewName.SDKSandboxPayView, {
			payInfo = PayModel.instance:getGamePayInfo()
		})
	else
		SDKMgr.instance:payGoods(slot1)
	end
end

function slot0._onGetSignFailed(slot0)
	UIBlockMgr.instance:endBlock("charging")
	PayModel.instance:clearOrderInfo()
end

function slot0._onPayFinished(slot0)
	PayModel.instance:clearOrderInfo()
end

function slot0._onPayFailed(slot0)
	PayModel.instance:clearOrderInfo()
end

function slot0._onPayCallback(slot0, slot1, slot2)
	if slot1 == PayEnum.PayResultCode.PayFinish then
		-- Nothing
	elseif slot1 == PayEnum.PayResultCode.PayCancel then
		-- Nothing
	elseif slot1 == PayEnum.PayResultCode.PayInfoFail then
		-- Nothing
	elseif slot1 == PayEnum.PayResultCode.PayError then
		-- Nothing
	elseif slot1 == PayEnum.PayResultCode.PayOrderCancel then
		-- Nothing
	elseif slot1 ~= PayEnum.PayResultCode.PayChannelFail then
		logNormal("支付异常 : " .. slot1 .. ":" .. slot2)
		GameFacade.showToast(ToastEnum.PayError, slot2, slot1)
		uv0.instance:dispatchEvent(PayEvent.PayFailed)
	end
end

function slot0.onReceiveMaterialChangePush(slot0, slot1)
	if not slot1 or #slot1 == 0 then
		return
	end

	if not PayModel.instance:getQuickUseInfo() then
		return
	end

	slot3 = {}

	for slot7, slot8 in ipairs(slot1) do
		slot9 = slot8.materilType
		slot10 = slot8.materilId
		slot3[slot9] = slot3[slot9] or {}
		slot3[slot9][slot10] = (slot3[slot9][slot10] or 0) + (slot8.quantity or 0)
	end

	slot4 = {}

	for slot8, slot9 in ipairs(slot2.itemList) do
		slot11 = slot9[2]
		slot12 = slot9[3]

		if slot3[slot9[1]] and slot3[slot10][slot11] then
			slot4[slot10] = slot4[slot10] or {}

			if not slot4[slot10][slot11] then
				slot4[slot10][slot11] = math.min(ItemModel.instance:getItemQuantity(slot10, slot11) or 0, slot3[slot10][slot11])
			end

			if slot13 - slot12 < 0 then
				slot12 = slot13
				slot13 = 0
			end

			if slot12 > 0 then
				slot15 = slot12 == 1
				slot16 = slot15 and MessageBoxIdDefine.ChargeStoreQuickUseTip or MessageBoxIdDefine.ChargeStoreQuickUseTipWithNum

				PopupController.instance:addPopupView(PopupEnum.PriorityType.ChargeStoreQuickUseTip, ViewName.MessageBoxView, {
					messageBoxId = slot16,
					msg = MessageBoxConfig.instance:getMessage(slot16),
					msgBoxType = MsgBoxEnum.BoxType.Yes_No,
					yesCallback = function ()
						CharacterModel.instance:setGainHeroViewShowState(false)
						CharacterModel.instance:setGainHeroViewNewShowState(false)
						ItemRpc.instance:sendUseItemRequest({
							{
								materialId = uv0,
								quantity = uv1
							}
						}, 0)
					end,
					extra = {
						ItemModel.instance:getItemConfig(slot10, slot11).name,
						not slot15 and slot12 or nil
					}
				})
			end

			slot4[slot10][slot11] = slot13
		end
	end
end

slot0.instance = slot0.New()

return slot0
