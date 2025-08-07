module("modules.logic.story.view.StoryFrontItem", package.seeall)

local var_0_0 = class("StoryFrontItem")

function var_0_0.init(arg_1_0, arg_1_1)
	arg_1_0._frontGO = arg_1_1
	arg_1_0._txtscreentext = gohelper.findChildText(arg_1_1, "txt_screentext")
	arg_1_0._imagefulltop = gohelper.findChildImage(arg_1_1, "image_fulltop")
	arg_1_0._imageupfade = gohelper.findChildImage(arg_1_1, "go_upfade")
	arg_1_0._imageblock = gohelper.findChildImage(arg_1_1, "#go_block")
	arg_1_0._goupfade = gohelper.findChild(arg_1_1, "go_upfade")
	arg_1_0._goirregularshake = gohelper.findChild(arg_1_1.transform.parent.gameObject, "#go_irregularshake")

	arg_1_0:setFullTopShow()
	gohelper.setActive(arg_1_0._txtscreentext.gameObject, false)

	arg_1_0._imagefulltop.color.a = 1
	arg_1_0._imagefulltop.color = Color.black

	arg_1_0:_addEvent()
end

function var_0_0._addEvent(arg_2_0)
	StoryController.instance:registerCallback(StoryEvent.PlayDarkFadeUp, arg_2_0._playDarkUpFade, arg_2_0)
	StoryController.instance:registerCallback(StoryEvent.PlayDarkFade, arg_2_0._playDarkFade, arg_2_0)
	StoryController.instance:registerCallback(StoryEvent.PlayWhiteFade, arg_2_0._playWhiteFade, arg_2_0)
end

function var_0_0._removeEvent(arg_3_0)
	StoryController.instance:unregisterCallback(StoryEvent.PlayDarkFadeUp, arg_3_0._playDarkUpFade, arg_3_0)
	StoryController.instance:unregisterCallback(StoryEvent.PlayDarkFade, arg_3_0._playDarkFade, arg_3_0)
	StoryController.instance:unregisterCallback(StoryEvent.PlayWhiteFade, arg_3_0._playWhiteFade, arg_3_0)
end

function var_0_0.showFullScreenText(arg_4_0, arg_4_1, arg_4_2)
	if not arg_4_1 then
		arg_4_0._finishCallback = nil
		arg_4_0._finishCallbackObj = nil
		arg_4_0._fadeOutCallback = nil
		arg_4_0._fadeOutCallbackObj = nil

		ZProj.TweenHelper.KillByObj(arg_4_0._txtscreentext)
		ZProj.TweenHelper.KillByObj(arg_4_0._copyText)

		if arg_4_0._copyText then
			gohelper.destroy(arg_4_0._copyText.gameObject)

			arg_4_0._copyText = nil
		end
	end

	gohelper.setActive(arg_4_0._txtscreentext.gameObject, arg_4_1)

	arg_4_0._diatxt = string.gsub(arg_4_2, "<notShowInLog>", "")

	local var_4_0 = StoryController.instance._curStepId
	local var_4_1 = StoryStepModel.instance:getStepListById(var_4_0)

	arg_4_0._diatxt = StoryModel.instance:getStoryTxtByVoiceType(arg_4_0._diatxt, var_4_1.conversation.audio or 0)
	arg_4_0._txtscreentext.alignment = StoryTool.getTxtAlignment(arg_4_0._diatxt)
	arg_4_0._txtscreentext.text = StoryTool.getFilterAlignTxt(arg_4_0._diatxt)

	arg_4_0:_showGlitch(var_4_1.conversation.effType == StoryEnum.ConversationEffectType.Glitch)
end

function var_0_0.enableFrontRayCast(arg_5_0, arg_5_1)
	arg_5_0._txtscreentext.raycastTarget = arg_5_1
	arg_5_0._imagefulltop.raycastTarget = arg_5_1
	arg_5_0._imageblock.raycastTarget = arg_5_1
	arg_5_0._imageupfade.raycastTarget = arg_5_1
end

