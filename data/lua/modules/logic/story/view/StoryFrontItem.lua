module("modules.logic.story.view.StoryFrontItem", package.seeall)

local var_0_0 = class("StoryFrontItem")

function var_0_0.init(arg_1_0, arg_1_1)
	arg_1_0._frontGO = arg_1_1
	arg_1_0._txtscreentext = gohelper.findChildText(arg_1_1, "txt_screentext")
	arg_1_0._imagefulltop = gohelper.findChildImage(arg_1_1, "image_fulltop")
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

function var_0_0._showGlitch(arg_5_0, arg_5_1)
	if arg_5_1 then
		if not arg_5_0._goGlitch then
			arg_5_0._glitchPath = ResUrl.getEffect("story/v2a6_fontglitch")
			arg_5_0._effLoader = MultiAbLoader.New()

			arg_5_0._effLoader:addPath(arg_5_0._glitchPath)
			arg_5_0._effLoader:startLoad(arg_5_0._glitchEffLoaded, arg_5_0)
		else
			local var_5_0 = arg_5_0._txtscreentext.gameObject:GetComponent(typeof(UnityEngine.UI.CustomText))

			var_5_0.isSetParticleShapeMesh = true
			var_5_0.isSetParticleCount = true

			gohelper.setLayer(arg_5_0._txtscreentext.gameObject, UnityLayer.UISecond, true)
			gohelper.setActive(arg_5_0._goGlitch, true)
		end
	else
		gohelper.setLayer(arg_5_0._txtscreentext.gameObject, UnityLayer.UITop, true)

		if arg_5_0._goGlitch then
			gohelper.setActive(arg_5_0._goGlitch, false)
		end

		local var_5_1 = arg_5_0._txtscreentext.gameObject:GetComponent(typeof(UnityEngine.UI.CustomText))

		var_5_1.isSetParticleShapeMesh = false
		var_5_1.isSetParticleCount = false
	end
end

function var_0_0.playGlitch(arg_6_0)
	StoryTool.enablePostProcess(true)
	gohelper.setActive(arg_6_0._txtscreentext.gameObject, true)
	arg_6_0:_showGlitch(true)
end

function var_0_0._glitchEffLoaded(arg_7_0, arg_7_1)
	local var_7_0 = arg_7_1:getAssetItem(arg_7_0._glitchPath)

	arg_7_0._goGlitch = gohelper.clone(var_7_0:GetResource(arg_7_0._glitchPath), arg_7_0._txtscreentext.gameObject)

	gohelper.setActive(arg_7_0._goGlitch, true)

	local var_7_1 = gohelper.findChild(arg_7_0._goGlitch, "part_up")
	local var_7_2 = gohelper.findChild(arg_7_0._goGlitch, "part_down")
	local var_7_3 = gohelper.findChild(arg_7_0._goGlitch, "part_screen")

	gohelper.setActive(var_7_1, false)
	gohelper.setActive(var_7_2, false)
	gohelper.setActive(var_7_3, true)

	local var_7_4 = arg_7_0._txtscreentext.gameObject:GetComponent(typeof(UnityEngine.UI.CustomText))

	var_7_4.isSetParticleShapeMesh = true
	var_7_4.isSetParticleCount = true
	var_7_4.particle = var_7_3:GetComponent(typeof(UnityEngine.ParticleSystem))

	gohelper.setLayer(arg_7_0._txtscreentext.gameObject, UnityLayer.UISecond, true)
end

function var_0_0._getFadeTime(arg_8_0)
	return not StoryModel.instance.skipFade and 1 or 0
end

function var_0_0.setFullTopShow(arg_9_0)
	gohelper.setActive(arg_9_0._imagefulltop.gameObject, not StoryModel.instance.skipFade and true or false)
end

function var_0_0.playStoryViewIn(arg_10_0)
	local var_10_0 = StoryModel.instance:isTypeSkip(StoryEnum.SkipType.InDarkFade, StoryController.instance._curStoryId)

	StoryModel.instance.skipFade = var_10_0

	ZProj.TweenHelper.KillByObj(arg_10_0._imagefulltop)

	arg_10_0._imagefulltop.color.a = 1

	arg_10_0:setFullTopShow()

	if not var_10_0 then
		TaskDispatcher.runDelay(arg_10_0._startStoryViewIn, arg_10_0, 0.5)
	end
