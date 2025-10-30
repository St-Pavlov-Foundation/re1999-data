﻿-- chunkname: @modules/logic/pay/controller/PayController.lua

module("modules.logic.pay.controller.PayController", package.seeall)

local PayController = class("PayController", BaseController)

function PayController:onInit()
	return
end

function PayController:reInit()
	return
end

function PayController:onInitFinish()
	return
end

function PayController:addConstEvents()
	SDKMgr.instance:setPayCallBack(self._onPayCallback, self)
	self:registerCallback(PayEvent.GetSignSuccess, self._onGetSignSuccess, self)
	self:registerCallback(PayEvent.GetSignFailed, self._onGetSignFailed, self)
	self:registerCallback(PayEvent.PayFinished, self._onPayFinished, self)
	self:registerCallback(PayEvent.PayFailed, self._onPayFailed, self)
end

function PayController:startPay(goodsId, selectInfos, isDict)
	if not GameChannelConfig.isXfsdk() and PayModel.instance:getSandboxEnable() ~= true then
		return
	end

	UIBlockMgr.instance:startBlock("charging")

	if isDict then
		ChargeRpc.instance:sendDictNewOrderRequest(goodsId, selectInfos)
	else
		ChargeRpc.instance:sendNewOrderRequest(goodsId, selectInfos)
	end
end

function PayController:_onGetSignSuccess()
	UIBlockMgr.instance:endBlock("charging")

	if GameFacade.isKOLTest() then
		return
	end

	local payInfo = StatModel.instance:getPayInfo()

	if PayModel.instance:getSandboxEnable() then
		ViewMgr.instance:openView(ViewName.SDKSandboxPayView, {
			payInfo = PayModel.instance:getGamePayInfo()
		})
	else
		SDKMgr.instance:payGoods(payInfo)
	end
end

function PayController:_onGetSignFailed()
	UIBlockMgr.instance:endBlock("charging")
	PayModel.instance:clearOrderInfo()
end

function PayController:_onPayFinished()
	PayModel.instance:clearOrderInfo()
end

function PayController:_onPayFailed()
	PayModel.instance:clearOrderInfo()
end

function PayController:_onPayCallback(code, msg)
	if code == PayEnum.PayResultCode.PayFinish then
		-- block empty
	elseif code == PayEnum.PayResultCode.PayCancel then
		-- block empty
	elseif code == PayEnum.PayResultCode.PayInfoFail then
		-- block empty
	elseif code == PayEnum.PayResultCode.PayError then
		-- block empty
	elseif code == PayEnum.PayResultCode.PayOrderCancel then
		-- block empty
	elseif code == PayEnum.PayResultCode.PayChannelFail then
		-- block empty
	else
		logNormal("支付异常 : " .. code .. ":" .. msg)
		GameFacade.showToast(ToastEnum.PayError, msg, code)
		PayController.instance:dispatchEvent(PayEvent.PayFailed)
	end
end

function PayController:onReceiveMaterialChangePush(materialDataMOList)
	if not materialDataMOList or #materialDataMOList == 0 then
		return
	end

	local info = PayModel.instance:getQuickUseInfo()

	if not info then
		return
	end

	local itemId2GotCountDict = {}

	for i, mo in ipairs(materialDataMOList) do
		local materilType = mo.materilType
		local materilId = mo.materilId
		local quantity = mo.quantity or 0

		itemId2GotCountDict[materilType] = itemId2GotCountDict[materilType] or {}

		local cur = itemId2GotCountDict[materilType][materilId] or 0

		itemId2GotCountDict[materilType][materilId] = cur + quantity
	end

	local hasNumDict = {}

	for i, v in ipairs(info.itemList) do
		local itemType = v[1]
		local itemId = v[2]
		local useCount = v[3]

		if itemId2GotCountDict[itemType] and itemId2GotCountDict[itemType][itemId] then
			hasNumDict[itemType] = hasNumDict[itemType] or {}

			local has = hasNumDict[itemType][itemId]

			if not has then
				local maxUseCount = itemId2GotCountDict[itemType][itemId]

				has = math.min(ItemModel.instance:getItemQuantity(itemType, itemId) or 0, maxUseCount)
				hasNumDict[itemType][itemId] = has
			end

			local newHas = has - useCount

			if newHas < 0 then
				useCount = has
				has = 0
			end

			if useCount > 0 then
				local isOnlyOne = useCount == 1
				local messageBoxId = isOnlyOne and MessageBoxIdDefine.ChargeStoreQuickUseTip or MessageBoxIdDefine.ChargeStoreQuickUseTipWithNum
				local itemCo = ItemModel.instance:getItemConfig(itemType, itemId)
				local extra = {
					itemCo.name,
					not isOnlyOne and useCount or nil
				}
				local viewParam = {
					messageBoxId = messageBoxId,
					msg = MessageBoxConfig.instance:getMessage(messageBoxId),
					msgBoxType = MsgBoxEnum.BoxType.Yes_No,
					yesCallback = function()
						local list = {
							{
								materialId = itemId,
								quantity = useCount
							}
						}

						CharacterModel.instance:setGainHeroViewShowState(false)
						CharacterModel.instance:setGainHeroViewNewShowState(false)
						ItemRpc.instance:sendUseItemRequest(list, 0)
					end,
					extra = extra
				}

				PopupController.instance:addPopupView(PopupEnum.PriorityType.ChargeStoreQuickUseTip, ViewName.MessageBoxView, viewParam)
			end

			hasNumDict[itemType][itemId] = has
		end
	end
end

PayController.instance = PayController.New()

return PayController
