module("modules.logic.weekwalk_2.view.WeekWalk_2HeartBuffViewContainer", package.seeall)

slot0 = class("WeekWalk_2HeartBuffViewContainer", BaseViewContainer)

function slot0.buildViews(slot0)
	slot1 = ListScrollParam.New()
	slot1.scrollGOPath = "Root/Left/Scroll View"
	slot1.prefabType = ScrollEnum.ScrollPrefabFromRes
	slot1.prefabUrl = slot0._viewSetting.otherRes[1]
	slot1.cellClass = WeekWalk_2HeartBuffItem
	slot1.scrollDir = ScrollEnum.ScrollDirV
	slot1.lineCount = 3
	slot1.cellWidth = 240
	slot1.cellHeight = 220
	slot2 = {}

	table.insert(slot2, WeekWalk_2HeartBuffView.New())
	table.insert(slot2, LuaListScrollView.New(WeekWalk_2BuffListModel.instance, slot1))

	return slot2
end

function slot0.onContainerOpen(slot0)
	WeekWalk_2BuffListModel.instance:initBuffList(slot0.viewParam and slot0.viewParam.isBattle)
end

function slot0.onContainerClickModalMask(slot0)
	slot0:closeThis()
end

return slot0
