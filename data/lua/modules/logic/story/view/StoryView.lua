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

	if not arg_4_0._stepCo then
		return
	end

	if arg_4_0:_isUnInteractType() then
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

function var_0_0._isUnInteractType(arg_5_0)
	if not arg_5_0._stepCo then
		return true
	end

	if arg_5_0._stepCo.conversation.type == StoryEnum.ConversationType.None then
		return true
	end

	if arg_5_0._stepCo.conversation.type == StoryEnum.ConversationType.NoInteract then
		return true
	end

	if arg_5_0._stepCo.conversation.type == StoryEnum.ConversationType.ScreenDialog then
		return true
	end

	if arg_5_0._stepCo.conversation.type == StoryEnum.ConversationType.IrregularShake then
		return true
	end

	if StoryModel.instance:isLimitNoInteractLock(arg_5_0._stepCo) then
		return true
	end

	return false
end

function var_0_0._btnhideOnClick(arg_6_0)
	StoryController.instance:dispatchEvent(StoryEvent.LeadRoleViewShow, false)
	gohelper.setActive(arg_6_0._gocontentroot, false)
end

function var_0_0._btnlogOnClick(arg_7_0)
	StoryController.instance:openStoryLogView()
end

function var_0_0._btnautoOnClick(arg_8_0)
	if not arg_8_0._stepCo then
		return
	end

	if not arg_8_0:_isUnInteractType() then
		arg_8_0._dialogItem:startAutoEnterNext()
	end
end

function var_0_0._btnskipOnClick(arg_9_0, arg_9_1)
	if not arg_9_1 and not StoryModel.instance:isNormalStep() then
		return
	end

	StoryTool.enablePostProcess(true)
	arg_9_0:_skipStep(arg_9_1)
end

function var_0_0._editableInitView(arg_10_0)
	arg_10_0:_initData()
	arg_10_0:_initView()
end

function var_0_0.addEvent(arg_11_0)
	arg_11_0:addEventCb(StoryController.instance, StoryEvent.RefreshStep, arg_11_0._onUpdateUI, arg_11_0)
	arg_11_0:addEventCb(StoryController.instance, StoryEvent.AllStepFinished, arg_11_0._storyFinished, arg_11_0)
	arg_11_0:addEventCb(StoryController.instance, StoryEvent.RefreshView, arg_11_0._refreshView, arg_11_0)
	arg_11_0:addEventCb(StoryController.instance, StoryEvent.RefreshConversation, arg_11_0._updateConversation, arg_11_0)
	arg_11_0:addEventCb(StoryController.instance, StoryEvent.Log, arg_11_0._btnlogOnClick, arg_11_0)
	arg_11_0:addEventCb(StoryController.instance, StoryEvent.Hide, arg_11_0._btnhideOnClick, arg_11_0)
	arg_11_0:addEventCb(StoryController.instance, StoryEvent.Auto, arg_11_0._btnautoOnClick, arg_11_0)
	arg_11_0:addEventCb(StoryController.instance, StoryEvent.Skip, arg_11_0._btnskipOnClick, arg_11_0)
	arg_11_0:addEventCb(StoryController.instance, StoryEvent.PvPause, arg_11_0._btnPvPauseOnClick, arg_11_0)
	arg_11_0:addEventCb(StoryController.instance, StoryEvent.PvPlay, arg_11_0._btnPvPlayOnClick, arg_11_0)
	arg_11_0:addEventCb(StoryController.instance, StoryEvent.EnterNextStep, arg_11_0._btnnextOnClick, arg_11_0)
	arg_11_0:addEventCb(StoryController.instance, StoryEvent.Finish, arg_11_0._clearItems, arg_11_0)
	arg_11_0:addEventCb(StoryController.instance, StoryEvent.FullTextLineShowFinished, arg_11_0._onFullTextShowFinished, arg_11_0)
	arg_11_0:addEventCb(StoryController.instance, StoryEvent.HideDialog, arg_11_0._hideDialog, arg_11_0)
	arg_11_0:addEventCb(StoryController.instance, StoryEvent.DialogConFinished, arg_11_0._dialogConFinished, arg_11_0)
end

function var_0_0.removeEvent(arg_12_0)
	arg_12_0:removeEventCb(StoryController.instance, StoryEvent.RefreshStep, arg_12_0._onUpdateUI, arg_12_0)
	arg_12_0:removeEventCb(StoryController.instance, StoryEvent.AllStepFinished, arg_12_0._storyFinished, arg_12_0)
	arg_12_0:removeEventCb(StoryController.instance, StoryEvent.RefreshView, arg_12_0._refreshView, arg_12_0)
	arg_12_0:removeEventCb(StoryController.instance, StoryEvent.RefreshConversation, arg_12_0._updateConversation, arg_12_0)
	arg_12_0:removeEventCb(StoryController.instance, StoryEvent.Log, arg_12_0._btnlogOnClick, arg_12_0)
	arg_12_0:removeEventCb(StoryController.instance, StoryEvent.Hide, arg_12_0._btnhideOnClick, arg_12_0)
	arg_12_0:removeEventCb(StoryController.instance, StoryEvent.Auto, arg_12_0._btnautoOnClick, arg_12_0)
	arg_12_0:removeEventCb(StoryController.instance, StoryEvent.Skip, arg_12_0._btnskipOnClick, arg_12_0)
	arg_12_0:removeEventCb(StoryController.instance, StoryEvent.PvPause, arg_12_0._btnPvPauseOnClick, arg_12_0)
	arg_12_0:removeEventCb(StoryController.instance, StoryEvent.PvPlay, arg_12_0._btnPvPlayOnClick, arg_12_0)
	arg_12_0:removeEventCb(StoryController.instance, StoryEvent.EnterNextStep, arg_12_0._btnnextOnClick, arg_12_0)
	arg_12_0:removeEventCb(StoryController.instance, StoryEvent.Finish, arg_12_0._clearItems, arg_12_0)
	arg_12_0:removeEventCb(StoryController.instance, StoryEvent.FullTextLineShowFinished, arg_12_0._onFullTextShowFinished, arg_12_0)
	arg_12_0:removeEventCb(StoryController.instance, StoryEvent.HideDialog, arg_12_0._hideDialog, arg_12_0)
	arg_12_0:removeEventCb(StoryController.instance, StoryEvent.DialogConFinished, arg_12_0._dialogConFinished, arg_12_0)
end

function var_0_0._btnPvPauseOnClick(arg_13_0)
	for iter_13_0, iter_13_1 in pairs(arg_13_0._videos) do
		iter_13_1:pause(true)
	end
end

function var_0_0._btnPvPlayOnClick(arg_14_0)
	for iter_14_0, iter_14_1 in pairs(arg_14_0._videos) do
		iter_14_1:pause(false)
	end
end

function var_0_0._initData(arg_15_0)
	arg_15_0._stepId = 0
	arg_15_0._audios = {}
	arg_15_0._pictures = {}
	arg_15_0._effects = {}
	arg_15_0._videos = {}
	arg_15_0._initFullBottomAlpha = arg_15_0._imagefullbottom.color.a

	StoryModel.instance:resetStoryState()
end

