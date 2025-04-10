module("modules.logic.versionactivity2_7.act191.view.Act191CollectionEditViewContainer", package.seeall)

slot0 = class("Act191CollectionEditViewContainer", BaseViewContainer)

function slot0.buildViews(slot0)
	slot1 = {}

	table.insert(slot1, Act191CollectionEditView.New())

	slot2 = ListScrollParam.New()
	slot2.scrollGOPath = "right_container/CollectionList/scroll_collection"
	slot2.prefabType = ScrollEnum.ScrollPrefabFromRes
	slot2.prefabUrl = slot0._viewSetting.otherRes[1]
	slot2.cellClass = Act191CollectionEditItem
	slot2.scrollDir = ScrollEnum.ScrollDirV
	slot2.lineCount = 5
	slot2.cellWidth = 200
	slot2.cellHeight = 200
	slot2.cellSpaceH = 0
	slot2.cellSpaceV = 0
	slot2.startSpace = 10

	table.insert(slot1, LuaListScrollView.New(Act191CollectionEditListModel.instance, slot2))
	table.insert(slot1, TabViewGroup.New(1, "#go_topleft"))

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
