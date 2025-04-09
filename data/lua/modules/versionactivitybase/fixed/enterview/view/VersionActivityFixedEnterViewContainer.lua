module("modules.versionactivitybase.fixed.enterview.view.VersionActivityFixedEnterViewContainer", package.seeall)

slot0 = class("VersionActivityFixedEnterViewContainer", BaseViewContainer)

function slot0.buildViews(slot0)
	slot1 = slot0:getViews()

	table.insert(slot1, TabViewGroup.New(1, "#go_topleft"))
	table.insert(slot1, TabViewGroup.New(2, "#go_subview"))

	return slot1
end

function slot0.buildTabViews(slot0, slot1)
	if slot1 == 1 then
		slot0:initNavigateButtonsView({
			true,
			true,
			false
		})

		return {
			slot0._navigateButtonView
		}
	elseif slot1 == 2 then
		slot2 = slot0:getMultiViews()
		slot2[#slot2 + 1] = ActivityWeekWalkDeepShowView.New()
		slot2[#slot2 + 1] = TowerMainEntryView.New()
		slot2[#slot2 + 1] = ActivityWeekWalkHeartShowView.New()

		return slot2
	end
end

function slot0.selectActTab(slot0, slot1, slot2)
	slot0.activityId = slot2

	slot0:dispatchEvent(ViewEvent.ToSwitchTab, 2, slot1)
end

function slot0.onContainerInit(slot0)
	if not slot0.viewParam then
		return
	end

	slot0.isFirstPlaySubViewAnim = true

	ActivityStageHelper.recordActivityStage(slot0.viewParam.activityIdList or {})

	slot0.activityId = slot0.viewParam.jumpActId

	if VersionActivityEnterHelper.getTabIndex(slot0.viewParam.activitySettingList or {}, slot0.activityId) ~= 1 then
		slot0.viewParam.defaultTabIds = {
			[2] = slot3
		}
	end

	slot5 = VersionActivityEnterHelper.getActId(slot2[slot3])

	ActivityEnterMgr.instance:enterActivity(slot5)
	ActivityRpc.instance:sendActivityNewStageReadRequest({
		slot5
	})
end

function slot0.onContainerClose(slot0)
	if slot0:isManualClose() and not ViewMgr.instance:isOpen(ViewName.MainView) then
		ViewMgr.instance:openView(ViewName.MainView)
	end
end

function slot0.getIsFirstPlaySubViewAnim(slot0)
	return slot0.isFirstPlaySubViewAnim
end

function slot0.markPlayedSubViewAnim(slot0)
	slot0.isFirstPlaySubViewAnim = false
end

function slot0.getViews(slot0)
	return {
		VersionActivityFixedHelper.getVersionActivityEnterView().New(),
		VersionActivityFixedHelper.getVersionActivityEnterBgmView().New()
	}
end

function slot0.initNavigateButtonsView(slot0, slot1)
	slot0._navigateButtonView = NavigateButtonsView.New(slot1)
end

function slot0.getMultiViews(slot0)
	return {
		VersionActivityFixedHelper.getVersionActivityDungeonEnterView().New()
	}
end

return slot0
