module("modules.logic.pay.model.PayModel", package.seeall)

slot0 = class("PayModel", BaseModel)

function slot0.onInit(slot0)
	slot0._chargeInfos = {}
	slot0._orderInfo = {}
	slot0._sandboxEnable = false
	slot0._sandboxBalance = 0
end

function slot0.reInit(slot0)
	slot0._chargeInfos = {}
	slot0._orderInfo = {}
	slot0._sandboxEnable = false
	slot0._sandboxBalance = 0
end

function slot0.setSandboxInfo(slot0, slot1, slot2)
	slot0._sandboxEnable = slot1
	slot0._sandboxBalance = slot2
end

function slot0.updateSandboxBalance(slot0, slot1)
	slot0._sandboxBalance = slot1
end

function slot0.setChargeInfo(slot0, slot1)
	for slot5, slot6 in ipairs(slot1) do
		slot0._chargeInfos[slot6.id] = slot6
	end
end

function slot0.setOrderInfo(slot0, slot1)
	slot0._orderInfo = {
		id = slot1.id
	}

	if slot1.passBackParam then
		slot0._orderInfo.passBackParam = slot1.passBackParam
	end

	slot0._orderInfo.notifyUrl = slot1.notifyUrl and slot1.notifyUrl or ""
	slot0._orderInfo.gameOrderId = slot1.gameOrderId
	slot0._orderInfo.timestamp = slot1.timestamp
	slot0._orderInfo.sign = slot1.sign
	slot0._orderInfo.serverId = slot1.serverId
end

function slot0.clearOrderInfo(slot0)
	slot0._orderInfo = {}
end

function slot0.getSandboxEnable(slot0)
	return slot0._sandboxEnable
end

function slot0.getSandboxBalance(slot0)
	return slot0._sandboxBalance
end

function slot0.getOrderInfo(slot0)
	return slot0._orderInfo
end

function slot0.getGamePayInfo(slot0)
	if not slot0._orderInfo.id then
		return ""
	end

	slot1 = StoreConfig.instance:getChargeGoodsConfig(slot0._orderInfo.id)
	slot3 = {
		gameRoleInfo = slot0:getGameRoleInfo(true)
	}
	slot3.gameRoleInfo.roleEstablishTime = tonumber(PlayerModel.instance:getPlayinfo().registerTime)
	slot3.amount = math.ceil(100 * slot1.price)
	slot3.goodsId = slot0._orderInfo.id
	slot3.goodsName = slot1.name
	slot3.goodsDesc = slot1.desc
	slot3.gameOrderId = slot0._orderInfo.gameOrderId
	slot3.passBackParam = slot0._orderInfo.passBackParam and slot0._orderInfo.passBackParam or ""
	slot3.notifyUrl = slot0._orderInfo.notifyUrl
	slot3.timestamp = slot0._orderInfo.timestamp
	slot3.sign = slot0._orderInfo.sign
	slot3.productId = BootNativeUtil.isIOS() and StoreConfig.instance:getStoreChargeConfig(slot0._orderInfo.id, BootNativeUtil.getPackageName()).appStoreProductID or ""

	return slot3
end

function slot0.getGameRoleInfo(slot0, slot1)
	slot2 = PlayerModel.instance:getPlayinfo()
	slot3 = CurrencyModel.instance:getFreeDiamond()
	slot4 = CurrencyModel.instance:getDiamond()
	slot5 = {
		roleId = tostring(slot2.userId),
		roleName = tostring(slot2.name),
		currentLevel = tonumber(slot2.level),
		vipLevel = 0
	}
	slot6 = tostring(LoginModel.instance.serverId)

	if slot1 and slot0._orderInfo.serverId > 0 then
		slot6 = slot0._orderInfo.serverId
	end

	slot5.serverId = slot6
	slot5.serverName = tostring(LoginModel.instance.serverName)
	slot5.roleCTime = tonumber(slot2.registerTime)
	slot5.loginTime = tonumber(slot2.lastLoginTime)
	slot5.logoutTime = tonumber(slot2.lastLogoutTime)
	slot5.accountRegisterTime = tonumber(slot2.registerTime)
	slot5.giveCurrencyNum = slot3
	slot5.paidCurrencyNum = slot4
	slot5.currencyNum = slot3 + slot4
	slot5.currentProgress = DungeonConfig.instance:getEpisodeCO(slot2.lastEpisodeId) and tostring(slot7.name .. slot7.id) or ""
	slot5.roleEstablishTime = tonumber(slot2.registerTime)
	slot5.guildLevel = tonumber(slot2.level)
	slot5.roleType = StatModel.instance:getRoleType()
	slot5.gameEnv = VersionValidator.instance:isInReviewing() and 1 or 0

	return slot5
end

function slot0.getQuickUseInfo(slot0)
	if not slot0._orderInfo then
		return
	end

	if not StoreConfig.instance:getChargeGoodsConfig(slot0._orderInfo.id) then
		return
	end

	if string.nilorempty(slot2.quickUseItemList) then
		return
	end

	if not GameUtil.splitString2(slot3, true, "|", "#") or #slot4 == 0 then
		return
	end

	return {
		goodsId = slot1,
		chargeGoodsConfig = slot2,
		itemList = slot4
	}
end

slot0.instance = slot0.New()

return slot0
