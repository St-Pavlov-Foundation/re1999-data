module("modules.logic.pay.rpc.ChargeRpc", package.seeall)

slot0 = class("ChargeRpc", BaseRpc)

function slot0.sendGetChargeInfoRequest(slot0, slot1, slot2)
	return slot0:sendMsg(ChargeModule_pb.GetChargeInfoRequest(), slot1, slot2)
end

function slot0.onReceiveGetChargeInfoReply(slot0, slot1, slot2)
	if slot1 == 0 then
		PayModel.instance:setSandboxInfo(slot2.sandboxEnable, slot2.sandboxBalance)
		PayModel.instance:setChargeInfo(slot2.infos)
		StoreModel.instance:initChargeInfo(slot2.infos)
		PayController.instance:dispatchEvent(PayEvent.PayInfoChanged)
	end
end

function slot0.sendNewOrderRequest(slot0, slot1, slot2)
	ChargeModule_pb.NewOrderRequest().id = slot1

	if slot2 then
		for slot7, slot8 in ipairs(slot2) do
			slot9 = ChargeModule_pb.SelectionInfo()
			slot9.regionId = slot7
			slot9.selectionPos = slot8 - 1

			table.insert(slot3.selectionInfos, slot9)
		end
	end

	slot0:sendMsg(slot3)
end

function slot0.onReceiveNewOrderReply(slot0, slot1, slot2)
	if slot1 == 0 then
		PayModel.instance:setOrderInfo(slot2)
		PayController.instance:dispatchEvent(PayEvent.GetSignSuccess)

		return
	end

	PayController.instance:dispatchEvent(PayEvent.GetSignFailed)
end

function slot0.onReceiveOrderCompletePush(slot0, slot1, slot2)
	if slot1 == 0 then
		slot3 = slot2.id

		StoreModel.instance:chargeOrderComplete(slot3)
		slot0:_tryUpdateMonthCard(slot2)

		if StoreConfig.instance:getChargeGoodsConfig(slot3) then
			uv0.instance:sendGetChargeInfoRequest()
		end

		PayController.instance:dispatchEvent(PayEvent.PayFinished)
	else
		PayController.instance:dispatchEvent(PayEvent.PayFailed)
	end
end

function slot0.sendGetMonthCardInfoRequest(slot0, slot1, slot2)
	return slot0:sendMsg(ChargeModule_pb.GetMonthCardInfoRequest(), slot1, slot2)
end

function slot0.onReceiveGetMonthCardInfoReply(slot0, slot1, slot2)
	if slot1 ~= 0 then
		return
	end

	StoreModel.instance:updateMonthCardInfo(slot2.infos[1])
	StoreController.instance:dispatchEvent(StoreEvent.MonthCardInfoChanged)
end

function slot0.sendGetMonthCardBonusRequest(slot0, slot1)
	slot2 = ChargeModule_pb.GetMonthCardBonusRequest()
	slot2.id = slot1

	return slot0:sendMsg(slot2)
end

function slot0.onReceiveGetMonthCardBonusReply(slot0, slot1, slot2)
end

function slot0.sendSandboxChargeRequset(slot0, slot1)
	slot2 = ChargeModule_pb.SandboxChargeRequset()
	slot2.gameOrderId = slot1

	return slot0:sendMsg(slot2)
end

function slot0.onReceiveSandboxChargeReply(slot0, slot1, slot2)
	if slot1 ~= 0 then
		return
	end

	PayModel.instance:updateSandboxBalance(slot2.sandboxBalance)
end

function slot0.sendReadChargeNewRequest(slot0, slot1)
	slot2 = ChargeModule_pb.ReadChargeNewRequest()

	for slot6, slot7 in ipairs(slot1) do
		table.insert(slot2.goodsIds, slot7)
	end

	return slot0:sendMsg(slot2)
end

function slot0.onReceiveReadChargeNewReply(slot0, slot1, slot2)
	if slot1 == 0 then
		-- Nothing
	end
end

function slot0._tryUpdateMonthCard(slot0, slot1)
	if not (StoreConfig.instance:getMonthCardConfig(slot1.id) and true or false) and StoreConfig.instance:getChargeGoodsConfig(slot2) then
		slot4 = slot2 == StoreEnum.SeasonCardGoodsId
	end

	if not slot4 then
		return
	end

	SignInController.instance:sendGetSignInInfoRequestIfUnlock()
end

slot0.instance = slot0.New()

return slot0
