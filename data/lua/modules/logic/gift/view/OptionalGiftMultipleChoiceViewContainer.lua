﻿module("modules.logic.gift.view.OptionalGiftMultipleChoiceViewContainer", package.seeall)

local var_0_0 = class("OptionalGiftMultipleChoiceViewContainer", BaseViewContainer)

function var_0_0.buildViews(arg_1_0)
	local var_1_0 = {}
	local var_1_1 = ListScrollParam.New()

	var_1_1.scrollGOPath = "root/#scroll_item"
	var_1_1.prefabType = ScrollEnum.ScrollPrefabFromRes
	var_1_1.prefabUrl = arg_1_0._viewSetting.otherRes[1]
	var_1_1.cellClass = GiftMultipleChoiceListItem
	var_1_1.scrollDir = ScrollEnum.ScrollDirV
	var_1_1.lineCount = 6
	var_1_1.cellWidth = 200
	var_1_1.cellHeight = 275
	var_1_1.cellSpaceH = 41
	var_1_1.cellSpaceV = 56
	var_1_1.startSpace = 11

	table.insert(var_1_0, LuaListScrollView.New(GiftMultipleChoiceListModel.instance, var_1_1))
	table.insert(var_1_0, OptionalGiftMultipleChoiceView.New())

	return var_1_0
end

return var_0_0
