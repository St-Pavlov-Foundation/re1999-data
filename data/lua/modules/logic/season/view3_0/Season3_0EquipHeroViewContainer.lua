﻿module("modules.logic.season.view3_0.Season3_0EquipHeroViewContainer", package.seeall)

local var_0_0 = class("Season3_0EquipHeroViewContainer", BaseViewContainer)

function var_0_0.buildViews(arg_1_0)
	local var_1_0 = arg_1_0:createEquipItemsParam()
	local var_1_1 = Season3_0EquipTagSelect.New()

	var_1_1:init(Activity104EquipController.instance, "#go_normal/right/#drop_filter")

	return {
		Season3_0EquipHeroView.New(),
		Season3_0EquipHeroSpineView.New(),
		var_1_1,
		LuaListScrollView.New(Activity104EquipItemListModel.instance, var_1_0),
		TabViewGroup.New(1, "#go_btn")
	}
end

var_0_0.ColumnCount = 5

function var_0_0.createEquipItemsParam(arg_2_0)
	local var_2_0 = ListScrollParam.New()

	var_2_0.scrollGOPath = "#go_normal/right/#scroll_card"
	var_2_0.prefabType = ScrollEnum.ScrollPrefabFromRes
	var_2_0.prefabUrl = arg_2_0._viewSetting.otherRes[1]
	var_2_0.cellClass = Season3_0EquipItem
	var_2_0.scrollDir = ScrollEnum.ScrollDirV
	var_2_0.lineCount = var_0_0.ColumnCount
	var_2_0.cellWidth = 170
	var_2_0.cellHeight = 235
	var_2_0.cellSpaceH = 9.2
	var_2_0.cellSpaceV = 2.18
	var_2_0.frameUpdateMs = 100
	var_2_0.minUpdateCountInFrame = var_0_0.ColumnCount

	return var_2_0
end

function var_0_0.buildTabViews(arg_3_0, arg_3_1)
	if arg_3_1 == 1 then
		arg_3_0._navigateButtonView = NavigateButtonsView.New({
			true,
			true,
			false
		})

		return {
			arg_3_0._navigateButtonView
		}
	end
end

var_0_0.Close_Anim_Time = 0.17

function var_0_0.playCloseTransition(arg_4_0)
	UnityEngine.Shader.EnableKeyword("_CLIPALPHA_ON")
	arg_4_0.viewGO:GetComponent(typeof(UnityEngine.Animator)):Play("close", 0, 0)
	TaskDispatcher.runDelay(arg_4_0.delayOnPlayCloseAnim, arg_4_0, var_0_0.Close_Anim_Time)
end

function var_0_0.delayOnPlayCloseAnim(arg_5_0)
	UnityEngine.Shader.DisableKeyword("_CLIPALPHA_ON")
	arg_5_0:onPlayCloseTransitionFinish()
end

return var_0_0
