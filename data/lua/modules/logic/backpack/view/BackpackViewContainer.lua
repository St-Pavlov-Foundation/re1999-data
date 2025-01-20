module("modules.logic.backpack.view.BackpackViewContainer", package.seeall)

slot0 = class("BackpackViewContainer", BaseViewContainer)

function slot0.buildViews(slot0)
	slot1 = ListScrollParam.New()
	slot1.scrollGOPath = "#scroll_category"
	slot1.prefabType = ScrollEnum.ScrollPrefabFromRes
	slot1.prefabUrl = slot0._viewSetting.otherRes[2]
	slot1.cellClass = BackpackCategoryListItem
	slot1.scrollDir = ScrollEnum.ScrollDirV
	slot1.lineCount = 1
	slot1.cellWidth = 335
	slot1.cellHeight = 110
	slot1.cellSpaceH = 0
	slot1.cellSpaceV = 4

	return {
		LuaListScrollView.New(BackpackCategoryListModel.instance, slot1),
		BackpackView.New(),
		TabViewGroup.New(1, "#go_btns"),
		TabViewGroup.New(BackpackController.BackpackViewTabContainerId, "#go_container"),
		CommonRainEffectView.New("rainEffect")
	}
end

function slot0.buildTabViews(slot0, slot1)
	if slot1 == 1 then
		slot0.navigationView = NavigateButtonsView.New({
			true,
			true,
			false
		})

		return {
			slot0.navigationView
		}
	elseif slot1 == 2 then
		slot2 = ListScrollParam.New()
		slot2.scrollGOPath = "#scroll_prop"
		slot2.prefabType = ScrollEnum.ScrollPrefabFromRes
		slot2.prefabUrl = slot0._viewSetting.otherRes[1]
		slot2.cellClass = BackpackPropListItem
		slot2.scrollDir = ScrollEnum.ScrollDirV
		slot2.lineCount = 6
		slot2.cellWidth = 250
		slot2.cellHeight = 250
		slot2.cellSpaceH = 0
		slot2.cellSpaceV = 0
		slot2.startSpace = 20
		slot2.endSpace = 10
		slot2.minUpdateCountInFrame = 100
		slot3 = ListScrollParam.New()
		slot3.scrollGOPath = "#scroll_equip"
		slot3.prefabType = ScrollEnum.ScrollPrefabFromRes
		slot3.prefabUrl = slot0._viewSetting.otherRes[3]
		slot3.cellClass = CharacterEquipItem
		slot3.scrollDir = ScrollEnum.ScrollDirV
		slot3.lineCount = 6
		slot3.cellWidth = 250
		slot3.cellHeight = 250
		slot3.cellSpaceH = 0
		slot3.cellSpaceV = 0
		slot3.startSpace = 20
		slot2.endSpace = 10
		slot3.minUpdateCountInFrame = 100
		slot5 = nil

		for slot9 = 1, 24 do
		end

		slot6 = ListScrollParam.New()
		slot6.scrollGOPath = "#scroll_antique"
		slot6.prefabType = ScrollEnum.ScrollPrefabFromRes
		slot6.prefabUrl = slot0._viewSetting.otherRes[1]
		slot6.cellClass = AntiqueBackpackItem
		slot6.scrollDir = ScrollEnum.ScrollDirV
		slot6.lineCount = 6
		slot6.cellWidth = 250
		slot6.cellHeight = 250
		slot6.cellSpaceH = 0
		slot6.cellSpaceV = 0
		slot6.startSpace = 20
		slot6.endSpace = 10
		slot6.minUpdateCountInFrame = 100
		slot0.notPlayAnimation = true

		return {
			MultiView.New({
				BackpackPropView.New(),
				LuaListScrollView.New(BackpackPropListModel.instance, slot2)
			}),
			MultiView.New({
				CharacterBackpackEquipView.New(),
				LuaListScrollViewWithAnimator.New(CharacterBackpackEquipListModel.instance, slot3, {
					[slot9] = (math.ceil(slot9 / 6) - 1) * 0.03
				})
			}),
			MultiView.New({
				AntiqueBackpackView.New(),
				LuaListScrollViewWithAnimator.New(AntiqueBackpackListModel.instance, slot6)
			})
		}
	end
end

function slot0.onContainerOpenFinish(slot0)
	slot0.navigationView:resetOnCloseViewAudio(AudioEnum.UI.UI_Rolesclose)
end

function slot0.setCurrentSelectCategoryId(slot0, slot1)
	slot0.currentSelectCategoryId = slot1 or ItemEnum.CategoryType.All
end

function slot0.getCurrentSelectCategoryId(slot0)
	return slot0.currentSelectCategoryId
end

return slot0
