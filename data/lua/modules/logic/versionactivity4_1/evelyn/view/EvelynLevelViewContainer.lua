-- chunkname: @modules/logic/versionactivity4_1/evelyn/view/EvelynLevelViewContainer.lua

module("modules.logic.versionactivity4_1.evelyn.view.EvelynLevelViewContainer", package.seeall)

local EvelynLevelViewContainer = class("EvelynLevelViewContainer", BaseViewContainer)

function EvelynLevelViewContainer:buildViews()
	local views = {}

	table.insert(views, EvelynLevelView.New())
	table.insert(views, TabViewGroup.New(1, "#go_topleft"))

	return views
end

function EvelynLevelViewContainer:buildTabViews(tabContainerId)
	if tabContainerId == 1 then
		self._navigateButtonsView = NavigateButtonsView.New({
			true,
			true,
			false
		})

		return {
			self._navigateButtonsView
		}
	end
end

function EvelynLevelViewContainer:onContainerInit()
	local actId = EvelynModel.instance:getActId()

	ActivityEnterMgr.instance:enterActivity(actId)
	ActivityRpc.instance:sendActivityNewStageReadRequest({
		actId
	})
end

return EvelynLevelViewContainer
