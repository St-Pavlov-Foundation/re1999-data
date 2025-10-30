﻿-- chunkname: @modules/logic/versionactivity3_2/dungeon/view/map/VersionActivity3_2DungeonMapControlView.lua

module("modules.logic.versionactivity3_2.dungeon.view.map.VersionActivity3_2DungeonMapControlView", package.seeall)

local VersionActivity3_2DungeonMapControlView = class("VersionActivity3_2DungeonMapControlView", BaseView)

function VersionActivity3_2DungeonMapControlView:onInitView()
	self._gotopleft = gohelper.findChild(self.viewGO, "#go_topleft")
	self._imagenormalmask = gohelper.findChildImage(self.viewGO, "#simage_normalmask")
	self._rootAnimator = self.viewGO:GetComponent("Animator")
	self._goScrollContent = gohelper.findChild(self.viewGO, "#scroll_content")
	self._scrollCanvasGroup = self._goScrollContent:GetComponent(typeof(UnityEngine.CanvasGroup))
	self._goMapEpisodeList = gohelper.findChild(self.viewGO, "mapEpisodeList")
	self._btnhide = gohelper.findChildButtonWithAudio(self.viewGO, "#btn_hide")
	self._btnlist = gohelper.findChildButtonWithAudio(self.viewGO, "#btn_list", AudioEnum3_2.VersionActivity3_2.ui_mln_day_night)
	self._btnlistIcon = gohelper.findChild(self.viewGO, "#btn_list/icon")
	self._goTitle = gohelper.findChild(self.viewGO, "title")
	self._txtTime = gohelper.findChildText(self.viewGO, "title/#txt_time")
	self._txtPlace = gohelper.findChildText(self.viewGO, "title/#txt_place")
	self._goScrollTask = gohelper.findChild(self.viewGO, "#scroll_task")

	gohelper.setActive(self._goScrollTask, true)

	self._goScrollTaskViewport = gohelper.findChild(self.viewGO, "#scroll_task/Viewport")
	self._touchMgr = TouchEventMgrHepler.getTouchEventMgr(self.viewGO)

	self._touchMgr:SetIgnoreUI(true)
	self._touchMgr:SetOnlyTouch(true)
	self._touchMgr:SetOnClickCb(self._onTouchDown, self)

	self._touchFrame = Time.frameCount

	self:addEventCb(DungeonController.instance, DungeonMapElementEvent.OnLoadSceneFinish, self.loadSceneFinish, self, LuaEventSystem.Low)
	self:addEventCb(ViewMgr.instance, ViewEvent.OnOpenView, self.onOpenViewCallBack, self)
	self:addEventCb(ViewMgr.instance, ViewEvent.OnCloseView, self.onCloseViewCallBack, self, LuaEventSystem.High)
	self:addEventCb(ViewMgr.instance, ViewEvent.OnCloseViewFinish, self.OnCloseViewFinishCallBack, self)
	self:addEventCb(VersionActivityDungeonBaseController.instance, VersionActivityDungeonEvent.OnActivityDungeonMoChange, self.onActivityDungeonMoChange, self)
	self:addEventCb(VersionActivityFixedDungeonController.instance, VersionActivityFixedDungeonEvent.OnClickElement, self.onClickElement, self)
	self:addEventCb(VersionActivityFixedDungeonController.instance, VersionActivityFixedDungeonEvent.OnHideInteractUI, self.showBtnUI, self)
end

function VersionActivity3_2DungeonMapControlView:onClickElement()
	self:_setSomeViewVisible(false)

	if not self._showTimeline then
		gohelper.setActive(self._goMapEpisodeList, false)
	end
end

function VersionActivity3_2DungeonMapControlView:showBtnUI()
	self:_setSomeViewVisible(true)
	self:_updateTimeline()
end

function VersionActivity3_2DungeonMapControlView:addEvents()
	self._btnlist:AddClickListener(self._btnlistOnClick, self)
	self._btnhide:AddClickListener(self._btnhideOnClick, self)
end

function VersionActivity3_2DungeonMapControlView:removeEvents()
	self._btnlist:RemoveClickListener()
	self._btnhide:RemoveClickListener()