end

function var_0_0._startStoryViewIn(arg_11_0)
	local var_11_0 = arg_11_0._imagefulltop.color.a

	ZProj.TweenHelper.DoFade(arg_11_0._imagefulltop, var_11_0, 0, arg_11_0:_getFadeTime(), function()
		gohelper.setActive(arg_11_0._imagefulltop.gameObject, false)
	end, nil, nil, EaseType.Linear)
end

function var_0_0.playStoryViewOut(arg_13_0, arg_13_1, arg_13_2, arg_13_3)
	local var_13_0 = StoryModel.instance:isTypeSkip(StoryEnum.SkipType.OutDarkFade, StoryController.instance._curStoryId)

	StoryModel.instance.skipFade = var_13_0

	arg_13_0:setFullTopShow()

	arg_13_0._imagefulltop.color.a = 0
	arg_13_0._finishCallback = nil
	arg_13_0._finishCallbackObj = nil

	ZProj.TweenHelper.KillByObj(arg_13_0._txtscreentext)
	ZProj.TweenHelper.KillByObj(arg_13_0._copyText)

	if arg_13_0._copyText then
		gohelper.destroy(arg_13_0._copyText.gameObject)

		arg_13_0._copyText = nil
	end

	arg_13_0._outCallback = arg_13_1
	arg_13_0._outCallbackObj = arg_13_2

	ZProj.TweenHelper.KillByObj(arg_13_0._imagefulltop)
	ZProj.TweenHelper.DoFade(arg_13_0._imagefulltop, 0, 1, arg_13_0:_getFadeTime(), arg_13_0.enterStoryFinish, arg_13_0, nil, EaseType.Linear)
end

function var_0_0.enterStoryFinish(arg_14_0)
	gohelper.setActive(arg_14_0._txtscreentext.gameObject, false)
	StoryController.instance:dispatchEvent(StoryEvent.Hide)
	ViewMgr.instance:registerCallback(ViewEvent.OnOpenFullView, arg_14_0._onOpenView, arg_14_0)
	TaskDispatcher.runDelay(arg_14_0._viewFadeOut, arg_14_0, 0.5)
	StoryController.instance:finished()
end

function var_0_0._onOpenView(arg_15_0, arg_15_1)
	ViewMgr.instance:unregisterCallback(ViewEvent.OnOpenFullView, arg_15_0._onOpenView, arg_15_0)

	if arg_15_1 == ViewName.StoryView or arg_15_1 == ViewName.StoryBackgroundView then
		TaskDispatcher.cancelTask(arg_15_0._viewFadeOut, arg_15_0)

		return
	end

	local var_15_0 = StoryController.instance._curStoryId

	if StoryModel.instance:isStoryFinished(var_15_0) then
		StoryController.instance:closeStoryView()
	end
end

function var_0_0.cancelViewFadeOut(arg_16_0)
	TaskDispatcher.cancelTask(arg_16_0._viewFadeOut, arg_16_0)
end

function var_0_0._viewFadeOut(arg_17_0)
	ViewMgr.instance:unregisterCallback(ViewEvent.OnOpenFullView, arg_17_0._onOpenView, arg_17_0)
	StoryController.instance:closeStoryView()
	TaskDispatcher.runDelay(arg_17_0._viewFadeOutFinished, arg_17_0, 0.1)
	StoryController.instance:dispatchEvent(StoryEvent.FrontItemFadeOut)
end

function var_0_0._viewFadeOutFinished(arg_18_0)
	gohelper.setActive(arg_18_0._imagefulltop.gameObject, false)

	if arg_18_0._outCallback then
		arg_18_0._outCallback(arg_18_0._outCallbackObj)
	end
end

function var_0_0._playDarkUpFade(arg_19_0)
	gohelper.setActive(arg_19_0._goupfade, true)
	transformhelper.setLocalPosXY(arg_19_0._goupfade.transform, 0, 390)
	ZProj.TweenHelper.DOLocalMove(arg_19_0._goupfade.transform, 0, 2800, 0, 1.5, function()
		gohelper.setActive(arg_19_0._goupfade, false)
	end)
