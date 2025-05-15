module("modules.logic.story.view.StoryView", package.seeall)

local var_0_0 = class("StoryView", BaseView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._imagefullbottom = gohelper.findChildImage(arg_1_0.viewGO, "#image_fullbottom")
	arg_1_0._gomiddle = gohelper.findChild(arg_1_0.viewGO, "#go_middle")
	arg_1_0._goimg2 = gohelper.findChild(arg_1_0.viewGO, "#go_middle/#go_img2")
	arg_1_0._govideo2 = gohelper.findChild(arg_1_0.viewGO, "#go_middle/#go_video2")
	arg_1_0._goeff2 = gohelper.findChild(arg_1_0.viewGO, "#go_middle/#go_eff2")
	arg_1_0._gocontentroot = gohelper.findChild(arg_1_0.viewGO, "#go_contentroot")
	arg_1_0._gonexticon = gohelper.findChild(arg_1_0.viewGO, "#go_contentroot/nexticon")
	arg_1_0._goconversation = gohelper.findChild(arg_1_0.viewGO, "#go_contentroot/#go_conversation")
	arg_1_0._goblackbottom = gohelper.findChild(arg_1_0.viewGO, "#go_contentroot/#go_conversation/blackBottom")
	arg_1_0._gohead = gohelper.findChild(arg_1_0.viewGO, "#go_contentroot/#go_conversation/#go_head")
	arg_1_0._goheadgrey = gohelper.findChild(arg_1_0.viewGO, "#go_contentroot/#go_conversation/#go_head/#go_headgrey")
	arg_1_0._simagehead = gohelper.findChildSingleImage(arg_1_0.viewGO, "#go_contentroot/#go_conversation/#go_head/#simage_head")
	arg_1_0._gospine = gohelper.findChild(arg_1_0.viewGO, "#go_contentroot/#go_conversation/#go_spine")
	arg_1_0._gonamebg = gohelper.findChild(arg_1_0.viewGO, "#go_contentroot/#go_conversation/#go_spine/#go_namebg")
	arg_1_0._gospineobj = gohelper.findChild(arg_1_0.viewGO, "#go_contentroot/#go_conversation/#go_spine/mask/#go_spineobj")
	arg_1_0._goname = gohelper.findChild(arg_1_0.viewGO, "#go_contentroot/#go_conversation/#go_name")
	arg_1_0._txtnamecn1 = gohelper.findChildText(arg_1_0.viewGO, "#go_contentroot/#go_conversation/#go_name/namelayout/#txt_namecn1")
	arg_1_0._txtnamecn2 = gohelper.findChildText(arg_1_0.viewGO, "#go_contentroot/#go_conversation/#go_name/namelayout/#txt_namecn2")
	arg_1_0._txtnameen = gohelper.findChildText(arg_1_0.viewGO, "#go_contentroot/#go_conversation/#go_name/namelayout/#txt_nameen")
	arg_1_0._gocontents = gohelper.findChild(arg_1_0.viewGO, "#go_contentroot/#go_conversation/#go_contents")
	arg_1_0._gonoconversation = gohelper.findChild(arg_1_0.viewGO, "#go_contentroot/#go_noconversation")
	arg_1_0._gotop = gohelper.findChild(arg_1_0.viewGO, "#go_top")
	arg_1_0._goimg3 = gohelper.findChild(arg_1_0.viewGO, "#go_top/#go_img3")
	arg_1_0._govideo3 = gohelper.findChild(arg_1_0.viewGO, "#go_top/#go_video3")
	arg_1_0._goeff3 = gohelper.findChild(arg_1_0.viewGO, "#go_top/#go_eff3")

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	return
end

function var_0_0.removeEvents(arg_3_0)
	return
end

function var_0_0._btnnextOnClick(arg_4_0)
	if StoryModel.instance:isViewHide() then
		StoryModel.instance:setViewHide(false)
		gohelper.setActive(arg_4_0._gocontentroot, StoryModel.instance:isNormalStep())
		StoryController.instance:dispatchEvent(StoryEvent.LeadRoleViewShow, StoryModel.instance:isNormalStep())

		return
	end

	if StoryModel.instance:isStoryAuto() then
		return
	end

	if not arg_4_0._stepCo or arg_4_0._stepCo.conversation.type == StoryEnum.ConversationType.None or arg_4_0._stepCo.conversation.type == StoryEnum.ConversationType.NoInteract or arg_4_0._stepCo.conversation.type == StoryEnum.ConversationType.ScreenDialog or arg_4_0._stepCo.conversation.type == StoryEnum.ConversationType.IrregularShake then
		return
	end

	if StoryModel.instance:isNormalStep() then
		if StoryModel.instance:isTextShowing() then
			arg_4_0._dialogItem:conFinished()
			arg_4_0:_conFinished()
		else
			arg_4_0:_enterNextStep()
		end
	end
end

function var_0_0._btnhideOnClick(arg_5_0)
	StoryController.instance:dispatchEvent(StoryEvent.LeadRoleViewShow, false)
	gohelper.setActive(arg_5_0._gocontentroot, false)
end

function var_0_0._btnlogOnClick(arg_6_0)
	StoryController.instance:openStoryLogView()
end

function var_0_0._btnautoOnClick(arg_7_0)
	if arg_7_0._stepCo.conversation.type ~= StoryEnum.ConversationType.None and arg_7_0._stepCo.conversation.type ~= StoryEnum.ConversationType.NoInteract and arg_7_0._stepCo.conversation.type ~= StoryEnum.ConversationType.ScreenDialog and arg_7_0._stepCo.conversation.type ~= StoryEnum.ConversationType.IrregularShake then
		arg_7_0._dialogItem:startAutoEnterNext()
	end
end

function var_0_0._btnskipOnClick(arg_8_0, arg_8_1)
	if not arg_8_1 and not StoryModel.instance:isNormalStep() then
		return
	end

	StoryTool.enablePostProcess(true)
	arg_8_0:_skipStep(arg_8_1)
end

function var_0_0._editableInitView(arg_9_0)
	arg_9_0:_initData()
	arg_9_0:_initView()
end

function var_0_0.addEvent(arg_10_0)
	arg_10_0:addEventCb(StoryController.instance, StoryEvent.RefreshStep, arg_10_0._onUpdateUI, arg_10_0)
	arg_10_0:addEventCb(StoryController.instance, StoryEvent.AllStepFinished, arg_10_0._storyFinished, arg_10_0)
	arg_10_0:addEventCb(StoryController.instance, StoryEvent.RefreshView, arg_10_0._refreshView, arg_10_0)
	arg_10_0:addEventCb(StoryController.instance, StoryEvent.RefreshConversation, arg_10_0._updateConversation, arg_10_0)
	arg_10_0:addEventCb(StoryController.instance, StoryEvent.Log, arg_10_0._btnlogOnClick, arg_10_0)
	arg_10_0:addEventCb(StoryController.instance, StoryEvent.Hide, arg_10_0._btnhideOnClick, arg_10_0)
	arg_10_0:addEventCb(StoryController.instance, StoryEvent.Auto, arg_10_0._btnautoOnClick, arg_10_0)
	arg_10_0:addEventCb(StoryController.instance, StoryEvent.Skip, arg_10_0._btnskipOnClick, arg_10_0)
	arg_10_0:addEventCb(StoryController.instance, StoryEvent.EnterNextStep, arg_10_0._btnnextOnClick, arg_10_0)
	arg_10_0:addEventCb(StoryController.instance, StoryEvent.Finish, arg_10_0._clearItems, arg_10_0)
	arg_10_0:addEventCb(StoryController.instance, StoryEvent.FullTextLineShowFinished, arg_10_0._onFullTextShowFinished, arg_10_0)
	arg_10_0:addEventCb(StoryController.instance, StoryEvent.HideDialog, arg_10_0._hideDialog, arg_10_0)
	arg_10_0:addEventCb(StoryController.instance, StoryEvent.DialogConFinished, arg_10_0._dialogConFinished, arg_10_0)
end

function var_0_0.removeEvent(arg_11_0)
	arg_11_0:removeEventCb(StoryController.instance, StoryEvent.RefreshStep, arg_11_0._onUpdateUI, arg_11_0)
	arg_11_0:removeEventCb(StoryController.instance, StoryEvent.AllStepFinished, arg_11_0._storyFinished, arg_11_0)
	arg_11_0:removeEventCb(StoryController.instance, StoryEvent.RefreshView, arg_11_0._refreshView, arg_11_0)
	arg_11_0:removeEventCb(StoryController.instance, StoryEvent.RefreshConversation, arg_11_0._updateConversation, arg_11_0)
	arg_11_0:removeEventCb(StoryController.instance, StoryEvent.Log, arg_11_0._btnlogOnClick, arg_11_0)
	arg_11_0:removeEventCb(StoryController.instance, StoryEvent.Hide, arg_11_0._btnhideOnClick, arg_11_0)
	arg_11_0:removeEventCb(StoryController.instance, StoryEvent.Auto, arg_11_0._btnautoOnClick, arg_11_0)
	arg_11_0:removeEventCb(StoryController.instance, StoryEvent.Skip, arg_11_0._btnskipOnClick, arg_11_0)
	arg_11_0:removeEventCb(StoryController.instance, StoryEvent.EnterNextStep, arg_11_0._btnnextOnClick, arg_11_0)
	arg_11_0:removeEventCb(StoryController.instance, StoryEvent.Finish, arg_11_0._clearItems, arg_11_0)
	arg_11_0:removeEventCb(StoryController.instance, StoryEvent.FullTextLineShowFinished, arg_11_0._onFullTextShowFinished, arg_11_0)
	arg_11_0:removeEventCb(StoryController.instance, StoryEvent.HideDialog, arg_11_0._hideDialog, arg_11_0)
	arg_11_0:removeEventCb(StoryController.instance, StoryEvent.DialogConFinished, arg_11_0._dialogConFinished, arg_11_0)
end

function var_0_0._initData(arg_12_0)
	arg_12_0._stepId = 0
	arg_12_0._audios = {}
	arg_12_0._pictures = {}
	arg_12_0._effects = {}
	arg_12_0._videos = {}
	arg_12_0._initFullBottomAlpha = arg_12_0._imagefullbottom.color.a

	StoryModel.instance:resetStoryState()
end

function var_0_0._initView(arg_13_0)
	arg_13_0._conCanvasGroup = arg_13_0._gocontentroot:GetComponent(typeof(UnityEngine.CanvasGroup))
	arg_13_0._contentAnimator = arg_13_0._goconversation:GetComponent(typeof(UnityEngine.Animator))

	local var_13_0 = ViewMgr.instance:getContainer(ViewName.StoryBackgroundView).viewGO

	arg_13_0._gobottom = gohelper.findChild(var_13_0, "#go_bottomitem")
	arg_13_0._goimg1 = gohelper.findChild(var_13_0, "#go_bottomitem/#go_img1")
	arg_13_0._govideo1 = gohelper.findChild(var_13_0, "#go_bottomitem/#go_video1")
	arg_13_0._goeff1 = gohelper.findChild(var_13_0, "#go_bottomitem/#go_eff1")

	gohelper.setActive(arg_13_0._gocontentroot, false)
	arg_13_0:_initItems()
end

function var_0_0.onOpen(arg_14_0)
	arg_14_0:addEvent()
	ViewMgr.instance:openView(ViewName.StoryFrontView, nil, true)
	gohelper.setActive(arg_14_0.viewGO, true)
	SpineFpsMgr.instance:set(SpineFpsMgr.Story)

	if UnityEngine.Shader.IsKeywordEnabled("_MAININTERFACELIGHT") then
		arg_14_0._keywordEnable = true

		UnityEngine.Shader.DisableKeyword("_MAININTERFACELIGHT")
	end

	arg_14_0:_clearItems()
end

function var_0_0._initItems(arg_15_0)
	if not arg_15_0._dialogItem then
		arg_15_0._dialogItem = StoryDialogItem.New()

		arg_15_0._dialogItem:init(arg_15_0._gocontentroot)
		arg_15_0._dialogItem:hideDialog()
	end
end

function var_0_0._hideDialog(arg_16_0)
	if arg_16_0._dialogItem then
		if StoryModel.instance:isTextShowing() then
			arg_16_0._dialogItem:conFinished()
			arg_16_0:_conFinished()
		end

		gohelper.setActive(arg_16_0._gocontentroot, false)
	end
end

function var_0_0._dialogConFinished(arg_17_0)
	if arg_17_0._dialogItem and StoryModel.instance:isTextShowing() then
		arg_17_0._dialogItem:conFinished()
		arg_17_0:_conFinished()
	end
end

function var_0_0._storyFinished(arg_18_0, arg_18_1)
	arg_18_0._stepId = 0
	arg_18_0._finished = true
	arg_18_0._stepCo = nil

	TaskDispatcher.cancelTask(arg_18_0._onCheckNext, arg_18_0)
	arg_18_0._dialogItem:storyFinished()
	StoryModel.instance:enableClick(false)

	if arg_18_0._dialogItem then
		arg_18_0._dialogItem:stopConAudio()
	end

	if StoryController.instance._hideStartAndEndDark then
		arg_18_0:stopAllAudio(1.5)
		gohelper.setActive(arg_18_0._gospine, false)

		if arg_18_0._confadeId then
			ZProj.TweenHelper.KillById(arg_18_0._confadeId)
		end

		arg_18_0._confadeId = ZProj.TweenHelper.DOFadeCanvasGroup(arg_18_0._gocontentroot, 1, 0, 0.35, nil, nil, nil, EaseType.Linear)

		return
	end

	if StoryModel.instance:isTypeSkip(StoryEnum.SkipType.OutDarkFade, StoryController.instance._curStoryId) then
		return
	end

	arg_18_0:stopAllAudio(1.5)
end

function var_0_0.onClose(arg_19_0)
	if not arg_19_0._finished then
		arg_19_0:stopAllAudio(0)
	end

	if arg_19_0._keywordEnable then
		UnityEngine.Shader.EnableKeyword("_MAININTERFACELIGHT")
	end

	arg_19_0:removeEvent()
	TaskDispatcher.cancelTask(arg_19_0._viewFadeIn, arg_19_0)
	arg_19_0:_clearItems()
	SpineFpsMgr.instance:remove(SpineFpsMgr.Story)
end

function var_0_0.onUpdateParam(arg_20_0)
	return
end

function var_0_0._enterNextStep(arg_21_0)
	StoryController.instance:dispatchEvent(StoryEvent.PlayFullTextOut)

	if arg_21_0._diaLineTxt and arg_21_0._diaLineTxt[2] then
		local var_21_0, var_21_1, var_21_2 = transformhelper.getLocalPos(arg_21_0._diaLineTxt[2].transform)

		transformhelper.setLocalPos(arg_21_0._diaLineTxt[2].transform, var_21_0, var_21_1, 1)
	end

	TaskDispatcher.cancelTask(arg_21_0._enterNextStep, arg_21_0)
	StoryController.instance:enterNext()
end

function var_0_0._skipStep(arg_22_0, arg_22_1)
	StoryModel.instance:enableClick(false)
	TaskDispatcher.cancelTask(arg_22_0._enterNextStep, arg_22_0)
	TaskDispatcher.cancelTask(arg_22_0._playShowHero, arg_22_0)

	if arg_22_1 then
		StoryController.instance:skipAllStory()
	else
		StoryController.instance:skipStory()
	end
end

function var_0_0._onCheckNext(arg_23_0)
	arg_23_0:_onConFinished(arg_23_0._stepCo.conversation.isAuto)
end

function var_0_0._onUpdateUI(arg_24_0, arg_24_1)
	arg_24_0._finished = false

	StoryModel.instance:setStepNormal(arg_24_1.stepType == StoryEnum.StepType.Normal)

	if arg_24_0._gocontentroot.activeSelf ~= StoryModel.instance:isNormalStep() then
		gohelper.setActive(arg_24_0._gocontentroot, not StoryModel.instance:isNormalStep())
		StoryController.instance:dispatchEvent(StoryEvent.LeadRoleViewShow, not StoryModel.instance:isNormalStep())
	end

	if arg_24_0._curStoryId ~= arg_24_1.storyId and #arg_24_1.branches < 1 then
		arg_24_0:_clearItems()

		arg_24_0._curStoryId = arg_24_1.storyId
	end

	arg_24_0:_updateStep(arg_24_1.stepId)
	StoryController.instance:dispatchEvent(StoryEvent.RefreshHero, arg_24_1)

	if #arg_24_1.branches > 0 then
		StoryController.instance:openStoryBranchView(arg_24_1.branches)
		arg_24_0:_showBranchLeadHero()
	else
		gohelper.setActive(arg_24_0._gonoconversation, false)
	end

	StoryModel.instance:clearStepLine()
end

function var_0_0._showBranchLeadHero(arg_25_0)
	arg_25_0._dialogItem:hideDialog()
	arg_25_0._dialogItem:stopConAudio()

	if arg_25_0._confadeId then
		ZProj.TweenHelper.KillById(arg_25_0._confadeId)
	end

	TaskDispatcher.cancelTask(arg_25_0._conShowIn, arg_25_0)
	TaskDispatcher.cancelTask(arg_25_0._startShowText, arg_25_0)
	TaskDispatcher.cancelTask(arg_25_0._startShake, arg_25_0)
	TaskDispatcher.cancelTask(arg_25_0._shakeStop, arg_25_0)
	TaskDispatcher.cancelTask(arg_25_0._enterNextStep, arg_25_0)

	arg_25_0._conCanvasGroup.alpha = 1

	gohelper.setActive(arg_25_0._goname, true)
	gohelper.setActive(arg_25_0._txtnameen.gameObject, true)
	gohelper.setActive(arg_25_0._gocontentroot, true)
	gohelper.setActive(arg_25_0._gonoconversation, true)

	local var_25_0

	for iter_25_0, iter_25_1 in pairs(arg_25_0._stepCo.optList) do
		if iter_25_1.condition and iter_25_1.conditionType == StoryEnum.OptionConditionType.NormalLead then
			arg_25_0:_showNormalLeadHero(iter_25_1)

			return
		elseif iter_25_1.condition and iter_25_1.conditionType == StoryEnum.OptionConditionType.MainSpine then
			arg_25_0:_showSpineLeadHero(iter_25_1)

			return
		end
	end

	arg_25_0:_showSpineLeadHero()
end

function var_0_0._showNormalLeadHero(arg_26_0, arg_26_1)
	gohelper.setActive(arg_26_0._gohead, true)
	gohelper.setActive(arg_26_0._gospine, false)

	local var_26_0 = arg_26_1.conditionValue2[GameLanguageMgr.instance:getLanguageTypeStoryIndex()]
	local var_26_1 = arg_26_1.conditionValue2[LanguageEnum.LanguageStoryType.EN]

	arg_26_0:_showHeadContentTxt(var_26_0, var_26_1)
	arg_26_0:_showHeadContentIcon(arg_26_1.conditionValue)
end

function var_0_0._showSpineLeadHero(arg_27_0, arg_27_1)
	local var_27_0 = arg_27_1 and string.split(arg_27_1.conditionValue, ".")[1] or nil

	StoryController.instance:dispatchEvent(StoryEvent.LeadRoleViewShow, true, var_27_0)
	gohelper.setActive(arg_27_0._gohead, false)
	gohelper.setActive(arg_27_0._gospine, true)

	arg_27_0._txtnamecn1.text = luaLang("mainrolename")
	arg_27_0._txtnamecn2.text = luaLang("mainrolename")
	arg_27_0._txtnameen.text = "<voffset=4>/ </voffset>Vertin"

	if arg_27_1 then
		return
	end

	local var_27_1 = 1

	if arg_27_0._stepCo and arg_27_0._stepCo.optList[1] and arg_27_0._stepCo.optList[1].feedbackType == StoryEnum.OptionFeedbackType.HeroLead then
		var_27_1 = arg_27_0._stepCo.optList[1].feedbackValue ~= "" and tonumber(arg_27_0._stepCo.optList[1].feedbackValue) or 1
	end

	StoryController.instance:dispatchEvent(StoryEvent.ShowLeadRole, arg_27_0._stepCo, true, false, false, var_27_1)
end

function var_0_0._updateStep(arg_28_0, arg_28_1)
	if not StoryModel.instance:isNormalStep() and not arg_28_0._skip then
		return
	end

	arg_28_0._stepCo = StoryStepModel.instance:getStepListById(arg_28_1)

	if arg_28_0._stepCo.conversation.effType == StoryEnum.ConversationEffectType.SoftLight then
		gohelper.setActive(arg_28_0._goline, false)
		gohelper.setActive(arg_28_0._gonexticon, false)
		gohelper.setActive(arg_28_0._goblackbottom, false)
	else
		gohelper.setActive(arg_28_0._goline, true)
		gohelper.setActive(arg_28_0._gonexticon, true)
		gohelper.setActive(arg_28_0._goblackbottom, true)
	end

	if arg_28_0._stepCo.bg.transType ~= StoryEnum.BgTransType.DarkFade and arg_28_0._stepCo.bg.transType ~= StoryEnum.BgTransType.WhiteFade then
		arg_28_0:_refreshView()
	else
		arg_28_0:_updateEffectList(arg_28_0._stepCo.effList)
		arg_28_0:_updateAudioList(arg_28_0._stepCo.audioList)
	end
end

function var_0_0._refreshView(arg_29_0)
	arg_29_0:_updateEffectList(arg_29_0._stepCo.effList)
	arg_29_0:_updateAudioList(arg_29_0._stepCo.audioList)
	arg_29_0:_updatePictureList(arg_29_0._stepCo.picList)
	arg_29_0:_updateVideoList(arg_29_0._stepCo.videoList)
	arg_29_0:_updateNavigateList(arg_29_0._stepCo.navigateList)
	arg_29_0:_updateOptionList(arg_29_0._stepCo.optList)
end

function var_0_0._updateConversation(arg_30_0)
	if not arg_30_0._stepCo then
		return
	end

	if not arg_30_0._stepId then
		arg_30_0._stepId = 0

		return
	end

	if arg_30_0._storyId and arg_30_0._storyId == arg_30_0._curStoryId and arg_30_0._stepId == arg_30_0._stepCo.id then
		arg_30_0._stepId = 0

		return
	end

	StoryModel.instance:enableClick(false)

	arg_30_0._stepId = arg_30_0._stepCo.id
	arg_30_0._storyId = arg_30_0._curStoryId

	if arg_30_0._confadeId then
		ZProj.TweenHelper.KillById(arg_30_0._confadeId)
	end

	TaskDispatcher.cancelTask(arg_30_0._conShowIn, arg_30_0)
	TaskDispatcher.cancelTask(arg_30_0._onEnableClick, arg_30_0)
	TaskDispatcher.cancelTask(arg_30_0._enterNextStep, arg_30_0)
	TaskDispatcher.cancelTask(arg_30_0._onFullTextFinished, arg_30_0)
	TaskDispatcher.cancelTask(arg_30_0._startShowText, arg_30_0)
	TaskDispatcher.cancelTask(arg_30_0._onCheckNext, arg_30_0)

	if arg_30_0._stepCo.conversation.type ~= StoryEnum.ConversationType.None then
		StoryModel.instance:setTextShowing(true)
	end

	if StoryModel.instance:isNeedFadeOut() then
		if arg_30_0._gospine.activeSelf then
			StoryController.instance:dispatchEvent(StoryEvent.ShowLeadRole, arg_30_0._stepCo, true, false, true)
		end

		arg_30_0._confadeId = ZProj.TweenHelper.DOFadeCanvasGroup(arg_30_0._gocontentroot, 1, 0, 0.35, nil, nil, nil, EaseType.Linear)

		if not StoryModel.instance:isPlayFinished() then
			TaskDispatcher.runDelay(arg_30_0._conShowIn, arg_30_0, 0.35)
		end
	else
		arg_30_0:_conShowIn()
	end
end

function var_0_0._conShowIn(arg_31_0)
	if not arg_31_0._stepCo then
		return
	end

	arg_31_0._diatxt = StoryTool.getFilterDia(arg_31_0._stepCo.conversation.diaTexts[GameLanguageMgr.instance:getLanguageTypeStoryIndex()])

	arg_31_0._dialogItem:hideDialog()
	TaskDispatcher.cancelTask(arg_31_0._enterNextStep, arg_31_0)
	TaskDispatcher.cancelTask(arg_31_0._onFullTextFinished, arg_31_0)
	TaskDispatcher.cancelTask(arg_31_0._startShowText, arg_31_0)

	if arg_31_0._stepCo.conversation.type == StoryEnum.ConversationType.None then
		arg_31_0:_showConversationItem(false)
		TaskDispatcher.runDelay(arg_31_0._enterNextStep, arg_31_0, arg_31_0._stepCo.conversation.delayTimes[GameLanguageMgr.instance:getVoiceTypeStoryIndex()])
	else
		StoryController.instance:dispatchEvent(StoryEvent.SetFullText, "")

		if arg_31_0._stepCo.conversation.type == StoryEnum.ConversationType.NoInteract then
			StoryModel.instance:enableClick(false)
			TaskDispatcher.runDelay(arg_31_0._enterNextStep, arg_31_0, arg_31_0._stepCo.conversation.delayTimes[GameLanguageMgr.instance:getVoiceTypeStoryIndex()])
		end

		arg_31_0:_showConversationItem(true)
	end

	if StoryModel.instance:isNeedFadeIn() then
		if arg_31_0._gospine.activeSelf then
			StoryController.instance:dispatchEvent(StoryEvent.ShowLeadRole, arg_31_0._stepCo, true, true, false)
		end

		arg_31_0._confadeId = ZProj.TweenHelper.DOFadeCanvasGroup(arg_31_0._gocontentroot, 0, 1, 0.5, nil, nil, nil, EaseType.Linear)

		TaskDispatcher.runDelay(arg_31_0._startShowText, arg_31_0, 0.5)
	else
		arg_31_0:_startShowText()
	end
end

function var_0_0._startShowText(arg_32_0)
	if not arg_32_0._stepCo then
		return
	end

	arg_32_0._conCanvasGroup.alpha = 1

	if arg_32_0._stepCo.conversation.effType ~= StoryEnum.ConversationEffectType.Shake then
		StoryController.instance:dispatchEvent(StoryEvent.ConversationShake, arg_32_0._stepCo, 0, true)
		TaskDispatcher.cancelTask(arg_32_0._startShake, arg_32_0)
		TaskDispatcher.cancelTask(arg_32_0._shakeStop, arg_32_0)
		arg_32_0._contentAnimator:Play(UIAnimationName.Idle)
	end

	arg_32_0:_showText()
end

function var_0_0._showConversationItem(arg_33_0, arg_33_1)
	local var_33_0 = arg_33_0._stepCo.conversation.type ~= StoryEnum.ConversationType.ScreenDialog and arg_33_0._stepCo.conversation.type ~= StoryEnum.ConversationType.IrregularShake
	local var_33_1 = arg_33_0._stepCo.conversation.type == StoryEnum.ConversationType.SlideDialog

	if not arg_33_1 then
		gohelper.setActive(arg_33_0._gocontentroot, false)
		arg_33_0._simagehead:UnLoadImage()
		StoryController.instance:dispatchEvent(StoryEvent.LeadRoleViewShow, false)

		return
	end

	StoryController.instance:dispatchEvent(StoryEvent.SetFullText, arg_33_0._diatxt)
	gohelper.setActive(arg_33_0._gobtns, var_33_0)
	gohelper.setActive(arg_33_0._gocontentroot, var_33_0)
	gohelper.setActive(arg_33_0._goconversation, not var_33_1)
	StoryController.instance:dispatchEvent(StoryEvent.LeadRoleViewShow, var_33_0)

	local var_33_2 = arg_33_0._stepCo.conversation.heroNames[GameLanguageMgr.instance:getLanguageTypeStoryIndex()]
	local var_33_3 = arg_33_0._stepCo.conversation.heroNames[LanguageEnum.LanguageStoryType.EN]

	arg_33_0:_showHeadContentTxt(var_33_2, var_33_3)
	gohelper.setActive(arg_33_0._goname, arg_33_0._stepCo.conversation.nameShow)
	gohelper.setActive(arg_33_0._txtnameen.gameObject, arg_33_0._stepCo.conversation.nameEnShow)

	if not arg_33_0._stepCo.conversation.iconShow then
		gohelper.setActive(arg_33_0._gohead, false)
		gohelper.setActive(arg_33_0._gospine, false)
		arg_33_0._simagehead:UnLoadImage()
		StoryController.instance:dispatchEvent(StoryEvent.ShowLeadRole, arg_33_0._stepCo, false, false, false)

		return
	end

	arg_33_0:_showHeadContentIcon(arg_33_0._stepCo.conversation.heroIcon)
end

function var_0_0._showHeadContentTxt(arg_34_0, arg_34_1, arg_34_2)
	local var_34_0 = string.find(arg_34_1, "?")

	gohelper.setActive(arg_34_0._txtnamecn1.gameObject, not var_34_0)
	gohelper.setActive(arg_34_0._txtnamecn2.gameObject, var_34_0)

	if var_34_0 then
		arg_34_0._txtnamecn2.text = string.split(arg_34_1, "_")[1]
	else
		arg_34_0._txtnamecn1.text = string.split(arg_34_1, "_")[1]
	end

	local var_34_1 = arg_34_2 ~= "" and "<voffset=4>/ </voffset>" .. arg_34_2 or ""

	arg_34_0._txtnameen.text = var_34_1
end

function var_0_0._showHeadContentIcon(arg_35_0, arg_35_1)
	if arg_35_0._goeffectIcon then
		gohelper.destroy(arg_35_0._goeffectIcon)

		arg_35_0._goeffectIcon = nil
	end

	if arg_35_0:_isHeroLead() then
		gohelper.setActive(arg_35_0._gohead, false)
		gohelper.setActive(arg_35_0._gospine, true)
		StoryController.instance:dispatchEvent(StoryEvent.ShowLeadRole, arg_35_0._stepCo, true, false, false)
	else
		gohelper.setActive(arg_35_0._gospine, false)
		gohelper.setActive(arg_35_0._gohead, true)

		local var_35_0 = StoryModel.instance:isHeroIconCuts(string.split(arg_35_1, ".")[1])

		gohelper.setActive(arg_35_0._goheadblack, not var_35_0)
		gohelper.setActive(arg_35_0._goheadgrey, false)
		StoryController.instance:dispatchEvent(StoryEvent.ShowLeadRole, arg_35_0._stepCo, false, false, false)

		local var_35_1 = arg_35_0:_getEffectHeadIconCo()

		if var_35_1 then
			arg_35_0._headEffectResPath = ResUrl.getStoryPrefabRes(var_35_1.path)

			local var_35_2 = {}

			table.insert(var_35_2, arg_35_0._headEffectResPath)
			arg_35_0:loadRes(var_35_2, arg_35_0._headEffectResLoaded, arg_35_0)
			gohelper.setActive(arg_35_0._goheadgrey, true)
		else
			local var_35_3 = string.format("singlebg/headicon_small/%s", arg_35_1)

			if arg_35_0._simagehead.curImageUrl == var_35_3 then
				gohelper.setActive(arg_35_0._goheadgrey, true)
			else
				arg_35_0._simagehead:LoadImage(var_35_3, function()
					gohelper.setActive(arg_35_0._goheadgrey, true)
				end)
			end
		end
	end
end

function var_0_0._headEffectResLoaded(arg_37_0)
	if arg_37_0._headEffectResPath then
		local var_37_0 = arg_37_0._loader:getAssetItem(arg_37_0._headEffectResPath)

		arg_37_0._goeffectIcon = gohelper.clone(var_37_0:GetResource(), arg_37_0._gohead)
	end
end

function var_0_0.loadRes(arg_38_0, arg_38_1, arg_38_2, arg_38_3)
	if arg_38_0._loader then
		arg_38_0._loader:dispose()

		arg_38_0._loader = nil
	end

	if arg_38_1 and #arg_38_1 > 0 then
		arg_38_0._loader = MultiAbLoader.New()

		arg_38_0._loader:setPathList(arg_38_1)
		arg_38_0._loader:startLoad(arg_38_2, arg_38_3)
	elseif arg_38_2 then
		arg_38_2(arg_38_3)
	end
end

function var_0_0._getEffectHeadIconCo(arg_39_0)
	local var_39_0 = string.split(arg_39_0._stepCo.conversation.heroIcon, ".")[1]
	local var_39_1 = StoryConfig.instance:getStoryLeadHeroSpine()

	for iter_39_0, iter_39_1 in ipairs(var_39_1) do
		if iter_39_1.resType == StoryEnum.IconResType.IconEff and iter_39_1.icon == var_39_0 then
			return iter_39_1
		end
	end

	return nil
end

function var_0_0._isHeroLead(arg_40_0)
	local var_40_0 = string.split(arg_40_0._stepCo.conversation.heroIcon, ".")[1]
	local var_40_1 = StoryConfig.instance:getStoryLeadHeroSpine()

	for iter_40_0, iter_40_1 in ipairs(var_40_1) do
		if iter_40_1.resType == StoryEnum.IconResType.Spine and iter_40_1.icon == var_40_0 then
			return true
		end
	end

	return false
end

function var_0_0._showText(arg_41_0)
	if arg_41_0._stepCo.conversation.type == StoryEnum.ConversationType.None then
		arg_41_0._dialogItem:stopConAudio()

		return
	end

	StoryModel.instance:setTextShowing(true)

	if arg_41_0._stepCo.conversation.type == StoryEnum.ConversationType.ScreenDialog then
		StoryModel.instance:enableClick(false)
		arg_41_0:_playDialog()
		StoryController.instance:dispatchEvent(StoryEvent.PlayFullText, arg_41_0._stepCo)
	elseif arg_41_0._stepCo.conversation.type == StoryEnum.ConversationType.IrregularShake then
		StoryModel.instance:enableClick(false)
		arg_41_0:_playDialog()
		StoryController.instance:dispatchEvent(StoryEvent.PlayIrregularShakeText, arg_41_0._stepCo)
	else
		StoryModel.instance:enableClick(true)
		arg_41_0:_playDialog()
	end

	if arg_41_0._stepCo.conversation.effType == StoryEnum.ConversationEffectType.Shake then
		arg_41_0:_shakeDialog()
	elseif arg_41_0._stepCo.conversation.effType == StoryEnum.ConversationEffectType.Fade then
		arg_41_0:_fadeIn()
	elseif arg_41_0._stepCo.conversation.effType == StoryEnum.ConversationEffectType.WordByWord then
		-- block empty
	elseif arg_41_0._stepCo.conversation.effType == StoryEnum.ConversationEffectType.LineByLine then
		arg_41_0:_lineShow(1)
	elseif arg_41_0._stepCo.conversation.effType == StoryEnum.ConversationEffectType.TwoLineShow then
		arg_41_0:_lineShow(2)
	end
end

function var_0_0._playDialog(arg_42_0)
	arg_42_0._finishTime = nil

	arg_42_0._dialogItem:hideDialog()
	arg_42_0._dialogItem:playDialog(arg_42_0._diatxt, arg_42_0._stepCo, arg_42_0._conFinished, arg_42_0)
end

function var_0_0._conFinished(arg_43_0)
	StoryModel.instance:setTextShowing(false)

	if arg_43_0._conTweenId then
		ZProj.TweenHelper.KillById(arg_43_0._conTweenId)

		arg_43_0._conTweenId = nil
	end

	local var_43_0 = false
	local var_43_1 = arg_43_0._stepCo and arg_43_0._stepCo.conversation.keepTimes[GameLanguageMgr.instance:getVoiceTypeStoryIndex()] or 1.5

	if StoryModel.instance:isStoryAuto() then
		if not arg_43_0._finishTime then
			arg_43_0._finishTime = ServerTime.now()
		end

		var_43_0 = var_43_1 < ServerTime.now() - arg_43_0._finishTime
	end

	arg_43_0._finishTime = ServerTime.now()

	if var_43_0 then
		arg_43_0:_onCheckNext()
	else
		TaskDispatcher.runDelay(arg_43_0._onCheckNext, arg_43_0, var_43_1)
	end
end

function var_0_0._shakeDialog(arg_44_0)
	TaskDispatcher.cancelTask(arg_44_0._startShake, arg_44_0)
	TaskDispatcher.cancelTask(arg_44_0._shakeStop, arg_44_0)

	if arg_44_0._stepCo.conversation.effTimes[GameLanguageMgr.instance:getVoiceTypeStoryIndex()] < 0.1 then
		return
	end

	if arg_44_0._stepCo.conversation.effDelayTimes[GameLanguageMgr.instance:getVoiceTypeStoryIndex()] < 0.1 then
		arg_44_0:_startShake()
	else
		TaskDispatcher.runDelay(arg_44_0._startShake, arg_44_0, arg_44_0._stepCo.conversation.effDelayTimes[GameLanguageMgr.instance:getVoiceTypeStoryIndex()])
	end
end

function var_0_0._startShake(arg_45_0)
	TaskDispatcher.cancelTask(arg_45_0._shakeStop, arg_45_0)

	local var_45_0 = {
		"low",
		"middle",
		"high"
	}

	arg_45_0._contentAnimator:Play(var_45_0[arg_45_0._stepCo.conversation.effLv + 1])

	arg_45_0._contentAnimator.speed = arg_45_0._stepCo.conversation.effRate

	TaskDispatcher.runDelay(arg_45_0._shakeStop, arg_45_0, arg_45_0._stepCo.conversation.effTimes[GameLanguageMgr.instance:getVoiceTypeStoryIndex()])
	StoryController.instance:dispatchEvent(StoryEvent.ConversationShake, arg_45_0._stepCo, true, arg_45_0._stepCo.conversation.effLv + 1)
end

function var_0_0._shakeStop(arg_46_0)
	if not arg_46_0._stepCo then
		return
	end

	StoryController.instance:dispatchEvent(StoryEvent.ConversationShake, arg_46_0._stepCo, false, arg_46_0._stepCo.conversation.effLv + 1)

	arg_46_0._contentAnimator.speed = arg_46_0._stepCo.conversation.effRate

	arg_46_0._contentAnimator:SetBool("stoploop", true)
end

function var_0_0._fadeIn(arg_47_0)
	StoryModel.instance:setTextShowing(true)
	arg_47_0._dialogItem:playNorDialogFadeIn(arg_47_0._fadeInFinished, arg_47_0)
end

function var_0_0._fadeInFinished(arg_48_0)
	if not arg_48_0._stepCo then
		return
	end

	StoryModel.instance:setTextShowing(false)
	TaskDispatcher.cancelTask(arg_48_0._onCheckNext, arg_48_0)
	TaskDispatcher.runDelay(arg_48_0._onCheckNext, arg_48_0, arg_48_0._stepCo.conversation.delayTimes[GameLanguageMgr.instance:getVoiceTypeStoryIndex()])
end

function var_0_0._wordByWord(arg_49_0)
	StoryModel.instance:setTextShowing(true)
	arg_49_0._dialogItem:playWordByWord(arg_49_0._wordByWordFinished, arg_49_0)
end

function var_0_0._wordByWordFinished(arg_50_0)
	StoryModel.instance:setTextShowing(false)
	TaskDispatcher.cancelTask(arg_50_0._onCheckNext, arg_50_0)

	if not arg_50_0._stepCo then
		return
	end

	TaskDispatcher.runDelay(arg_50_0._onCheckNext, arg_50_0, 1)
end

function var_0_0._lineShow(arg_51_0, arg_51_1)
	StoryModel.instance:enableClick(false)
	StoryModel.instance:setTextShowing(true)
	StoryController.instance:dispatchEvent(StoryEvent.PlayFullTextLineShow, arg_51_1, arg_51_0._stepCo)
end

function var_0_0._onFullTextShowFinished(arg_52_0)
	StoryModel.instance:setTextShowing(false)
	TaskDispatcher.cancelTask(arg_52_0._onFullTextFinished, arg_52_0)
	TaskDispatcher.runDelay(arg_52_0._onFullTextFinished, arg_52_0, arg_52_0._stepCo.conversation.keepTimes[GameLanguageMgr.instance:getVoiceTypeStoryIndex()])
end

function var_0_0._onFullTextFinished(arg_53_0)
	StoryModel.instance:enableClick(true)
	TaskDispatcher.cancelTask(arg_53_0._onFullTextFinished, arg_53_0)
	StoryController.instance:dispatchEvent(StoryEvent.PlayFullTextOut)
	arg_53_0:_onConFinished(true)
end

function var_0_0._onConFinished(arg_54_0, arg_54_1)
	if arg_54_1 then
		arg_54_0:_onAutoDialogFinished()

		return
	end

	if StoryModel.instance:isStoryAuto() then
		if arg_54_0._stepCo.conversation.type == StoryEnum.ConversationType.None or arg_54_0._stepCo.conversation.type == StoryEnum.ConversationType.NoInteract or arg_54_0._stepCo.conversation.type == StoryEnum.ConversationType.ScreenDialog or arg_54_0._stepCo.conversation.type == StoryEnum.ConversationType.IrregularShake then
			return
		end

		if arg_54_0._dialogItem then
			if arg_54_0._dialogItem:isAudioPlaying() then
				arg_54_0._dialogItem:checkAutoEnterNext(arg_54_0._onAutoDialogFinished, arg_54_0)
			else
				arg_54_0:_onAutoDialogFinished()
			end
		end
	end
end

function var_0_0._onAutoDialogFinished(arg_55_0)
	StoryController.instance:enterNext()
end

function var_0_0._onEnableClick(arg_56_0)
	if StoryModel.instance:isTextShowing() then
		return
	end

	StoryModel.instance:enableClick(true)
end

function var_0_0._updateAudioList(arg_57_0, arg_57_1)
	local var_57_0 = {}
	local var_57_1 = StoryModel.instance:getStepLine()
	local var_57_2 = 0

	for iter_57_0, iter_57_1 in pairs(var_57_1) do
		var_57_2 = var_57_2 + 1
	end

	if var_57_2 > 1 then
		arg_57_0:stopAllAudio(0)
	end

	local var_57_3 = false

	if var_57_1[arg_57_0._curStoryId] then
		for iter_57_2, iter_57_3 in ipairs(var_57_1[arg_57_0._curStoryId]) do
			if iter_57_3.skip then
				var_57_3 = true

				break
			end
		end
	end

	if var_57_3 then
		arg_57_0:stopAllAudio(0)
	end

	if arg_57_0._curStoryId and arg_57_0._curStoryId == StoryController.instance._curStoryId and arg_57_0._stepId and arg_57_0._stepId == StoryController.instance._curStepId and arg_57_0._audios then
		for iter_57_4, iter_57_5 in pairs(arg_57_1) do
			if not arg_57_0._audios[iter_57_5.audio] then
				return
			end
		end
	end

	arg_57_0._audioCo = arg_57_1

	for iter_57_6, iter_57_7 in pairs(arg_57_0._audioCo) do
		if not arg_57_0._audios then
			arg_57_0._audios = {}
		end

		if not arg_57_0._audios[iter_57_7.audio] then
			arg_57_0._audios[iter_57_7.audio] = StoryAudioItem.New()

			arg_57_0._audios[iter_57_7.audio]:init(iter_57_7.audio)
		end

		arg_57_0._audios[iter_57_7.audio]:setAudio(iter_57_7)
	end
end

function var_0_0.stopAllAudio(arg_58_0, arg_58_1)
	if arg_58_0._audios then
		for iter_58_0, iter_58_1 in pairs(arg_58_0._audios) do
			iter_58_1:stop(arg_58_1)
		end

		arg_58_0._audios = nil
	end
end

function var_0_0._updateEffectList(arg_59_0, arg_59_1)
	local var_59_0 = {}
	local var_59_1 = StoryModel.instance:getStepLine()
	local var_59_2 = 0

	for iter_59_0, iter_59_1 in pairs(var_59_1) do
		var_59_2 = var_59_2 + 1
	end

	if var_59_2 > 1 then
		for iter_59_2, iter_59_3 in pairs(arg_59_0._effects) do
			iter_59_3:onDestroy()
		end
	end

	if var_59_1[arg_59_0._curStoryId] then
		for iter_59_4, iter_59_5 in ipairs(var_59_1[arg_59_0._curStoryId]) do
			if iter_59_5.skip and iter_59_5.skip then
				local var_59_3 = StoryStepModel.instance:getStepListById(iter_59_5.stepId).effList

				for iter_59_6 = 1, #var_59_3 do
					table.insert(var_59_0, var_59_3[iter_59_6])

					if var_59_3[iter_59_6].orderType == StoryEnum.EffectOrderType.Destroy then
						for iter_59_7 = #var_59_0, 1, -1 do
							if var_59_0[iter_59_7].orderType ~= StoryEnum.EffectOrderType.Destroy and var_59_0[iter_59_7].effect == var_59_3[iter_59_6].effect then
								table.remove(var_59_0, #var_59_0)
								table.remove(var_59_0, iter_59_7)
							end
						end
					end
				end
			end
		end
	end

	if #arg_59_1 < 1 and #var_59_0 == 0 then
		return
	end

	arg_59_0._effCo = #var_59_0 == 0 and arg_59_1 or var_59_0

	local var_59_4 = false

	for iter_59_8, iter_59_9 in pairs(arg_59_0._effCo) do
		if iter_59_9.orderType ~= StoryEnum.EffectOrderType.Destroy and iter_59_9.layer > 0 then
			arg_59_0:_buildEffect(iter_59_9.effect, iter_59_9)
		else
			arg_59_0:_destroyEffect(iter_59_9.effect, iter_59_9)
		end

		if iter_59_9.layer < 4 then
			var_59_4 = true
		end
	end

	StoryTool.enablePostProcess(false)

	for iter_59_10, iter_59_11 in pairs(arg_59_0._effects) do
		StoryTool.enablePostProcess(true)
	end

	StoryModel.instance:setHasBottomEffect(var_59_4)
end

function var_0_0._buildEffect(arg_60_0, arg_60_1, arg_60_2)
	local var_60_0 = 0
	local var_60_1

	if arg_60_2.layer < 4 then
		var_60_1 = arg_60_0._goeff1
		var_60_0 = 4
	elseif arg_60_2.layer < 7 then
		var_60_1 = arg_60_0._goeff2
		var_60_0 = 1000
	elseif arg_60_2.layer < 10 then
		var_60_1 = arg_60_0._goeff3
		var_60_0 = 2000
	else
		if not arg_60_0._goeff4 then
			local var_60_2 = ViewMgr.instance:getContainer(ViewName.StoryFrontView).viewGO

			arg_60_0._goeff4 = gohelper.findChild(var_60_2, "#go_frontitem/#go_eff4")
		end

		var_60_1 = arg_60_0._goeff4
	end

	if not arg_60_0._effects[arg_60_1] then
		arg_60_0._effects[arg_60_1] = StoryEffectItem.New()

		arg_60_0._effects[arg_60_1]:init(var_60_1, arg_60_1, arg_60_2, var_60_0)
	else
		arg_60_0._effects[arg_60_1]:reset(var_60_1, arg_60_2, var_60_0)
	end
end

function var_0_0._destroyEffect(arg_61_0, arg_61_1, arg_61_2)
	if not arg_61_0._effects[arg_61_1] then
		return
	end

	arg_61_0._effects[arg_61_1]:destroyEffect(arg_61_2)

	arg_61_0._effects[arg_61_1] = nil
end

function var_0_0._updatePictureList(arg_62_0, arg_62_1)
	local var_62_0 = {}
	local var_62_1 = StoryModel.instance:getStepLine()
	local var_62_2 = 0

	for iter_62_0, iter_62_1 in pairs(var_62_1) do
		var_62_2 = var_62_2 + 1
	end

	if var_62_2 > 1 then
		for iter_62_2, iter_62_3 in pairs(arg_62_0._pictures) do
			iter_62_3:onDestroy()
		end
	end

	local var_62_3 = false

	if var_62_1[arg_62_0._curStoryId] then
		for iter_62_4, iter_62_5 in ipairs(var_62_1[arg_62_0._curStoryId]) do
			local var_62_4 = StoryStepModel.instance:getStepListById(iter_62_5.stepId).picList

			if iter_62_5.skip then
				var_62_3 = true

				for iter_62_6 = 1, #var_62_4 do
					table.insert(var_62_0, var_62_4[iter_62_6])

					if var_62_4[iter_62_6].orderType == StoryEnum.PictureOrderType.Destroy then
						for iter_62_7 = #var_62_0, 1, -1 do
							if var_62_0[iter_62_7].orderType == StoryEnum.PictureOrderType.Produce and var_62_0[iter_62_7].picture == var_62_4[iter_62_6].picture then
								table.remove(var_62_0, #var_62_0)
								table.remove(var_62_0, iter_62_7)
							end
						end
					end
				end
			end
		end
	end

	arg_62_0:_resetStepPictures()

	if #arg_62_1 < 1 and #var_62_0 == 0 then
		return
	end

	arg_62_0._picCo = #var_62_0 > 0 and var_62_0 or arg_62_1

	for iter_62_8, iter_62_9 in pairs(arg_62_0._picCo) do
		local var_62_5 = iter_62_9.picType == StoryEnum.PictureType.FullScreen and "fullfocusitem" or iter_62_9.picture

		if iter_62_9.orderType == StoryEnum.PictureOrderType.Produce and iter_62_9.layer > 0 then
			arg_62_0:_buildPicture(var_62_5, iter_62_9, var_62_3)
		else
			arg_62_0:_destroyPicture(var_62_5, iter_62_9, var_62_3)
		end
	end

	arg_62_0:_checkFloatBgShow()
end

function var_0_0._resetStepPictures(arg_63_0)
	for iter_63_0, iter_63_1 in pairs(arg_63_0._pictures) do
		iter_63_1:resetStep()
	end
end

function var_0_0._checkFloatBgShow(arg_64_0)
	ZProj.TweenHelper.KillByObj(arg_64_0._imagefullbottom)

	for iter_64_0, iter_64_1 in pairs(arg_64_0._pictures) do
		if iter_64_1:isFloatType() then
			gohelper.setActive(arg_64_0._imagefullbottom.gameObject, true)

			local var_64_0 = arg_64_0._imagefullbottom.color.a

			ZProj.TweenHelper.DoFade(arg_64_0._imagefullbottom, var_64_0, arg_64_0._initFullBottomAlpha, 0.1, nil, nil, nil, EaseType.Linear)

			return
		end
	end

	local var_64_1 = 0

	for iter_64_2, iter_64_3 in pairs(arg_64_0._picCo) do
		var_64_1 = iter_64_3.orderType == StoryEnum.PictureOrderType.Destroy and iter_64_3.layer > 0 and iter_64_3.picType == StoryEnum.PictureType.Float and var_64_1 < iter_64_3.outTimes[GameLanguageMgr.instance:getVoiceTypeStoryIndex()] and iter_64_3.outTimes[GameLanguageMgr.instance:getVoiceTypeStoryIndex()] or var_64_1
	end

	for iter_64_4, iter_64_5 in pairs(arg_64_0._picCo) do
		if iter_64_5.orderType == StoryEnum.PictureOrderType.Produce and iter_64_5.layer > 0 and iter_64_5.picType == StoryEnum.PictureType.Float then
			var_64_1 = 0
		end
	end

	if var_64_1 < 0.01 then
		gohelper.setActive(arg_64_0._imagefullbottom.gameObject, false)
	else
		gohelper.setActive(arg_64_0._imagefullbottom.gameObject, true)
		ZProj.TweenHelper.DoFade(arg_64_0._imagefullbottom, arg_64_0._initFullBottomAlpha, 0, var_64_1, function()
			gohelper.setActive(arg_64_0._imagefullbottom.gameObject, false)
		end, nil, nil, EaseType.Linear)
	end
end

function var_0_0._buildPicture(arg_66_0, arg_66_1, arg_66_2, arg_66_3)
	local var_66_0

	if arg_66_2.layer < 4 then
		var_66_0 = arg_66_0._goimg1
	elseif arg_66_2.layer < 7 then
		var_66_0 = arg_66_0._goimg2
	elseif arg_66_2.layer < 10 then
		var_66_0 = arg_66_0._goimg3
	else
		if not arg_66_0._goimg4 then
			local var_66_1 = ViewMgr.instance:getContainer(ViewName.StoryFrontView).viewGO

			arg_66_0._goimg4 = gohelper.findChild(var_66_1, "#go_frontitem/#go_img4")
		end

		var_66_0 = arg_66_0._goimg4
	end

	if not arg_66_0._pictures[arg_66_1] then
		arg_66_0._pictures[arg_66_1] = StoryPictureItem.New()

		arg_66_0._pictures[arg_66_1]:init(var_66_0, arg_66_1, arg_66_2)
	elseif not arg_66_3 then
		arg_66_0._pictures[arg_66_1]:reset(var_66_0, arg_66_2)
	end
end

function var_0_0._destroyPicture(arg_67_0, arg_67_1, arg_67_2, arg_67_3)
	if not arg_67_0._pictures[arg_67_1] then
		if arg_67_3 then
			if arg_67_2.orderType == StoryEnum.PictureOrderType.Produce then
				arg_67_0:_buildPicture(arg_67_1, arg_67_2, arg_67_3)
			end

			TaskDispatcher.runDelay(function()
				local var_68_0 = 0
				local var_68_1 = arg_67_0._stepCo.videoList

				for iter_68_0, iter_68_1 in pairs(var_68_1) do
					if iter_68_1.orderType == StoryEnum.VideoOrderType.Produce then
						var_68_0 = 0.5
					end
				end

				if not arg_67_0._pictures[arg_67_1] then
					return
				end

				arg_67_0._pictures[arg_67_1]:destroyPicture(arg_67_2, arg_67_3, var_68_0)

				arg_67_0._pictures[arg_67_1] = nil
			end, nil, 0.2)
		end

		return
	end

	local var_67_0 = 0
	local var_67_1 = arg_67_0._stepCo.videoList

	for iter_67_0, iter_67_1 in pairs(var_67_1) do
		if iter_67_1.orderType == StoryEnum.VideoOrderType.Produce then
			var_67_0 = 0.5
		end
	end

	arg_67_0._pictures[arg_67_1]:destroyPicture(arg_67_2, arg_67_3, var_67_0)

	arg_67_0._pictures[arg_67_1] = nil
end

function var_0_0._updateNavigateList(arg_69_0, arg_69_1)
	StoryController.instance:dispatchEvent(StoryEvent.RefreshNavigate, arg_69_1)
end

function var_0_0._updateVideoList(arg_70_0, arg_70_1)
	arg_70_0._videoCo = arg_70_1

	local var_70_0 = false

	arg_70_0:_checkCreatePlayList()

	for iter_70_0, iter_70_1 in pairs(arg_70_0._videoCo) do
		if iter_70_1.orderType == StoryEnum.VideoOrderType.Produce then
			arg_70_0:_buildVideo(iter_70_1.video, iter_70_1)
		elseif iter_70_1.orderType == StoryEnum.VideoOrderType.Destroy then
			arg_70_0:_destroyVideo(iter_70_1.video, iter_70_1)
		elseif iter_70_1.orderType == StoryEnum.VideoOrderType.Pause then
			arg_70_0._videos[iter_70_1.video]:pause(true)
		else
			arg_70_0._videos[iter_70_1.video]:pause(false)
		end
	end

	for iter_70_2, iter_70_3 in pairs(arg_70_0._videoCo) do
		if iter_70_3.delayTimes[GameLanguageMgr.instance:getVoiceTypeStoryIndex()] < 0.1 and (iter_70_3.orderType == StoryEnum.VideoOrderType.Produce or iter_70_3.orderType == StoryEnum.VideoOrderType.Pause or iter_70_3.orderType == StoryEnum.VideoOrderType.Restart) then
			var_70_0 = true
		end
	end

	if not var_70_0 then
		StoryController.instance:dispatchEvent(StoryEvent.ShowBackground)
	end
end

function var_0_0._videoStarted(arg_71_0, arg_71_1)
	for iter_71_0, iter_71_1 in pairs(arg_71_0._videos) do
		if iter_71_1 ~= arg_71_1 then
			iter_71_1:pause(true)
		end
	end
end

function var_0_0._buildVideo(arg_72_0, arg_72_1, arg_72_2)
	arg_72_0:_checkCreatePlayList()

	local var_72_0

	if arg_72_2.layer < 4 then
		var_72_0 = arg_72_0._govideo1
	elseif arg_72_2.layer < 7 then
		var_72_0 = arg_72_0._govideo2
	else
		var_72_0 = arg_72_0._govideo3
	end

	if not arg_72_0._videos[arg_72_1] then
		arg_72_0._videos[arg_72_1] = StoryVideoItem.New()

		arg_72_0._videos[arg_72_1]:init(var_72_0, arg_72_1, arg_72_2, arg_72_0._videoStarted, arg_72_0, arg_72_0._videoPlayList)
	else
		arg_72_0._videos[arg_72_1]:reset(var_72_0, arg_72_2)
	end
end

function var_0_0._destroyVideo(arg_73_0, arg_73_1, arg_73_2)
	if not arg_73_0._videos[arg_73_1] then
		return
	end

	arg_73_0._videos[arg_73_1]:destroyVideo(arg_73_2)

	arg_73_0._videos[arg_73_1] = nil
end

function var_0_0._checkCreatePlayList(arg_74_0)
	if not arg_74_0._videoPlayList then
		local var_74_0 = AvProMgr.instance:getStoryUrl()
		local var_74_1 = arg_74_0:getResInst(var_74_0, arg_74_0.viewGO, "play_list")

		arg_74_0._videoPlayList = StoryVideoPlayList.New()

		arg_74_0._videoPlayList:init(var_74_1, arg_74_0.viewGO)
	end
end

function var_0_0._checkDisposePlayList(arg_75_0)
	if arg_75_0._videoPlayList then
		arg_75_0._videoPlayList:dispose()

		arg_75_0._videoPlayList = nil
	end
end

function var_0_0._updateOptionList(arg_76_0, arg_76_1)
	arg_76_0._optCo = arg_76_1
end

function var_0_0._clearItems(arg_77_0)
	TaskDispatcher.cancelTask(arg_77_0._viewFadeIn, arg_77_0)
	TaskDispatcher.cancelTask(arg_77_0._enterNextStep, arg_77_0)
	TaskDispatcher.cancelTask(arg_77_0._startShowText, arg_77_0)
	TaskDispatcher.cancelTask(arg_77_0._startShake, arg_77_0)
	TaskDispatcher.cancelTask(arg_77_0._shakeStop, arg_77_0)

	for iter_77_0, iter_77_1 in pairs(arg_77_0._pictures) do
		iter_77_1:onDestroy()
	end

	arg_77_0._pictures = {}

	for iter_77_2, iter_77_3 in pairs(arg_77_0._effects) do
		iter_77_3:onDestroy()
	end

	arg_77_0._effects = {}

	for iter_77_4, iter_77_5 in pairs(arg_77_0._videos) do
		iter_77_5:onDestroy()
	end

	arg_77_0._videos = {}

	arg_77_0:_checkDisposePlayList()
end

function var_0_0.onDestroyView(arg_78_0)
	if ViewMgr.instance:isOpen(ViewName.MessageBoxView) then
		ViewMgr.instance:closeView(ViewName.MessageBoxView, true)
	end

	if arg_78_0._confadeId then
		ZProj.TweenHelper.KillById(arg_78_0._confadeId)

		arg_78_0._confadeId = nil
	end

	ZProj.TweenHelper.KillByObj(arg_78_0._imagefullbottom)
	arg_78_0:_checkDisposePlayList()
	TaskDispatcher.cancelTask(arg_78_0._conShowIn, arg_78_0)
	TaskDispatcher.cancelTask(arg_78_0._startShowText, arg_78_0)
	TaskDispatcher.cancelTask(arg_78_0._enterNextStep, arg_78_0)
	TaskDispatcher.cancelTask(arg_78_0._onFullTextFinished, arg_78_0)
	TaskDispatcher.cancelTask(arg_78_0._startShake, arg_78_0)
	TaskDispatcher.cancelTask(arg_78_0._shakeStop, arg_78_0)
	StoryTool.enablePostProcess(false)
	ViewMgr.instance:closeView(ViewName.StoryFrontView, nil, true)
	arg_78_0._simagehead:UnLoadImage()
	StoryController.instance:stopPlotMusic()

	arg_78_0._bgAudio = nil

	arg_78_0:stopAllAudio(0)

	if arg_78_0._dialogItem then
		arg_78_0._dialogItem:destroy()

		arg_78_0._dialogItem = nil
	end
end

return var_0_0
