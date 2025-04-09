module("modules.logic.versionactivity2_7.lengzhou6.view.LengZhou6TaskViewContainer", package.seeall)

slot0 = class("LengZhou6TaskViewContainer", BaseViewContainer)

function slot0.buildViews(slot0)
	slot1 = {}
	slot2 = ListScrollParam.New()
	slot2.scrollGOPath = "#scroll_TaskList"
	slot2.prefabType = ScrollEnum.ScrollPrefabFromRes
	slot2.prefabUrl = slot0._viewSetting.otherRes[1]
	slot2.cellClass = LengZhou6TaskItem
	slot2.scrollDir = ScrollEnum.ScrollDirV
	slot2.lineCount = 1
	slot2.cellWidth = 1160
	slot2.cellHeight = 165
	slot2.cellSpaceH = 0
	slot2.cellSpaceV = 0
	slot2.startSpace = 0

	for slot7 = 1, 10 do
	end

	table.insert(slot1, LuaListScrollViewWithAnimator.New(LengZhou6TaskListModel.instance, slot2, {
		[slot7] = (slot7 - 1) * 0.06
	}))
	table.insert(slot1, LengZhou6TaskView.New())
	table.insert(slot1, TabViewGroup.New(1, "#go_lefttop"))

	return slot1
end

function slot0.buildTabViews(slot0, slot1)
	if slot1 == 1 then
		slot0.navigationView = NavigateButtonsView.New({
			true,
			false,
			false
		})

		slot0.navigationView:setOverrideClose(slot0._overrideClose, slot0)

		return {
			slot0.navigationView
		}
	end
end

return slot0