function var_0_0._showGlitch(arg_6_0, arg_6_1)
	if arg_6_1 then
		if not arg_6_0._goGlitch then
			arg_6_0._glitchPath = ResUrl.getEffect("story/v2a6_fontglitch")
			arg_6_0._effLoader = MultiAbLoader.New()

			arg_6_0._effLoader:addPath(arg_6_0._glitchPath)
			arg_6_0._effLoader:startLoad(arg_6_0._glitchEffLoaded, arg_6_0)
		else
			local var_6_0 = arg_6_0._txtscreentext.gameObject:GetComponent(typeof(UnityEngine.UI.CustomText))

			var_6_0.isSetParticleShapeMesh = true
			var_6_0.isSetParticleCount = true

			gohelper.setLayer(arg_6_0._txtscreentext.gameObject, UnityLayer.UISecond, true)
			gohelper.setActive(arg_6_0._goGlitch, true)
		end
	else
		gohelper.setLayer(arg_6_0._txtscreentext.gameObject, UnityLayer.UITop, true)

		if arg_6_0._goGlitch then
			gohelper.setActive(arg_6_0._goGlitch, false)
		end

		local var_6_1 = arg_6_0._txtscreentext.gameObject:GetComponent(typeof(UnityEngine.UI.CustomText))

		var_6_1.isSetParticleShapeMesh = false
		var_6_1.isSetParticleCount = false
	end
end

function var_0_0.playGlitch(arg_7_0)
	StoryTool.enablePostProcess(true)
	gohelper.setActive(arg_7_0._txtscreentext.gameObject, true)
	arg_7_0:_showGlitch(true)
end

function var_0_0._glitchEffLoaded(arg_8_0, arg_8_1)
	local var_8_0 = arg_8_1:getAssetItem(arg_8_0._glitchPath)

	arg_8_0._goGlitch = gohelper.clone(var_8_0:GetResource(arg_8_0._glitchPath), arg_8_0._txtscreentext.gameObject)

	gohelper.setActive(arg_8_0._goGlitch, true)

	local var_8_1 = gohelper.findChild(arg_8_0._goGlitch, "part_up")
	local var_8_2 = gohelper.findChild(arg_8_0._goGlitch, "part_down")
	local var_8_3 = gohelper.findChild(arg_8_0._goGlitch, "part_screen")

	gohelper.setActive(var_8_1, false)
	gohelper.setActive(var_8_2, false)
	gohelper.setActive(var_8_3, true)

	local var_8_4 = arg_8_0._txtscreentext.gameObject:GetComponent(typeof(UnityEngine.UI.CustomText))

	var_8_4.isSetParticleShapeMesh = true
	var_8_4.isSetParticleCount = true
	var_8_4.particle = var_8_3:GetComponent(typeof(UnityEngine.ParticleSystem))

	gohelper.setLayer(arg_8_0._txtscreentext.gameObject, UnityLayer.UISecond, true)
end

function var_0_0._getFadeTime(arg_9_0)
	return not StoryModel.instance.skipFade and 1 or 0
end

function var_0_0.setFullTopShow(arg_10_0)
	gohelper.setActive(arg_10_0._imagefulltop.gameObject, not StoryModel.instance.skipFade and true or false)
end

function var_0_0.playStoryViewIn(arg_11_0)
	local var_11_0 = StoryModel.instance:isTypeSkip(StoryEnum.SkipType.InDarkFade, StoryController.instance._curStoryId)

	StoryModel.instance.skipFade = var_11_0

	ZProj.TweenHelper.KillByObj(arg_11_0._imagefulltop)

	arg_11_0._imagefulltop.color.a = 1

	arg_11_0:setFullTopShow()

	if not var_11_0 then
		TaskDispatcher.runDelay(arg_11_0._startStoryViewIn, arg_11_0, 0.5)
	end
end

function var_0_0._startStoryViewIn(arg_12_0)
	local var_12_0 = arg_12_0._imagefulltop.color.a

	ZProj.TweenHelper.DoFade(arg_12_0._imagefulltop, var_12_0, 0, arg_12_0:_getFadeTime(), function()
		gohelper.setActive(arg_12_0._imagefulltop.gameObject, false)
	end, nil, nil, EaseType.Linear)
end

