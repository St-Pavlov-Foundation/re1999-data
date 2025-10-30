﻿-- chunkname: @modules/logic/story/view/StoryFrontView.lua

module("modules.logic.story.view.StoryFrontView", package.seeall)

local StoryFrontView = class("StoryFrontView", BaseView)

function StoryFrontView:onInitView()
	self._gobtns = gohelper.findChild(self.viewGO, "#go_btns")
	self._gobtnleft = gohelper.findChild(self.viewGO, "#go_btns/#go_btnleft")
	self._btnlog = gohelper.findChildButtonWithAudio(self.viewGO, "#go_btns/#go_btnleft/#btn_log")
	self._btnhide = gohelper.findChildButtonWithAudio(self.viewGO, "#go_btns/#go_btnleft/#btn_hide")
	self._gobtnright = gohelper.findChild(self.viewGO, "#go_btns/#go_btnright")
	self._btnauto = gohelper.findChildButtonWithAudio(self._gobtnright, "#btn_auto")
	self._txtauto = gohelper.findChildTextMesh(self._gobtnright, "#btn_auto/txt_Auto")
	self._imageautooff = gohelper.findChildImage(self._gobtnright, "#btn_auto/#image_autooff")
	self._imageautoon = gohelper.findChildImage(self._gobtnright, "#btn_auto/#image_autoon")
	self._btnskip = gohelper.findChildButtonWithAudio(self._gobtnright, "#btn_skip")
	self._objskip = self._btnskip.gameObject
	self._txtskip = gohelper.findChildTextMesh(self._gobtnright, "#btn_skip/txt_skip")
	self._imageskip = gohelper.findChildImage(self._gobtnright, "#btn_skip/#image_skip")
	self._gopvpause = gohelper.findChild(self.viewGO, "#go_pvpause")
	self._pvpauseAnim = self._gopvpause:GetComponent(gohelper.Type_Animator)
	self._btnpause = gohelper.findChildButtonWithAudio(self.viewGO, "#go_pvpause/#btn_Pause")
	self._btnplay = gohelper.findChildButtonWithAudio(self.viewGO, "#go_pvpause/#btn_Play")
	self._goexit = gohelper.findChild(self.viewGO, "#btn_exit")
	self._txtexit = gohelper.findChildTextMesh(self.viewGO, "#btn_exit/txt_exit")
	self._imageexit = gohelper.findChildImage(self.viewGO, "#btn_exit/#image_exit")
	self._goshadow = gohelper.findChild(self.viewGO, "#go_shadow")
	self._gofront = gohelper.findChild(self.viewGO, "#go_front")
	self._goblock = gohelper.findChild(self.viewGO, "#go_front/#go_block")
	self._gonavigate = gohelper.findChild(self.viewGO, "#go_navigate")
	self._goepisode = gohelper.findChild(self.viewGO, "#go_navigate/#go_episode")
	self._gochapteropen = gohelper.findChild(self.viewGO, "#go_navigate/#go_chapter/#go_open")
	self._gochapterclose = gohelper.findChild(self.viewGO, "#go_navigate/#go_chapter/#go_close")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function StoryFrontView:addEvents()
	self._btnlog:AddClickListener(self._btnlogOnClick, self)
	self._btnhide:AddClickListener(self._btnhideOnClick, self)
	self._btnauto:AddClickListener(self._btnautoOnClick, self)
	self._btnskip:AddClickListener(self._btnskipOnClick, self)
	self._btnpause:AddClickListener(self._btnpauseOnClick, self)
	self._btnplay:AddClickListener(self._btnplayOnClick, self)
	self:addEventCb(PCInputController.instance, PCInputEvent.NotifyStoryDialogAuto, self._btnautoOnClick, self)
	self:addEventCb(PCInputController.instance, PCInputEvent.NotifyStoryDialogSkip, self._btnskipOnClick, self)
	self:addEventCb(PCInputController.instance, PCInputEvent.NotifyStoryDialogExit, self._onKeyExit, self)
end