end

function var_0_0._playDarkFade(arg_21_0)
	StoryModel.instance.skipFade = false

	arg_21_0:setFullTopShow()

	arg_21_0._imagefulltop.color.a = 0
	arg_21_0._imagefulltop.color = Color.black

	ZProj.TweenHelper.DoFade(arg_21_0._imagefulltop, 0, 1, 1.5, arg_21_0._playDarkFadeFinished, arg_21_0, nil, EaseType.Linear)
end

function var_0_0._playDarkFadeFinished(arg_22_0)
	StoryController.instance:dispatchEvent(StoryEvent.RefreshView)
	StoryController.instance:dispatchEvent(StoryEvent.RefreshBackground)
	ZProj.TweenHelper.KillByObj(arg_22_0._imagefulltop)
	TaskDispatcher.runDelay(arg_22_0._playDarkFadeInFinished, arg_22_0, 0.5)
end

function var_0_0._playDarkFadeInFinished(arg_23_0)
	ZProj.TweenHelper.DoFade(arg_23_0._imagefulltop, 1, 0, 1.5, arg_23_0._hideImageFullTop, arg_23_0, nil, EaseType.Linear)
end

function var_0_0._hideImageFullTop(arg_24_0)
	arg_24_0._imagefulltop.color = Color.black

	gohelper.setActive(arg_24_0._imagefulltop.gameObject, false)
end

function var_0_0._playWhiteFade(arg_25_0)
	StoryModel.instance.skipFade = false

	arg_25_0:setFullTopShow()

	arg_25_0._imagefulltop.color.a = 0
	arg_25_0._imagefulltop.color = Color.white

	ZProj.TweenHelper.DoFade(arg_25_0._imagefulltop, 0, 1, 1.5, arg_25_0._playWhiteFadeFinished, arg_25_0, nil, EaseType.Linear)
end

function var_0_0._playWhiteFadeFinished(arg_26_0)
	StoryController.instance:dispatchEvent(StoryEvent.RefreshView)
	StoryController.instance:dispatchEvent(StoryEvent.RefreshBackground)
	ZProj.TweenHelper.KillByObj(arg_26_0._imagefulltop)
	TaskDispatcher.runDelay(arg_26_0._playDarkFadeInFinished, arg_26_0, 0.5)
end

function var_0_0._playWhiteFadeInFinished(arg_27_0)
	ZProj.TweenHelper.DoFade(arg_27_0._imagefulltop, 1, 0, 1.5, arg_27_0._hideImageFullTop, arg_27_0, nil, EaseType.Linear)
end

function var_0_0.playIrregularShakeText(arg_28_0, arg_28_1, arg_28_2, arg_28_3)
	arg_28_0._stepCo = arg_28_1

	gohelper.setActive(arg_28_0._goirregularshake, true)

	arg_28_0._shakefinishCallback = arg_28_2
	arg_28_0._shakefinishCallbackObj = arg_28_3

	if not arg_28_0._goshake then
		local var_28_0 = ViewMgr.instance:getContainer(ViewName.StoryFrontView)

		arg_28_0._goshake = var_28_0:getResInst(var_28_0:getSetting().otherRes[1], arg_28_0._goirregularshake)
	end

	local var_28_1 = gohelper.findChildText(arg_28_0._goshake, "tex_ani/#tex")

	arg_28_0._shakeAni = arg_28_0._goshake:GetComponent(typeof(UnityEngine.Animator))
	var_28_1.text = arg_28_0._stepCo.conversation.diaTexts[GameLanguageMgr.instance:getLanguageTypeStoryIndex()]

	local var_28_2 = arg_28_0._stepCo.conversation.showTimes[GameLanguageMgr.instance:getVoiceTypeStoryIndex()] - 0.17

	if var_28_2 < 0.1 then
		if arg_28_0._shakefinishCallback then
			arg_28_0._shakefinishCallback(arg_28_0._shakefinishCallbackObj)

			arg_28_0._shakefinishCallback = nil
			arg_28_0._shakefinishCallbackObj = nil
		end

		return
	end

	TaskDispatcher.runDelay(arg_28_0._onShakeEnd, arg_28_0, var_28_2)
end