function var_0_0._initView(arg_16_0)
	arg_16_0._conCanvasGroup = arg_16_0._gocontentroot:GetComponent(typeof(UnityEngine.CanvasGroup))
	arg_16_0._contentAnimator = arg_16_0._goconversation:GetComponent(typeof(UnityEngine.Animator))

	local var_16_0 = ViewMgr.instance:getContainer(ViewName.StoryBackgroundView).viewGO

	arg_16_0._gobottom = gohelper.findChild(var_16_0, "#go_bottomitem")
	arg_16_0._goimg1 = gohelper.findChild(var_16_0, "#go_bottomitem/#go_img1")
	arg_16_0._govideo1 = gohelper.findChild(var_16_0, "#go_bottomitem/#go_video1")
	arg_16_0._goeff1 = gohelper.findChild(var_16_0, "#go_bottomitem/#go_eff1")

	gohelper.setActive(arg_16_0._gocontentroot, false)
	arg_16_0:_initItems()
end

function var_0_0.onOpen(arg_17_0)
	arg_17_0:addEvent()
	ViewMgr.instance:openView(ViewName.StoryFrontView, nil, true)
	gohelper.setActive(arg_17_0.viewGO, true)
	SpineFpsMgr.instance:set(SpineFpsMgr.Story)

	if UnityEngine.Shader.IsKeywordEnabled("_MAININTERFACELIGHT") then
		arg_17_0._keywordEnable = true

		UnityEngine.Shader.DisableKeyword("_MAININTERFACELIGHT")
	end

	arg_17_0:_clearItems()
end

function var_0_0._initItems(arg_18_0)
	if not arg_18_0._dialogItem then
		arg_18_0._dialogItem = StoryDialogItem.New()

		arg_18_0._dialogItem:init(arg_18_0._gocontentroot)
		arg_18_0._dialogItem:hideDialog()
	end
end

function var_0_0._hideDialog(arg_19_0)
	if arg_19_0._dialogItem then
		if StoryModel.instance:isTextShowing() then
			arg_19_0._dialogItem:conFinished()
			arg_19_0:_conFinished()
		end

		gohelper.setActive(arg_19_0._gocontentroot, false)
	end
end

function var_0_0._dialogConFinished(arg_20_0)
	if arg_20_0._dialogItem and StoryModel.instance:isTextShowing() then
		arg_20_0._dialogItem:conFinished()
		arg_20_0:_conFinished()
	end
end

function var_0_0._storyFinished(arg_21_0, arg_21_1)
	arg_21_0._stepId = 0
	arg_21_0._finished = true
	arg_21_0._stepCo = nil

	TaskDispatcher.cancelTask(arg_21_0._onCheckNext, arg_21_0)
	arg_21_0._dialogItem:storyFinished()
	StoryModel.instance:enableClick(false)

	if arg_21_0._dialogItem then
		arg_21_0._dialogItem:stopConAudio()
	end

	if StoryController.instance._hideStartAndEndDark then
		arg_21_0:stopAllAudio(1.5)
		gohelper.setActive(arg_21_0._gospine, false)

		if arg_21_0._confadeId then
			ZProj.TweenHelper.KillById(arg_21_0._confadeId)
		end

		arg_21_0._confadeId = ZProj.TweenHelper.DOFadeCanvasGroup(arg_21_0._gocontentroot, 1, 0, 0.35, nil, nil, nil, EaseType.Linear)

		return
	end

	if StoryModel.instance:isTypeSkip(StoryEnum.SkipType.OutDarkFade, StoryModel.instance:getCurStoryId()) then
		return
	end

	arg_21_0:stopAllAudio(1.5)
end

function var_0_0.onClose(arg_22_0)
	if not arg_22_0._finished then
		arg_22_0:stopAllAudio(0)
	end

	if arg_22_0._keywordEnable then
		UnityEngine.Shader.EnableKeyword("_MAININTERFACELIGHT")
	end

	arg_22_0:removeEvent()
	TaskDispatcher.cancelTask(arg_22_0._viewFadeIn, arg_22_0)
	arg_22_0:_clearItems()
	SpineFpsMgr.instance:remove(SpineFpsMgr.Story)
end

function var_0_0.onUpdateParam(arg_23_0)
	return
end

function var_0_0._enterNextStep(arg_24_0)
	StoryController.instance:dispatchEvent(StoryEvent.PlayFullTextOut)

	if arg_24_0._diaLineTxt and arg_24_0._diaLineTxt[2] then
		local var_24_0, var_24_1, var_24_2 = transformhelper.getLocalPos(arg_24_0._diaLineTxt[2].transform)

		transformhelper.setLocalPos(arg_24_0._diaLineTxt[2].transform, var_24_0, var_24_1, 1)
	end

	TaskDispatcher.cancelTask(arg_24_0._enterNextStep, arg_24_0)
	StoryController.instance:enterNext()
end

function var_0_0._skipStep(arg_25_0, arg_25_1)
	StoryModel.instance:enableClick(false)
	TaskDispatcher.cancelTask(arg_25_0._enterNextStep, arg_25_0)
	TaskDispatcher.cancelTask(arg_25_0._playShowHero, arg_25_0)

	if arg_25_1 then
		StoryController.instance:skipAllStory()
	else
		StoryController.instance:skipStory()
	end
end

function var_0_0._onCheckNext(arg_26_0)
	arg_26_0:_onConFinished(arg_26_0._stepCo.conversation.isAuto)
end

function var_0_0._onUpdateUI(arg_27_0, arg_27_1)
	arg_27_0._finished = false

	StoryModel.instance:setStepNormal(arg_27_1.stepType == StoryEnum.StepType.Normal)

	if arg_27_0._gocontentroot.activeSelf ~= StoryModel.instance:isNormalStep() then
		gohelper.setActive(arg_27_0._gocontentroot, not StoryModel.instance:isNormalStep())
		StoryController.instance:dispatchEvent(StoryEvent.LeadRoleViewShow, not StoryModel.instance:isNormalStep())
	end

	if arg_27_0._curStoryId ~= arg_27_1.storyId and #arg_27_1.branches < 1 then
		arg_27_0:_clearItems()

		arg_27_0._curStoryId = arg_27_1.storyId
	end

	arg_27_0:_updateStep(arg_27_1.stepId)
	StoryController.instance:dispatchEvent(StoryEvent.RefreshHero, arg_27_1)

	if #arg_27_1.branches > 0 then
		StoryController.instance:openStoryBranchView(arg_27_1.branches)
		arg_27_0:_showBranchLeadHero()
	else
		gohelper.setActive(arg_27_0._gonoconversation, false)
	end

	StoryModel.instance:clearStepLine()
end

function var_0_0._showBranchLeadHero(arg_28_0)
	arg_28_0._dialogItem:hideDialog()
	arg_28_0._dialogItem:stopConAudio()

	if arg_28_0._confadeId then
		ZProj.TweenHelper.KillById(arg_28_0._confadeId)
	end

	TaskDispatcher.cancelTask(arg_28_0._conShowIn, arg_28_0)
	TaskDispatcher.cancelTask(arg_28_0._startShowText, arg_28_0)
	TaskDispatcher.cancelTask(arg_28_0._startShake, arg_28_0)
	TaskDispatcher.cancelTask(arg_28_0._shakeStop, arg_28_0)
	TaskDispatcher.cancelTask(arg_28_0._enterNextStep, arg_28_0)

	arg_28_0._conCanvasGroup.alpha = 1

	gohelper.setActive(arg_28_0._goname, true)
	gohelper.setActive(arg_28_0._txtnameen.gameObject, true)
	gohelper.setActive(arg_28_0._gocontentroot, true)
	gohelper.setActive(arg_28_0._gonoconversation, true)

	local var_28_0

	for iter_28_0, iter_28_1 in pairs(arg_28_0._stepCo.optList) do
		if iter_28_1.condition and iter_28_1.conditionType == StoryEnum.OptionConditionType.NormalLead then
			arg_28_0:_showNormalLeadHero(iter_28_1)

			return
		elseif iter_28_1.condition and iter_28_1.conditionType == StoryEnum.OptionConditionType.MainSpine then
			arg_28_0:_showSpineLeadHero(iter_28_1)

			return
		end
	end

	arg_28_0:_showSpineLeadHero()