function StoryFrontView:removeEvents()
	self._btnlog:RemoveClickListener()
	self._btnhide:RemoveClickListener()
	self._btnauto:RemoveClickListener()
	self._btnskip:RemoveClickListener()
	self._btnpause:RemoveClickListener()
	self._btnplay:RemoveClickListener()
	self:removeEventCb(PCInputController.instance, PCInputEvent.NotifyStoryDialogAuto, self._btnautoOnClick, self)
	self:removeEventCb(PCInputController.instance, PCInputEvent.NotifyStoryDialogSkip, self._btnskipOnClick, self)
	self:removeEventCb(PCInputController.instance, PCInputEvent.NotifyStoryDialogExit, self._onKeyExit, self)
end

function StoryFrontView:_btnpauseOnClick()
	TaskDispatcher.cancelTask(self._playFinished, self)
	UIBlockMgr.instance:endBlock("PlayPv")
	StoryModel.instance:setStoryPvPause(true)
	gohelper.setActive(self._gopvpause, true)
	gohelper.setActive(self._objskip, true)
	self._pvpauseAnim:Play("pause", 0, 0)
	UIBlockMgr.instance:startBlock("waitPause")
	TaskDispatcher.runDelay(self._realPause, self, 0.5)
end

function StoryFrontView:_realPause()
	UIBlockMgr.instance:endBlock("waitPause")
	AudioMgr.instance:trigger(AudioEnum.Story.pause_cg_bus)
	StoryController.instance:dispatchEvent(StoryEvent.PvPause)
	GameTimeMgr.instance:setTimeScale(GameTimeMgr.TimeScaleType.StoryPv, 0)
end

function StoryFrontView:_btnplayOnClick()
	UIBlockMgr.instance:endBlock("waitPause")
	TaskDispatcher.cancelTask(self._realPause, self)
	StoryModel.instance:setStoryPvPause(false)
	gohelper.setActive(self._gopvpause, true)
	AudioMgr.instance:trigger(AudioEnum.Story.resume_cg_bus)
	StoryController.instance:dispatchEvent(StoryEvent.PvPlay)
	GameTimeMgr.instance:setTimeScale(GameTimeMgr.TimeScaleType.StoryPv, 1)
	UIBlockMgr.instance:startBlock("PlayPv")
	self._pvpauseAnim:Play("play", 0, 0)
	TaskDispatcher.runDelay(self._playFinished, self, 0.5)
end

function StoryFrontView:_playFinished()
	UIBlockMgr.instance:endBlock("PlayPv")
	gohelper.setActive(self._gopvpause, false)
end

function StoryFrontView:_checkPvPlayRestart()
	local pvPause = StoryModel.instance:isStoryPvPause()

	if pvPause then
		StoryModel.instance:setStoryPvPause(false)
		AudioMgr.instance:trigger(AudioEnum.Story.resume_cg_bus)
		StoryController.instance:dispatchEvent(StoryEvent.PvPlay)
		GameTimeMgr.instance:setTimeScale(GameTimeMgr.TimeScaleType.StoryPv, 1)
	end
end

function StoryFrontView:_btnlogOnClick()
	if ViewMgr.instance:isOpen(ViewName.MessageBoxView) then
		return
	end

	AudioMgr.instance:trigger(AudioEnum.UI.play_ui_plot_common)
	StoryModel.instance:setStoryAuto(false)
	StoryController.instance:dispatchEvent(StoryEvent.Log)
end

function StoryFrontView:_onKeyExit()
	if ViewMgr.instance:isOpen(ViewName.MessageBoxView) then
		return
	end

	if self._exitBtn and self._goexit.activeInHierarchy then
		StoryController.instance:dispatchEvent(StoryEvent.SkipClick)
		self._exitBtn:onClickExitBtn()
	end
end

function StoryFrontView:_btnhideOnClick()
	if ViewMgr.instance:isOpen(ViewName.MessageBoxView) then
		return
	end

	AudioMgr.instance:trigger(AudioEnum.UI.play_ui_plot_common)

	if StoryModel.instance:isStoryAuto() then
		return
	end

	StoryModel.instance:setViewHide(true)
	self:setBtnVisible(false)
	StoryController.instance:dispatchEvent(StoryEvent.Hide)

	if self._exitBtn then
		self._exitBtn:setActive(false)
	end
end

