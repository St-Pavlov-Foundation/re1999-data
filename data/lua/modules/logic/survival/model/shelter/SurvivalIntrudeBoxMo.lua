module("modules.logic.survival.model.shelter.SurvivalIntrudeBoxMo", package.seeall)

local var_0_0 = pureTable("SurvivalIntrudeBoxMo")

function var_0_0.init(arg_1_0, arg_1_1)
	arg_1_0.templateId = arg_1_1.templateId
	arg_1_0.fight = SurvivalIntrudeFightMo.New()

	arg_1_0.fight:init(arg_1_1.fight)
end

return var_0_0