end

function var_0_0._showNormalLeadHero(arg_29_0, arg_29_1)
	gohelper.setActive(arg_29_0._gohead, true)
	gohelper.setActive(arg_29_0._gospine, false)

	local var_29_0 = arg_29_1.conditionValue2[GameLanguageMgr.instance:getLanguageTypeStoryIndex()]
	local var_29_1 = arg_29_1.conditionValue2[LanguageEnum.LanguageStoryType.EN]

	arg_29_0:_showHeadContentTxt(var_29_0, var_29_1)
	arg_29_0:_showHeadContentIcon(arg_29_1.conditionValue)
end

function var_0_0._showSpineLeadHero(arg_30_0, arg_30_1)
	local var_30_0 = arg_30_1 and string.split(arg_30_1.conditionValue, ".")[1] or nil

	StoryController.instance:dispatchEvent(StoryEvent.LeadRoleViewShow, true, var_30_0)
	gohelper.setActive(arg_30_0._gohead, false)
	gohelper.setActive(arg_30_0._gospine, true)

	arg_30_0._txtnamecn1.text = luaLang("mainrolename")
	arg_30_0._txtnamecn2.text = luaLang("mainrolename")
	arg_30_0._txtnameen.text = "<voffset=4>/ </voffset>Vertin"

	if arg_30_1 then
		return
	end

	local var_30_1 = 1

	if arg_30_0._stepCo and arg_30_0._stepCo.optList[1] and arg_30_0._stepCo.optList[1].feedbackType == StoryEnum.OptionFeedbackType.HeroLead then
		var_30_1 = arg_30_0._stepCo.optList[1].feedbackValue ~= "" and tonumber(arg_30_0._stepCo.optList[1].feedbackValue) or 1
	end

	StoryController.instance:dispatchEvent(StoryEvent.ShowLeadRole, arg_30_0._stepCo, true, false, false, var_30_1)
end

function var_0_0._updateStep(arg_31_0, arg_31_1)
	if not StoryModel.instance:isNormalStep() and not arg_31_0._skip then
		return
	end

	arg_31_0._stepCo = StoryStepModel.instance:getStepListById(arg_31_1)

	if arg_31_0._stepCo.conversation.effType == StoryEnum.ConversationEffectType.SoftLight then
		gohelper.setActive(arg_31_0._goline, false)
		gohelper.setActive(arg_31_0._gonexticon, false)
		gohelper.setActive(arg_31_0._goblackbottom, false)
	else
		gohelper.setActive(arg_31_0._goline, true)
		gohelper.setActive(arg_31_0._gonexticon, true)
		gohelper.setActive(arg_31_0._goblackbottom, true)
	end

	if arg_31_0._stepCo.bg.transType ~= StoryEnum.BgTransType.DarkFade and arg_31_0._stepCo.bg.transType ~= StoryEnum.BgTransType.WhiteFade then
		arg_31_0:_refreshView()
	else
		arg_31_0:_updateEffectList(arg_31_0._stepCo.effList)
		arg_31_0:_updateAudioList(arg_31_0._stepCo.audioList)
	end
end

function var_0_0._refreshView(arg_32_0)
	arg_32_0:_updateEffectList(arg_32_0._stepCo.effList)
	arg_32_0:_updateAudioList(arg_32_0._stepCo.audioList)
	arg_32_0:_updatePictureList(arg_32_0._stepCo.picList)
	arg_32_0:_updateVideoList(arg_32_0._stepCo.videoList)
	arg_32_0:_updateNavigateList(arg_32_0._stepCo.navigateList)
	arg_32_0:_updateOptionList(arg_32_0._stepCo.optList)
end

function var_0_0._updateConversation(arg_33_0)
	if not arg_33_0._stepCo then
		return
	end

	if not arg_33_0._stepId then
		arg_33_0._stepId = 0

		return
	end

	if arg_33_0._storyId and arg_33_0._storyId == arg_33_0._curStoryId and arg_33_0._stepId == arg_33_0._stepCo.id then
		arg_33_0._stepId = 0

		return
	end

	StoryModel.instance:enableClick(false)

	arg_33_0._stepId = arg_33_0._stepCo.id
	arg_33_0._storyId = arg_33_0._curStoryId

	if arg_33_0._confadeId then
		ZProj.TweenHelper.KillById(arg_33_0._confadeId)
	end

	TaskDispatcher.cancelTask(arg_33_0._conShowIn, arg_33_0)
	TaskDispatcher.cancelTask(arg_33_0._onEnableClick, arg_33_0)
	TaskDispatcher.cancelTask(arg_33_0._enterNextStep, arg_33_0)
	TaskDispatcher.cancelTask(arg_33_0._onFullTextKeepFinished, arg_33_0)
	TaskDispatcher.cancelTask(arg_33_0._startShowText, arg_33_0)
	TaskDispatcher.cancelTask(arg_33_0._onCheckNext, arg_33_0)

	if arg_33_0._stepCo.conversation.type ~= StoryEnum.ConversationType.None then
		StoryModel.instance:setTextShowing(true)
	end

	if StoryModel.instance:isNeedFadeOut() then
		if arg_33_0._gospine.activeSelf then
			StoryController.instance:dispatchEvent(StoryEvent.ShowLeadRole, arg_33_0._stepCo, true, false, true)
		end

		arg_33_0._confadeId = ZProj.TweenHelper.DOFadeCanvasGroup(arg_33_0._gocontentroot, 1, 0, 0.35, nil, nil, nil, EaseType.Linear)

		if not StoryModel.instance:isPlayFinished() then
			TaskDispatcher.runDelay(arg_33_0._conShowIn, arg_33_0, 0.35)
		end
	else
		arg_33_0:_conShowIn()
	end
end