function StoryFrontView:_btnautoOnClick()
	if ViewMgr.instance:isOpen(ViewName.MessageBoxView) then
		return
	end

	if not self._stepCo then
		return
	end

	AudioMgr.instance:trigger(AudioEnum.UI.play_ui_plot_common)

	local isLimitNoInteractLock = StoryModel.instance:isLimitNoInteractLock(self._stepCo)

	if self._stepCo.conversation.type ~= StoryEnum.ConversationType.None and self._stepCo.conversation.type ~= StoryEnum.ConversationType.NoInteract and self._stepCo.conversation.type ~= StoryEnum.ConversationType.ScreenDialog and self._stepCo.conversation.type ~= StoryEnum.ConversationType.IrregularShake and not isLimitNoInteractLock then
		StoryModel.instance:enableClick(true)
	end

	if not StoryModel.instance:isNormalStep() then
		return
	end

	local auto = StoryModel.instance:isStoryAuto()

	auto = not auto

	StoryModel.instance:setStoryAuto(auto)
	StoryController.instance:dispatchEvent(StoryEvent.Auto)
end

function StoryFrontView:_onEscapeBtnClick()
	if self._objskip.activeInHierarchy and not self._goblock.gameObject.activeInHierarchy then
		self:_btnskipOnClick()
	end
end

function StoryFrontView:_btnskipOnClick()
	self:_checkPvPlayRestart()

	if ViewMgr.instance:isOpen(ViewName.MessageBoxView) then
		return
	end

	StoryController.instance:dispatchEvent(StoryEvent.SkipClick)
	AudioMgr.instance:trigger(AudioEnum.UI.play_ui_plot_common)
	StoryModel.instance:setStoryAuto(false)

	if not OpenModel.instance:isFunctionUnlock(OpenEnum.UnlockFunc.StorySkip) and not isDebugBuild and not StoryModel.instance:isReplay() then
		GameFacade.showToast(OpenModel.instance:getFuncUnlockDesc(OpenEnum.UnlockFunc.StorySkip))

		return
	end

	if not StoryModel.instance:isReplay() then
		local storyId = StoryModel.instance:getCurStoryId()
		local stepId = StoryModel.instance:getCurStepId()
		local isPrologueSkip, txt = StoryModel.instance:isPrologueSkipAndGetTxt(storyId, stepId)

		if isPrologueSkip then
			GameFacade.showMessageBox(MessageBoxIdDefine.StorySkipConfirm, MsgBoxEnum.BoxType.Yes_No, function()
				gohelper.setActive(self._gobtns, false)

				local data = {}

				data.content = txt

				StoryController.instance:openStoryPrologueSkipView(data)
			end, nil)

			return
		end
	end

	local messegeId = StoryController.instance:getSkipMessageId()

	GameFacade.showMessageBox(messegeId, MsgBoxEnum.BoxType.Yes_No, function()
		self:_onSkipConfirm()
	end, nil)
end

function StoryFrontView:_onPrologueSkip()
	gohelper.setActive(self._gobtns, true)

	local storyId = StoryModel.instance:getCurStoryId()

	StoryModel.instance:setPrologueSkipId(storyId)
	self:_onSkipConfirm()
end

function StoryFrontView:_onSkipConfirm()
	gohelper.setActive(self._goepisode, false)
	gohelper.setActive(self._gochapteropen, false)
	StoryController.instance:dispatchEvent(StoryEvent.Skip)
end

function StoryFrontView:_btnnextOnClick()
	if StoryModel.instance:isPlayFinished() then
		if StoryModel.instance:isVersionActivityPV() then
			GameTimeMgr.instance:setTimeScale(GameTimeMgr.TimeScaleType.StoryPv, 1)
		end

		return
	end

	self:closeHideSkipTask()

	if self._exitBtn then
		self._exitBtn:onClickNext()
	end

	gohelper.setActive(self._gopvpause, false)

	if StoryModel.instance:isVersionActivityPV() then
		if self._frontItem then
			self._frontItem:enableFrontRayCast(false)
		end

		local pvPause = StoryModel.instance:isStoryPvPause()

		if not pvPause then
			self:_btnpauseOnClick()
		else
			self:_btnplayOnClick()
		end

		self:startHideSkipTask()

		if not self._objskip.activeInHierarchy then
			gohelper.setActive(self._objskip, true)
		end

		return
	end

	local autoSkip = false

	if StoryModel.instance:isStoryAuto() then
		autoSkip = true

		StoryModel.instance:setStoryAuto(false)
		StoryModel.instance:setTextShowing(false)

		return
	end

	if not StoryModel.instance:isEnableClick() then
		return
	end

	if StoryModel.instance:isViewHide() then
		self:setBtnVisible(true)
	end

	if not autoSkip then
		StoryController.instance:dispatchEvent(StoryEvent.EnterNextStep)
	end
