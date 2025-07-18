﻿module("modules.logic.season.view3_0.Season3_0FightRuleTipViewContainer", package.seeall)

local var_0_0 = class("Season3_0FightRuleTipViewContainer", BaseViewContainer)

function var_0_0.buildViews(arg_1_0)
	return {
		TabViewGroup.New(1, "root/contain"),
		Season3_0FightRuleTipView.New()
	}
end

function var_0_0.buildTabViews(arg_2_0, arg_2_1)
	return {
		Season3_0FightRuleView.New(),
		Season3_0FightCardView.New()
	}
end

function var_0_0.switchTab(arg_3_0, arg_3_1)
	arg_3_0:dispatchEvent(ViewEvent.ToSwitchTab, 1, arg_3_1)
end

return var_0_0
