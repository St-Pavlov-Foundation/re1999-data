module("modules.logic.story.view.StoryFrontView", package.seeall)

local var_0_0 = class("StoryFrontView", BaseView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._gobtns = gohelper.findChild(arg_1_0.viewGO, "#go_btns")
	arg_1_0._gobtnleft = gohelper.findChild(arg_1_0.viewGO, "#go_btns/#go_btnleft")
	arg_1_0._btnlog = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#go_btns/#go_btnleft/#btn_log")
	arg_1_0._btnhide = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#go_btns/#go_btnleft/#btn_hide")
	arg_1_0._gobtnright = gohelper.findChild(arg_1_0.viewGO, "#go_btns/#go_btnright")
	arg_1_0._btnauto = gohelper.findChildButtonWithAudio(arg_1_0._gobtnright, "#btn_auto")
	arg_1_0._txtauto = gohelper.findChildTextMesh(arg_1_0._gobtnright, "#btn_auto/txt_Auto")
	arg_1_0._imageautooff = gohelper.findChildImage(arg_1_0._gobtnright, "#btn_auto/#image_autooff")
	arg_1_0._imageautoon = gohelper.findChildImage(arg_1_0._gobtnright, "#btn_auto/#image_autoon")
	arg_1_0._btnskip = gohelper.findChildButtonWithAudio(arg_1_0._gobtnright, "#btn_skip")
	arg_1_0._objskip = arg_1_0._btnskip.gameObject
	arg_1_0._txtskip = gohelper.findChildTextMesh(arg_1_0._gobtnright, "#btn_skip/txt_skip")
	arg_1_0._imageskip = gohelper.findChildImage(arg_1_0._gobtnright, "#btn_skip/#image_skip")
	arg_1_0._goexit = gohelper.findChild(arg_1_0.viewGO, "#btn_exit")
	arg_1_0._txtexit = gohelper.findChildTextMesh(arg_1_0.viewGO, "#btn_exit/txt_exit")
	arg_1_0._imageexit = gohelper.findChildImage(arg_1_0.viewGO, "#btn_exit/#image_exit")
	arg_1_0._goshadow = gohelper.findChild(arg_1_0.viewGO, "#go_shadow")
	arg_1_0._gofront = gohelper.findChild(arg_1_0.viewGO, "#go_front")
	arg_1_0._goblock = gohelper.findChild(arg_1_0.viewGO, "#go_front/#go_block")
	arg_1_0._gonavigate = gohelper.findChild(arg_1_0.viewGO, "#go_navigate")
	arg_1_0._goepisode = gohelper.findChild(arg_1_0.viewGO, "#go_navigate/#go_episode")
	arg_1_0._gochapteropen = gohelper.findChild(arg_1_0.viewGO, "#go_navigate/#go_chapter/#go_open")
	arg_1_0._gochapterclose = gohelper.findChild(arg_1_0.viewGO, "#go_navigate/#go_chapter/#go_close")

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0._btnlog:AddClickListener(arg_2_0._btnlogOnClick, arg_2_0)
	arg_2_0._btnhide:AddClickListener(arg_2_0._btnhideOnClick, arg_2_0)
	arg_2_0._btnauto:AddClickListener(arg_2_0._btnautoOnClick, arg_2_0)
	arg_2_0._btnskip:AddClickListener(arg_2_0._btnskipOnClick, arg_2_0)
	arg_2_0:addEventCb(PCInputController.instance, PCInputEvent.NotifyStoryDialogAuto, arg_2_0._btnautoOnClick, arg_2_0)
	arg_2_0:addEventCb(PCInputController.instance, PCInputEvent.NotifyStoryDialogSkip, arg_2_0._btnskipOnClick, arg_2_0)
	arg_2_0:addEventCb(PCInputController.instance, PCInputEvent.NotifyStoryDialogExit, arg_2_0._onKeyExit, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	arg_3_0._btnlog:RemoveClickListener()
	arg_3_0._btnhide:RemoveClickListener()
	arg_3_0._btnauto:RemoveClickListener()
	arg_3_0._btnskip:RemoveClickListener()
	arg_3_0:removeEventCb(PCInputController.instance, PCInputEvent.NotifyStoryDialogAuto, arg_3_0._btnautoOnClick, arg_3_0)
	arg_3_0:removeEventCb(PCInputController.instance, PCInputEvent.NotifyStoryDialogSkip, arg_3_0._btnskipOnClick, arg_3_0)
	arg_3_0:removeEventCb(PCInputController.instance, PCInputEvent.NotifyStoryDialogExit, arg_3_0._onKeyExit, arg_3_0)
end

function var_0_0._btnlogOnClick(arg_4_0)
	if ViewMgr.instance:isOpen(ViewName.MessageBoxView) then
		return
	end

	AudioMgr.instance:trigger(AudioEnum.UI.play_ui_plot_common)
	StoryModel.instance:setStoryAuto(false)
	StoryController.instance:dispatchEvent(StoryEvent.Log)
end

function var_0_0._onKeyExit(arg_5_0)
	if ViewMgr.instance:isOpen(ViewName.MessageBoxView) then
		return
	end

	if arg_5_0._exitBtn and arg_5_0._goexit.activeInHierarchy then
		arg_5_0._exitBtn:onClickExitBtn()
	end
end

function var_0_0._btnhideOnClick(arg_6_0)
	if ViewMgr.instance:isOpen(ViewName.MessageBoxView) then
		return
	end

	AudioMgr.instance:trigger(AudioEnum.UI.play_ui_plot_common)

	if StoryModel.instance:isStoryAuto() then
		return
	end

	StoryModel.instance:setViewHide(true)
	arg_6_0:setBtnVisible(false)
	StoryController.instance:dispatchEvent(StoryEvent.Hide)

	if arg_6_0._exitBtn then
		arg_6_0._exitBtn:setActive(false)
	end
end

function var_0_0._btnautoOnClick(arg_7_0)
	if ViewMgr.instance:isOpen(ViewName.MessageBoxView) then
		return
	end

	if not arg_7_0._stepCo then
		return
	end

	AudioMgr.instance:trigger(AudioEnum.UI.play_ui_plot_common)

	if arg_7_0._stepCo.conversation.type ~= StoryEnum.ConversationType.None and arg_7_0._stepCo.conversation.type ~= StoryEnum.ConversationType.NoInteract and arg_7_0._stepCo.conversation.type ~= StoryEnum.ConversationType.ScreenDialog and arg_7_0._stepCo.conversation.type ~= StoryEnum.ConversationType.IrregularShake then
		StoryModel.instance:enableClick(true)
	end

	if not StoryModel.instance:isNormalStep() then
		return
	end

	local var_7_0 = not StoryModel.instance:isStoryAuto()

	StoryModel.instance:setStoryAuto(var_7_0)
	StoryController.instance:dispatchEvent(StoryEvent.Auto)
end

function var_0_0._onEscapeBtnClick(arg_8_0)
	if arg_8_0._objskip.activeInHierarchy and not arg_8_0._goblock.gameObject.activeInHierarchy then
		arg_8_0:_btnskipOnClick()
	end
end

function var_0_0._btnskipOnClick(arg_9_0)
	if ViewMgr.instance:isOpen(ViewName.MessageBoxView) then
		return
	end

	AudioMgr.instance:trigger(AudioEnum.UI.play_ui_plot_common)
	StoryModel.instance:setStoryAuto(false)

	if not OpenModel.instance:isFunctionUnlock(OpenEnum.UnlockFunc.StorySkip) and not isDebugBuild and not StoryController.instance:isReplay() then
		GameFacade.showToast(OpenModel.instance:getFuncUnlockDesc(OpenEnum.UnlockFunc.StorySkip))

		return
	end

	if not StoryController.instance:isReplay() then
		local var_9_0 = StoryController.instance._curStoryId
		local var_9_1 = StoryController.instance._curStepId
		local var_9_2, var_9_3 = StoryModel.instance:isPrologueSkipAndGetTxt(var_9_0, var_9_1)

		if var_9_2 then
			GameFacade.showMessageBox(MessageBoxIdDefine.StorySkipConfirm, MsgBoxEnum.BoxType.Yes_No, function()
				gohelper.setActive(arg_9_0._gobtns, false)

				local var_10_0 = {
					content = var_9_3
				}

				StoryController.instance:openStoryPrologueSkipView(var_10_0)
			end, nil)

			return
		end
	end

	local var_9_4 = StoryController.instance:getSkipMessageId()

	GameFacade.showMessageBox(var_9_4, MsgBoxEnum.BoxType.Yes_No, function()
		arg_9_0:_onSkipConfirm()
	end, nil)
end

function var_0_0._onPrologueSkip(arg_12_0)
	gohelper.setActive(arg_12_0._gobtns, true)

	local var_12_0 = StoryController.instance._curStoryId

	StoryModel.instance:setPrologueSkipId(var_12_0)
	arg_12_0:_onSkipConfirm()
end

function var_0_0._onSkipConfirm(arg_13_0)
	gohelper.setActive(arg_13_0._goepisode, false)
	gohelper.setActive(arg_13_0._gochapteropen, false)
	StoryController.instance:dispatchEvent(StoryEvent.Skip)
end

function var_0_0._btnnextOnClick(arg_14_0)
	if StoryModel.instance:isPlayFinished() then
		return
	end

	arg_14_0:closeHideSkipTask()

	if arg_14_0._exitBtn then
		arg_14_0._exitBtn:onClickNext()
	end

	if StoryController.instance:isVersionActivityPV() then
		arg_14_0:startHideSkipTask()

		if not arg_14_0._objskip.activeInHierarchy then
			gohelper.setActive(arg_14_0._objskip, true)
		end

		return
	end

	local var_14_0 = false

	if StoryModel.instance:isStoryAuto() then
		var_14_0 = true

		StoryModel.instance:setStoryAuto(false)
		StoryModel.instance:setTextShowing(false)

		return
	end

	if not StoryModel.instance:isEnableClick() then
		return
	end

	if StoryModel.instance:isViewHide() then
		arg_14_0:setBtnVisible(true)
	end

	if not var_14_0 then
		StoryController.instance:dispatchEvent(StoryEvent.EnterNextStep)
	end
end

function var_0_0._editableInitView(arg_15_0)
	arg_15_0._btnnext = gohelper.findChildButton(arg_15_0.viewGO, "btn_next")
	arg_15_0._imagehide = gohelper.findChildImage(arg_15_0.viewGO, "#go_btns/#go_btnleft/#btn_hide/icon")

	gohelper.setActive(arg_15_0._imageautooff.gameObject, true)
	gohelper.setActive(arg_15_0._imageautoon.gameObject, false)

	if not arg_15_0._frontItem then
		arg_15_0._frontItem = StoryFrontItem.New()

		arg_15_0._frontItem:init(arg_15_0._gofront)
	end

	if not arg_15_0._exitBtn then
		arg_15_0._exitBtn = StoryExitBtn.New(arg_15_0._goexit, arg_15_0.resetRightBtnPos, arg_15_0)
	end
end

function var_0_0.onUpdateParam(arg_16_0)
	return
end

function var_0_0.onOpen(arg_17_0)
	arg_17_0._btnnext:AddClickListener(arg_17_0._btnnextOnClick, arg_17_0)
	arg_17_0:addEventCb(StoryController.instance, StoryEvent.Skip, arg_17_0._onSkip, arg_17_0)
	arg_17_0:addEventCb(StoryController.instance, StoryEvent.AutoChange, arg_17_0._onAutoChange, arg_17_0)
	arg_17_0:addEventCb(StoryController.instance, StoryEvent.ReOpenStoryView, arg_17_0._reOpenStory, arg_17_0)
	arg_17_0:addEventCb(StoryController.instance, StoryEvent.AllStepFinished, arg_17_0._screenFadeOut, arg_17_0)
	arg_17_0:addEventCb(StoryController.instance, StoryEvent.RefreshStep, arg_17_0._onUpdateUI, arg_17_0)
	arg_17_0:addEventCb(StoryController.instance, StoryEvent.SetFullText, arg_17_0._onSetFullText, arg_17_0)
	arg_17_0:addEventCb(StoryController.instance, StoryEvent.PlayFullText, arg_17_0._onPlayFullText, arg_17_0)
	arg_17_0:addEventCb(StoryController.instance, StoryEvent.PlayIrregularShakeText, arg_17_0._onPlayIrregularShakeText, arg_17_0)
	arg_17_0:addEventCb(StoryController.instance, StoryEvent.PlayFullTextOut, arg_17_0._onPlayFullTextOut, arg_17_0)
	arg_17_0:addEventCb(StoryController.instance, StoryEvent.PlayFullBlurIn, arg_17_0._onPlayFullBlurIn, arg_17_0)
	arg_17_0:addEventCb(StoryController.instance, StoryEvent.PlayFullTextLineShow, arg_17_0._onPlayLineShow, arg_17_0)
	arg_17_0:addEventCb(StoryController.instance, StoryEvent.RefreshNavigate, arg_17_0._refreshNavigate, arg_17_0)
	arg_17_0:addEventCb(StoryController.instance, StoryEvent.HideTopBtns, arg_17_0._onHideBtns, arg_17_0)
	arg_17_0:addEventCb(StoryController.instance, StoryEvent.OnSkipClick, arg_17_0._onPrologueSkip, arg_17_0)
	arg_17_0:addEventCb(ViewMgr.instance, ViewEvent.OnOpenViewFinish, arg_17_0._setBtnsVisible, arg_17_0)
	arg_17_0:addEventCb(ViewMgr.instance, ViewEvent.OnCloseViewFinish, arg_17_0._setBtnsVisible, arg_17_0)

	if StoryModel.instance:getHideBtns() then
		arg_17_0:setBtnVisible(false)
	end

	arg_17_0:_enterStory()

	if StoryController.instance:isVersionActivityPV() then
		gohelper.setActive(arg_17_0._gobtnleft, false)
		gohelper.setActive(arg_17_0._objskip, false)
		gohelper.setActive(arg_17_0._btnauto, false)
	else
		gohelper.setActive(arg_17_0._gobtnleft, true)
		gohelper.setActive(arg_17_0._btnauto, true)

		local var_17_0 = OpenModel.instance:isFuncBtnShow(OpenEnum.UnlockFunc.StorySkip) or StoryController.instance:isReplay()
		local var_17_1 = StoryModel.instance:isDirectSkipStory(StoryController.instance._curStoryId)

		var_17_0 = var_17_0 or isDebugBuild or var_17_1

		gohelper.setActive(arg_17_0._objskip, var_17_0)
	end

	arg_17_0:refreshExitBtn()
	NavigateMgr.instance:addSpace(ViewName.StoryFrontView, arg_17_0._btnnextOnClick, arg_17_0)
	NavigateMgr.instance:addEscape(ViewName.StoryFrontView, arg_17_0._onEscapeBtnClick, arg_17_0)
end

function var_0_0.onClose(arg_18_0)
	arg_18_0._btnnext:RemoveClickListener()
	arg_18_0:removeEventCb(StoryController.instance, StoryEvent.Skip, arg_18_0._onSkip, arg_18_0)
	arg_18_0:removeEventCb(StoryController.instance, StoryEvent.AutoChange, arg_18_0._onAutoChange, arg_18_0)
	arg_18_0:removeEventCb(StoryController.instance, StoryEvent.ReOpenStoryView, arg_18_0._reOpenStory, arg_18_0)
	arg_18_0:removeEventCb(StoryController.instance, StoryEvent.AllStepFinished, arg_18_0._screenFadeOut, arg_18_0)
	arg_18_0:removeEventCb(StoryController.instance, StoryEvent.RefreshStep, arg_18_0._onUpdateUI, arg_18_0)
	arg_18_0:removeEventCb(StoryController.instance, StoryEvent.SetFullText, arg_18_0._onSetFullText, arg_18_0)
	arg_18_0:removeEventCb(StoryController.instance, StoryEvent.PlayFullText, arg_18_0._onPlayFullText, arg_18_0)
	arg_18_0:removeEventCb(StoryController.instance, StoryEvent.PlayIrregularShakeText, arg_18_0._onPlayIrregularShakeText, arg_18_0)
	arg_18_0:removeEventCb(StoryController.instance, StoryEvent.PlayFullTextOut, arg_18_0._onPlayFullTextOut, arg_18_0)
	arg_18_0:removeEventCb(StoryController.instance, StoryEvent.PlayFullBlurIn, arg_18_0._onPlayFullBlurIn, arg_18_0)
	arg_18_0:removeEventCb(StoryController.instance, StoryEvent.PlayFullTextLineShow, arg_18_0._onPlayLineShow, arg_18_0)
	arg_18_0:removeEventCb(StoryController.instance, StoryEvent.RefreshNavigate, arg_18_0._refreshNavigate, arg_18_0)
	arg_18_0:removeEventCb(StoryController.instance, StoryEvent.HideTopBtns, arg_18_0._onHideBtns, arg_18_0)
	arg_18_0:removeEventCb(StoryController.instance, StoryEvent.OnSkipClick, arg_18_0._onPrologueSkip, arg_18_0)
	arg_18_0:removeEventCb(ViewMgr.instance, ViewEvent.OnOpenViewFinish, arg_18_0._setBtnsVisible, arg_18_0)
	arg_18_0:removeEventCb(ViewMgr.instance, ViewEvent.OnCloseViewFinish, arg_18_0._setBtnsVisible, arg_18_0)
end

function var_0_0._onSkip(arg_19_0)
	gohelper.setActive(arg_19_0._goepisode, false)
	gohelper.setActive(arg_19_0._gochapteropen, false)
end

function var_0_0._onAutoChange(arg_20_0)
	local var_20_0 = StoryModel.instance:isStoryAuto()

	gohelper.setActive(arg_20_0._imageautooff.gameObject, not var_20_0)
	gohelper.setActive(arg_20_0._imageautoon.gameObject, var_20_0)

	local var_20_1 = var_20_0 and "#333333" or "#FFFFFF"

	SLFramework.UGUI.GuiHelper.SetColor(arg_20_0._imagehide, var_20_1)
end

function var_0_0._reOpenStory(arg_21_0)
	arg_21_0._reOpen = true

	arg_21_0:_enterStory()
end

function var_0_0._onSetFullText(arg_22_0, arg_22_1)
	arg_22_0._frontItem:showFullScreenText(false, arg_22_1)
end

function var_0_0._onPlayFullText(arg_23_0, arg_23_1)
	arg_23_0._stepCo = arg_23_1

	if arg_23_0._stepCo.conversation.effType == StoryEnum.ConversationEffectType.Fade then
		arg_23_0._frontItem:playTextFadeIn(arg_23_0._stepCo, arg_23_0._onFullTextShowFinished, arg_23_0)
	elseif arg_23_0._stepCo.conversation.effType == StoryEnum.ConversationEffectType.WordByWord then
		arg_23_0._frontItem:wordByWord(arg_23_0._stepCo, arg_23_0._onFullTextShowFinished, arg_23_0)
	elseif arg_23_0._stepCo.conversation.effType == StoryEnum.ConversationEffectType.Glitch then
		arg_23_0._frontItem:playGlitch()
		arg_23_0:_onFullTextShowFinished()
	end
end

function var_0_0._onPlayIrregularShakeText(arg_24_0, arg_24_1)
	arg_24_0._stepCo = arg_24_1

	arg_24_0._frontItem:playIrregularShakeText(arg_24_0._stepCo, arg_24_0._onFullTextShowFinished, arg_24_0)
end

function var_0_0._onPlayFullTextOut(arg_25_0)
	arg_25_0._frontItem:playFullTextFadeOut()
end

function var_0_0._onPlayFullBlurIn(arg_26_0, arg_26_1, arg_26_2)
	if arg_26_1 < 1 then
		return
	end

	local var_26_0 = {
		0.3,
		0.6,
		1
	}

	PostProcessingMgr.instance:setDesamplingRate(1)

	arg_26_0._blurTweenId = ZProj.TweenHelper.DOTweenFloat(0, var_26_0[arg_26_1], arg_26_2, arg_26_0._fadeUpdate, nil, arg_26_0, nil, EaseType.Linear)
end

function var_0_0._fadeUpdate(arg_27_0, arg_27_1)
	PostProcessingMgr.instance:setBlurWeight(arg_27_1)
end

function var_0_0._onPlayLineShow(arg_28_0, arg_28_1, arg_28_2)
	arg_28_0._stepCo = arg_28_2

	arg_28_0._frontItem:lineShow(arg_28_1, arg_28_0._stepCo, arg_28_0._onFullTextShowFinished, arg_28_0)
end

function var_0_0._onFullTextShowFinished(arg_29_0)
	StoryController.instance:dispatchEvent(StoryEvent.FullTextLineShowFinished)
end

function var_0_0._onUpdateUI(arg_30_0, arg_30_1)
	if arg_30_0._blurTweenId then
		ZProj.TweenHelper.KillById(arg_30_0._blurTweenId)

		arg_30_0._blurTweenId = nil
	end

	local var_30_0 = arg_30_1.stepType == StoryEnum.StepType.Normal
	local var_30_1 = var_30_0 and "#FFFFFF" or "#292218"
	local var_30_2 = var_30_0 and "#FFFFFF" or "#333333"

	SLFramework.UGUI.GuiHelper.SetColor(arg_30_0._txtskip, var_30_1)
	SLFramework.UGUI.GuiHelper.SetColor(arg_30_0._imageskip, var_30_2)
	SLFramework.UGUI.GuiHelper.SetColor(arg_30_0._txtauto, var_30_1)
	SLFramework.UGUI.GuiHelper.SetColor(arg_30_0._imageautooff, var_30_2)
	SLFramework.UGUI.GuiHelper.SetColor(arg_30_0._imageautoon, var_30_2)
	SLFramework.UGUI.GuiHelper.SetColor(arg_30_0._txtexit, var_30_1)
	SLFramework.UGUI.GuiHelper.SetColor(arg_30_0._imageexit, var_30_2)

	arg_30_0._stepCo = StoryStepModel.instance:getStepListById(arg_30_1.stepId)

	if arg_30_0:_isCgStep() or StoryModel.instance:getHideBtns() then
		arg_30_0:setBtnVisible(false)
	else
		arg_30_0:setBtnVisible(true)
	end

	if not (arg_30_0._stepCo.conversation.type == StoryEnum.ConversationType.ScreenDialog) then
		arg_30_0._frontItem:showFullScreenText(false, "")
	end

	arg_30_0:refreshExitBtn()
end

function var_0_0._isCgStep(arg_31_0)
	if StoryController.instance._curStoryId ~= 100001 then
		return false
	end

	if isDebugBuild then
		return false
	end

	if StoryController.instance:isReplay() then
		return false
	end

	if arg_31_0._stepCo then
		for iter_31_0, iter_31_1 in pairs(arg_31_0._stepCo.videoList) do
			if iter_31_1.orderType ~= StoryEnum.VideoOrderType.Destroy then
				return true
			end
		end
	end

	return false
end

function var_0_0._enterStory(arg_32_0)
	TaskDispatcher.cancelTask(arg_32_0._startStory, arg_32_0)
	TaskDispatcher.cancelTask(arg_32_0._viewFadeIn, arg_32_0)
	arg_32_0._frontItem:cancelViewFadeOut()
	gohelper.setActive(arg_32_0._goblock, false)
	arg_32_0:_screenFadeIn()
end

function var_0_0._screenFadeIn(arg_33_0)
	if GuideModel.instance:isDoingFirstGuide() and not GuideController.instance:isForbidGuides() and GameSceneMgr.instance:getCurSceneType() == SceneType.Fight then
		StoryController.instance:startStory()

		return
	end

	local var_33_0 = StoryModel.instance:isTypeSkip(StoryEnum.SkipType.InDarkFade, StoryController.instance._curStoryId)

	StoryModel.instance.skipFade = var_33_0

	arg_33_0._frontItem:setFullTopShow()
	gohelper.setActive(arg_33_0.viewGO, true)

	if arg_33_0._reOpen and var_33_0 then
		arg_33_0:_startStory()
	else
		TaskDispatcher.runDelay(arg_33_0._startStory, arg_33_0, 0.5)
	end
end

function var_0_0._startStory(arg_34_0)
	StoryController.instance:startStory()
	TaskDispatcher.runDelay(arg_34_0._viewFadeIn, arg_34_0, 0.05)
end

function var_0_0._viewFadeIn(arg_35_0)
	if StoryController.instance._showBlur then
		arg_35_0._dofFactor = PostProcessingMgr.instance:getUnitPPValue("DofFactor")
		arg_35_0._unitCameraActive = CameraMgr.instance:getUnitCamera().gameObject.activeSelf

		gohelper.setActive(PostProcessingMgr.instance._unitPPVolume.gameObject, true)
		gohelper.setActive(CameraMgr.instance:getUnitCamera(), true)

		arg_35_0._blurTweenId = ZProj.TweenHelper.DOTweenFloat(0, 1, 1.5, arg_35_0._blurUpdate, arg_35_0._blurInFinished, arg_35_0, EaseType.Linear)

		return
	end

	arg_35_0._frontItem:playStoryViewIn()
end

function var_0_0._blurUpdate(arg_36_0, arg_36_1)
	PostProcessingMgr.instance:setUnitPPValue("dofFactor", arg_36_1)
	PostProcessingMgr.instance:setUnitPPValue("DofFactor", arg_36_1)
end

function var_0_0._blurInFinished(arg_37_0)
	arg_37_0:_blurUpdate(1)

	arg_37_0._blurTweenId = nil
end

function var_0_0._screenFadeOut(arg_38_0, arg_38_1)
	StoryModel.instance:enableClick(false)
	gohelper.setActive(arg_38_0._goblock, true)
	gohelper.setActive(arg_38_0._goepisode, false)
	gohelper.setActive(arg_38_0._gochapteropen, false)
	arg_38_0:setBtnVisible(false)

	if arg_38_0._exitBtn then
		arg_38_0._exitBtn:setActive(false)
	end

	if StoryController.instance._showBlur then
		arg_38_0._blurTweenId = ZProj.TweenHelper.DOTweenFloat(1, 0, 1.5, arg_38_0._blurUpdate, arg_38_0._blurOutFinished, arg_38_0, EaseType.Linear)

		return
	end

	arg_38_0._frontItem:playStoryViewOut(arg_38_0._onScreenFadeOut, arg_38_0, arg_38_1)
end

function var_0_0._blurOutFinished(arg_39_0)
	arg_39_0:_blurUpdate(0)
	PostProcessingMgr.instance:setUnitPPValue("dofFactor", arg_39_0._dofFactor or 0)
	PostProcessingMgr.instance:setUnitPPValue("DofFactor", arg_39_0._dofFactor or 0)
	gohelper.setActive(CameraMgr.instance:getUnitCamera().gameObject, arg_39_0._unitCameraActive)
	StoryController.instance:finished()
	arg_39_0._frontItem:enterStoryFinish()
	arg_39_0:_onScreenFadeOut()
end

function var_0_0._onScreenFadeOut(arg_40_0)
	if arg_40_0._navigateItem then
		arg_40_0._navigateItem:clear()
	end
end

function var_0_0._refreshNavigate(arg_41_0, arg_41_1)
	local var_41_0 = false
	local var_41_1 = {}

	for iter_41_0, iter_41_1 in pairs(arg_41_1) do
		if iter_41_1.navigateType == StoryEnum.NavigateType.HideBtns then
			var_41_0 = true
		else
			table.insert(var_41_1, iter_41_1)
		end
	end

	arg_41_0:setBtnVisible(not var_41_0)
	arg_41_0:refreshExitBtn()
	StoryModel.instance:setHideBtns(var_41_0)

	if #var_41_1 > 0 then
		if not arg_41_0._navigateItem then
			arg_41_0._navigateItem = StoryNavigateItem.New()

			arg_41_0._navigateItem:init(arg_41_0._gonavigate)
			arg_41_0._navigateItem:show(var_41_1)
		else
			arg_41_0._navigateItem:show(var_41_1)
		end
	elseif arg_41_0._navigateItem then
		arg_41_0._navigateItem:clear()
	end
end

function var_0_0.setBtnVisible(arg_42_0, arg_42_1)
	if StoryModel.instance:getHideBtns() then
		gohelper.setActive(arg_42_0._gobtns, false)

		return
	end

	if arg_42_0.btnVisible == arg_42_1 then
		return
	end

	arg_42_0.btnVisible = arg_42_1

	gohelper.setActive(arg_42_0._gobtns, arg_42_1)
end

function var_0_0._setBtnsVisible(arg_43_0, arg_43_1)
	if StoryController.instance._showBlur then
		StoryModel.instance:setUIActive(true)
	else
		local var_43_0 = StoryModel.instance:getUIActive()

		StoryModel.instance:setUIActive(var_43_0)
	end

	if arg_43_1 == ViewName.StoryLogView then
		local var_43_1 = arg_43_0._gobtnleft.activeInHierarchy

		gohelper.setActive(arg_43_0._gobtnleft, not var_43_1)
	end
end

function var_0_0._onHideBtns(arg_44_0, arg_44_1)
	StoryModel.instance:setHideBtns(arg_44_1)
	arg_44_0:setBtnVisible(not arg_44_1)

	if arg_44_1 and arg_44_0._exitBtn then
		arg_44_0._exitBtn:setActive(false)
	end
end

function var_0_0.startHideSkipTask(arg_45_0)
	arg_45_0:closeHideSkipTask()
	TaskDispatcher.runDelay(arg_45_0._hideSkipBtn, arg_45_0, 3)
end

function var_0_0._hideSkipBtn(arg_46_0)
	gohelper.setActive(arg_46_0._objskip, false)
end

function var_0_0.closeHideSkipTask(arg_47_0)
	TaskDispatcher.cancelTask(arg_47_0._hideSkipBtn, arg_47_0)
end

function var_0_0.refreshExitBtn(arg_48_0)
	if arg_48_0._exitBtn then
		arg_48_0._exitBtn:refresh(arg_48_0.btnVisible)
	end
end

function var_0_0.resetRightBtnPos(arg_49_0)
	if arg_49_0._exitBtn and arg_49_0._exitBtn.isActive then
		local var_49_0 = arg_49_0._txtexit.preferredWidth + 180

		recthelper.setAnchorX(arg_49_0._gobtnright.transform, -var_49_0)
		gohelper.setActive(arg_49_0._goshadow, arg_49_0._exitBtn.isInVideo and true or false)
	else
		recthelper.setAnchorX(arg_49_0._gobtnright.transform, -62)
		gohelper.setActive(arg_49_0._goshadow, false)
	end
end

function var_0_0.onDestroyView(arg_50_0)
	if StoryController.instance._showBlur then
		PostProcessingMgr.instance:setUnitPPValue("dofFactor", arg_50_0._dofFactor or 0)
		PostProcessingMgr.instance:setUnitPPValue("DofFactor", arg_50_0._dofFactor or 0)

		StoryController.instance._showBlur = false
	end

	StoryController.instance:dispatchEvent(StoryEvent.StoryFrontViewDestroy)
	TaskDispatcher.cancelTask(arg_50_0._startStory, arg_50_0)
	TaskDispatcher.cancelTask(arg_50_0._viewFadeIn, arg_50_0)

	if arg_50_0._blurTweenId then
		ZProj.TweenHelper.KillById(arg_50_0._blurTweenId)

		arg_50_0._blurTweenId = nil
	end

	arg_50_0:closeHideSkipTask()

	if arg_50_0._frontItem then
		arg_50_0._frontItem:destroy()

		arg_50_0._frontItem = nil
	end

	if arg_50_0._navigateItem then
		arg_50_0._navigateItem:destroy()

		arg_50_0._navigateItem = nil
	end

	if arg_50_0._exitBtn then
		arg_50_0._exitBtn:destroy()

		arg_50_0._exitBtn = nil
	end
end

return var_0_0