function var_0_0._onShakeEnd(arg_29_0)
	arg_29_0._shakeAni:Play("close", 0, 0)
	TaskDispatcher.runDelay(function()
		gohelper.setActive(arg_29_0._goirregularshake, false)

		if arg_29_0._shakefinishCallback then
			arg_29_0._shakefinishCallback(arg_29_0._shakefinishCallbackObj)

			arg_29_0._shakefinishCallback = nil
			arg_29_0._shakefinishCallbackObj = nil
		end
	end, nil, 0.17)
end

function var_0_0.wordByWord(arg_31_0, arg_31_1, arg_31_2, arg_31_3)
	arg_31_0._stepCo = arg_31_1

	gohelper.setActive(arg_31_0._txtscreentext.gameObject, true)

	arg_31_0._finishCallback = arg_31_2
	arg_31_0._finishCallbackObj = arg_31_3

	ZProj.UGUIHelper.SetColorAlpha(arg_31_0._txtscreentext, 1)

	if arg_31_0._stepCo.conversation.showTimes[GameLanguageMgr.instance:getVoiceTypeStoryIndex()] < 0.1 then
		if arg_31_0._finishCallback then
			arg_31_0._finishCallback(arg_31_0._finishCallbackObj)

			arg_31_0._finishCallback = nil
			arg_31_0._finishCallbackObj = nil
		end

		return
	end

	arg_31_0:_startWordByWord()
end

function var_0_0._startWordByWord(arg_32_0)
	ZProj.TweenHelper.KillByObj(arg_32_0._txtscreentext)

	arg_32_0._txtscreentext.text = ""

	local var_32_0 = StoryTool.getTxtAlignment(arg_32_0._stepCo.conversation.diaTexts[GameLanguageMgr.instance:getLanguageTypeStoryIndex()])

	arg_32_0._txtscreentext.alignment = var_32_0

	local var_32_1 = StoryTool.getFilterAlignTxt(arg_32_0._stepCo.conversation.diaTexts[GameLanguageMgr.instance:getLanguageTypeStoryIndex()])

	ZProj.TweenHelper.DOText(arg_32_0._txtscreentext, var_32_1, arg_32_0._stepCo.conversation.showTimes[GameLanguageMgr.instance:getVoiceTypeStoryIndex()], function()
		if arg_32_0._finishCallback then
			arg_32_0._finishCallback(arg_32_0._finishCallbackObj)
		end
	end)
end

function var_0_0.lineShow(arg_34_0, arg_34_1, arg_34_2, arg_34_3, arg_34_4)
	arg_34_0._stepCo = arg_34_2

	gohelper.setActive(arg_34_0._txtscreentext.gameObject, true)

	arg_34_0._finishCallback = arg_34_3
	arg_34_0._finishCallbackObj = arg_34_4

	ZProj.UGUIHelper.SetColorAlpha(arg_34_0._txtscreentext, 1)

	if arg_34_0._stepCo.conversation.showTimes[GameLanguageMgr.instance:getVoiceTypeStoryIndex()] < 0.1 then
		if arg_34_0._finishCallback then
			arg_34_0._finishCallback(arg_34_0._finishCallbackObj)
		end

		return
	end

	arg_34_0:_startShowLine(arg_34_1)
end