function var_0_0.playStoryViewOut(arg_14_0, arg_14_1, arg_14_2, arg_14_3)
	local var_14_0 = StoryModel.instance:isTypeSkip(StoryEnum.SkipType.OutDarkFade, StoryController.instance._curStoryId)

	StoryModel.instance.skipFade = var_14_0

	arg_14_0:setFullTopShow()

	arg_14_0._imagefulltop.color.a = 0
	arg_14_0._finishCallback = nil
	arg_14_0._finishCallbackObj = nil
	arg_14_0._fadeOutCallback = nil
	arg_14_0._fadeOutCallbackObj = nil

	ZProj.TweenHelper.KillByObj(arg_14_0._txtscreentext)
	ZProj.TweenHelper.KillByObj(arg_14_0._copyText)

	if arg_14_0._copyText then
		gohelper.destroy(arg_14_0._copyText.gameObject)

		arg_14_0._copyText = nil
	end

	arg_14_0._outCallback = arg_14_1
	arg_14_0._outCallbackObj = arg_14_2

	ZProj.TweenHelper.KillByObj(arg_14_0._imagefulltop)
	ZProj.TweenHelper.DoFade(arg_14_0._imagefulltop, 0, 1, arg_14_0:_getFadeTime(), arg_14_0.enterStoryFinish, arg_14_0, nil, EaseType.Linear)
end

function var_0_0.enterStoryFinish(arg_15_0)
	gohelper.setActive(arg_15_0._txtscreentext.gameObject, false)
	StoryController.instance:dispatchEvent(StoryEvent.Hide)
	ViewMgr.instance:registerCallback(ViewEvent.OnOpenFullView, arg_15_0._onOpenView, arg_15_0)
	TaskDispatcher.runDelay(arg_15_0._viewFadeOut, arg_15_0, 0.5)
	StoryController.instance:finished()
end

function var_0_0._onOpenView(arg_16_0, arg_16_1)
	ViewMgr.instance:unregisterCallback(ViewEvent.OnOpenFullView, arg_16_0._onOpenView, arg_16_0)

	if arg_16_1 == ViewName.StoryView or arg_16_1 == ViewName.StoryBackgroundView then
		TaskDispatcher.cancelTask(arg_16_0._viewFadeOut, arg_16_0)

		return
	end

	local var_16_0 = StoryController.instance._curStoryId

	if StoryModel.instance:isStoryFinished(var_16_0) then
		StoryController.instance:closeStoryView()
	end
end

function var_0_0.cancelViewFadeOut(arg_17_0)
	TaskDispatcher.cancelTask(arg_17_0._viewFadeOut, arg_17_0)
end

function var_0_0._viewFadeOut(arg_18_0)
	ViewMgr.instance:unregisterCallback(ViewEvent.OnOpenFullView, arg_18_0._onOpenView, arg_18_0)
	StoryController.instance:closeStoryView()
	TaskDispatcher.runDelay(arg_18_0._viewFadeOutFinished, arg_18_0, 0.1)
	StoryController.instance:dispatchEvent(StoryEvent.FrontItemFadeOut)
end

function var_0_0._viewFadeOutFinished(arg_19_0)
	gohelper.setActive(arg_19_0._imagefulltop.gameObject, false)

	if arg_19_0._outCallback then
		arg_19_0._outCallback(arg_19_0._outCallbackObj)
	end
end

function var_0_0._playDarkUpFade(arg_20_0)
	gohelper.setActive(arg_20_0._goupfade, true)
	transformhelper.setLocalPosXY(arg_20_0._goupfade.transform, 0, 390)
	ZProj.TweenHelper.DOLocalMove(arg_20_0._goupfade.transform, 0, 2800, 0, 1.5, function()
		gohelper.setActive(arg_20_0._goupfade, false)
	end)
end

function var_0_0._playDarkFade(arg_22_0)
	StoryModel.instance.skipFade = false

	arg_22_0:setFullTopShow()

	arg_22_0._imagefulltop.color.a = 0
	arg_22_0._imagefulltop.color = Color.black

	ZProj.TweenHelper.DoFade(arg_22_0._imagefulltop, 0, 1, 1.5, arg_22_0._playDarkFadeFinished, arg_22_0, nil, EaseType.Linear)
end

function var_0_0._playDarkFadeFinished(arg_23_0)
	StoryController.instance:dispatchEvent(StoryEvent.RefreshView)
	StoryController.instance:dispatchEvent(StoryEvent.RefreshBackground)
	ZProj.TweenHelper.KillByObj(arg_23_0._imagefulltop)
	TaskDispatcher.runDelay(arg_23_0._playDarkFadeInFinished, arg_23_0, 0.5)
