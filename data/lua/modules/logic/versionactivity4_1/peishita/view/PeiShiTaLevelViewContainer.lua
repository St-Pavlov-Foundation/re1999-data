-- chunkname: @modules/logic/versionactivity4_1/peishita/view/PeiShiTaLevelViewContainer.lua

module("modules.logic.versionactivity4_1.peishita.view.PeiShiTaLevelViewContainer", package.seeall)

local PeiShiTaLevelViewContainer = class("PeiShiTaLevelViewContainer", BaseViewContainer)

function PeiShiTaLevelViewContainer:buildViews()
	local views = {}

	table.insert(views, PeiShiTaLevelView.New())
	table.insert(views, TabViewGroup.New(1, "#go_topleft"))

	return views
end

function PeiShiTaLevelViewContainer:buildTabViews(tabContainerId)
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

function PeiShiTaLevelViewContainer:onContainerInit()
	local actId = VersionActivity4_1Enum.ActivityId.PeiShiTa

	ActivityEnterMgr.instance:enterActivity(actId)
	ActivityRpc.instance:sendActivityNewStageReadRequest({
		actId
	})
end

return PeiShiTaLevelViewContainer
