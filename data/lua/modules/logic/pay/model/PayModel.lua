module("modules.logic.pay.model.PayModel", package.seeall)

local var_0_0 = class("PayModel", BaseModel)

function var_0_0.onInit(arg_1_0)
	arg_1_0._chargeInfos = {}
	arg_1_0._orderInfo = {}
	arg_1_0._sandboxEnable = false
	arg_1_0._sandboxBalance = 0
end

function var_0_0.reInit(arg_2_0)
	arg_2_0._chargeInfos = {}
	arg_2_0._orderInfo = {}
	arg_2_0._sandboxEnable = false
	arg_2_0._sandboxBalance = 0
end

function var_0_0.setSandboxInfo(arg_3_0, arg_3_1, arg_3_2)
	arg_3_0._sandboxEnable = arg_3_1
	arg_3_0._sandboxBalance = arg_3_2
end

function var_0_0.updateSandboxBalance(arg_4_0, arg_4_1)
	arg_4_0._sandboxBalance = arg_4_1
end

function var_0_0.setChargeInfo(arg_5_0, arg_5_1)
	for iter_5_0, iter_5_1 in ipairs(arg_5_1) do
		arg_5_0._chargeInfos[iter_5_1.id] = iter_5_1
	end
end

function var_0_0.setOrderInfo(arg_6_0, arg_6_1)
	arg_6_0._orderInfo = {}
	arg_6_0._orderInfo.id = arg_6_1.id

	if arg_6_1.passBackParam then
		arg_6_0._orderInfo.passBackParam = arg_6_1.passBackParam
	end

	arg_6_0._orderInfo.notifyUrl = arg_6_1.notifyUrl and arg_6_1.notifyUrl or ""
	arg_6_0._orderInfo.gameOrderId = arg_6_1.gameOrderId
	arg_6_0._orderInfo.timestamp = arg_6_1.timestamp
	arg_6_0._orderInfo.sign = arg_6_1.sign
	arg_6_0._orderInfo.serverId = arg_6_1.serverId
end

function var_0_0.clearOrderInfo(arg_7_0)
	arg_7_0._orderInfo = {}
end

function var_0_0.getSandboxEnable(arg_8_0)
	return arg_8_0._sandboxEnable
end

function var_0_0.getSandboxBalance(arg_9_0)
	return arg_9_0._sandboxBalance
end

function var_0_0.getOrderInfo(arg_10_0)
	return arg_10_0._orderInfo
end

function var_0_0.getGamePayInfo(arg_11_0)
	if not arg_11_0._orderInfo.id then
		return ""
	end

	local var_11_0 = StoreConfig.instance:getChargeGoodsConfig(arg_11_0._orderInfo.id)
	local var_11_1 = PlayerModel.instance:getPlayinfo()
	local var_11_2 = {
		gameRoleInfo = arg_11_0:getGameRoleInfo(true)
	}

	var_11_2.gameRoleInfo.roleEstablishTime = tonumber(var_11_1.registerTime)
	var_11_2.amount = math.ceil(100 * var_11_0.price)
	var_11_2.goodsId = arg_11_0._orderInfo.id
	var_11_2.goodsName = var_11_0.name
	var_11_2.goodsDesc = var_11_0.desc
	var_11_2.gameOrderId = arg_11_0._orderInfo.gameOrderId
	var_11_2.passBackParam = arg_11_0._orderInfo.passBackParam and arg_11_0._orderInfo.passBackParam or ""
	var_11_2.notifyUrl = arg_11_0._orderInfo.notifyUrl
	var_11_2.timestamp = arg_11_0._orderInfo.timestamp
	var_11_2.sign = arg_11_0._orderInfo.sign
	var_11_2.productId = BootNativeUtil.isIOS() and StoreConfig.instance:getStoreChargeConfig(arg_11_0._orderInfo.id, BootNativeUtil.getPackageName()).appStoreProductID or ""

	return var_11_2
end

function var_0_0.getGameRoleInfo(arg_12_0, arg_12_1)
	local var_12_0 = PlayerModel.instance:getPlayinfo()
	local var_12_1 = CurrencyModel.instance:getFreeDiamond()
	local var_12_2 = CurrencyModel.instance:getDiamond()
	local var_12_3 = {
		roleId = tostring(var_12_0.userId),
		roleName = tostring(var_12_0.name),
		currentLevel = tonumber(var_12_0.level)
	}

	var_12_3.vipLevel = 0

	local var_12_4 = tostring(LoginModel.instance.serverId)

	if arg_12_1 and arg_12_0._orderInfo.serverId > 0 then
		var_12_4 = arg_12_0._orderInfo.serverId
	end

	local var_12_5 = DungeonConfig.instance:getEpisodeCO(var_12_0.lastEpisodeId)
	local var_12_6 = var_12_5 and tostring(var_12_5.name .. var_12_5.id) or ""

	var_12_3.serverId = var_12_4
	var_12_3.serverName = tostring(LoginModel.instance.serverName)
	var_12_3.roleCTime = tonumber(var_12_0.registerTime)
	var_12_3.loginTime = tonumber(var_12_0.lastLoginTime)
	var_12_3.logoutTime = tonumber(var_12_0.lastLogoutTime)
	var_12_3.accountRegisterTime = tonumber(var_12_0.registerTime)
	var_12_3.giveCurrencyNum = var_12_1
	var_12_3.paidCurrencyNum = var_12_2
	var_12_3.currencyNum = var_12_1 + var_12_2
	var_12_3.currentProgress = var_12_6
	var_12_3.roleEstablishTime = tonumber(var_12_0.registerTime)
	var_12_3.guildLevel = tonumber(var_12_0.level)
	var_12_3.roleType = StatModel.instance:getRoleType()
	var_12_3.gameEnv = VersionValidator.instance:isInReviewing() and 1 or 0

	return var_12_3
end

function var_0_0.getQuickUseInfo(arg_13_0)
	if not arg_13_0._orderInfo then
		return
	end

	local var_13_0 = arg_13_0._orderInfo.id
	local var_13_1 = StoreConfig.instance:getChargeGoodsConfig(var_13_0)

	if not var_13_1 then
		return
	end

	local var_13_2 = var_13_1.quickUseItemList

	if string.nilorempty(var_13_2) then
		return
	end

	local var_13_3 = GameUtil.splitString2(var_13_2, true, "|", "#")

	if not var_13_3 or #var_13_3 == 0 then
		return
	end

	return {
		goodsId = var_13_0,
		chargeGoodsConfig = var_13_1,
		itemList = var_13_3
	}
end

var_0_0.instance = var_0_0.New()

return var_0_0