end

function var_0_0._playDarkFadeInFinished(arg_24_0)
	ZProj.TweenHelper.DoFade(arg_24_0._imagefulltop, 1, 0, 1.5, arg_24_0._hideImageFullTop, arg_24_0, nil, EaseType.Linear)
end

function var_0_0._hideImageFullTop(arg_25_0)
	arg_25_0._imagefulltop.color = Color.black

	gohelper.setActive(arg_25_0._imagefulltop.gameObject, false)
end

function var_0_0._playWhiteFade(arg_26_0)
	StoryModel.instance.skipFade = false

	arg_26_0:setFullTopShow()

	arg_26_0._imagefulltop.color.a = 0
	arg_26_0._imagefulltop.color = Color.white

	ZProj.TweenHelper.DoFade(arg_26_0._imagefulltop, 0, 1, 1.5, arg_26_0._playWhiteFadeFinished, arg_26_0, nil, EaseType.Linear)
end

function var_0_0._playWhiteFadeFinished(arg_27_0)
	StoryController.instance:dispatchEvent(StoryEvent.RefreshView)
	StoryController.instance:dispatchEvent(StoryEvent.RefreshBackground)
	ZProj.TweenHelper.KillByObj(arg_27_0._imagefulltop)
	TaskDispatcher.runDelay(arg_27_0._playDarkFadeInFinished, arg_27_0, 0.5)
end

function var_0_0._playWhiteFadeInFinished(arg_28_0)
	ZProj.TweenHelper.DoFade(arg_28_0._imagefulltop, 1, 0, 1.5, arg_28_0._hideImageFullTop, arg_28_0, nil, EaseType.Linear)
end

function var_0_0.playIrregularShakeText(arg_29_0, arg_29_1, arg_29_2, arg_29_3)
	arg_29_0._stepCo = arg_29_1

	gohelper.setActive(arg_29_0._goirregularshake, true)

	arg_29_0._shakefinishCallback = arg_29_2
	arg_29_0._shakefinishCallbackObj = arg_29_3

	if not arg_29_0._goshake then
		local var_29_0 = ViewMgr.instance:getContainer(ViewName.StoryFrontView)

		arg_29_0._goshake = var_29_0:getResInst(var_29_0:getSetting().otherRes[1], arg_29_0._goirregularshake)
	end

	local var_29_1 = gohelper.findChildText(arg_29_0._goshake, "tex_ani/#tex")

	arg_29_0._shakeAni = arg_29_0._goshake:GetComponent(typeof(UnityEngine.Animator))
	var_29_1.text = arg_29_0._stepCo.conversation.diaTexts[GameLanguageMgr.instance:getLanguageTypeStoryIndex()]

	local var_29_2 = arg_29_0._stepCo.conversation.showTimes[GameLanguageMgr.instance:getVoiceTypeStoryIndex()] - 0.17

	if var_29_2 < 0.1 then
		if arg_29_0._shakefinishCallback then
			arg_29_0._shakefinishCallback(arg_29_0._shakefinishCallbackObj)

			arg_29_0._shakefinishCallback = nil
			arg_29_0._shakefinishCallbackObj = nil
		end

		return
	end

	TaskDispatcher.runDelay(arg_29_0._onShakeEnd, arg_29_0, var_29_2)
end

function var_0_0._onShakeEnd(arg_30_0)
	arg_30_0._shakeAni:Play("close", 0, 0)
	TaskDispatcher.runDelay(function()
		gohelper.setActive(arg_30_0._goirregularshake, false)

		if arg_30_0._shakefinishCallback then
			arg_30_0._shakefinishCallback(arg_30_0._shakefinishCallbackObj)

			arg_30_0._shakefinishCallback = nil
			arg_30_0._shakefinishCallbackObj = nil
		end
	end, nil, 0.17)
end

