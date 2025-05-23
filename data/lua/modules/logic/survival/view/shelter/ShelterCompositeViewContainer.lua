﻿module("modules.logic.survival.view.shelter.ShelterCompositeViewContainer", package.seeall)

local var_0_0 = class("ShelterCompositeViewContainer", BaseViewContainer)

function var_0_0.buildViews(arg_1_0)
	local var_1_0 = {}

	arg_1_0.materialView = ShelterCompositeMaterialView.New()
	arg_1_0.compositeView = ShelterCompositeView.New()

	table.insert(var_1_0, arg_1_0.materialView)
	table.insert(var_1_0, arg_1_0.compositeView)
	table.insert(var_1_0, TabViewGroup.New(1, "#go_lefttop"))

	return var_1_0
end

function var_0_0.buildTabViews(arg_2_0, arg_2_1)
	if arg_2_1 == 1 then
		local var_2_0 = NavigateButtonsView.New({
			true,
			false,
			false
		})

		return {
			var_2_0
		}
	end
end

function var_0_0.showMaterialView(arg_3_0, arg_3_1)
	arg_3_0.materialView:showMaterialView(arg_3_1)
end

function var_0_0.closeMaterialView(arg_4_0)
	arg_4_0.materialView:closeMaterialView()
end

function var_0_0.isSelectItem(arg_5_0, arg_5_1, arg_5_2)
	return arg_5_0.compositeView:isSelectItem(arg_5_1, arg_5_2)
end

return var_0_0