function var_0_0._conShowIn(arg_34_0)
	if not arg_34_0._stepCo then
		return
	end

	arg_34_0._diatxt = StoryTool.getFilterDia(arg_34_0._stepCo.conversation.diaTexts[GameLanguageMgr.instance:getLanguageTypeStoryIndex()])

	arg_34_0._dialogItem:hideDialog()
	TaskDispatcher.cancelTask(arg_34_0._enterNextStep, arg_34_0)
	TaskDispatcher.cancelTask(arg_34_0._onFullTextKeepFinished, arg_34_0)
	TaskDispatcher.cancelTask(arg_34_0._startShowText, arg_34_0)

	if arg_34_0._stepCo.conversation.type == StoryEnum.ConversationType.None then
		arg_34_0:_showConversationItem(false)
		TaskDispatcher.runDelay(arg_34_0._enterNextStep, arg_34_0, arg_34_0._stepCo.conversation.delayTimes[GameLanguageMgr.instance:getVoiceTypeStoryIndex()])
	else
		StoryController.instance:dispatchEvent(StoryEvent.SetFullText, "")
		StoryModel.instance:setLimitNoInteractLock(false)

		if arg_34_0._stepCo.conversation.type == StoryEnum.ConversationType.NoInteract then
			StoryModel.instance:enableClick(false)
			TaskDispatcher.runDelay(arg_34_0._enterNextStep, arg_34_0, arg_34_0._stepCo.conversation.delayTimes[GameLanguageMgr.instance:getVoiceTypeStoryIndex()])
		elseif arg_34_0._stepCo.conversation.type == StoryEnum.ConversationType.LimitNoInteract then
			StoryModel.instance:setLimitNoInteractLock(true)
			StoryModel.instance:enableClick(false)
			TaskDispatcher.runDelay(arg_34_0._onLimitNoInteractFinished, arg_34_0, arg_34_0._stepCo.conversation.delayTimes[GameLanguageMgr.instance:getVoiceTypeStoryIndex()])
		end

		arg_34_0:_showConversationItem(true)
	end

	if StoryModel.instance:isNeedFadeIn() then
		if arg_34_0._gospine.activeSelf then
			StoryController.instance:dispatchEvent(StoryEvent.ShowLeadRole, arg_34_0._stepCo, true, true, false)
		end

		arg_34_0._confadeId = ZProj.TweenHelper.DOFadeCanvasGroup(arg_34_0._gocontentroot, 0, 1, 0.5, nil, nil, nil, EaseType.Linear)

		TaskDispatcher.runDelay(arg_34_0._startShowText, arg_34_0, 0.5)
	else
		arg_34_0:_startShowText()
	end
end

function var_0_0._onLimitNoInteractFinished(arg_35_0)
	StoryModel.instance:setLimitNoInteractLock(false)
	StoryModel.instance:enableClick(true)

	if StoryModel.instance:isStoryAuto() then
		arg_35_0:_enterNextStep()
	end
end

function var_0_0._startShowText(arg_36_0)
	if not arg_36_0._stepCo then
		return
	end

	arg_36_0._conCanvasGroup.alpha = 1

	if arg_36_0._stepCo.conversation.effType ~= StoryEnum.ConversationEffectType.Shake then
		StoryController.instance:dispatchEvent(StoryEvent.ConversationShake, arg_36_0._stepCo, 0, true)
		TaskDispatcher.cancelTask(arg_36_0._startShake, arg_36_0)
		TaskDispatcher.cancelTask(arg_36_0._shakeStop, arg_36_0)
		arg_36_0._contentAnimator:Play(UIAnimationName.Idle)
	end

	arg_36_0:_showText()
end

function var_0_0._showConversationItem(arg_37_0, arg_37_1)
	local var_37_0 = arg_37_0._stepCo.conversation.type ~= StoryEnum.ConversationType.ScreenDialog and arg_37_0._stepCo.conversation.type ~= StoryEnum.ConversationType.IrregularShake
	local var_37_1 = arg_37_0._stepCo.conversation.type == StoryEnum.ConversationType.SlideDialog

	if not arg_37_1 then
		gohelper.setActive(arg_37_0._gocontentroot, false)
		arg_37_0._simagehead:UnLoadImage()
		StoryController.instance:dispatchEvent(StoryEvent.LeadRoleViewShow, false)

		return
	end

	StoryController.instance:dispatchEvent(StoryEvent.SetFullText, arg_37_0._diatxt)
	gohelper.setActive(arg_37_0._gobtns, var_37_0)
	gohelper.setActive(arg_37_0._gocontentroot, var_37_0)
	gohelper.setActive(arg_37_0._goconversation, not var_37_1)
	StoryController.instance:dispatchEvent(StoryEvent.LeadRoleViewShow, var_37_0)

	local var_37_2 = arg_37_0._stepCo.conversation.heroNames[GameLanguageMgr.instance:getLanguageTypeStoryIndex()]
	local var_37_3 = arg_37_0._stepCo.conversation.heroNames[LanguageEnum.LanguageStoryType.EN]

	arg_37_0:_showHeadContentTxt(var_37_2, var_37_3)
	gohelper.setActive(arg_37_0._goname, arg_37_0._stepCo.conversation.nameShow)
	gohelper.setActive(arg_37_0._txtnameen.gameObject, arg_37_0._stepCo.conversation.nameEnShow)

	if not arg_37_0._stepCo.conversation.iconShow then
		gohelper.setActive(arg_37_0._gohead, false)
		gohelper.setActive(arg_37_0._gospine, false)
		arg_37_0._simagehead:UnLoadImage()
		StoryController.instance:dispatchEvent(StoryEvent.ShowLeadRole, arg_37_0._stepCo, false, false, false)

		return
	end

	arg_37_0:_showHeadContentIcon(arg_37_0._stepCo.conversation.heroIcon)
end

function var_0_0._showHeadContentTxt(arg_38_0, arg_38_1, arg_38_2)
	local var_38_0 = string.find(arg_38_1, "?")

	gohelper.setActive(arg_38_0._txtnamecn1.gameObject, not var_38_0)
	gohelper.setActive(arg_38_0._txtnamecn2.gameObject, var_38_0)

	if var_38_0 then
		arg_38_0._txtnamecn2.text = string.split(arg_38_1, "_")[1]
	else
		arg_38_0._txtnamecn1.text = string.split(arg_38_1, "_")[1]
	end

	local var_38_1 = arg_38_2 ~= "" and "<voffset=4>/ </voffset>" .. arg_38_2 or ""

	arg_38_0._txtnameen.text = var_38_1
end

function var_0_0._showHeadContentIcon(arg_39_0, arg_39_1)
	if arg_39_0._goeffectIcon then
		gohelper.destroy(arg_39_0._goeffectIcon)

		arg_39_0._goeffectIcon = nil
	end

	if arg_39_0:_isHeroLead() then
		gohelper.setActive(arg_39_0._gohead, false)
		gohelper.setActive(arg_39_0._gospine, true)
		StoryController.instance:dispatchEvent(StoryEvent.ShowLeadRole, arg_39_0._stepCo, true, false, false)
	else
		gohelper.setActive(arg_39_0._gospine, false)
		gohelper.setActive(arg_39_0._gohead, true)

		local var_39_0 = StoryModel.instance:isHeroIconCuts(string.split(arg_39_1, ".")[1])

		gohelper.setActive(arg_39_0._goheadblack, not var_39_0)
		gohelper.setActive(arg_39_0._goheadgrey, false)
		StoryController.instance:dispatchEvent(StoryEvent.ShowLeadRole, arg_39_0._stepCo, false, false, false)

		local var_39_1 = arg_39_0:_getEffectHeadIconCo()

		if var_39_1 then
			arg_39_0._headEffectResPath = ResUrl.getStoryPrefabRes(var_39_1.path)

			local var_39_2 = {}

			table.insert(var_39_2, arg_39_0._headEffectResPath)
			arg_39_0:loadRes(var_39_2, arg_39_0._headEffectResLoaded, arg_39_0)
			gohelper.setActive(arg_39_0._goheadgrey, true)
		else
			local var_39_3 = string.format("singlebg/headicon_small/%s", arg_39_1)

			if arg_39_0._simagehead.curImageUrl == var_39_3 then
				gohelper.setActive(arg_39_0._goheadgrey, true)
			else
				arg_39_0._simagehead:LoadImage(var_39_3, function()
					gohelper.setActive(arg_39_0._goheadgrey, true)
				end)
			end
		end
	end
end