function var_0_0.wordByWord(arg_32_0, arg_32_1, arg_32_2, arg_32_3)
	arg_32_0._stepCo = arg_32_1

	gohelper.setActive(arg_32_0._txtscreentext.gameObject, true)

	arg_32_0._finishCallback = arg_32_2
	arg_32_0._finishCallbackObj = arg_32_3

	ZProj.UGUIHelper.SetColorAlpha(arg_32_0._txtscreentext, 1)

	if arg_32_0._stepCo.conversation.showTimes[GameLanguageMgr.instance:getVoiceTypeStoryIndex()] < 0.1 then
		if arg_32_0._finishCallback then
			arg_32_0._finishCallback(arg_32_0._finishCallbackObj)

			arg_32_0._finishCallback = nil
			arg_32_0._finishCallbackObj = nil
		end

		return
	end

	arg_32_0:_startWordByWord()
end

function var_0_0._startWordByWord(arg_33_0)
	ZProj.TweenHelper.KillByObj(arg_33_0._txtscreentext)

	arg_33_0._txtscreentext.text = ""

	local var_33_0 = StoryTool.getTxtAlignment(arg_33_0._stepCo.conversation.diaTexts[GameLanguageMgr.instance:getLanguageTypeStoryIndex()])

	arg_33_0._txtscreentext.alignment = var_33_0

	local var_33_1 = StoryTool.getFilterAlignTxt(arg_33_0._stepCo.conversation.diaTexts[GameLanguageMgr.instance:getLanguageTypeStoryIndex()])

	ZProj.TweenHelper.DOText(arg_33_0._txtscreentext, var_33_1, arg_33_0._stepCo.conversation.showTimes[GameLanguageMgr.instance:getVoiceTypeStoryIndex()], function()
		if arg_33_0._finishCallback then
			arg_33_0._finishCallback(arg_33_0._finishCallbackObj)

			arg_33_0._finishCallback = nil
			arg_33_0._finishCallbackObj = nil
		end
	end)
end

function var_0_0.lineShow(arg_35_0, arg_35_1, arg_35_2, arg_35_3, arg_35_4)
	arg_35_0._stepCo = arg_35_2

	gohelper.setActive(arg_35_0._txtscreentext.gameObject, true)

	arg_35_0._finishCallback = arg_35_3
	arg_35_0._finishCallbackObj = arg_35_4

	ZProj.UGUIHelper.SetColorAlpha(arg_35_0._txtscreentext, 1)

	if arg_35_0._stepCo.conversation.showTimes[GameLanguageMgr.instance:getVoiceTypeStoryIndex()] < 0.1 then
		if arg_35_0._finishCallback then
			arg_35_0._finishCallback(arg_35_0._finishCallbackObj)

			arg_35_0._finishCallback = nil
			arg_35_0._finishCallbackObj = nil
		end

		return
	end

	arg_35_0:_startShowLine(arg_35_1)
end