end

function StoryFrontView:_editableInitView()
	self._btnnext = gohelper.findChildButton(self.viewGO, "btn_next")
	self._imagehide = gohelper.findChildImage(self.viewGO, "#go_btns/#go_btnleft/#btn_hide/icon")

	gohelper.setActive(self._imageautooff.gameObject, true)
	gohelper.setActive(self._imageautoon.gameObject, false)

	if not self._frontItem then
		self._frontItem = StoryFrontItem.New()

		self._frontItem:init(self._gofront)
	end

	if not self._exitBtn then
		self._exitBtn = StoryExitBtn.New(self._goexit, self.resetRightBtnPos, self)
	end
end

function StoryFrontView:onUpdateParam()
	return
end

function StoryFrontView:onOpen()
	self._btnnext:AddClickListener(self._btnnextOnClick, self)
	self:addEventCb(StoryController.instance, StoryEvent.Skip, self._onSkip, self)
	self:addEventCb(StoryController.instance, StoryEvent.AutoChange, self._onAutoChange, self)
	self:addEventCb(StoryController.instance, StoryEvent.ReOpenStoryView, self._reOpenStory, self)
	self:addEventCb(StoryController.instance, StoryEvent.AllStepFinished, self._screenFadeOut, self)
	self:addEventCb(StoryController.instance, StoryEvent.RefreshStep, self._onUpdateUI, self)
	self:addEventCb(StoryController.instance, StoryEvent.SetFullText, self._onSetFullText, self)
	self:addEventCb(StoryController.instance, StoryEvent.PlayFullText, self._onPlayFullText, self)
	self:addEventCb(StoryController.instance, StoryEvent.PlayIrregularShakeText, self._onPlayIrregularShakeText, self)
	self:addEventCb(StoryController.instance, StoryEvent.PlayFullTextOut, self._onPlayFullTextOut, self)
	self:addEventCb(StoryController.instance, StoryEvent.PlayFullBlurIn, self._onPlayFullBlurIn, self)
	self:addEventCb(StoryController.instance, StoryEvent.PlayFullBlurOut, self._onPlayFullBlurOut, self)
	self:addEventCb(StoryController.instance, StoryEvent.PlayFullTextLineShow, self._onPlayLineShow, self)
	self:addEventCb(StoryController.instance, StoryEvent.RefreshNavigate, self._refreshNavigate, self)
	self:addEventCb(StoryController.instance, StoryEvent.HideTopBtns, self._onHideBtns, self)
	self:addEventCb(StoryController.instance, StoryEvent.OnSkipClick, self._onPrologueSkip, self)
	self:addEventCb(ViewMgr.instance, ViewEvent.OnOpenViewFinish, self._setBtnsVisible, self)
	self:addEventCb(ViewMgr.instance, ViewEvent.OnCloseViewFinish, self._setBtnsVisible, self)

	if StoryModel.instance:getHideBtns() then
		self:setBtnVisible(false)
	end

	self:_enterStory()

	local isPv = StoryModel.instance:isVersionActivityPV()

	if isPv then
		gohelper.setActive(self._gobtnleft, false)
		gohelper.setActive(self._objskip, false)
		gohelper.setActive(self._btnauto, false)
	else
		gohelper.setActive(self._gobtnleft, true)
		gohelper.setActive(self._btnauto, true)

		local skipShow = OpenModel.instance:isFuncBtnShow(OpenEnum.UnlockFunc.StorySkip) or StoryModel.instance:isReplay()
		local directShow = StoryModel.instance:isDirectSkipStory(StoryModel.instance:getCurStoryId())

		skipShow = skipShow or isDebugBuild or directShow

		gohelper.setActive(self._objskip, skipShow)
	end

	self:refreshExitBtn()
	NavigateMgr.instance:addSpace(ViewName.StoryFrontView, self._btnnextOnClick, self)
	NavigateMgr.instance:addEscape(ViewName.StoryFrontView, self._onEscapeBtnClick, self)
