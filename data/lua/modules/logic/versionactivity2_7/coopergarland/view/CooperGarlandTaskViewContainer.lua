module("modules.logic.versionactivity2_7.coopergarland.view.CooperGarlandTaskViewContainer", package.seeall)

slot0 = class("CooperGarlandTaskViewContainer", BaseViewContainer)

function slot0.buildViews(slot0)
	slot1 = {}
	slot2 = ListScrollParam.New()
	slot2.scrollGOPath = "#scroll_TaskList"
	slot2.prefabType = ScrollEnum.ScrollPrefabFromRes
	slot2.prefabUrl = slot0._viewSetting.otherRes[1]
	slot2.cellClass = CooperGarlandTaskItem
	slot2.scrollDir = ScrollEnum.ScrollDirV
	slot2.lineCount = 1
	slot2.cellWidth = 1160
	slot2.cellHeight = 165
	slot2.cellSpaceH = 0
	slot2.cellSpaceV = 0
	slot2.startSpace = 0

	for slot7 = 1, 10 do
	end

	table.insert(slot1, LuaListScrollViewWithAnimator.New(CooperGarlandTaskListModel.instance, slot2, {
		[slot7] = (slot7 - 1) * 0.06
	}))
	table.insert(slot1, CooperGarlandTaskView.New())
	table.insert(slot1, TabViewGroup.New(1, "#go_lefttop"))

	return slot1
end

function slot0.buildTabViews(slot0, slot1)
	if slot1 == 1 then
		slot0.navigateView = NavigateButtonsView.New({
			true,
			false,
			false
		})

		return {
			slot0.navigateView
		}
	end
end

return slot0
