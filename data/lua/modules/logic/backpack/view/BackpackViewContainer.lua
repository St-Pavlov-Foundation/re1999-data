module("modules.logic.backpack.view.BackpackViewContainer", package.seeall)

local var_0_0 = class("BackpackViewContainer", BaseViewContainer)

function var_0_0.buildViews(arg_1_0)
	local var_1_0 = ListScrollParam.New()

	var_1_0.scrollGOPath = "#scroll_category"
	var_1_0.prefabType = ScrollEnum.ScrollPrefabFromRes
	var_1_0.prefabUrl = arg_1_0._viewSetting.otherRes[2]
	var_1_0.cellClass = BackpackCategoryListItem
	var_1_0.scrollDir = ScrollEnum.ScrollDirV
	var_1_0.lineCount = 1
	var_1_0.cellWidth = 335
	var_1_0.cellHeight = 110
	var_1_0.cellSpaceH = 0
	var_1_0.cellSpaceV = 4

	return {
		LuaListScrollView.New(BackpackCategoryListModel.instance, var_1_0),
		BackpackView.New(),
		TabViewGroup.New(1, "#go_btns"),
		TabViewGroup.New(BackpackController.BackpackViewTabContainerId, "#go_container"),
		CommonRainEffectView.New("rainEffect")
	}
end

function var_0_0.buildTabViews(arg_2_0, arg_2_1)
	if arg_2_1 == 1 then
		arg_2_0.navigationView = NavigateButtonsView.New({
			true,
			true,
			false
		})

		return {
			arg_2_0.navigationView
		}
	elseif arg_2_1 == 2 then
		local var_2_0 = ListScrollParam.New()

		var_2_0.scrollGOPath = "#scroll_prop"
		var_2_0.prefabType = ScrollEnum.ScrollPrefabFromRes
		var_2_0.prefabUrl = arg_2_0._viewSetting.otherRes[1]
		var_2_0.cellClass = BackpackPropListItem
		var_2_0.scrollDir = ScrollEnum.ScrollDirV
		var_2_0.lineCount = 6
		var_2_0.cellWidth = 250
		var_2_0.cellHeight = 250
		var_2_0.cellSpaceH = 0
		var_2_0.cellSpaceV = 0
		var_2_0.startSpace = 20
		var_2_0.endSpace = 10
		var_2_0.minUpdateCountInFrame = 100

		local var_2_1 = ListScrollParam.New()

		var_2_1.scrollGOPath = "#scroll_equip"
		var_2_1.prefabType = ScrollEnum.ScrollPrefabFromRes
		var_2_1.prefabUrl = arg_2_0._viewSetting.otherRes[3]
		var_2_1.cellClass = CharacterEquipItem
		var_2_1.scrollDir = ScrollEnum.ScrollDirV
		var_2_1.lineCount = 6
		var_2_1.cellWidth = 250
		var_2_1.cellHeight = 250
		var_2_1.cellSpaceH = 0
		var_2_1.cellSpaceV = 0
		var_2_1.startSpace = 20
		var_2_0.endSpace = 10
		var_2_1.minUpdateCountInFrame = 100

		local var_2_2 = {}
		local var_2_3

		for iter_2_0 = 1, 24 do
			var_2_2[iter_2_0] = (math.ceil(iter_2_0 / 6) - 1) * 0.03
		end

		local var_2_4 = ListScrollParam.New()

		var_2_4.scrollGOPath = "#scroll_antique"
		var_2_4.prefabType = ScrollEnum.ScrollPrefabFromRes
		var_2_4.prefabUrl = arg_2_0._viewSetting.otherRes[1]
		var_2_4.cellClass = AntiqueBackpackItem
		var_2_4.scrollDir = ScrollEnum.ScrollDirV
		var_2_4.lineCount = 6
		var_2_4.cellWidth = 250
		var_2_4.cellHeight = 250
		var_2_4.cellSpaceH = 0
		var_2_4.cellSpaceV = 0
		var_2_4.startSpace = 20
		var_2_4.endSpace = 10
		var_2_4.minUpdateCountInFrame = 100
		arg_2_0.notPlayAnimation = true

		return {
			MultiView.New({
				BackpackPropView.New(),
				LuaListScrollView.New(BackpackPropListModel.instance, var_2_0)
			}),
			MultiView.New({
				CharacterBackpackEquipView.New(),
				LuaListScrollViewWithAnimator.New(CharacterBackpackEquipListModel.instance, var_2_1, var_2_2)
			}),
			MultiView.New({
				AntiqueBackpackView.New(),
				LuaListScrollViewWithAnimator.New(AntiqueBackpackListModel.instance, var_2_4)
			})
		}
	end
end

function var_0_0.onContainerOpenFinish(arg_3_0)
	arg_3_0.navigationView:resetOnCloseViewAudio(AudioEnum.UI.UI_Rolesclose)
end

function var_0_0.setCurrentSelectCategoryId(arg_4_0, arg_4_1)
	arg_4_0.currentSelectCategoryId = arg_4_1 or ItemEnum.CategoryType.All
end

function var_0_0.getCurrentSelectCategoryId(arg_5_0)
	return arg_5_0.currentSelectCategoryId
end

return var_0_0
