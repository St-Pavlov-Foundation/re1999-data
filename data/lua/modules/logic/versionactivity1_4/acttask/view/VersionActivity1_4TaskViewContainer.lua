module("modules.logic.versionactivity1_4.acttask.view.VersionActivity1_4TaskViewContainer", package.seeall)

slot0 = class("VersionActivity1_4TaskViewContainer", BaseViewContainer)

function slot0.buildViews(slot0)
	slot1 = ListScrollParam.New()
	slot1.scrollGOPath = "Right/#scroll_TaskList"
	slot1.prefabType = ScrollEnum.ScrollPrefabFromRes
	slot1.prefabUrl = slot0._viewSetting.otherRes[1]
	slot1.cellClass = VersionActivity1_4TaskItem
	slot1.scrollDir = ScrollEnum.ScrollDirV
	slot1.lineCount = 1
	slot1.cellWidth = 1160
	slot1.cellHeight = 165
	slot1.cellSpaceH = 0
	slot1.cellSpaceV = 0

	for slot6 = 1, 6 do
	end

	slot0._taskScrollView = LuaListScrollViewWithAnimator.New(VersionActivity1_4TaskListModel.instance, slot1, {
		[slot6] = (slot6 - 1) * 0.06
	})

	return {
		slot0._taskScrollView,
		VersionActivity1_4TaskView.New(),
		TabViewGroup.New(1, "#go_topleft")
	}
end

function slot0.buildTabViews(slot0, slot1)
	return {
		NavigateButtonsView.New({
			true,
			true,
			false
		})
	}
end

function slot0.onContainerInit(slot0)
	slot0.taskAnimRemoveItem = ListScrollAnimRemoveItem.Get(slot0._taskScrollView)

	slot0.taskAnimRemoveItem:setMoveInterval(0)
end

function slot0.getScrollView(slot0)
	return slot0._taskScrollView
end

return slot0
