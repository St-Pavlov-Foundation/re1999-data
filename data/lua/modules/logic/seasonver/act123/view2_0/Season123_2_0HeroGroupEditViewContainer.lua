﻿-- chunkname: @modules/logic/seasonver/act123/view2_0/Season123_2_0HeroGroupEditViewContainer.lua

module("modules.logic.seasonver.act123.view2_0.Season123_2_0HeroGroupEditViewContainer", package.seeall)

local Season123_2_0HeroGroupEditViewContainer = class("Season123_2_0HeroGroupEditViewContainer", BaseViewContainer)

function Season123_2_0HeroGroupEditViewContainer:buildViews()
	local scrollParam = ListScrollParam.New()

	scrollParam.scrollGOPath = "#go_rolecontainer/#scroll_card"
	scrollParam.prefabType = ScrollEnum.ScrollPrefabFromRes
	scrollParam.prefabUrl = self._viewSetting.otherRes[1]
	scrollParam.cellClass = Season123_2_0HeroGroupEditItem
	scrollParam.scrollDir = ScrollEnum.ScrollDirV
	scrollParam.lineCount = 5
	scrollParam.cellWidth = 200
	scrollParam.cellHeight = 472
	scrollParam.cellSpaceH = 12
	scrollParam.cellSpaceV = 10
	scrollParam.startSpace = 35

	local animationDelayTimes = {}

	for i = 1, 15 do
		local delayTime = math.ceil((i - 1) % 5) * 0.03

		animationDelayTimes[i] = delayTime
	end

	return {
		Season123_2_0HeroGroupEditView.New(),
		LuaListScrollViewWithAnimator.New(Season123HeroGroupEditModel.instance, scrollParam, animationDelayTimes),
		self:getQuickEditScroll(),
		CommonRainEffectView.New("bg/#go_raincontainer"),
		TabViewGroup.New(1, "#go_btns")
	}
end

function Season123_2_0HeroGroupEditViewContainer:getQuickEditScroll()
	local scrollParam = ListScrollParam.New()

	scrollParam.scrollGOPath = "#go_rolecontainer/#scroll_quickedit"
	scrollParam.prefabType = ScrollEnum.ScrollPrefabFromRes
	scrollParam.prefabUrl = self._viewSetting.otherRes[2]
	scrollParam.cellClass = Season123_2_0HeroGroupQuickEditItem
	scrollParam.scrollDir = ScrollEnum.ScrollDirV
	scrollParam.lineCount = 5
	scrollParam.cellWidth = 200
	scrollParam.cellHeight = 472
	scrollParam.cellSpaceH = 12
	scrollParam.cellSpaceV = 10
	scrollParam.startSpace = 35

	local animationDelayTimes = {}

	for i = 1, 15 do
		local delayTime = math.ceil((i - 1) % 5) * 0.03

		animationDelayTimes[i] = delayTime
	end

	return LuaListScrollViewWithAnimator.New(Season123HeroGroupQuickEditModel.instance, scrollParam, animationDelayTimes)
end

function Season123_2_0HeroGroupEditViewContainer:buildTabViews(tabContainerId)
	self._navigateButtonView = NavigateButtonsView.New({
		true,
		true,
		false
	})

	self._navigateButtonView:setOverrideClose(self._overrideClose, self)

	return {
		self._navigateButtonView
	}
end

function Season123_2_0HeroGroupEditViewContainer:onContainerOpenFinish()
	self._navigateButtonView:resetOnCloseViewAudio(AudioEnum.HeroGroupUI.Play_UI_Team_Close)
end

function Season123_2_0HeroGroupEditViewContainer:_overrideClose()
	if ViewMgr.instance:isOpen(ViewName.CharacterLevelUpView) then
		ViewMgr.instance:closeView(ViewName.CharacterLevelUpView, nil, true)
	elseif ViewMgr.instance:isOpen(Season123Controller.instance:getHeroGroupEditViewName()) then
		ViewMgr.instance:closeView(Season123Controller.instance:getHeroGroupEditViewName(), nil, true)
	end
end

function Season123_2_0HeroGroupEditViewContainer:_setHomeBtnVisible(isVisible)
	self._navigateButtonView:setParam({
		true,
		isVisible,
		false
	})
end

return Season123_2_0HeroGroupEditViewContainer
