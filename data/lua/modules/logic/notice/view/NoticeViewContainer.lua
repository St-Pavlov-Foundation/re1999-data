module("modules.logic.notice.view.NoticeViewContainer", package.seeall)

local var_0_0 = class("NoticeViewContainer", BaseViewContainer)

function var_0_0.buildViews(arg_1_0)
	local var_1_0 = {}
	local var_1_1 = ListScrollParam.New()

	var_1_1.scrollGOPath = "left/#scroll_notice"
	var_1_1.prefabType = ScrollEnum.ScrollPrefabFromView
	var_1_1.prefabUrl = "left/#scroll_notice/Viewport/Content/noticeItem"
	var_1_1.cellClass = NoticeTitleItem
	var_1_1.scrollDir = ScrollEnum.ScrollDirV
	var_1_1.lineCount = 1
	var_1_1.cellWidth = 420
	var_1_1.cellHeight = 120
	var_1_1.cellSpaceH = 0
	var_1_1.cellSpaceV = 8
	var_1_1.startSpace = 0
	var_1_1.endSpace = 20

	local var_1_2 = MixScrollParam.New()

	var_1_2.scrollGOPath = "right/#scroll_content"
	var_1_2.prefabType = ScrollEnum.ScrollPrefabFromView
	var_1_2.prefabUrl = "right/#scroll_content/Viewport/Content/cell/noticeContentItem"
	var_1_2.cellClass = NoticeContentItemWrap
	var_1_2.scrollDir = ScrollEnum.ScrollDirV
	arg_1_0._titleListView = LuaListScrollView.New(NoticeModel.instance, var_1_1)
	arg_1_0._contentListView = LuaMixScrollView.New(NoticeContentListModel.instance, var_1_2)
	arg_1_0._noticeView = NoticeView.New()

	table.insert(var_1_0, arg_1_0._titleListView)
	table.insert(var_1_0, arg_1_0._contentListView)
	table.insert(var_1_0, arg_1_0._noticeView)

	local var_1_3 = ToggleListView.New(1, "right/#toggleGroup")

	var_1_3.onOpen = var_0_0.customToggleViewOpen

	table.insert(var_1_0, var_1_3)

	return var_1_0
end

function var_0_0.customToggleViewOpen(arg_2_0)
	local var_2_0 = arg_2_0._toggleGroup.allowSwitchOff

	arg_2_0._toggleGroup.allowSwitchOff = true

	local var_2_1 = arg_2_0.viewContainer:getFirstShowNoticeType()
	local var_2_2 = NoticeType.getTypeIndex(var_2_1)

	for iter_2_0, iter_2_1 in pairs(arg_2_0._toggleDict) do
		iter_2_1.isOn = iter_2_0 == var_2_2

		iter_2_1:AddOnValueChanged(arg_2_0._onToggleValueChanged, arg_2_0, iter_2_0)
	end

	arg_2_0._toggleGroup.allowSwitchOff = var_2_0
end

function var_0_0.onContainerInit(arg_3_0)
	arg_3_0:registerCallback(ViewEvent.ToSwitchTab, arg_3_0._toSwitchTab, arg_3_0)
end

function var_0_0.onContainerDestroy(arg_4_0)
	arg_4_0:unregisterCallback(ViewEvent.ToSwitchTab, arg_4_0._toSwitchTab, arg_4_0)
end

function var_0_0._toSwitchTab(arg_5_0, arg_5_1, arg_5_2)
	if arg_5_2 == NoticeModel.instance:getSelectType() then
		return
	end

	NoticeModel.instance:switchNoticeTypeByToggleId(arg_5_2)
	arg_5_0:selectFirstNotice()
end

function var_0_0.selectFirstNotice(arg_6_0)
	if NoticeModel.instance:getCount() > 0 then
		arg_6_0._titleListView:getCsListScroll().VerticalScrollPixel = 0

		arg_6_0._titleListView:selectCell(1, true)
	else
		NoticeContentListModel.instance:setNoticeMO(nil)
	end
end

function var_0_0.getFirstShowNoticeType(arg_7_0)
	local var_7_0 = NoticeController.instance.autoOpen
	local var_7_1 = NoticeModel.instance.autoSelectType
	local var_7_2

	for iter_7_0, iter_7_1 in ipairs(NoticeType.NoticeList) do
		if #NoticeModel.instance:getNoticesByType(iter_7_1) > 0 then
			var_7_2 = var_7_2 or iter_7_1

			if not var_7_0 then
				return iter_7_1
			elseif iter_7_1 == var_7_1 then
				return iter_7_1
			end
		end
	end

	return var_7_2
end

return var_0_0