end

function VersionActivity3_2DungeonMapControlView:_btnlistOnClick()
	self._showTimeline = not self._showTimeline

	transformhelper.setLocalRotation(self._btnlistIcon.transform, 0, 0, self._showTimeline and 0 or 180)

	if self._showTimeline then
		self._rootAnimator:Play("content")
	else
		self._rootAnimator:Play("mapepisodelist")
	end

	self:_updateTimeline()
end

local normalCameraSize = 5
local zoomInCameraSize = 10
local tweenTime = 0.46
local fastTweenTime = 0.25

function VersionActivity3_2DungeonMapControlView:_updateMask(showMapEpisodeList)
	local showMapLevel = ViewMgr.instance:isOpen(ViewName.VersionActivity3_2DungeonMapLevelView)
	local showNormalMask = not showMapEpisodeList and not showMapLevel
	local oldShowNormalMask = self._showNormalMask

	self._showNormalMask = showNormalMask

	if showNormalMask and oldShowNormalMask == false then
		ZProj.TweenHelper.DoFade(self._imagenormalmask, 0, 1, tweenTime)
	elseif not showNormalMask and oldShowNormalMask == true then
		ZProj.TweenHelper.DoFade(self._imagenormalmask, 1, 0, tweenTime)
	end

	self._scrollCanvasGroup.blocksRaycasts = showNormalMask
end

function VersionActivity3_2DungeonMapControlView:_updateTimeline(isOpenMapLevelView)
	local showMapEpisodeList = not self._showTimeline and not isOpenMapLevelView

	gohelper.setActive(self._goMapEpisodeList, showMapEpisodeList)

	VersionActivity3_2DungeonEnum.DungeonMapCameraSize = showMapEpisodeList and zoomInCameraSize or normalCameraSize

	self:_tweenCameraSize()
	self:_updateMask(showMapEpisodeList)

	self._showMask = not showMapEpisodeList

	self.viewContainer:getDungeonMapHoleView():setMaskVisible(self._showMask)
	VersionActivityFixedDungeonController.instance:dispatchEvent(VersionActivity3_2DungeonEvent.V3a2TimelineChange, showMapEpisodeList)
end

function VersionActivity3_2DungeonMapControlView:_tweenCameraSize()
	self:killTween()

	local camera = CameraMgr.instance:getMainCamera()
	local scale = GameUtil.getAdapterScale()
	local currentCameraSize = camera.orthographicSize
	local targetCameraSize = VersionActivity3_2DungeonEnum.DungeonMapCameraSize * scale

	if currentCameraSize == targetCameraSize then
		return
	end

	local time = tweenTime

	if ViewMgr.instance:isOpen(ViewName.VersionActivity3_2DungeonMapLevelView) then
		time = fastTweenTime
	end

	self.tweenId = ZProj.TweenHelper.DOTweenFloat(currentCameraSize, targetCameraSize, time, self.tweenFrameCallback, self.tweenFinishCallback, self)
end

function VersionActivity3_2DungeonMapControlView:tweenFrameCallback(value)
	local camera = CameraMgr.instance:getMainCamera()

	camera.orthographicSize = value

	VersionActivityFixedDungeonController.instance:dispatchEvent(VersionActivity3_2DungeonEvent.V3a2CameraSizeChange)
end

function VersionActivity3_2DungeonMapControlView:tweenFinishCallback()
	MainCameraMgr.instance:setLock(false)

	local gameScreenState = GameGlobalMgr.instance:getScreenState()
	local width, height = gameScreenState:getScreenSize()

	GameGlobalMgr.instance:dispatchEvent(GameStateEvent.OnScreenResize, width, height)
	VersionActivityFixedDungeonController.instance:dispatchEvent(VersionActivity3_2DungeonEvent.V3a2CameraSizeChangeFinish)
end

function VersionActivity3_2DungeonMapControlView:killTween()
	if self.tweenId then
		ZProj.TweenHelper.KillById(self.tweenId)

		self.tweenId = nil
	end
end