end

function StoryFrontView:onClose()
	self._btnnext:RemoveClickListener()
	self:removeEventCb(StoryController.instance, StoryEvent.Skip, self._onSkip, self)
	self:removeEventCb(StoryController.instance, StoryEvent.AutoChange, self._onAutoChange, self)
	self:removeEventCb(StoryController.instance, StoryEvent.ReOpenStoryView, self._reOpenStory, self)
	self:removeEventCb(StoryController.instance, StoryEvent.AllStepFinished, self._screenFadeOut, self)
	self:removeEventCb(StoryController.instance, StoryEvent.RefreshStep, self._onUpdateUI, self)
	self:removeEventCb(StoryController.instance, StoryEvent.SetFullText, self._onSetFullText, self)
	self:removeEventCb(StoryController.instance, StoryEvent.PlayFullText, self._onPlayFullText, self)
	self:removeEventCb(StoryController.instance, StoryEvent.PlayIrregularShakeText, self._onPlayIrregularShakeText, self)
	self:removeEventCb(StoryController.instance, StoryEvent.PlayFullTextOut, self._onPlayFullTextOut, self)
	self:removeEventCb(StoryController.instance, StoryEvent.PlayFullBlurIn, self._onPlayFullBlurIn, self)
	self:removeEventCb(StoryController.instance, StoryEvent.PlayFullBlurOut, self._onPlayFullBlurOut, self)
	self:removeEventCb(StoryController.instance, StoryEvent.PlayFullTextLineShow, self._onPlayLineShow, self)
	self:removeEventCb(StoryController.instance, StoryEvent.RefreshNavigate, self._refreshNavigate, self)
	self:removeEventCb(StoryController.instance, StoryEvent.HideTopBtns, self._onHideBtns, self)
	self:removeEventCb(StoryController.instance, StoryEvent.OnSkipClick, self._onPrologueSkip, self)
	self:removeEventCb(ViewMgr.instance, ViewEvent.OnOpenViewFinish, self._setBtnsVisible, self)
	self:removeEventCb(ViewMgr.instance, ViewEvent.OnCloseViewFinish, self._setBtnsVisible, self)
end

function StoryFrontView:_onSkip()
	gohelper.setActive(self._goepisode, false)
	gohelper.setActive(self._gochapteropen, false)
end

function StoryFrontView:_onAutoChange()
	local auto = StoryModel.instance:isStoryAuto()

	gohelper.setActive(self._imageautooff.gameObject, not auto)
	gohelper.setActive(self._imageautoon.gameObject, auto)

	local btnColor = auto and "#333333" or "#FFFFFF"

	SLFramework.UGUI.GuiHelper.SetColor(self._imagehide, btnColor)
end

function StoryFrontView:_reOpenStory()
	self._reOpen = true

	self:_enterStory()
end

function StoryFrontView:_onSetFullText(txt)
	self._frontItem:showFullScreenText(false, txt)
end

function StoryFrontView:_onPlayFullText(stepCo)
	self._stepCo = stepCo

	if self._stepCo.conversation.effType == StoryEnum.ConversationEffectType.Fade then
		self._frontItem:playTextFadeIn(self._stepCo, self._onFullTextShowFinished, self)
	elseif self._stepCo.conversation.effType == StoryEnum.ConversationEffectType.WordByWord then
		self._frontItem:wordByWord(self._stepCo, self._onFullTextShowFinished, self)
	elseif self._stepCo.conversation.effType == StoryEnum.ConversationEffectType.Glitch then
		self._frontItem:playTextFadeIn(self._stepCo, self._onFullTextShowFinished, self)
		self._frontItem:playGlitch()
	end
end

function StoryFrontView:_onPlayIrregularShakeText(stepCo)
	self._stepCo = stepCo

	self._frontItem:playIrregularShakeText(self._stepCo, self._onFullTextShowFinished, self)
end

