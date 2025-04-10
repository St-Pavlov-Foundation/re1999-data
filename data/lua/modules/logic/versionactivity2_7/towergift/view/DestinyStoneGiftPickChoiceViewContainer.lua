module("modules.logic.versionactivity2_7.towergift.view.DestinyStoneGiftPickChoiceViewContainer", package.seeall)

slot0 = class("DestinyStoneGiftPickChoiceViewContainer", BaseViewContainer)

function slot0.buildViews(slot0)
	slot1 = {}
	slot2 = ListScrollParam.New()
	slot2.scrollGOPath = "#scroll_stone"
	slot2.prefabType = ScrollEnum.ScrollPrefabFromView
	slot2.prefabUrl = "#scroll_stone/Viewport/Content/stoneitem"
	slot2.cellClass = DestinyStoneGiftPickChoiceListItem
	slot2.scrollDir = ScrollEnum.ScrollDirV
	slot2.lineCount = 4
	slot2.cellWidth = 408
	slot2.cellHeight = 208
	slot2.cellSpaceH = 16
	slot2.cellSpaceV = 16
	slot2.startSpace = 10
	slot2.endSpace = 30

	table.insert(slot1, LuaListScrollView.New(DestinyStoneGiftPickChoiceListModel.instance, slot2))
	table.insert(slot1, DestinyStoneGiftPickChoiceView.New())

	return slot1
end

return slot0
