﻿-- chunkname: @modules/logic/season/view/SeasonFightRuleTipViewContainer.lua

module("modules.logic.season.view.SeasonFightRuleTipViewContainer", package.seeall)

local SeasonFightRuleTipViewContainer = class("SeasonFightRuleTipViewContainer", BaseViewContainer)

function SeasonFightRuleTipViewContainer:buildViews()
	local views = {
		TabViewGroup.New(1, "root/contain"),
		SeasonFightRuleTipView.New()
	}

	return views
end

function SeasonFightRuleTipViewContainer:buildTabViews(tabContainerId)
	return {
		SeasonFightRuleView.New(),
		SeasonFightCardView.New()
	}
end

function SeasonFightRuleTipViewContainer:switchTab(tabId)
	self:dispatchEvent(ViewEvent.ToSwitchTab, 1, tabId)
end

return SeasonFightRuleTipViewContainer