function var_0_0._startShowLine(arg_36_0, arg_36_1)
	if not arg_36_0._copyText then
		local var_36_0 = gohelper.cloneInPlace(arg_36_0._txtscreentext.gameObject, "copytext")

		arg_36_0._copyCanvasGroup = gohelper.onceAddComponent(var_36_0, typeof(UnityEngine.CanvasGroup))
		arg_36_0._copyText = var_36_0:GetComponent(gohelper.Type_Text)
	end

	arg_36_0._copyText.alignment = StoryTool.getTxtAlignment(arg_36_0._diatxt)
	arg_36_0._diatxt = StoryTool.getFilterAlignTxt(arg_36_0._diatxt)
	arg_36_0._diatxt = StoryModel.instance:getStoryTxtByVoiceType(arg_36_0._diatxt, arg_36_0._stepCo.conversation.audio or 0)

	gohelper.setActive(arg_36_0._copyText.gameObject, true)

	local var_36_1 = arg_36_0:_getLineWord(arg_36_1)
	local var_36_2 = #var_36_1 == 0 and arg_36_0._stepCo.conversation.showTimes[GameLanguageMgr.instance:getVoiceTypeStoryIndex()] or arg_36_0._stepCo.conversation.showTimes[GameLanguageMgr.instance:getVoiceTypeStoryIndex()] / #var_36_1
	local var_36_3 = 1

	local function var_36_4(arg_37_0)
		local var_37_0 = " "
		local var_37_1 = ""
		local var_37_2 = #string.split(var_37_1, "\n")

		if var_37_2 > 1 then
			for iter_37_0 = 2, var_37_2 do
				var_37_0 = string.format("%s\n%s", var_37_0, " ")
			end
		end

		if #var_36_1 >= 1 then
			for iter_37_1 = 1, #var_36_1 do
				local var_37_3 = #string.split(var_36_1[iter_37_1], "\n") or 1

				if iter_37_1 < arg_37_0 then
					var_37_1 = string.format("%s\n%s", var_37_1, var_36_1[iter_37_1])

					for iter_37_2 = 1, var_37_3 do
						local var_37_4, var_37_5, var_37_6, var_37_7 = string.match(string.split(var_36_1[iter_37_1], "\n")[iter_37_2], "(.*)<size=(%d+)>(.*)</size>(%s*)")

						if var_37_5 and tonumber(var_37_5) then
							var_37_0 = string.format("%s\n%s", var_37_0, string.format("<size=%s> </size>", var_37_5))
						else
							var_37_0 = string.format("%s\n%s", var_37_0, " ")
						end
					end
				elseif iter_37_1 == arg_37_0 then
					for iter_37_3 = 1, var_37_3 do
						var_37_1 = string.format("%s\n%s", var_37_1, " ")
					end

					var_37_0 = string.format("%s\n%s", var_37_0, var_36_1[iter_37_1])
				else
					for iter_37_4 = 1, var_37_3 do
						var_37_1 = string.format("%s\n%s", var_37_1, " ")
						var_37_0 = string.format("%s\n%s", var_37_0, " ")
					end
				end
			end
		end

		arg_36_0._txtscreentext.text = var_37_1
		arg_36_0._copyText.text = var_37_0

		ZProj.TweenHelper.KillByObj(arg_36_0._txtscreentext)
		ZProj.TweenHelper.KillByObj(arg_36_0._copyText)
		ZProj.UGUIHelper.SetColorAlpha(arg_36_0._txtscreentext, 1)
		ZProj.TweenHelper.DOFadeCanvasGroup(arg_36_0._copyText.gameObject, 0, 1, var_36_2, function()
			if arg_37_0 - #var_36_1 >= 0 then
				arg_36_0:_lineWordShowFinished()
			else
				arg_37_0 = arg_37_0 + 1

				var_36_4(arg_37_0)
			end
		end, nil, nil, EaseType.Linear)
	end

	var_36_4(var_36_3)
end

