module("modules.logic.versionactivity1_4.act129.view.Activity129ViewContainer", package.seeall)

local var_0_0 = class("Activity129ViewContainer", BaseViewContainer)

function var_0_0.buildViews(arg_1_0)
	local var_1_0 = {}

	arg_1_0.heroView = Activity129HeroView.New()
	arg_1_0.entranceView = Activity129EntranceView.New()
	arg_1_0.rewardView = Activity129RewardView.New()

	table.insert(var_1_0, arg_1_0.heroView)
	table.insert(var_1_0, arg_1_0.entranceView)
	table.insert(var_1_0, arg_1_0.rewardView)
	table.insert(var_1_0, Activity129View.New())
	table.insert(var_1_0, Activity129PrizeView.New())
	table.insert(var_1_0, Activity129ResultView.New())
	table.insert(var_1_0, TabViewGroup.New(1, "#go_BackBtns"))
	table.insert(var_1_0, TabViewGroup.New(2, "#go_CurrenyBar"))

	return var_1_0
end

function var_0_0.buildTabViews(arg_2_0, arg_2_1)
	if arg_2_1 == 1 then
		arg_2_0._navigateButtonsView = NavigateButtonsView.New({
			true,
			true,
			false
		})

		arg_2_0._navigateButtonsView:setOverrideClose(arg_2_0.overrideClose, arg_2_0)

		return {
			arg_2_0._navigateButtonsView
		}
	end

	if arg_2_1 == 2 then
		local var_2_0 = Activity129Config.instance:getConstValue1(arg_2_0.viewParam.actId, Activity129Enum.ConstEnum.CostId)
		local var_2_1 = {
			var_2_0
		}

		arg_2_0.currencyView = CurrencyView.New(var_2_1)
		arg_2_0.currencyView.foreHideBtn = true

		return {
			arg_2_0.currencyView
		}
	end
end

function var_0_0.overrideClose(arg_3_0)
	if Activity129Model.instance:getSelectPoolId() then
		Activity129Model.instance:setSelectPoolId()

		return
	end

	arg_3_0:closeThis()
end

return var_0_0
