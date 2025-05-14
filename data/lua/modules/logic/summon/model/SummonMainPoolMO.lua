module("modules.logic.summon.model.SummonMainPoolMO", package.seeall)

local var_0_0 = pureTable("SummonMainPoolMO")

function var_0_0.init(arg_1_0, arg_1_1)
	arg_1_0.id = arg_1_1.poolId
	arg_1_0.luckyBagMO = SummonLuckyBagMO.New()
	arg_1_0.customPickMO = SummonCustomPickMO.New()

	arg_1_0:update(arg_1_1)
end

function var_0_0.update(arg_2_0, arg_2_1)
	arg_2_0.offlineTime = arg_2_1.offlineTime or 0
	arg_2_0.onlineTime = arg_2_1.onlineTime or 0
	arg_2_0.haveFree = arg_2_1.haveFree or false
	arg_2_0.usedFreeCount = arg_2_1.usedFreeCount or 0

	if arg_2_1.luckyBagInfo then
		arg_2_0.luckyBagMO:update(arg_2_1.luckyBagInfo)
	end

	if arg_2_1.spPoolInfo then
		arg_2_0.customPickMO:update(arg_2_1.spPoolInfo)
	end

	arg_2_0.discountTime = arg_2_1.discountTime or 0
	arg_2_0.canGetGuaranteeSRCount = arg_2_1.canGetGuaranteeSRCount or 0
	arg_2_0.guaranteeSRCountDown = arg_2_1.guaranteeSRCountDown or 0
end

function var_0_0.isOpening(arg_3_0)
	if arg_3_0.offlineTime == 0 and arg_3_0.onlineTime == 0 then
		return true
	end

	local var_3_0 = ServerTime.now()

	return var_3_0 >= arg_3_0.onlineTime and var_3_0 <= arg_3_0.offlineTime
end

return var_0_0