function var_0_0._getLineWord(arg_39_0, arg_39_1)
	local var_39_0 = string.split(arg_39_0._diatxt, "\n")
	local var_39_1 = {}
	local var_39_2 = math.floor(#var_39_0 / arg_39_1)

	for iter_39_0 = 0, var_39_2 - 1 do
		local var_39_3 = var_39_0[iter_39_0 * arg_39_1 + 1]

		for iter_39_1 = 2, arg_39_1 do
			var_39_3 = string.format("%s\n%s", var_39_3, var_39_0[iter_39_0 * arg_39_1 + iter_39_1])
		end

		table.insert(var_39_1, var_39_3)
	end

	if var_39_2 * arg_39_1 < #var_39_0 then
		local var_39_4 = var_39_0[var_39_2 * arg_39_1 + 1]

		if #var_39_0 - var_39_2 * arg_39_1 > 1 then
			for iter_39_2 = 2, #var_39_0 - var_39_2 * arg_39_1 do
				var_39_4 = string.format("%s\n%s", var_39_4, var_39_0[arg_39_1 * var_39_2 + iter_39_2])
			end
		end

		table.insert(var_39_1, var_39_4)
	end

	return var_39_1
end

function var_0_0._lineWordShowFinished(arg_40_0)
	arg_40_0._txtscreentext.text = "\n" .. arg_40_0._diatxt

	gohelper.setActive(arg_40_0._copyText.gameObject, false)

	if arg_40_0._finishCallback then
		arg_40_0._finishCallback(arg_40_0._finishCallbackObj)

		arg_40_0._finishCallback = nil
		arg_40_0._finishCallback = nil
	end
end

function var_0_0.playFullTextFadeOut(arg_41_0, arg_41_1, arg_41_2, arg_41_3)
	local var_41_0 = arg_41_1 or 0.5

	arg_41_0._fadeOutCallback = arg_41_2
	arg_41_0._fadeOutCallbackObj = arg_41_3

	ZProj.TweenHelper.KillByObj(arg_41_0._txtscreentext)
	ZProj.TweenHelper.DoFade(arg_41_0._txtscreentext, 1, 0, var_41_0, arg_41_0._hideScreenTxt, arg_41_0, nil, EaseType.Linear)
end

function var_0_0._hideScreenTxt(arg_42_0)
	ZProj.TweenHelper.KillByObj(arg_42_0._txtscreentext)
	gohelper.setActive(arg_42_0._txtscreentext.gameObject, false)

	if arg_42_0._fadeOutCallback then
		arg_42_0._fadeOutCallback(arg_42_0._fadeOutCallbackObj)

		arg_42_0._fadeOutCallback = nil
		arg_42_0._fadeOutCallbackObj = nil
	end
end

function var_0_0.playTextFadeIn(arg_43_0, arg_43_1, arg_43_2, arg_43_3)
	arg_43_0._stepCo = arg_43_1

	gohelper.setActive(arg_43_0._txtscreentext.gameObject, true)

	arg_43_0._finishCallback = arg_43_2
	arg_43_0._finishCallbackObj = arg_43_3

	ZProj.TweenHelper.KillByObj(arg_43_0._txtscreentext)

	if arg_43_0._stepCo.conversation.showTimes[GameLanguageMgr.instance:getVoiceTypeStoryIndex()] < 0.1 then
		ZProj.UGUIHelper.SetColorAlpha(arg_43_0._txtscreentext, 1)
		arg_43_0:_fadeFinished()
	else
		local var_43_0 = arg_43_0._txtscreentext.text

		if string.match(var_43_0, "<color=#%x+>") then
			local var_43_1 = string.gsub(var_43_0, "<color=#(%x%x%x%x%x%x)(%x-)>", "<color=#%100>")

			arg_43_0._txtscreentext.text = var_43_1
		end

		arg_43_0._floatTweenId = ZProj.TweenHelper.DOTweenFloat(0, 1, arg_43_0._stepCo.conversation.showTimes[GameLanguageMgr.instance:getVoiceTypeStoryIndex()], arg_43_0._fadeUpdate, arg_43_0._fadeFinished, arg_43_0, nil, EaseType.Linear)
	end
end

function var_0_0._fadeUpdate(arg_44_0, arg_44_1)
	local var_44_0 = arg_44_0._txtscreentext.text
	local var_44_1 = math.ceil(255 * arg_44_1)
	local var_44_2 = string.format("%02x", var_44_1)

	if string.match(var_44_0, "<color=#%x+>") then
		local var_44_3 = string.gsub(var_44_0, "<color=#(%x%x%x%x%x%x)(%x+)>", "<color=#%1" .. var_44_2 .. ">")

		arg_44_0._txtscreentext.text = var_44_3

		return
	end

	ZProj.UGUIHelper.SetColorAlpha(arg_44_0._txtscreentext, arg_44_1)
end

function var_0_0._fadeFinished(arg_45_0)
	if arg_45_0._finishCallback then
		arg_45_0._finishCallback(arg_45_0._finishCallbackObj)

		arg_45_0._finishCallback = nil
		arg_45_0._finishCallbackObj = nil
	end
end

function var_0_0.destroy(arg_46_0)
	arg_46_0:_removeEvent()

	arg_46_0._finishCallback = nil
	arg_46_0._finishCallbackObj = nil
	arg_46_0._outCallback = nil
	arg_46_0._outCallbackObj = nil
	arg_46_0._fadeOutCallback = nil
	arg_46_0._fadeOutCallbackObj = nil

	TaskDispatcher.cancelTask(arg_46_0._viewFadeOutFinished, arg_46_0)
	TaskDispatcher.cancelTask(arg_46_0._startStoryViewIn, arg_46_0)
	TaskDispatcher.cancelTask(arg_46_0._viewFadeOut, arg_46_0)
	TaskDispatcher.cancelTask(arg_46_0._onShakeEnd, arg_46_0)

	if arg_46_0._floatTweenId then
		ZProj.TweenHelper.KillById(arg_46_0._floatTweenId)

		arg_46_0._floatTweenId = nil
	end

	ZProj.TweenHelper.KillByObj(arg_46_0._imagefulltop)
	ZProj.TweenHelper.KillByObj(arg_46_0._goupfade.transform)
	ZProj.TweenHelper.KillByObj(arg_46_0._txtscreentext)
end

return var_0_0
