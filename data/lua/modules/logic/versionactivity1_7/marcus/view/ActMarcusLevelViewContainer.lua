module("modules.logic.versionactivity1_7.marcus.view.ActMarcusLevelViewContainer", package.seeall)

slot0 = class("ActMarcusLevelViewContainer", BaseViewContainer)

function slot0.buildViews(slot0)
	slot1 = {}

	table.insert(slot1, ActMarcusLevelView.New())
	table.insert(slot1, TabViewGroup.New(1, "#go_btns"))

	return slot1
end

function slot0.buildTabViews(slot0, slot1)
	if slot1 == 1 then
		slot0._navigateButtonsView = NavigateButtonsView.New({
			true,
			true,
			false
		})

		return {
			slot0._navigateButtonsView
		}
	end
end

function slot0.onContainerInit(slot0)
	ActivityEnterMgr.instance:enterActivity(VersionActivity1_7Enum.ActivityId.Marcus)
	ActivityRpc.instance:sendActivityNewStageReadRequest({
		VersionActivity1_7Enum.ActivityId.Marcus
	})
end

return slot0
