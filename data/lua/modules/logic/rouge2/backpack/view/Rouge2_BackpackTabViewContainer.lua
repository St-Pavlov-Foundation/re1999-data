﻿-- chunkname: @modules/logic/rouge2/backpack/view/Rouge2_BackpackTabViewContainer.lua

module("modules.logic.rouge2.backpack.view.Rouge2_BackpackTabViewContainer", package.seeall)

local Rouge2_BackpackTabViewContainer = class("Rouge2_BackpackTabViewContainer", BaseViewContainer)

function Rouge2_BackpackTabViewContainer:buildViews()
	local views = {}

	table.insert(views, TabViewGroup.New(1, "#go_lefttop"))
	table.insert(views, TabViewGroup.New(4, "#go_lefttop2"))

	self._containerView = TabViewGroup.New(Rouge2_Enum.BackpackTabContainerId, "#go_Container")

	table.insert(views, self._containerView)
	table.insert(views, Rouge2_BackpackTabView.New())
	table.insert(views, Rouge2_MapCoinView.New())

	return views
end

function Rouge2_BackpackTabViewContainer:buildTabViews(tabContainerId)
	if tabContainerId == 1 then
		self.navigateView = NavigateButtonsView.New({
			true,
			false,
			false
		})

		return {
			self.navigateView
		}
	elseif tabContainerId == Rouge2_Enum.BackpackTabContainerId then
		return {
			Rouge2_BackpackCareerView.New(),
			Rouge2_BackpackSkillView.New(),
			Rouge2_BackpackRelicsView.New(),
			Rouge2_BackpackBuffView.New()
		}
	elseif tabContainerId == 3 then
		return {
			NavigateButtonsView.New({
				true,
				false,
				false
			}, nil, self._closeSkillEditViewCallback, nil, nil, self)
		}
	elseif tabContainerId == 4 then
		local editBtnViews = NavigateButtonsView.New({
			true,
			false,
			false
		})

		editBtnViews:setOverrideClose(self._closeSkillEditViewCallback, self)

		return {
			editBtnViews
		}
	end
end

function Rouge2_BackpackTabViewContainer:getCurSelectType()
	return self._containerView:getCurTabId()
end

function Rouge2_BackpackTabViewContainer:switchTab(type)
	local curTabId = self._containerView:getCurTabId()

	if curTabId == type then
		return
	end

	self:dispatchEvent(ViewEvent.ToSwitchTab, Rouge2_Enum.BackpackTabContainerId, type)
end

function Rouge2_BackpackTabViewContainer:_closeSkillEditViewCallback()
	AudioMgr.instance:trigger(AudioEnum.Rouge2.CloseSkillEditView)
	Rouge2_BackpackController.instance:readAllActiveSkills()
	ViewMgr.instance:closeView(ViewName.Rouge2_CareerSkillTipsView)
	Rouge2_Controller.instance:dispatchEvent(Rouge2_Event.OnSwitchSkillViewType, Rouge2_BackpackSkillView.ViewState.Panel)
end

return Rouge2_BackpackTabViewContainer
