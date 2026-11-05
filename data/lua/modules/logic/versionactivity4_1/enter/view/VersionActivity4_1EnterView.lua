-- chunkname: @modules/logic/versionactivity4_1/enter/view/VersionActivity4_1EnterView.lua

module("modules.logic.versionactivity4_1.enter.view.VersionActivity4_1EnterView", package.seeall)

local VersionActivity4_1EnterView = class("VersionActivity4_1EnterView", VersionActivityFixedEnterView)

function VersionActivity4_1EnterView:_editableInitView()
	self._scrolltab = gohelper.findChildScrollRect(self.viewGO, "#go_tabcontainer/#scroll_tab")
	self._godrag = gohelper.findChild(self.viewGO, "#go_tabcontainer/#scroll_tab/#go_drag")
	self.goArrowRedDot = gohelper.findChild(self.viewGO, "#go_tabcontainer/#scroll_tab/arrow/#go_arrowreddot")

	local rectTrViewPort = gohelper.findChildComponent(self.viewGO, "#go_tabcontainer/#scroll_tab/Viewport", gohelper.Type_RectTransform)

	self.viewPortHeight = recthelper.getHeight(rectTrViewPort)
	self.viewPortWidth = recthelper.getWidth(rectTrViewPort)
	self.rectTrContent = gohelper.findChildComponent(self.viewGO, "#go_tabcontainer/#scroll_tab/Viewport/Content", gohelper.Type_RectTransform)
	self._gotabitem1 = gohelper.findChild(self.viewGO, "#go_tabcontainer/#scroll_tab/Viewport/Content/#go_tabitem1")
	self._gotabitem2 = gohelper.findChild(self.viewGO, "#go_tabcontainer/#scroll_tab/Viewport/Content/#go_tabitem2")
	self._goline = gohelper.findChild(self.viewGO, "#go_tabcontainer/#scroll_tab/Viewport/Content/#go_line")

	self:setTabLevelSetting(VersionActivityEnterViewEnum.ActLevel.First, self._gotabitem1, VersionActivity4_1EnterViewTabItem1)
	self:setTabLevelSetting(VersionActivityEnterViewEnum.ActLevel.Second, self._gotabitem2, VersionActivity4_1EnterViewTabItem2)

	self._btnreplay = gohelper.findChildButtonWithAudio(self.viewGO, "entrance/#btn_replay")
	self._btnachievementnormal = gohelper.findChildButtonWithAudio(self.viewGO, "entrance/#btn_achievement_normal")
	self._btnachievementpreview = gohelper.findChildButtonWithAudio(self.viewGO, "entrance/#btn_achievementpreview")
	self.goReplayBtn = self._btnreplay.gameObject
	self.goAchievementBtn = self._btnachievementpreview.gameObject

	gohelper.setActive(self._btnachievementnormal.gameObject, false)

	self.viewAnim = self.viewGO:GetComponent(gohelper.Type_Animator)
	self.gosubviewCanvasGroup = gohelper.findChildComponent(self.viewGO, "#go_subview", gohelper.Type_CanvasGroup)

	gohelper.setActive(self._goActivityLine, false)

	self._drag = SLFramework.UGUI.UIDragListener.Get(self._scrolltab.gameObject)
end

function VersionActivity4_1EnterView:childAddEvents()
	VersionActivity4_1EnterView.super.childAddEvents(self)

	if self._drag then
		self._drag:AddDragBeginListener(self._onBeginDrag, self)
		self._drag:AddDragEndListener(self._onEndDrag, self)
	end
end

function VersionActivity4_1EnterView:childRemoveEvents()
	VersionActivity4_1EnterView.super.childRemoveEvents(self)

	if self._drag then
		self._drag:RemoveDragBeginListener()
		self._drag:RemoveDragEndListener()
	end
end

function VersionActivity4_1EnterView:_onBeginDrag(data, pointerEventData)
	for _, tabSetting in ipairs(self.tabLevelSetting) do
		local cls = tabSetting.cls

		if cls then
			cls:setDrag(true)
		end
	end
end

function VersionActivity4_1EnterView:_onEndDrag(data, pointerEventData)
	for _, tabSetting in ipairs(self.tabLevelSetting) do
		local cls = tabSetting.cls

		if cls then
			cls:setDrag(false)
		end
	end
end

function VersionActivity4_1EnterView:onOpen()
	for _, tabSetting in ipairs(self.tabLevelSetting) do
		local go = tabSetting.go

		gohelper.setActive(go, false)
	end

	gohelper.setActive(self._goActivityLine, false)
	self:initViewParam()
	self:createActivityTabItem()
	self:playVideo()
	self:refreshUI()
	self:refreshRedDot()
	self:refreshBtnVisible(true)
	self:_initPositioningTab()
