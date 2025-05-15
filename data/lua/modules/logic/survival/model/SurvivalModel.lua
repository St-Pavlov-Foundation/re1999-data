module("modules.logic.survival.model.SurvivalModel", package.seeall)

local var_0_0 = class("SurvivalModel", BaseModel)

function var_0_0.onInit(arg_1_0)
	arg_1_0._outsideInfo = SurvivalOutSideInfoMo.New()
	arg_1_0._report = nil
	arg_1_0._survivalSettleInfo = nil
	arg_1_0._lastIndex = nil
end

function var_0_0.reInit(arg_2_0)
	arg_2_0:onInit()
	SurvivalMapHelper.instance:clear()
end

function var_0_0.onGetInfo(arg_3_0, arg_3_1)
	arg_3_0._outsideInfo:init(arg_3_1)
	SurvivalController.instance:dispatchEvent(SurvivalEvent.OnOutInfoChange)
end

function var_0_0.getOutSideInfo(arg_4_0)
	return arg_4_0._outsideInfo
end

function var_0_0.getRewardState(arg_5_0, arg_5_1, arg_5_2)
	return arg_5_0._outsideInfo:getRewardState(arg_5_1, arg_5_2)
end

function var_0_0.setDailyReport(arg_6_0, arg_6_1)
	arg_6_0._report = arg_6_1
end

function var_0_0.getDailyReport(arg_7_0)
	return arg_7_0._report
end

function var_0_0.setSurvivalSettleInfo(arg_8_0, arg_8_1)
	arg_8_0._survivalSettleInfo = arg_8_1
end

function var_0_0.getSurvivalSettleInfo(arg_9_0)
	return arg_9_0._survivalSettleInfo
end

function var_0_0.setBossFightLastIndex(arg_10_0, arg_10_1)
	arg_10_0._lastIndex = arg_10_1
end

function var_0_0.getBossFightLastIndex(arg_11_0)
	local var_11_0 = arg_11_0._lastIndex

	arg_11_0._lastIndex = nil

	return var_11_0
end

var_0_0.instance = var_0_0.New()

return var_0_0