function VersionActivity3_2DungeonMapControlView:_onTouchDown()
	if Time.frameCount - self._touchFrame < 2 then
		return
	end

	if self._showAllView then
		return
	end

	self:_btnhideOnClick()
end

function VersionActivity3_2DungeonMapControlView:_btnhideOnClick()
	self._touchFrame = Time.frameCount
	self._showAllView = not self._showAllView

	if self._showAllView then
		self._rootAnimator:Play(self._showTimeline and "open" or "open_map")
		VersionActivity3_2DungeonLogicController.instance:setDragFrameEnd()
	else
		self._rootAnimator:Play(self._showTimeline and "close" or "mapepisodelist_close")
		VersionActivity3_2DungeonLogicController.instance:setDragFrameBegin()
	end

	gohelper.setActive(self._gotopleft, self._showAllView)
end

function VersionActivity3_2DungeonMapControlView:onOpenViewCallBack(viewName)
	if viewName == ViewName.VersionActivity3_2DungeonMapLevelView then
		self:_updateTimeline(true)
		self:_setSomeViewVisible(false)

		local elementRoot = gohelper.findChild(self._mapSceneGo, "elementRoot")

		transformhelper.setLocalPos(elementRoot.transform, 0, 0, 1000)
	end
end

function VersionActivity3_2DungeonMapControlView:onCloseViewCallBack(viewName)
	if viewName == ViewName.VersionActivity3_2DungeonMapLevelView then
		MainCameraMgr.instance:setLock(true)
	end
end

function VersionActivity3_2DungeonMapControlView:OnCloseViewFinishCallBack(viewName)
	if viewName == ViewName.VersionActivity3_2DungeonMapLevelView then
		self:_updateTimeline(false)
		self:_setSomeViewVisible(true)

		local elementRoot = gohelper.findChild(self._mapSceneGo, "elementRoot")

		if elementRoot then
			transformhelper.setLocalPos(elementRoot.transform, 0, 0, 0)
		end
	end
end

function VersionActivity3_2DungeonMapControlView:_setSomeViewVisible(show)
	return
end

function VersionActivity3_2DungeonMapControlView:loadSceneFinish(param)
	self._mapSceneGo = param.mapSceneGo

	self:_updateMapInfo()

	if self._showMask ~= nil then
		self.viewContainer:getDungeonMapHoleView():setMaskVisible(self._showMask)
	end

	TaskDispatcher.cancelTask(self._delayUpdateEpisodeSceneItemPos, self)
	TaskDispatcher.runDelay(self._delayUpdateEpisodeSceneItemPos, self, 0.1)
end

function VersionActivity3_2DungeonMapControlView:_delayUpdateEpisodeSceneItemPos()
	VersionActivityFixedDungeonController.instance:dispatchEvent(VersionActivity3_2DungeonEvent.V3a2CameraSizeChange)
end

function VersionActivity3_2DungeonMapControlView:onActivityDungeonMoChange()
	self:_updateMapInfo()
end

function VersionActivity3_2DungeonMapControlView:_updateMapInfo()
	local episodeId = self.activityDungeonMo.episodeId
	local mapCfg = VersionActivityFixedDungeonConfig.instance:getEpisodeMapConfig(episodeId)

	self._txtTime.text = mapCfg.desc

	local extraConfig = lua_v3a2_chapter_map.configDict[episodeId]

	extraConfig = extraConfig or lua_v3a2_chapter_map.configDict[episodeId - 10000]
	self._txtPlace.text = extraConfig and extraConfig.locationDesc
end

function VersionActivity3_2DungeonMapControlView:onOpen()
	self._showAllView = true
	self._showTimeline = true

	self:_updateTimeline()
end

function VersionActivity3_2DungeonMapControlView:showTimeline()
	return self._showTimeline
end

function VersionActivity3_2DungeonMapControlView:onClose()
	if self._touchMgr then
		TouchEventMgrHepler.remove(self._touchMgr)

		self._touchMgr = nil
	end

	MainCameraMgr.instance:setLock(false)
	self:killTween()
	TaskDispatcher.cancelTask(self._delayUpdateEpisodeSceneItemPos, self)
end

return VersionActivity3_2DungeonMapControlView