function StoryFrontView:_onPlayFullTextOut(callback, callbackObj)
	local fadeOutTime = 0.5

	if self._stepCo and self._stepCo.conversation.type == StoryEnum.ConversationType.ScreenDialog and (self._stepCo.conversation.effType == StoryEnum.ConversationEffectType.Fade or self._stepCo.conversation.effType == StoryEnum.ConversationEffectType.WordByWord or self._stepCo.conversation.effType == StoryEnum.ConversationEffectType.LineByLine or self._stepCo.conversation.effType == StoryEnum.ConversationEffectType.TwoLineShow) then
		fadeOutTime = self._stepCo.conversation.effTimes[GameLanguageMgr.instance:getVoiceTypeStoryIndex()]
	end

	self._frontItem:playFullTextFadeOut(fadeOutTime, callback, callbackObj)
end

function StoryFrontView:_onPlayFullBlurIn(level, time)
	if level < 1 then
		return
	end

	local state = {
		0.3,
		0.6,
		1
	}

	PostProcessingMgr.instance:setUIBlurActive(3)
	PostProcessingMgr.instance:setFreezeVisble(true)
	PostProcessingMgr.instance:setDesamplingRate(1)
	self:_killBlurId()

	self._blurTweenId = ZProj.TweenHelper.DOTweenFloat(0, state[level], time, self._fadeUpdate, nil, self, nil, EaseType.Linear)
end

function StoryFrontView:_killBlurId()
	if self._blurTweenId then
		ZProj.TweenHelper.KillById(self._blurTweenId)

		self._blurTweenId = nil
	end
end

function StoryFrontView:_onPlayFullBlurOut(time)
	self:_killBlurId()

	local captureGo = PostProcessingMgr.instance:getCaptureView()

	if not captureGo or not captureGo.activeSelf then
		return
	end

	local capture = captureGo:GetComponent(typeof(UrpCustom.UIGaussianEffect))
	local blurWeight = capture and capture.blurWeight or 0

	if blurWeight <= 0 then
		return
	end

	if time < 0.1 then
		self:_fadeBlurOutFinished()

		return
	end

	self._blurTweenId = ZProj.TweenHelper.DOTweenFloat(blurWeight, 0, time, self._fadeUpdate, self._fadeBlurOutFinished, self, nil, EaseType.Linear)
end

function StoryFrontView:_fadeUpdate(value)
	PostProcessingMgr.instance:setBlurWeight(value)
end

function StoryFrontView:_fadeBlurOutFinished()
	PostProcessingMgr.instance:setUIBlurActive(0)
	PostProcessingMgr.instance:setFreezeVisble(false)
	self:_killBlurId()
	self:_fadeUpdate(0)
end

function StoryFrontView:_onPlayLineShow(lineCount, co)
	self._stepCo = co

	self._frontItem:lineShow(lineCount, self._stepCo, self._onFullTextShowFinished, self)
end

function StoryFrontView:_onFullTextShowFinished()
	StoryController.instance:dispatchEvent(StoryEvent.FullTextLineShowFinished)
end

function StoryFrontView:_onUpdateUI(param)
	self:_killBlurId()

	local normalstep = param.stepType == StoryEnum.StepType.Normal
	local color1 = normalstep and "#FFFFFF" or "#292218"
	local color2 = normalstep and "#FFFFFF" or "#333333"

	SLFramework.UGUI.GuiHelper.SetColor(self._txtskip, color1)
	SLFramework.UGUI.GuiHelper.SetColor(self._imageskip, color2)
	SLFramework.UGUI.GuiHelper.SetColor(self._txtauto, color1)
	SLFramework.UGUI.GuiHelper.SetColor(self._imageautooff, color2)
	SLFramework.UGUI.GuiHelper.SetColor(self._imageautoon, color2)
	SLFramework.UGUI.GuiHelper.SetColor(self._txtexit, color1)
	SLFramework.UGUI.GuiHelper.SetColor(self._imageexit, color2)

	self._stepCo = StoryStepModel.instance:getStepListById(param.stepId)

	if self:_isCgStep() or StoryModel.instance:getHideBtns() then
		self:setBtnVisible(false)
	else
		self:setBtnVisible(true)
	end

	local isScreenDialog = self._stepCo.conversation.type == StoryEnum.ConversationType.ScreenDialog

	if not isScreenDialog then
		self._frontItem:showFullScreenText(false, "")
	end

	self:refreshExitBtn()