function var_0_0._headEffectResLoaded(arg_41_0)
	if arg_41_0._headEffectResPath then
		local var_41_0 = arg_41_0._loader:getAssetItem(arg_41_0._headEffectResPath)

		arg_41_0._goeffectIcon = gohelper.clone(var_41_0:GetResource(), arg_41_0._gohead)
	end
end

function var_0_0.loadRes(arg_42_0, arg_42_1, arg_42_2, arg_42_3)
	if arg_42_0._loader then
		arg_42_0._loader:dispose()

		arg_42_0._loader = nil
	end

	if arg_42_1 and #arg_42_1 > 0 then
		arg_42_0._loader = MultiAbLoader.New()

		arg_42_0._loader:setPathList(arg_42_1)
		arg_42_0._loader:startLoad(arg_42_2, arg_42_3)
	elseif arg_42_2 then
		arg_42_2(arg_42_3)
	end
end

function var_0_0._getEffectHeadIconCo(arg_43_0)
	local var_43_0 = string.split(arg_43_0._stepCo.conversation.heroIcon, ".")[1]
	local var_43_1 = StoryConfig.instance:getStoryLeadHeroSpine()

	for iter_43_0, iter_43_1 in ipairs(var_43_1) do
		if iter_43_1.resType == StoryEnum.IconResType.IconEff and iter_43_1.icon == var_43_0 then
			return iter_43_1
		end
	end

	return nil
end

function var_0_0._isHeroLead(arg_44_0)
	local var_44_0 = string.split(arg_44_0._stepCo.conversation.heroIcon, ".")[1]
	local var_44_1 = StoryConfig.instance:getStoryLeadHeroSpine()

	for iter_44_0, iter_44_1 in ipairs(var_44_1) do
		if iter_44_1.resType == StoryEnum.IconResType.Spine and iter_44_1.icon == var_44_0 then
			return true
		end
	end

	return false
end

function var_0_0._showText(arg_45_0)
	if arg_45_0._stepCo.conversation.type == StoryEnum.ConversationType.None then
		arg_45_0._dialogItem:stopConAudio()

		return
	end

	StoryModel.instance:setTextShowing(true)

	if arg_45_0._stepCo.conversation.type == StoryEnum.ConversationType.ScreenDialog then
		StoryModel.instance:enableClick(false)
		arg_45_0:_playDialog()
		StoryController.instance:dispatchEvent(StoryEvent.PlayFullText, arg_45_0._stepCo)
	elseif arg_45_0._stepCo.conversation.type == StoryEnum.ConversationType.IrregularShake then
		StoryModel.instance:enableClick(false)
		arg_45_0:_playDialog()
		StoryController.instance:dispatchEvent(StoryEvent.PlayIrregularShakeText, arg_45_0._stepCo)
	else
		StoryModel.instance:enableClick(true)
		arg_45_0:_playDialog()
	end

	if arg_45_0._stepCo.conversation.effType == StoryEnum.ConversationEffectType.Shake then
		arg_45_0:_shakeDialog()
	elseif arg_45_0._stepCo.conversation.effType == StoryEnum.ConversationEffectType.Fade then
		arg_45_0:_fadeIn()
	elseif arg_45_0._stepCo.conversation.effType == StoryEnum.ConversationEffectType.WordByWord then
		-- block empty
	elseif arg_45_0._stepCo.conversation.effType == StoryEnum.ConversationEffectType.LineByLine then
		arg_45_0:_lineShow(1)
	elseif arg_45_0._stepCo.conversation.effType == StoryEnum.ConversationEffectType.TwoLineShow then
		arg_45_0:_lineShow(2)
	end
end

function var_0_0._playDialog(arg_46_0)
	arg_46_0._finishTime = nil

	arg_46_0._dialogItem:hideDialog()
	arg_46_0._dialogItem:playDialog(arg_46_0._diatxt, arg_46_0._stepCo, arg_46_0._conFinished, arg_46_0)
end

function var_0_0._conFinished(arg_47_0)
	StoryModel.instance:setTextShowing(false)

	if arg_47_0._conTweenId then
		ZProj.TweenHelper.KillById(arg_47_0._conTweenId)

		arg_47_0._conTweenId = nil
	end

	local var_47_0 = false
	local var_47_1 = arg_47_0._stepCo and arg_47_0._stepCo.conversation.keepTimes[GameLanguageMgr.instance:getVoiceTypeStoryIndex()] or 1.5

	if StoryModel.instance:isStoryAuto() then
		if not arg_47_0._finishTime then
			arg_47_0._finishTime = ServerTime.now()
		end

		var_47_0 = var_47_1 < ServerTime.now() - arg_47_0._finishTime
	end

	arg_47_0._finishTime = ServerTime.now()

	if var_47_0 then
		arg_47_0:_onCheckNext()
	else
		TaskDispatcher.runDelay(arg_47_0._onCheckNext, arg_47_0, var_47_1)
	end
end

function var_0_0._shakeDialog(arg_48_0)
	TaskDispatcher.cancelTask(arg_48_0._startShake, arg_48_0)
	TaskDispatcher.cancelTask(arg_48_0._shakeStop, arg_48_0)

	if arg_48_0._stepCo.conversation.effTimes[GameLanguageMgr.instance:getVoiceTypeStoryIndex()] < 0.1 then
		return
	end

	if arg_48_0._stepCo.conversation.effDelayTimes[GameLanguageMgr.instance:getVoiceTypeStoryIndex()] < 0.1 then
		arg_48_0:_startShake()
	else
		TaskDispatcher.runDelay(arg_48_0._startShake, arg_48_0, arg_48_0._stepCo.conversation.effDelayTimes[GameLanguageMgr.instance:getVoiceTypeStoryIndex()])
	end
end

function var_0_0._startShake(arg_49_0)
	TaskDispatcher.cancelTask(arg_49_0._shakeStop, arg_49_0)

	local var_49_0 = {
		"low",
		"middle",
		"high"
	}

	arg_49_0._contentAnimator:Play(var_49_0[arg_49_0._stepCo.conversation.effLv + 1])

	arg_49_0._contentAnimator.speed = arg_49_0._stepCo.conversation.effRate

	TaskDispatcher.runDelay(arg_49_0._shakeStop, arg_49_0, arg_49_0._stepCo.conversation.effTimes[GameLanguageMgr.instance:getVoiceTypeStoryIndex()])
	StoryController.instance:dispatchEvent(StoryEvent.ConversationShake, arg_49_0._stepCo, true, arg_49_0._stepCo.conversation.effLv + 1)
end

function var_0_0._shakeStop(arg_50_0)
	if not arg_50_0._stepCo then
		return
	end

	StoryController.instance:dispatchEvent(StoryEvent.ConversationShake, arg_50_0._stepCo, false, arg_50_0._stepCo.conversation.effLv + 1)

	arg_50_0._contentAnimator.speed = arg_50_0._stepCo.conversation.effRate

	arg_50_0._contentAnimator:SetBool("stoploop", true)
end

function var_0_0._fadeIn(arg_51_0)
	StoryModel.instance:setTextShowing(true)
	arg_51_0._dialogItem:playNorDialogFadeIn(arg_51_0._fadeInFinished, arg_51_0)
end

function var_0_0._fadeInFinished(arg_52_0)
	if not arg_52_0._stepCo then
		return
	end

	StoryModel.instance:setTextShowing(false)
	TaskDispatcher.cancelTask(arg_52_0._onCheckNext, arg_52_0)
	TaskDispatcher.runDelay(arg_52_0._onCheckNext, arg_52_0, arg_52_0._stepCo.conversation.delayTimes[GameLanguageMgr.instance:getVoiceTypeStoryIndex()])
