﻿-- chunkname: @modules/logic/versionactivity2_0/enter/view/VersionActivity2_0EnterViewContainer.lua

module("modules.logic.versionactivity2_0.enter.view.VersionActivity2_0EnterViewContainer", package.seeall)

local VersionActivity2_0EnterViewContainer = class("VersionActivity2_0EnterViewContainer", BaseViewContainer)

function VersionActivity2_0EnterViewContainer:buildViews()
	return {
		VersionActivity2_0EnterView.New(),
		VersionActivity2_0EnterBgmView.New(),
		TabViewGroup.New(1, "#go_topleft"),
		TabViewGroup.New(2, "#go_subview")
	}
end

function VersionActivity2_0EnterViewContainer:buildTabViews(tabContainerId)
	if tabContainerId == 1 then
		self._navigateButtonView = NavigateButtonsView.New({
			true,
			true,
			false
		})

		return {
			self._navigateButtonView
		}
	elseif tabContainerId == 2 then
		local multiView = {}

		multiView[#multiView + 1] = V2a0_DungeonEnterView.New()
		multiView[#multiView + 1] = V2a0_Season123EnterView.New()
		multiView[#multiView + 1] = ReactivityEnterview.New()
		multiView[#multiView + 1] = V2a0_RoleActEnterView.New()
		multiView[#multiView + 1] = V1a6_BossRush_EnterView.New()
		multiView[#multiView + 1] = V2a0_RoleActEnterView.New()
		multiView[#multiView + 1] = RoleStoryEnterView.New()

		return multiView
	end
end

function VersionActivity2_0EnterViewContainer:selectActTab(jumpTabId, actId)
	self.activityId = actId

	self:dispatchEvent(ViewEvent.ToSwitchTab, 2, jumpTabId)
end

function VersionActivity2_0EnterViewContainer:onContainerInit()
	if not self.viewParam then
		return
	end

	self.isFirstPlaySubViewAnim = true

	local activityIdList = self.viewParam.activityIdList or {}

	ActivityStageHelper.recordActivityStage(activityIdList)

	local activitySettingList = self.viewParam.activitySettingList or {}
	local defaultIndex = VersionActivityEnterHelper.getTabIndex(activitySettingList, self.viewParam.jumpActId)

	if defaultIndex ~= 1 then
		self.viewParam.defaultTabIds = {}
		self.viewParam.defaultTabIds[2] = defaultIndex
	elseif not self.viewParam.isDirectOpen then
		-- block empty
	end

	local actSetting = activitySettingList[defaultIndex]
	local actId = VersionActivityEnterHelper.getActId(actSetting)

	self.activityId = actId

	ActivityEnterMgr.instance:enterActivity(actId)
	ActivityRpc.instance:sendActivityNewStageReadRequest({
		actId
	})
end

function VersionActivity2_0EnterViewContainer:onContainerClose()
	if self:isManualClose() and not ViewMgr.instance:isOpen(ViewName.MainView) then
		MainController.instance:dispatchEvent(MainEvent.ManuallyOpenMainView)
	end
end

function VersionActivity2_0EnterViewContainer:getIsFirstPlaySubViewAnim()
	return self.isFirstPlaySubViewAnim
end

function VersionActivity2_0EnterViewContainer:markPlayedSubViewAnim()
	self.isFirstPlaySubViewAnim = false
end

return VersionActivity2_0EnterViewContainer