end

function VersionActivity4_1EnterView:onClose()
	VersionActivity4_1EnterView.super.onClose(self)

	if self._audioId then
		AudioMgr.instance:stopPlayingID(self._audioId)
	end
end

function VersionActivity4_1EnterView:playVideo()
	TaskDispatcher.cancelTask(self._playOpen1Anim, self)

	if self.viewParam.jumpActId and self.viewParam.jumpActId ~= VersionActivity4_1Enum.ActivityId.Dungeon then
		return
	end

	if self.viewParam.isExitFight then
		return
	end

	if self.viewParam and self.viewParam.playVideo then
		self.viewAnim:Play("open1", 0, 0)

		self.viewAnim.speed = 0
		self.gosubviewCanvasGroup.alpha = 0

		local isCanSkip = GameUtil.playerPrefsGetNumberByUserId(VersionActivity4_1Enum.EnterVideoFirstKey, 0) ~= 0

		if not isCanSkip then
			GameUtil.playerPrefsSetNumberByUserId(VersionActivity4_1Enum.EnterVideoFirstKey, 1)
		end

		VideoController.instance:openFullScreenVideoView(VersionActivity4_1Enum.EnterAnimVideoName, nil, VersionActivity4_1Enum.KV_VIDEO_DURATION, nil, nil, {
			couldSkip = isCanSkip
		})
		TimeUtil.setDayFirstLoginRed(VersionActivity4_1Enum.EnterVideoDayKey)
		self:addEventCb(VideoController.instance, VideoEvent.OnVideoPlayFinished, self.onPlayVideoDone, self)
		self:addEventCb(VideoController.instance, VideoEvent.OnVideoPlayOverTime, self.onPlayVideoDone, self)
		self:addEventCb(VideoController.instance, VideoEvent.OnVideoStarted, self._delayPlayOpen1Anim, self)
	else
		self.viewAnim.speed = 1

		self:_playOpenAnim()
	end
end

function VersionActivity4_1EnterView:onPlayVideoDone()
	self:removeEventCb(VideoController.instance, VideoEvent.OnVideoPlayFinished, self.onPlayVideoDone, self)
	self:removeEventCb(VideoController.instance, VideoEvent.OnVideoPlayOverTime, self.onPlayVideoDone, self)
	AudioMgr.instance:trigger(AudioEnum4_1.EnterView.stop_ui_atlantis_4_1_kv_open)

	self.gosubviewCanvasGroup.alpha = 1

	if self.viewAnim.speed == 1 then
		return
	end

	self:_playOpen1Anim()
end

function VersionActivity4_1EnterView:_delayPlayOpen1Anim()
	if self.viewAnim.speed == 1 then
		return
	end

	TaskDispatcher.runDelay(self._playOpen1Anim, self, VersionActivity4_1Enum.OpenAnimDelayTime)
	self:removeEventCb(VideoController.instance, VideoEvent.OnVideoStarted, self._delayPlayOpen1Anim, self)
end

function VersionActivity4_1EnterView:_playOpen1Anim()
	TaskDispatcher.cancelTask(self._playOpen1Anim, self)

	self.gosubviewCanvasGroup.alpha = 1
	self.viewAnim.speed = 1

	self:_playOpenAnim("open1")
end

function VersionActivity4_1EnterView:_playOpenAnim(animName)
	if not string.nilorempty(animName) then
		self.viewAnim:Play(animName, 0, 0)
	else
		self.viewAnim:Play(UIAnimationName.Open, 0, 0)
		self.viewContainer:markPlayedSubViewAnim()
	end
end

function VersionActivity4_1EnterView:onDestroyView()
	VersionActivity4_1EnterView.super.onDestroyView(self)
	TaskDispatcher.cancelTask(self._playOpen1Anim, self)
	AudioMgr.instance:trigger(AudioEnum4_1.EnterView.stop_ui_atlantis_4_1_kv_open)

	if ViewMgr.instance:isOpen(ViewName.FullScreenVideoView) then
		self:removeEventCb(VideoController.instance, VideoEvent.OnVideoStarted, self._delayPlayOpen1Anim, self)
		self:removeEventCb(VideoController.instance, VideoEvent.OnVideoPlayFinished, self.onPlayVideoDone, self)
		self:removeEventCb(VideoController.instance, VideoEvent.OnVideoPlayOverTime, self.onPlayVideoDone, self)
	end
end

return VersionActivity4_1EnterView
