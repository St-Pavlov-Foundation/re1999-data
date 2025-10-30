﻿-- chunkname: @modules/logic/season/view1_3/Season1_3MainViewContainer.lua

module("modules.logic.season.view1_3.Season1_3MainViewContainer", package.seeall)

local Season1_3MainViewContainer = class("Season1_3MainViewContainer", BaseViewContainer)

function Season1_3MainViewContainer:buildViews()
	local views = {}

	self.scene = Season1_3MainScene.New()
	self.view = Season1_3MainView.New()

	table.insert(views, self.scene)
	table.insert(views, self.view)
	table.insert(views, TabViewGroup.New(1, "top_left"))

	return views
end

function Season1_3MainViewContainer:getScene()
	return self.scene
end

function Season1_3MainViewContainer:buildTabViews(tabContainerId)
	self._navigateButtonView = NavigateButtonsView.New({
		true,
		true,
		true
	}, 100, self._closeCallback, self._homeCallback, nil, self)

	self._navigateButtonView:setOverrideClose(self._overrideClose, self)
	self._navigateButtonView:setHelpId(HelpEnum.HelpId.Season1_3MainViewHelp)

	return {
		self._navigateButtonView
	}
end

function Season1_3MainViewContainer:onContainerInit()
	ActivityEnterMgr.instance:enterActivity(VersionActivity1_3Enum.ActivityId.Season)
	ActivityRpc.instance:sendActivityNewStageReadRequest({
		VersionActivity1_3Enum.ActivityId.Season
	})
	AudioMgr.instance:trigger(AudioEnum.VersionActivity1_2.play_ui_lvhu_goldcup_open)
end

function Season1_3MainViewContainer:onContainerOpenFinish()
	self._navigateButtonView:resetOnCloseViewAudio()
end

function Season1_3MainViewContainer:_closeCallback()
	return
end

function Season1_3MainViewContainer:_homeCallback()
	self:closeThis()
end

function Season1_3MainViewContainer:stopUI()
	self:setVisibleInternal(true)

	self._anim.speed = 0
	self._animRetail.speed = 0

	self.view:activeMask(true)
end

function Season1_3MainViewContainer:playUI()
	self:setVisibleInternal(true)

	self._anim.speed = 1
	self._animRetail.speed = 1

	self.view:activeMask(false)
end

function Season1_3MainViewContainer:setVisibleInternal(isVisible)
	if not self.viewGO then
		return
	end

	if not self._anim then
		self._anim = self.viewGO:GetComponent(typeof(UnityEngine.Animator))
	end

	if isVisible then
		self:_setVisible(true)
		self._anim:Play(UIAnimationName.Switch, 0, 0)

		if not self._animRetail then
			local goretail = gohelper.findChild(self.viewGO, "rightbtns/#go_retail")

			self._animRetail = goretail:GetComponent(typeof(UnityEngine.Animator))
		end

		self._animRetail:Play(UIAnimationName.Switch, 0, 0)

		if self.scene then
			self.scene:initCamera()
		end
	else
		self:_setVisible(false)
		self._anim:Play(UIAnimationName.Close)
	end
end

return Season1_3MainViewContainer