end

function var_0_0._wordByWord(arg_53_0)
	StoryModel.instance:setTextShowing(true)
	arg_53_0._dialogItem:playWordByWord(arg_53_0._wordByWordFinished, arg_53_0)
end

function var_0_0._wordByWordFinished(arg_54_0)
	StoryModel.instance:setTextShowing(false)
	TaskDispatcher.cancelTask(arg_54_0._onCheckNext, arg_54_0)

	if not arg_54_0._stepCo then
		return
	end

	TaskDispatcher.runDelay(arg_54_0._onCheckNext, arg_54_0, 1)
end

function var_0_0._lineShow(arg_55_0, arg_55_1)
	if not arg_55_0._stepCo then
		return
	end

	StoryModel.instance:enableClick(false)
	StoryModel.instance:setTextShowing(true)
	StoryController.instance:dispatchEvent(StoryEvent.PlayFullTextLineShow, arg_55_1, arg_55_0._stepCo)
end

function var_0_0._onFullTextShowFinished(arg_56_0)
	if not arg_56_0._stepCo then
		return
	end

	StoryModel.instance:setTextShowing(false)
	TaskDispatcher.cancelTask(arg_56_0._onFullTextKeepFinished, arg_56_0)
	TaskDispatcher.runDelay(arg_56_0._onFullTextKeepFinished, arg_56_0, arg_56_0._stepCo.conversation.keepTimes[GameLanguageMgr.instance:getVoiceTypeStoryIndex()])
end

function var_0_0._onFullTextKeepFinished(arg_57_0)
	StoryController.instance:dispatchEvent(StoryEvent.PlayFullTextOut, arg_57_0._onFullTextFadeOutFinished, arg_57_0)
end

function var_0_0._onFullTextFadeOutFinished(arg_58_0)
	StoryModel.instance:enableClick(true)
	TaskDispatcher.cancelTask(arg_58_0._onFullTextKeepFinished, arg_58_0)
	arg_58_0:_onConFinished(true)
end

function var_0_0._onConFinished(arg_59_0, arg_59_1)
	if arg_59_1 then
		arg_59_0:_onAutoDialogFinished()

		return
	end

	if StoryModel.instance:isStoryAuto() then
		if arg_59_0:_isUnInteractType() then
			return
		end

		if arg_59_0._dialogItem then
			if arg_59_0._dialogItem:isAudioPlaying() then
				arg_59_0._dialogItem:checkAutoEnterNext(arg_59_0._onAutoDialogFinished, arg_59_0)
			else
				arg_59_0:_onAutoDialogFinished()
			end
		end
	end
end

function var_0_0._onAutoDialogFinished(arg_60_0)
	StoryController.instance:enterNext()
end

function var_0_0._onEnableClick(arg_61_0)
	if StoryModel.instance:isTextShowing() then
		return
	end

	StoryModel.instance:enableClick(true)
end

function var_0_0._updateAudioList(arg_62_0, arg_62_1)
	local var_62_0 = {}
	local var_62_1 = StoryModel.instance:getStepLine()
	local var_62_2 = 0

	for iter_62_0, iter_62_1 in pairs(var_62_1) do
		var_62_2 = var_62_2 + 1
	end

	if var_62_2 > 1 then
		arg_62_0:stopAllAudio(0)
	end

	local var_62_3 = false

	if var_62_1[arg_62_0._curStoryId] then
		for iter_62_2, iter_62_3 in ipairs(var_62_1[arg_62_0._curStoryId]) do
			if iter_62_3.skip then
				var_62_3 = true

				break
			end
		end
	end

	if var_62_3 then
		arg_62_0:stopAllAudio(0)
	end

	if arg_62_0._curStoryId and arg_62_0._curStoryId == StoryModel.instance:getCurStoryId() and arg_62_0._stepId and arg_62_0._stepId == StoryModel.instance:getCurStepId() and arg_62_0._audios then
		for iter_62_4, iter_62_5 in pairs(arg_62_1) do
			if not arg_62_0._audios[iter_62_5.audio] then
				return
			end
		end
	end

	arg_62_0._audioCo = arg_62_1

	for iter_62_6, iter_62_7 in pairs(arg_62_0._audioCo) do
		if not arg_62_0._audios then
			arg_62_0._audios = {}
		end

		if not arg_62_0._audios[iter_62_7.audio] then
			arg_62_0._audios[iter_62_7.audio] = StoryAudioItem.New()

			arg_62_0._audios[iter_62_7.audio]:init(iter_62_7.audio)
		end

		arg_62_0._audios[iter_62_7.audio]:setAudio(iter_62_7)
	end
end

function var_0_0.stopAllAudio(arg_63_0, arg_63_1)
	if arg_63_0._audios then
		for iter_63_0, iter_63_1 in pairs(arg_63_0._audios) do
			iter_63_1:stop(arg_63_1)
		end

		arg_63_0._audios = nil
	end
end

