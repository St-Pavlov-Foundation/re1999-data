﻿module("modules.logic.handbook.view.HandbookSkinSuitDetailView3_0Container", package.seeall)

local var_0_0 = class("HandbookSkinSuitDetailView3_0Container", BaseViewContainer)

function var_0_0.buildViews(arg_1_0)
	local var_1_0 = {}

	table.insert(var_1_0, HandbookSkinSuitDetailView3_0.New())
	table.insert(var_1_0, TabViewGroup.New(1, "#go_btns"))

	return var_1_0
end

function var_0_0.buildTabViews(arg_2_0, arg_2_1)
	if arg_2_1 == 1 then
		arg_2_0.navigateView = NavigateButtonsView.New({
			true,
			true,
			false
		})

		return {
			arg_2_0.navigateView
		}
	end
end

function var_0_0.onContainerInit(arg_3_0)
	return
end

function var_0_0.onContainerOpenFinish(arg_4_0)
	arg_4_0.navigateView:resetCloseBtnAudioId(AudioEnum.UI.Play_UI_CloseHouse)
	arg_4_0.navigateView:resetHomeBtnAudioId(AudioEnum.UI.UI_checkpoint_story_close)
end

return var_0_0