end

function StoryFrontView:_isCgStep()
	if StoryModel.instance:getCurStoryId() ~= 100001 then
		return false
	end

	if isDebugBuild then
		return false
	end

	if StoryModel.instance:isReplay() then
		return false
	end

	if self._stepCo then
		for _, v in pairs(self._stepCo.videoList) do
			if v.orderType ~= StoryEnum.VideoOrderType.Destroy then
				return true
			end
		end
	end

	return false
end

function StoryFrontView:_enterStory()
	TaskDispatcher.cancelTask(self._startStory, self)
	TaskDispatcher.cancelTask(self._viewFadeIn, self)
	self._frontItem:cancelViewFadeOut()
	gohelper.setActive(self._goblock, false)
	self:_screenFadeIn()
end

function StoryFrontView:_screenFadeIn()
	if GuideModel.instance:isDoingFirstGuide() and not GuideController.instance:isForbidGuides() and GameSceneMgr.instance:getCurSceneType() == SceneType.Fight then
		StoryController.instance:startStory()

		return
	end

	local skip = StoryModel.instance:isTypeSkip(StoryEnum.SkipType.InDarkFade, StoryModel.instance:getCurStoryId())

	StoryModel.instance.skipFade = skip

	self._frontItem:setFullTopShow()
	gohelper.setActive(self.viewGO, true)

	if self._reOpen and skip then
		self:_startStory()
	else
		TaskDispatcher.runDelay(self._startStory, self, 0.5)
	end
end

function StoryFrontView:_startStory()
	StoryController.instance:startStory()
	TaskDispatcher.runDelay(self._viewFadeIn, self, 0.05)
end

function StoryFrontView:_viewFadeIn()
	if StoryController.instance._showBlur then
		self._dofFactor = PostProcessingMgr.instance:getUnitPPValue("DofFactor")
		self._unitCameraActive = CameraMgr.instance:getUnitCamera().gameObject.activeSelf

		gohelper.setActive(PostProcessingMgr.instance._unitPPVolume.gameObject, true)
		gohelper.setActive(CameraMgr.instance:getUnitCamera(), true)
		self:_killBlurId()

		self._blurTweenId = ZProj.TweenHelper.DOTweenFloat(0, 1, 1.5, self._blurUpdate, self._blurInFinished, self, EaseType.Linear)

		return
	end

	self._frontItem:playStoryViewIn()
end

function StoryFrontView:_blurUpdate(value)
	PostProcessingMgr.instance:setUnitPPValue("dofFactor", value)
	PostProcessingMgr.instance:setUnitPPValue("DofFactor", value)
end

function StoryFrontView:_blurInFinished()
	self:_blurUpdate(1)
	self:_killBlurId()
end

function StoryFrontView:_screenFadeOut(isSkip)
	StoryModel.instance:enableClick(false)
	gohelper.setActive(self._goblock, true)
	gohelper.setActive(self._goepisode, false)
	gohelper.setActive(self._gochapteropen, false)
	self:setBtnVisible(false)

	if self._exitBtn then
		self._exitBtn:setActive(false)
	end

	if StoryController.instance._showBlur then
		self:_killBlurId()

		self._blurTweenId = ZProj.TweenHelper.DOTweenFloat(1, 0, 1.5, self._blurUpdate, self._blurOutFinished, self, EaseType.Linear)

		return
	end

	self._frontItem:playStoryViewOut(self._onScreenFadeOut, self, isSkip)
end

function StoryFrontView:_blurOutFinished()
	self:_blurUpdate(0)
	PostProcessingMgr.instance:setUnitPPValue("dofFactor", self._dofFactor or 0)
	PostProcessingMgr.instance:setUnitPPValue("DofFactor", self._dofFactor or 0)
	gohelper.setActive(CameraMgr.instance:getUnitCamera().gameObject, self._unitCameraActive)
	StoryController.instance:finished()
	self._frontItem:enterStoryFinish()
	self:_onScreenFadeOut()
end

function StoryFrontView:_onScreenFadeOut()
	if self._navigateItem then
		self._navigateItem:clear()
	end