function var_0_0._updateEffectList(arg_64_0, arg_64_1)
	local var_64_0 = {}
	local var_64_1 = StoryModel.instance:getStepLine()
	local var_64_2 = 0

	for iter_64_0, iter_64_1 in pairs(var_64_1) do
		var_64_2 = var_64_2 + 1
	end

	if var_64_2 > 1 then
		for iter_64_2, iter_64_3 in pairs(arg_64_0._effects) do
			iter_64_3:onDestroy()
		end
	end

	if var_64_1[arg_64_0._curStoryId] then
		for iter_64_4, iter_64_5 in ipairs(var_64_1[arg_64_0._curStoryId]) do
			if iter_64_5.skip and iter_64_5.skip then
				local var_64_3 = StoryStepModel.instance:getStepListById(iter_64_5.stepId).effList

				for iter_64_6 = 1, #var_64_3 do
					table.insert(var_64_0, var_64_3[iter_64_6])

					if var_64_3[iter_64_6].orderType == StoryEnum.EffectOrderType.Destroy then
						for iter_64_7 = #var_64_0, 1, -1 do
							if var_64_0[iter_64_7].orderType ~= StoryEnum.EffectOrderType.Destroy and var_64_0[iter_64_7].effect == var_64_3[iter_64_6].effect then
								table.remove(var_64_0, #var_64_0)
								table.remove(var_64_0, iter_64_7)
							end
						end
					end
				end
			end
		end
	end

	if #arg_64_1 < 1 and #var_64_0 == 0 then
		return
	end

	arg_64_0._effCo = #var_64_0 == 0 and arg_64_1 or var_64_0

	local var_64_4 = false

	for iter_64_8, iter_64_9 in pairs(arg_64_0._effCo) do
		if iter_64_9.orderType ~= StoryEnum.EffectOrderType.Destroy and iter_64_9.layer > 0 then
			arg_64_0:_buildEffect(iter_64_9.effect, iter_64_9)
		else
			arg_64_0:_destroyEffect(iter_64_9.effect, iter_64_9)
		end

		if iter_64_9.layer < 4 then
			var_64_4 = true
		end
	end

	StoryTool.enablePostProcess(false)

	for iter_64_10, iter_64_11 in pairs(arg_64_0._effects) do
		StoryTool.enablePostProcess(true)
	end

	StoryModel.instance:setHasBottomEffect(var_64_4)
end

function var_0_0._buildEffect(arg_65_0, arg_65_1, arg_65_2)
	local var_65_0 = 0
	local var_65_1

	if arg_65_2.layer < 4 then
		var_65_1 = arg_65_0._goeff1
		var_65_0 = 4
	elseif arg_65_2.layer < 7 then
		var_65_1 = arg_65_0._goeff2
		var_65_0 = 1000
	elseif arg_65_2.layer < 10 then
		var_65_1 = arg_65_0._goeff3
		var_65_0 = 2000
	else
		if not arg_65_0._goeff4 then
			local var_65_2 = ViewMgr.instance:getContainer(ViewName.StoryFrontView).viewGO

			arg_65_0._goeff4 = gohelper.findChild(var_65_2, "#go_frontitem/#go_eff4")
		end

		var_65_1 = arg_65_0._goeff4
	end

	if not arg_65_0._effects[arg_65_1] then
		arg_65_0._effects[arg_65_1] = StoryEffectItem.New()

		arg_65_0._effects[arg_65_1]:init(var_65_1, arg_65_1, arg_65_2, var_65_0)
	else
		arg_65_0._effects[arg_65_1]:reset(var_65_1, arg_65_2, var_65_0)
	end
end

function var_0_0._destroyEffect(arg_66_0, arg_66_1, arg_66_2)
	if not arg_66_0._effects[arg_66_1] then
		return
	end

	arg_66_0._effects[arg_66_1]:destroyEffect(arg_66_2)

	arg_66_0._effects[arg_66_1] = nil
end

function var_0_0._updatePictureList(arg_67_0, arg_67_1)
	local var_67_0 = {}
	local var_67_1 = StoryModel.instance:getStepLine()
	local var_67_2 = 0

	for iter_67_0, iter_67_1 in pairs(var_67_1) do
		var_67_2 = var_67_2 + 1
	end

	if var_67_2 > 1 then
		for iter_67_2, iter_67_3 in pairs(arg_67_0._pictures) do
			iter_67_3:onDestroy()
		end
	end

	local var_67_3 = false

	if var_67_1[arg_67_0._curStoryId] then
		for iter_67_4, iter_67_5 in ipairs(var_67_1[arg_67_0._curStoryId]) do
			local var_67_4 = StoryStepModel.instance:getStepListById(iter_67_5.stepId).picList

			if iter_67_5.skip then
				var_67_3 = true

				for iter_67_6 = 1, #var_67_4 do
					table.insert(var_67_0, var_67_4[iter_67_6])

					if var_67_4[iter_67_6].orderType == StoryEnum.PictureOrderType.Destroy then
						for iter_67_7 = #var_67_0, 1, -1 do
							if var_67_0[iter_67_7].orderType == StoryEnum.PictureOrderType.Produce and var_67_0[iter_67_7].picture == var_67_4[iter_67_6].picture then
								table.remove(var_67_0, #var_67_0)
								table.remove(var_67_0, iter_67_7)
							end
						end
					end
				end
			end
		end
	end

	arg_67_0:_resetStepPictures()

	if #arg_67_1 < 1 and #var_67_0 == 0 then
		return
	end

	arg_67_0._picCo = #var_67_0 > 0 and var_67_0 or arg_67_1

	for iter_67_8, iter_67_9 in pairs(arg_67_0._picCo) do
		local var_67_5 = iter_67_9.picType == StoryEnum.PictureType.FullScreen and "fullfocusitem" or iter_67_9.picture

		if iter_67_9.orderType == StoryEnum.PictureOrderType.Produce and iter_67_9.layer > 0 then
			arg_67_0:_buildPicture(var_67_5, iter_67_9, var_67_3)
		else
			arg_67_0:_destroyPicture(var_67_5, iter_67_9, var_67_3)
		end
	end

	arg_67_0:_checkFloatBgShow()
end

function var_0_0._resetStepPictures(arg_68_0)
	for iter_68_0, iter_68_1 in pairs(arg_68_0._pictures) do
		iter_68_1:resetStep()
	end
end

function var_0_0._checkFloatBgShow(arg_69_0)
	ZProj.TweenHelper.KillByObj(arg_69_0._imagefullbottom)

	for iter_69_0, iter_69_1 in pairs(arg_69_0._pictures) do
		if iter_69_1:isFloatType() then
			gohelper.setActive(arg_69_0._imagefullbottom.gameObject, true)

			local var_69_0 = arg_69_0._imagefullbottom.color.a

			ZProj.TweenHelper.DoFade(arg_69_0._imagefullbottom, var_69_0, arg_69_0._initFullBottomAlpha, 0.1, nil, nil, nil, EaseType.Linear)

			return
		end
	end

	local var_69_1 = 0

	for iter_69_2, iter_69_3 in pairs(arg_69_0._picCo) do
		var_69_1 = iter_69_3.orderType == StoryEnum.PictureOrderType.Destroy and iter_69_3.layer > 0 and iter_69_3.picType == StoryEnum.PictureType.Float and var_69_1 < iter_69_3.outTimes[GameLanguageMgr.instance:getVoiceTypeStoryIndex()] and iter_69_3.outTimes[GameLanguageMgr.instance:getVoiceTypeStoryIndex()] or var_69_1
	end

	for iter_69_4, iter_69_5 in pairs(arg_69_0._picCo) do
		if iter_69_5.orderType == StoryEnum.PictureOrderType.Produce and iter_69_5.layer > 0 and iter_69_5.picType == StoryEnum.PictureType.Float then
			var_69_1 = 0
		end
	end

	if var_69_1 < 0.01 then
		gohelper.setActive(arg_69_0._imagefullbottom.gameObject, false)
	else
		gohelper.setActive(arg_69_0._imagefullbottom.gameObject, true)
		ZProj.TweenHelper.DoFade(arg_69_0._imagefullbottom, arg_69_0._initFullBottomAlpha, 0, var_69_1, function()
			gohelper.setActive(arg_69_0._imagefullbottom.gameObject, false)
		end, nil, nil, EaseType.Linear)
	end
end

function var_0_0._buildPicture(arg_71_0, arg_71_1, arg_71_2, arg_71_3)
	local var_71_0

	if arg_71_2.layer < 4 then
		var_71_0 = arg_71_0._goimg1
	elseif arg_71_2.layer < 7 then
		var_71_0 = arg_71_0._goimg2
	elseif arg_71_2.layer < 10 then
		var_71_0 = arg_71_0._goimg3
	else
		if not arg_71_0._goimg4 then
			local var_71_1 = ViewMgr.instance:getContainer(ViewName.StoryFrontView).viewGO

			arg_71_0._goimg4 = gohelper.findChild(var_71_1, "#go_frontitem/#go_img4")
		end

		var_71_0 = arg_71_0._goimg4
	end

	if not arg_71_0._pictures[arg_71_1] then
		arg_71_0._pictures[arg_71_1] = StoryPictureItem.New()

		arg_71_0._pictures[arg_71_1]:init(var_71_0, arg_71_1, arg_71_2)
	elseif not arg_71_3 then
		arg_71_0._pictures[arg_71_1]:reset(var_71_0, arg_71_2)
	end
end

function var_0_0._destroyPicture(arg_72_0, arg_72_1, arg_72_2, arg_72_3)
	if not arg_72_0._pictures[arg_72_1] then
		if arg_72_3 then
			if arg_72_2.orderType == StoryEnum.PictureOrderType.Produce then
				arg_72_0:_buildPicture(arg_72_1, arg_72_2, arg_72_3)
			end

			TaskDispatcher.runDelay(function()
				arg_72_0:_startDestroyPic(arg_72_2, arg_72_3, arg_72_1)
			end, nil, 0.2)
		end

		return
	end

	arg_72_0:_startDestroyPic(arg_72_2, arg_72_3, arg_72_1)
end

function var_0_0._startDestroyPic(arg_74_0, arg_74_1, arg_74_2, arg_74_3)
	if not arg_74_0._pictures[arg_74_3] then
		return
	end

	local var_74_0 = 0
	local var_74_1 = arg_74_0._stepCo.videoList

	for iter_74_0, iter_74_1 in pairs(var_74_1) do
		if iter_74_1.orderType == StoryEnum.VideoOrderType.Produce then
			var_74_0 = 0.5
		end
	end

	arg_74_0._pictures[arg_74_3]:destroyPicture(arg_74_1, arg_74_2, var_74_0)

	arg_74_0._pictures[arg_74_3] = nil
end

function var_0_0._updateNavigateList(arg_75_0, arg_75_1)
	StoryController.instance:dispatchEvent(StoryEvent.RefreshNavigate, arg_75_1)
end

function var_0_0._updateVideoList(arg_76_0, arg_76_1)
	arg_76_0._videoCo = arg_76_1

	local var_76_0 = false

	arg_76_0:_checkCreatePlayList()

	for iter_76_0, iter_76_1 in pairs(arg_76_0._videoCo) do
		if iter_76_1.orderType == StoryEnum.VideoOrderType.Produce then
			arg_76_0:_buildVideo(iter_76_1.video, iter_76_1)
		elseif iter_76_1.orderType == StoryEnum.VideoOrderType.Destroy then
			arg_76_0:_destroyVideo(iter_76_1.video, iter_76_1)
		elseif iter_76_1.orderType == StoryEnum.VideoOrderType.Pause then
			arg_76_0._videos[iter_76_1.video]:pause(true)
		else
			arg_76_0._videos[iter_76_1.video]:pause(false)
		end
	end

	for iter_76_2, iter_76_3 in pairs(arg_76_0._videoCo) do
		if iter_76_3.delayTimes[GameLanguageMgr.instance:getVoiceTypeStoryIndex()] < 0.1 and (iter_76_3.orderType == StoryEnum.VideoOrderType.Produce or iter_76_3.orderType == StoryEnum.VideoOrderType.Pause or iter_76_3.orderType == StoryEnum.VideoOrderType.Restart) then
			var_76_0 = true
		end
	end

	if not var_76_0 then
		StoryController.instance:dispatchEvent(StoryEvent.ShowBackground)
	end
end

function var_0_0._videoStarted(arg_77_0, arg_77_1)
	for iter_77_0, iter_77_1 in pairs(arg_77_0._videos) do
		if iter_77_1 ~= arg_77_1 then
			iter_77_1:pause(true)
		end
	end
end

function var_0_0._buildVideo(arg_78_0, arg_78_1, arg_78_2)
	arg_78_0:_checkCreatePlayList()

	local var_78_0

	if arg_78_2.layer < 4 then
		var_78_0 = arg_78_0._govideo1
	elseif arg_78_2.layer < 7 then
		var_78_0 = arg_78_0._govideo2
	else
		var_78_0 = arg_78_0._govideo3
	end

	if not arg_78_0._videos[arg_78_1] then
		arg_78_0._videos[arg_78_1] = StoryVideoItem.New()

		arg_78_0._videos[arg_78_1]:init(var_78_0, arg_78_1, arg_78_2, arg_78_0._videoStarted, arg_78_0, arg_78_0._videoPlayList)
	else
		arg_78_0._videos[arg_78_1]:reset(var_78_0, arg_78_2)
	end
end

function var_0_0._destroyVideo(arg_79_0, arg_79_1, arg_79_2)
	if not arg_79_0._videos[arg_79_1] then
		return
	end

	arg_79_0._videos[arg_79_1]:destroyVideo(arg_79_2)

	arg_79_0._videos[arg_79_1] = nil
end

function var_0_0._checkCreatePlayList(arg_80_0)
	if not arg_80_0._videoPlayList then
		local var_80_0 = AvProMgr.instance:getStoryUrl()
		local var_80_1 = arg_80_0:getResInst(var_80_0, arg_80_0.viewGO, "play_list")

		arg_80_0._videoPlayList = StoryVideoPlayList.New()

		arg_80_0._videoPlayList:init(var_80_1, arg_80_0.viewGO)
	end
end

function var_0_0._checkDisposePlayList(arg_81_0)
	if arg_81_0._videoPlayList then
		arg_81_0._videoPlayList:dispose()

		arg_81_0._videoPlayList = nil
	end
end

function var_0_0._updateOptionList(arg_82_0, arg_82_1)
	arg_82_0._optCo = arg_82_1
end

function var_0_0._clearItems(arg_83_0)
	TaskDispatcher.cancelTask(arg_83_0._viewFadeIn, arg_83_0)
	TaskDispatcher.cancelTask(arg_83_0._enterNextStep, arg_83_0)
	TaskDispatcher.cancelTask(arg_83_0._startShowText, arg_83_0)
	TaskDispatcher.cancelTask(arg_83_0._startShake, arg_83_0)
	TaskDispatcher.cancelTask(arg_83_0._shakeStop, arg_83_0)

	for iter_83_0, iter_83_1 in pairs(arg_83_0._pictures) do
		iter_83_1:onDestroy()
	end

	arg_83_0._pictures = {}

	for iter_83_2, iter_83_3 in pairs(arg_83_0._effects) do
		iter_83_3:onDestroy()
	end

	arg_83_0._effects = {}

	for iter_83_4, iter_83_5 in pairs(arg_83_0._videos) do
		iter_83_5:onDestroy()
	end

	arg_83_0._videos = {}

	arg_83_0:_checkDisposePlayList()
end

function var_0_0.onDestroyView(arg_84_0)
	if ViewMgr.instance:isOpen(ViewName.MessageBoxView) then
		ViewMgr.instance:closeView(ViewName.MessageBoxView, true)
	end

	if arg_84_0._confadeId then
		ZProj.TweenHelper.KillById(arg_84_0._confadeId)

		arg_84_0._confadeId = nil
	end

	ZProj.TweenHelper.KillByObj(arg_84_0._imagefullbottom)
	arg_84_0:_checkDisposePlayList()
	TaskDispatcher.cancelTask(arg_84_0._conShowIn, arg_84_0)
	TaskDispatcher.cancelTask(arg_84_0._startShowText, arg_84_0)
	TaskDispatcher.cancelTask(arg_84_0._enterNextStep, arg_84_0)
	TaskDispatcher.cancelTask(arg_84_0._onFullTextKeepFinished, arg_84_0)
	TaskDispatcher.cancelTask(arg_84_0._startShake, arg_84_0)
	TaskDispatcher.cancelTask(arg_84_0._shakeStop, arg_84_0)
	StoryTool.enablePostProcess(false)
	ViewMgr.instance:closeView(ViewName.StoryFrontView, nil, true)
	arg_84_0._simagehead:UnLoadImage()
	StoryController.instance:stopPlotMusic()

	arg_84_0._bgAudio = nil

	arg_84_0:stopAllAudio(0)

	if arg_84_0._dialogItem then
		arg_84_0._dialogItem:destroy()

		arg_84_0._dialogItem = nil
	end
end

return var_0_0
