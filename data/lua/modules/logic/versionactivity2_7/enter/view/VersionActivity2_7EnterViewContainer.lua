module("modules.logic.versionactivity2_7.enter.view.VersionActivity2_7EnterViewContainer", package.seeall)

slot0 = class("VersionActivity2_7EnterViewContainer", VersionActivityFixedEnterViewContainer)

function slot0.getViews(slot0)
	return {
		VersionActivityFixedHelper.getVersionActivityEnterView().New(),
		VersionActivity2_7EnterBgmView.New()
	}
end

function slot0.getMultiViews(slot0)
	return {
		VersionActivity2_7DungeonEnterView.New(),
		V2a7_Act191EnterView.New(),
		V2a6_CooperGarlandEnterView.New(),
		V2a7_LengZhou6EnterView.New(),
		V2a7_v2a0_ReactivityEnterview.New(),
		Act183VersionActivityEnterView.New(),
		RoleStoryEnterView.New()
	}
end

return slot0
