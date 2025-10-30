﻿-- chunkname: @modules/versionactivitybase/fixed/dungeon/view/map/VersionActivityFixedDungeonMapViewContainer.lua

module("modules.versionactivitybase.fixed.dungeon.view.map.VersionActivityFixedDungeonMapViewContainer", package.seeall)

local VersionActivityFixedDungeonMapViewContainer = class("VersionActivityFixedDungeonMapViewContainer", BaseViewContainer)

function VersionActivityFixedDungeonMapViewContainer:buildViews()
	self._bigVersion, self._smallVersion = VersionActivityFixedDungeonController.instance:getEnterVerison()
	self.mapScene = VersionActivityFixedHelper.getVersionActivityDungeonMapScene(self._bigVersion, self._smallVersion).New()
	self.mapSceneElements = VersionActivityFixedHelper.getVersionActivityDungeonMapSceneElements(self._bigVersion, self._smallVersion).New()
	self.mapView = VersionActivityFixedHelper.getVersionActivityDungeonMapView(self._bigVersion, self._smallVersion).New()
	self.mapEpisodeView = VersionActivityFixedHelper.getVersionActivityDungeonMapEpisodeView(self._bigVersion, self._smallVersion).New()
	self.interactView = VersionActivityFixedHelper.getVersionActivityDungeonMapInteractView(self._bigVersion, self._smallVersion).New()
	self.mapElementReward = self:getDungeonMapElementReward()
	self.dungeonMapHoleView = VersionActivityFixedHelper.getVersionActivityDungeonMapHoleView(self._bigVersion, self._smallVersion).New()

	local views = {
		self.dungeonMapHoleView,
		self.mapScene,
		self.mapSceneElements,
		self.mapView,
		self.mapEpisodeView,
		self.interactView,
		self.mapElementReward,
		TabViewGroup.New(1, "#go_topleft")
	}

	return views
end

function VersionActivityFixedDungeonMapViewContainer:getDungeonMapHoleView()
	return self.dungeonMapHoleView
end

function VersionActivityFixedDungeonMapViewContainer:getDungeonMapElementReward()
	return DungeonMapElementReward.New()
end

function VersionActivityFixedDungeonMapViewContainer:buildTabViews(tabContainerId)
	self.navigateView = NavigateButtonsView.New({
		true,
		true,
		false
	})

	self.navigateView:setOverrideClose(self.onClickClose, self)
	self.navigateView:setOverrideHome(self.onClickHome, self)

	return {
		self.navigateView
	}
end

function VersionActivityFixedDungeonMapViewContainer:onClickClose()
	local isShowInteractView = VersionActivityFixedDungeonModel.instance:checkIsShowInteractView()

	if isShowInteractView then
		return
	end

	self:closeThis()
end

function VersionActivityFixedDungeonMapViewContainer:onClickHome()
	local isShowInteractView = VersionActivityFixedDungeonModel.instance:checkIsShowInteractView()

	if isShowInteractView then
		return
	end

	NavigateButtonsView.homeClick()
end

function VersionActivityFixedDungeonMapViewContainer:onContainerInit()
	self.versionActivityDungeonBaseMo = VersionActivityFixedDungeonMo.New()

	self.versionActivityDungeonBaseMo:init(VersionActivityFixedHelper.getVersionActivityEnum(self._bigVersion, self._smallVersion).ActivityId.Dungeon, self.viewParam.chapterId, self.viewParam.episodeId)
	self.versionActivityDungeonBaseMo:setLayoutClass(VersionActivityFixedHelper.getVersionActivityDungeonMapChapterLayout(self._bigVersion, self._smallVersion))
	self.versionActivityDungeonBaseMo:setMapEpisodeItemClass(VersionActivityFixedHelper.getVersionActivityDungeonMapEpisodeItem(self._bigVersion, self._smallVersion))

	for _, view in ipairs(self._views) do
		view.activityDungeonMo = self.versionActivityDungeonBaseMo
	end

	VersionActivityFixedDungeonModel.instance:setDungeonBaseMo(self.versionActivityDungeonBaseMo)
	self.mapElementReward:setShowToastState(true)
end

function VersionActivityFixedDungeonMapViewContainer:onUpdateParamInternal(viewParam)
	self.viewParam = viewParam

	self:onContainerUpdateParam()
	self:_setVisible(true)

	if self._views then
		for _, item in ipairs(self._views) do
			item.viewParam = viewParam

			item:onUpdateParamInternal()
		end
	end
end

function VersionActivityFixedDungeonMapViewContainer:onContainerUpdateParam()
	self.versionActivityDungeonBaseMo:update(self.viewParam.chapterId, self.viewParam.episodeId)
	self:setVisibleInternal(true)
end

function VersionActivityFixedDungeonMapViewContainer:setVisibleInternal(isVisible)
	VersionActivityFixedDungeonMapViewContainer.super.setVisibleInternal(self, isVisible)

	if self.mapScene then
		self.mapScene:setVisible(isVisible)
	end
end

function VersionActivityFixedDungeonMapViewContainer:onContainerClose()
	TaskDispatcher.cancelTask(self.everySecondCall, self)
end

function VersionActivityFixedDungeonMapViewContainer:getMapScene()
	return self.mapScene
end

return VersionActivityFixedDungeonMapViewContainer