function var_0_0._startShowLine(arg_35_0, arg_35_1)
	if not arg_35_0._copyText then
		local var_35_0 = gohelper.cloneInPlace(arg_35_0._txtscreentext.gameObject, "copytext")

		arg_35_0._copyCanvasGroup = gohelper.onceAddComponent(var_35_0, typeof(UnityEngine.CanvasGroup))
		arg_35_0._copyText = var_35_0:GetComponent(gohelper.Type_Text)
	end

	arg_35_0._copyText.alignment = StoryTool.getTxtAlignment(arg_35_0._diatxt)
	arg_35_0._diatxt = StoryTool.getFilterAlignTxt(arg_35_0._diatxt)
	arg_35_0._diatxt = StoryModel.instance:getStoryTxtByVoiceType(arg_35_0._diatxt, arg_35_0._stepCo.conversation.audio or 0)

	gohelper.setActive(arg_35_0._copyText.gameObject, true)

	local var_35_1 = arg_35_0:_getLineWord(arg_35_1)
	local var_35_2 = #var_35_1 == 0 and arg_35_0._stepCo.conversation.showTimes[GameLanguageMgr.instance:getVoiceTypeStoryIndex()] or arg_35_0._stepCo.conversation.showTimes[GameLanguageMgr.instance:getVoiceTypeStoryIndex()] / #var_35_1
	local var_35_3 = 1

	local function var_35_4(arg_36_0)
		local var_36_0 = " "
		local var_36_1 = ""
		local var_36_2 = #string.split(var_36_1, "\n")

		if var_36_2 > 1 then
			for iter_36_0 = 2, var_36_2 do
				var_36_0 = string.format("%s\n%s", var_36_0, " ")
			end
		end

		if #var_35_1 > 1 then
			for iter_36_1 = 1, #var_35_1 do
				local var_36_3 = #string.split(var_35_1[iter_36_1], "\n") or 1

				if iter_36_1 < arg_36_0 then
					var_36_1 = string.format("%s\n%s", var_36_1, var_35_1[iter_36_1])

					for iter_36_2 = 1, var_36_3 do
						local var_36_4, var_36_5, var_36_6, var_36_7 = string.match(string.split(var_35_1[iter_36_1], "\n")[iter_36_2], "(.*)<size=(%d+)>(.*)</size>(%s*)")

						if var_36_5 and tonumber(var_36_5) then
							var_36_0 = string.format("%s\n%s", var_36_0, string.format("<size=%s> </size>", var_36_5))
						else
							var_36_0 = string.format("%s\n%s", var_36_0, " ")
						end
					end
				elseif iter_36_1 == arg_36_0 then
					for iter_36_3 = 1, var_36_3 do
						var_36_1 = string.format("%s\n%s", var_36_1, " ")
					end

					var_36_0 = string.format("%s\n%s", var_36_0, var_35_1[iter_36_1])
				else
					for iter_36_4 = 1, var_36_3 do
						var_36_1 = string.format("%s\n%s", var_36_1, " ")
						var_36_0 = string.format("%s\n%s", var_36_0, " ")
					end
				end
			end
		end

		arg_35_0._txtscreentext.text = var_36_1
		arg_35_0._copyText.text = var_36_0

		ZProj.TweenHelper.KillByObj(arg_35_0._txtscreentext)
		ZProj.TweenHelper.KillByObj(arg_35_0._copyText)
		ZProj.UGUIHelper.SetColorAlpha(arg_35_0._txtscreentext, 1)
		ZProj.TweenHelper.DOFadeCanvasGroup(arg_35_0._copyText.gameObject, 0, 1, var_35_2, function()
			if arg_36_0 - #var_35_1 >= 0 then
				arg_35_0:_lineWordShowFinished()
			else
				arg_36_0 = arg_36_0 + 1

				var_35_4(arg_36_0)
			end
		end, nil, nil, EaseType.Linear)
	end

	var_35_4(var_35_3)
end