end

function StoryFrontView:_refreshNavigate(navs)
	local hideBtns = false
	local navCos = {}

	for _, v in pairs(navs) do
		if v.navigateType == StoryEnum.NavigateType.HideBtns then
			hideBtns = true
		else
			table.insert(navCos, v)
		end
	end

	self:setBtnVisible(not hideBtns)
	self:refreshExitBtn()
	StoryModel.instance:setHideBtns(hideBtns)

	if #navCos > 0 then
		if not self._navigateItem then
			self._navigateItem = StoryNavigateItem.New()

			self._navigateItem:init(self._gonavigate)
			self._navigateItem:show(navCos)
		else
			self._navigateItem:show(navCos)
		end
	elseif self._navigateItem then
		self._navigateItem:clear()
	end
end

function StoryFrontView:setBtnVisible(isVisible)
	local hideTopBtns = StoryModel.instance:getHideBtns()

	if hideTopBtns then
		gohelper.setActive(self._gobtns, false)

		return
	end

	if self.btnVisible == isVisible then
		return
	end

	self.btnVisible = isVisible

	gohelper.setActive(self._gobtns, isVisible)
end

function StoryFrontView:_setBtnsVisible(viewName)
	if StoryController.instance._showBlur then
		StoryModel.instance:setUIActive(true)
	else
		local uiActive = StoryModel.instance:getUIActive()

		StoryModel.instance:setUIActive(uiActive)
	end

	if viewName == ViewName.StoryLogView then
		local isBtnActive = self._gobtnleft.activeInHierarchy

		gohelper.setActive(self._gobtnleft, not isBtnActive)
	end
end

function StoryFrontView:_onHideBtns(hide)
	StoryModel.instance:setHideBtns(hide)
	self:setBtnVisible(not hide)

	if hide and self._exitBtn then
		self._exitBtn:setActive(false)
	end
end

function StoryFrontView:startHideSkipTask()
	self:closeHideSkipTask()
	TaskDispatcher.runDelay(self._hideSkipBtn, self, 3)
end

function StoryFrontView:_hideSkipBtn()
	gohelper.setActive(self._objskip, false)
end

function StoryFrontView:closeHideSkipTask()
	TaskDispatcher.cancelTask(self._hideSkipBtn, self)
end

function StoryFrontView:refreshExitBtn()
	if self._exitBtn then
		self._exitBtn:refresh(self.btnVisible)
	end
end

function StoryFrontView:resetRightBtnPos()
	local exitShow = self._exitBtn and self._exitBtn.isActive

	if exitShow then
		local btnWidth = self._txtexit.preferredWidth + 180

		recthelper.setAnchorX(self._gobtnright.transform, -btnWidth)
		gohelper.setActive(self._goshadow, self._exitBtn.isInVideo and true or false)
	else
		recthelper.setAnchorX(self._gobtnright.transform, -62)
		gohelper.setActive(self._goshadow, false)
	end
end

function StoryFrontView:onDestroyView()
	StoryModel.instance:setStoryPvPause(false)
	TaskDispatcher.cancelTask(self._realPause, self)
	TaskDispatcher.cancelTask(self._playFinished, self)
	UIBlockMgr.instance:endBlock("waitPause")
	UIBlockMgr.instance:endBlock("PlayPv")

	if StoryController.instance._showBlur then
		PostProcessingMgr.instance:setUnitPPValue("dofFactor", self._dofFactor or 0)
		PostProcessingMgr.instance:setUnitPPValue("DofFactor", self._dofFactor or 0)

		StoryController.instance._showBlur = false
	end

	StoryController.instance:dispatchEvent(StoryEvent.StoryFrontViewDestroy)
	TaskDispatcher.cancelTask(self._startStory, self)
	TaskDispatcher.cancelTask(self._viewFadeIn, self)
	self:_killBlurId()
	self:closeHideSkipTask()

	if self._frontItem then
		self._frontItem:destroy()

		self._frontItem = nil
	end

	if self._navigateItem then
		self._navigateItem:destroy()

		self._navigateItem = nil
	end

	if self._exitBtn then
		self._exitBtn:destroy()

		self._exitBtn = nil
	end
end

return StoryFrontView
