module("modules.logic.room.view.RoomInformPlayerViewContainer", package.seeall)

local var_0_0 = class("RoomInformPlayerViewContainer", BaseViewContainer)

function var_0_0.buildViews(arg_1_0)
	local var_1_0 = ListScrollParam.New()

	var_1_0.scrollGOPath = "object/scroll_inform"
	var_1_0.prefabType = ScrollEnum.ScrollPrefabFromView
	var_1_0.prefabUrl = "object/scroll_inform/Viewport/#go_informContent/#go_informItem"
	var_1_0.cellClass = RoomInformReportTypeItem
	var_1_0.scrollDir = ScrollEnum.ScrollDirV
	var_1_0.lineCount = 4
	var_1_0.cellWidth = 280
	var_1_0.cellHeight = 40
	var_1_0.cellSpaceH = 37
	var_1_0.cellSpaceV = 33
	var_1_0.startSpace = 0

	return {
		CommonViewFrame.New(),
		RoomInformPlayerView.New(),
		LuaListScrollView.New(RoomReportTypeListModel.instance, var_1_0)
	}
end

function var_0_0.buildTabViews(arg_2_0, arg_2_1)
	return
end

function var_0_0.onContainerClickModalMask(arg_3_0)
	AudioMgr.instance:trigger(AudioEnum.UI.UI_Mail_switch)
	arg_3_0:closeThis()
end

return var_0_0