function var_0_0._getLineWord(arg_38_0, arg_38_1)
	local var_38_0 = string.split(arg_38_0._diatxt, "\n")
	local var_38_1 = {}
	local var_38_2 = math.floor(#var_38_0 / arg_38_1)

	for iter_38_0 = 0, var_38_2 - 1 do
		local var_38_3 = var_38_0[iter_38_0 * arg_38_1 + 1]

		for iter_38_1 = 2, arg_38_1 do
			var_38_3 = string.format("%s\n%s", var_38_3, var_38_0[iter_38_0 * arg_38_1 + iter_38_1])
		end

		table.insert(var_38_1, var_38_3)
	end

	if var_38_2 * arg_38_1 < #var_38_0 then
		local var_38_4 = var_38_0[var_38_2 * arg_38_1 + 1]

		if #var_38_0 - var_38_2 * arg_38_1 > 1 then
			for iter_38_2 = 2, #var_38_0 - var_38_2 * arg_38_1 do
				var_38_4 = string.format("%s\n%s", var_38_4, var_38_0[arg_38_1 * var_38_2 + iter_38_2])
			end
		end

		table.insert(var_38_1, var_38_4)
	end

	return var_38_1
end

function var_0_0._lineWordShowFinished(arg_39_0)
	arg_39_0._txtscreentext.text = "\n" .. arg_39_0._diatxt

	gohelper.setActive(arg_39_0._copyText.gameObject, false)

	if arg_39_0._finishCallback then
		arg_39_0._finishCallback(arg_39_0._finishCallbackObj)
	end
end

function var_0_0.playFullTextFadeOut(arg_40_0)
	ZProj.TweenHelper.KillByObj(arg_40_0._txtscreentext)
	ZProj.TweenHelper.DoFade(arg_40_0._txtscreentext, 1, 0, 0.5, arg_40_0._hideScreenTxt, arg_40_0, nil, EaseType.Linear)
end

function var_0_0._hideScreenTxt(arg_41_0)
	ZProj.TweenHelper.KillByObj(arg_41_0._txtscreentext)
	gohelper.setActive(arg_41_0._txtscreentext.gameObject, false)
end

function var_0_0.playTextFadeIn(arg_42_0, arg_42_1, arg_42_2, arg_42_3)
	arg_42_0._stepCo = arg_42_1

	gohelper.setActive(arg_42_0._txtscreentext.gameObject, true)

	arg_42_0._finishCallback = arg_42_2
	arg_42_0._finishCallbackObj = arg_42_3

	ZProj.TweenHelper.KillByObj(arg_42_0._txtscreentext)

	if arg_42_0._stepCo.conversation.showTimes[GameLanguageMgr.instance:getVoiceTypeStoryIndex()] < 0.1 then
		ZProj.UGUIHelper.SetColorAlpha(arg_42_0._txtscreentext, 1)
		arg_42_0:_fadeFinished()
	else
		local var_42_0 = arg_42_0._txtscreentext.text

		if string.match(var_42_0, "<color=#%x+>") then
			local var_42_1 = string.gsub(var_42_0, "<color=#(%x%x%x%x%x%x)(%x-)>", "<color=#%100>")

			arg_42_0._txtscreentext.text = var_42_1
		end

		arg_42_0._floatTweenId = ZProj.TweenHelper.DOTweenFloat(0, 1, arg_42_0._stepCo.conversation.showTimes[GameLanguageMgr.instance:getVoiceTypeStoryIndex()], arg_42_0._fadeUpdate, arg_42_0._fadeFinished, arg_42_0, nil, EaseType.Linear)
	end
end

function var_0_0._fadeUpdate(arg_43_0, arg_43_1)
	local var_43_0 = arg_43_0._txtscreentext.text
	local var_43_1 = math.ceil(255 * arg_43_1)
	local var_43_2 = string.format("%02x", var_43_1)

	if string.match(var_43_0, "<color=#%x+>") then
		local var_43_3 = string.gsub(var_43_0, "<color=#(%x%x%x%x%x%x)(%x+)>", "<color=#%1" .. var_43_2 .. ">")

		arg_43_0._txtscreentext.text = var_43_3

		return
	end

	ZProj.UGUIHelper.SetColorAlpha(arg_43_0._txtscreentext, arg_43_1)
end

function var_0_0._fadeFinished(arg_44_0)
	if arg_44_0._finishCallback then
		arg_44_0._finishCallback(arg_44_0._finishCallbackObj)
	end
end

function var_0_0.destroy(arg_45_0)
	arg_45_0:_removeEvent()
	TaskDispatcher.cancelTask(arg_45_0._viewFadeOutFinished, arg_45_0)
	TaskDispatcher.cancelTask(arg_45_0._startStoryViewIn, arg_45_0)
	TaskDispatcher.cancelTask(arg_45_0._viewFadeOut, arg_45_0)
	TaskDispatcher.cancelTask(arg_45_0._onShakeEnd, arg_45_0)

	if arg_45_0._floatTweenId then
		ZProj.TweenHelper.KillById(arg_45_0._floatTweenId)

		arg_45_0._floatTweenId = nil
	end

	ZProj.TweenHelper.KillByObj(arg_45_0._imagefulltop)
	ZProj.TweenHelper.KillByObj(arg_45_0._goupfade.transform)
	ZProj.TweenHelper.KillByObj(arg_45_0._txtscreentext)
end

return var_0_0
