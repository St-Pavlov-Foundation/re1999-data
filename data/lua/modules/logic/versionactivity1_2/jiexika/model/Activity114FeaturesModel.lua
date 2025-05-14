module("modules.logic.versionactivity1_2.jiexika.model.Activity114FeaturesModel", package.seeall)

local var_0_0 = class("Activity114FeaturesModel", ListScrollModel)

function var_0_0.onFeatureListUpdate(arg_1_0, arg_1_1)
	local var_1_0 = {}

	for iter_1_0 = 1, #arg_1_1 do
		var_1_0[iter_1_0] = Activity114Config.instance:getFeatureCo(Activity114Model.instance.id, arg_1_1[iter_1_0])
	end

	arg_1_0:setList(var_1_0)
end

var_0_0.instance = var_0_0.New()

return var_0_0
