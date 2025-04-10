module("modules.logic.versionactivity2_7.v2a7_selfselectsix_1.view.V2a7_SelfSelectSix_PickChoiceViewContainer", package.seeall)

slot0 = class("V2a7_SelfSelectSix_PickChoiceViewContainer", BaseViewContainer)

function slot0.buildViews(slot0)
	slot1 = {}
	slot2 = MixScrollParam.New()
	slot2.scrollGOPath = "#scroll_rule"
	slot2.prefabType = ScrollEnum.ScrollPrefabFromRes
	slot2.prefabUrl = slot0._viewSetting.otherRes[1]
	slot2.cellClass = V2a7_SelfSelectSix_PickChoiceItem
	slot2.scrollDir = ScrollEnum.ScrollDirV
	slot2.lineCount = 1
	slot2.startSpace = 0
	slot2.endSpace = 30
	slot0._csScrollView = LuaMixScrollView.New(V2a7_SelfSelectSix_PickChoiceListModel.instance, slot2)

	table.insert(slot1, V2a7_SelfSelectSix_PickChoiceView.New())
	table.insert(slot1, slot0._csScrollView)

	return slot1
end

return slot0
