﻿module("modules.logic.versionactivity.view.VersionActivityEnterViewContainer", package.seeall)

local var_0_0 = class("VersionActivityEnterViewContainer", BaseViewContainer)

function var_0_0.buildViews(arg_1_0)
	return {
		VersionActivityEnterView.New(),
		TabViewGroup.New(1, "#go_topleft")
	}
end

function var_0_0.buildTabViews(arg_2_0, arg_2_1)
	return {
		NavigateButtonsView.New({
			true,
			true,
			false
		})
	}
end

function var_0_0.onContainerInit(arg_3_0)
	ActivityStageHelper.recordActivityStage(arg_3_0.viewParam.activityIdList)
end

function var_0_0.onContainerClose(arg_4_0)
	if arg_4_0:isManualClose() and not ViewMgr.instance:isOpen(ViewName.MainView) and not ViewMgr.instance:hasOpenFullView() then
		MainController.instance:dispatchEvent(MainEvent.ManuallyOpenMainView)
	end
end

return var_0_0
