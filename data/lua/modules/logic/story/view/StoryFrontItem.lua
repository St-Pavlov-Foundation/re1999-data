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
end

function var_0_0._getFadeTime(arg_5_0)
	return not StoryModel.instance.skipFade and 1 or 0
end

function var_0_0.setFullTopShow(arg_6_0)
	gohelper.setActive(arg_6_0._imagefulltop.gameObject, not StoryModel.instance.skipFade and true or false)
end

function var_0_0.playStoryViewIn(arg_7_0)
	local var_7_0 = StoryModel.instance:isTypeSkip(StoryEnum.SkipType.InDarkFade, StoryController.instance._curStoryId)

	StoryModel.instance.skipFade = var_7_0

	ZProj.TweenHelper.KillByObj(arg_7_0._imagefulltop)

	arg_7_0._imagefulltop.color.a = 1

	arg_7_0:setFullTopShow()

	if not var_7_0 then
		TaskDispatcher.runDelay(arg_7_0._startStoryViewIn, arg_7_0, 0.5)
	end
end

function var_0_0._startStoryViewIn(arg_8_0)
	local var_8_0 = arg_8_0._imagefulltop.color.a

	ZProj.TweenHelper.DoFade(arg_8_0._imagefulltop, var_8_0, 0, arg_8_0:_getFadeTime(), function()
		gohelper.setActive(arg_8_0._imagefulltop.gameObject, false)
	end, nil, nil, EaseType.Linear)
end

function var_0_0.playStoryViewOut(arg_10_0, arg_10_1, arg_10_2, arg_10_3)
	local var_10_0 = StoryModel.instance:isTypeSkip(StoryEnum.SkipType.OutDarkFade, StoryController.instance._curStoryId)

	StoryModel.instance.skipFade = var_10_0

	arg_10_0:setFullTopShow()

	arg_10_0._imagefulltop.color.a = 0
	arg_10_0._finishCallback = nil
	arg_10_0._finishCallbackObj = nil

	ZProj.TweenHelper.KillByObj(arg_10_0._txtscreentext)
	ZProj.TweenHelper.KillByObj(arg_10_0._copyText)

	if arg_10_0._copyText then
		gohelper.destroy(arg_10_0._copyText.gameObject)

		arg_10_0._copyText = nil
	end

	arg_10_0._outCallback = arg_10_1
	arg_10_0._outCallbackObj = arg_10_2

	ZProj.TweenHelper.KillByObj(arg_10_0._imagefulltop)
	ZProj.TweenHelper.DoFade(arg_10_0._imagefulltop, 0, 1, arg_10_0:_getFadeTime(), arg_10_0.enterStoryFinish, arg_10_0, nil, EaseType.Linear)
end

function var_0_0.enterStoryFinish(arg_11_0)
	gohelper.setActive(arg_11_0._txtscreentext.gameObject, false)
	StoryController.instance:dispatchEvent(StoryEvent.Hide)
	ViewMgr.instance:registerCallback(ViewEvent.OnOpenFullView, arg_11_0._onOpenView, arg_11_0)
	TaskDispatcher.runDelay(arg_11_0._viewFadeOut, arg_11_0, 0.5)
	StoryController.instance:finished()
end

function var_0_0._onOpenView(arg_12_0, arg_12_1)
	ViewMgr.instance:unregisterCallback(ViewEvent.OnOpenFullView, arg_12_0._onOpenView, arg_12_0)

	if arg_12_1 == ViewName.StoryView or arg_12_1 == ViewName.StoryBackgroundView then
		TaskDispatcher.cancelTask(arg_12_0._viewFadeOut, arg_12_0)

		return
	end

	local var_12_0 = StoryController.instance._curStoryId

	if StoryModel.instance:isStoryFinished(var_12_0) then
		StoryController.instance:closeStoryView()
	end
end

function var_0_0.cancelViewFadeOut(arg_13_0)
	TaskDispatcher.cancelTask(arg_13_0._viewFadeOut, arg_13_0)
end

function var_0_0._viewFadeOut(arg_14_0)
	ViewMgr.instance:unregisterCallback(ViewEvent.OnOpenFullView, arg_14_0._onOpenView, arg_14_0)
	StoryController.instance:closeStoryView()
	TaskDispatcher.runDelay(arg_14_0._viewFadeOutFinished, arg_14_0, 0.1)
	StoryController.instance:dispatchEvent(StoryEvent.FrontItemFadeOut)
end

function var_0_0._viewFadeOutFinished(arg_15_0)
	gohelper.setActive(arg_15_0._imagefulltop.gameObject, false)

	if arg_15_0._outCallback then
		arg_15_0._outCallback(arg_15_0._outCallbackObj)
	end
end

function var_0_0._playDarkUpFade(arg_16_0)
	gohelper.setActive(arg_16_0._goupfade, true)
	transformhelper.setLocalPosXY(arg_16_0._goupfade.transform, 0, 390)
	ZProj.TweenHelper.DOLocalMove(arg_16_0._goupfade.transform, 0, 2800, 0, 1.5, function()
		gohelper.setActive(arg_16_0._goupfade, false)
	end)
end

function var_0_0._playDarkFade(arg_18_0)
	StoryModel.instance.skipFade = false

	arg_18_0:setFullTopShow()

	arg_18_0._imagefulltop.color.a = 0
	arg_18_0._imagefulltop.color = Color.black

	ZProj.TweenHelper.DoFade(arg_18_0._imagefulltop, 0, 1, 1.5, arg_18_0._playDarkFadeFinished, arg_18_0, nil, EaseType.Linear)
end

function var_0_0._playDarkFadeFinished(arg_19_0)
	StoryController.instance:dispatchEvent(StoryEvent.RefreshView)
	StoryController.instance:dispatchEvent(StoryEvent.RefreshBackground)
	ZProj.TweenHelper.KillByObj(arg_19_0._imagefulltop)
	TaskDispatcher.runDelay(arg_19_0._playDarkFadeInFinished, arg_19_0, 0.5)
end

function var_0_0._playDarkFadeInFinished(arg_20_0)
	ZProj.TweenHelper.DoFade(arg_20_0._imagefulltop, 1, 0, 1.5, arg_20_0._hideImageFullTop, arg_20_0, nil, EaseType.Linear)
end

function var_0_0._hideImageFullTop(arg_21_0)
	arg_21_0._imagefulltop.color = Color.black

	gohelper.setActive(arg_21_0._imagefulltop.gameObject, false)
end

function var_0_0._playWhiteFade(arg_22_0)
	StoryModel.instance.skipFade = false

	arg_22_0:setFullTopShow()

	arg_22_0._imagefulltop.color.a = 0
	arg_22_0._imagefulltop.color = Color.white

	ZProj.TweenHelper.DoFade(arg_22_0._imagefulltop, 0, 1, 1.5, arg_22_0._playWhiteFadeFinished, arg_22_0, nil, EaseType.Linear)
end

function var_0_0._playWhiteFadeFinished(arg_23_0)
	StoryController.instance:dispatchEvent(StoryEvent.RefreshView)
	StoryController.instance:dispatchEvent(StoryEvent.RefreshBackground)
	ZProj.TweenHelper.KillByObj(arg_23_0._imagefulltop)
	TaskDispatcher.runDelay(arg_23_0._playDarkFadeInFinished, arg_23_0, 0.5)
end

function var_0_0._playWhiteFadeInFinished(arg_24_0)
	ZProj.TweenHelper.DoFade(arg_24_0._imagefulltop, 1, 0, 1.5, arg_24_0._hideImageFullTop, arg_24_0, nil, EaseType.Linear)
end

function var_0_0.playIrregularShakeText(arg_25_0, arg_25_1, arg_25_2, arg_25_3)
	arg_25_0._stepCo = arg_25_1

	gohelper.setActive(arg_25_0._goirregularshake, true)

	arg_25_0._shakefinishCallback = arg_25_2
	arg_25_0._shakefinishCallbackObj = arg_25_3

	if not arg_25_0._goshake then
		local var_25_0 = ViewMgr.instance:getContainer(ViewName.StoryFrontView)

		arg_25_0._goshake = var_25_0:getResInst(var_25_0:getSetting().otherRes[1], arg_25_0._goirregularshake)
	end

	local var_25_1 = gohelper.findChildText(arg_25_0._goshake, "tex_ani/#tex")

	arg_25_0._shakeAni = arg_25_0._goshake:GetComponent(typeof(UnityEngine.Animator))
	var_25_1.text = arg_25_0._stepCo.conversation.diaTexts[GameLanguageMgr.instance:getLanguageTypeStoryIndex()]

	local var_25_2 = arg_25_0._stepCo.conversation.showTimes[GameLanguageMgr.instance:getVoiceTypeStoryIndex()] - 0.17

	if var_25_2 < 0.1 then
		if arg_25_0._shakefinishCallback then
			arg_25_0._shakefinishCallback(arg_25_0._shakefinishCallbackObj)

			arg_25_0._shakefinishCallback = nil
			arg_25_0._shakefinishCallbackObj = nil
		end

		return
	end

	TaskDispatcher.runDelay(arg_25_0._onShakeEnd, arg_25_0, var_25_2)
end

function var_0_0._onShakeEnd(arg_26_0)
	arg_26_0._shakeAni:Play("close", 0, 0)
	TaskDispatcher.runDelay(function()
		gohelper.setActive(arg_26_0._goirregularshake, false)

		if arg_26_0._shakefinishCallback then
			arg_26_0._shakefinishCallback(arg_26_0._shakefinishCallbackObj)

			arg_26_0._shakefinishCallback = nil
			arg_26_0._shakefinishCallbackObj = nil
		end
	end, nil, 0.17)
end

function var_0_0.wordByWord(arg_28_0, arg_28_1, arg_28_2, arg_28_3)
	arg_28_0._stepCo = arg_28_1

	gohelper.setActive(arg_28_0._txtscreentext.gameObject, true)

	arg_28_0._finishCallback = arg_28_2
	arg_28_0._finishCallbackObj = arg_28_3

	ZProj.UGUIHelper.SetColorAlpha(arg_28_0._txtscreentext, 1)

	if arg_28_0._stepCo.conversation.showTimes[GameLanguageMgr.instance:getVoiceTypeStoryIndex()] < 0.1 then
		if arg_28_0._finishCallback then
			arg_28_0._finishCallback(arg_28_0._finishCallbackObj)

			arg_28_0._finishCallback = nil
			arg_28_0._finishCallbackObj = nil
		end

		return
	end

	arg_28_0:_startWordByWord()
end

function var_0_0._startWordByWord(arg_29_0)
	ZProj.TweenHelper.KillByObj(arg_29_0._txtscreentext)

	arg_29_0._txtscreentext.text = ""

	local var_29_0 = StoryTool.getTxtAlignment(arg_29_0._stepCo.conversation.diaTexts[GameLanguageMgr.instance:getLanguageTypeStoryIndex()])

	arg_29_0._txtscreentext.alignment = var_29_0

	local var_29_1 = StoryTool.getFilterAlignTxt(arg_29_0._stepCo.conversation.diaTexts[GameLanguageMgr.instance:getLanguageTypeStoryIndex()])

	ZProj.TweenHelper.DOText(arg_29_0._txtscreentext, var_29_1, arg_29_0._stepCo.conversation.showTimes[GameLanguageMgr.instance:getVoiceTypeStoryIndex()], function()
		if arg_29_0._finishCallback then
			arg_29_0._finishCallback(arg_29_0._finishCallbackObj)
		end
	end)
end

function var_0_0.lineShow(arg_31_0, arg_31_1, arg_31_2, arg_31_3, arg_31_4)
	arg_31_0._stepCo = arg_31_2

	gohelper.setActive(arg_31_0._txtscreentext.gameObject, true)

	arg_31_0._finishCallback = arg_31_3
	arg_31_0._finishCallbackObj = arg_31_4

	ZProj.UGUIHelper.SetColorAlpha(arg_31_0._txtscreentext, 1)

	if arg_31_0._stepCo.conversation.showTimes[GameLanguageMgr.instance:getVoiceTypeStoryIndex()] < 0.1 then
		if arg_31_0._finishCallback then
			arg_31_0._finishCallback(arg_31_0._finishCallbackObj)
		end

		return
	end

	arg_31_0:_startShowLine(arg_31_1)
end

function var_0_0._startShowLine(arg_32_0, arg_32_1)
	if not arg_32_0._copyText then
		local var_32_0 = gohelper.cloneInPlace(arg_32_0._txtscreentext.gameObject, "copytext")

		arg_32_0._copyCanvasGroup = gohelper.onceAddComponent(var_32_0, typeof(UnityEngine.CanvasGroup))
		arg_32_0._copyText = var_32_0:GetComponent(gohelper.Type_Text)
	end

	arg_32_0._copyText.alignment = StoryTool.getTxtAlignment(arg_32_0._diatxt)
	arg_32_0._diatxt = StoryTool.getFilterAlignTxt(arg_32_0._diatxt)
	arg_32_0._diatxt = StoryModel.instance:getStoryTxtByVoiceType(arg_32_0._diatxt, arg_32_0._stepCo.conversation.audio or 0)

	gohelper.setActive(arg_32_0._copyText.gameObject, true)

	local var_32_1 = arg_32_0:_getLineWord(arg_32_1)
	local var_32_2 = #var_32_1 == 0 and arg_32_0._stepCo.conversation.showTimes[GameLanguageMgr.instance:getVoiceTypeStoryIndex()] or arg_32_0._stepCo.conversation.showTimes[GameLanguageMgr.instance:getVoiceTypeStoryIndex()] / #var_32_1
	local var_32_3 = 1

	local function var_32_4(arg_33_0)
		local var_33_0 = " "
		local var_33_1 = ""
		local var_33_2 = #string.split(var_33_1, "\n")

		if var_33_2 > 1 then
			for iter_33_0 = 2, var_33_2 do
				var_33_0 = string.format("%s\n%s", var_33_0, " ")
			end
		end

		if #var_32_1 > 1 then
			for iter_33_1 = 1, #var_32_1 do
				local var_33_3 = #string.split(var_32_1[iter_33_1], "\n") or 1

				if iter_33_1 < arg_33_0 then
					var_33_1 = string.format("%s\n%s", var_33_1, var_32_1[iter_33_1])

					for iter_33_2 = 1, var_33_3 do
						local var_33_4, var_33_5, var_33_6, var_33_7 = string.match(string.split(var_32_1[iter_33_1], "\n")[iter_33_2], "(.*)<size=(%d+)>(.*)</size>(%s*)")

						if var_33_5 and tonumber(var_33_5) then
							var_33_0 = string.format("%s\n%s", var_33_0, string.format("<size=%s> </size>", var_33_5))
						else
							var_33_0 = string.format("%s\n%s", var_33_0, " ")
						end
					end
				elseif iter_33_1 == arg_33_0 then
					for iter_33_3 = 1, var_33_3 do
						var_33_1 = string.format("%s\n%s", var_33_1, " ")
					end

					var_33_0 = string.format("%s\n%s", var_33_0, var_32_1[iter_33_1])
				else
					for iter_33_4 = 1, var_33_3 do
						var_33_1 = string.format("%s\n%s", var_33_1, " ")
						var_33_0 = string.format("%s\n%s", var_33_0, " ")
					end
				end
			end
		end

		arg_32_0._txtscreentext.text = var_33_1
		arg_32_0._copyText.text = var_33_0

		ZProj.TweenHelper.KillByObj(arg_32_0._txtscreentext)
		ZProj.TweenHelper.KillByObj(arg_32_0._copyText)
		ZProj.UGUIHelper.SetColorAlpha(arg_32_0._txtscreentext, 1)
		ZProj.TweenHelper.DOFadeCanvasGroup(arg_32_0._copyText.gameObject, 0, 1, var_32_2, function()
			if arg_33_0 - #var_32_1 >= 0 then
				arg_32_0:_lineWordShowFinished()
			else
				arg_33_0 = arg_33_0 + 1

				var_32_4(arg_33_0)
			end
		end, nil, nil, EaseType.Linear)
	end

	var_32_4(var_32_3)
end

function var_0_0._getLineWord(arg_35_0, arg_35_1)
	local var_35_0 = string.split(arg_35_0._diatxt, "\n")
	local var_35_1 = {}
	local var_35_2 = math.floor(#var_35_0 / arg_35_1)

	for iter_35_0 = 0, var_35_2 - 1 do
		local var_35_3 = var_35_0[iter_35_0 * arg_35_1 + 1]

		for iter_35_1 = 2, arg_35_1 do
			var_35_3 = string.format("%s\n%s", var_35_3, var_35_0[iter_35_0 * arg_35_1 + iter_35_1])
		end

		table.insert(var_35_1, var_35_3)
	end

	if var_35_2 * arg_35_1 < #var_35_0 then
		local var_35_4 = var_35_0[var_35_2 * arg_35_1 + 1]

		if #var_35_0 - var_35_2 * arg_35_1 > 1 then
			for iter_35_2 = 2, #var_35_0 - var_35_2 * arg_35_1 do
				var_35_4 = string.format("%s\n%s", var_35_4, var_35_0[arg_35_1 * var_35_2 + iter_35_2])
			end
		end

		table.insert(var_35_1, var_35_4)
	end

	return var_35_1
end

function var_0_0._lineWordShowFinished(arg_36_0)
	arg_36_0._txtscreentext.text = "\n" .. arg_36_0._diatxt

	gohelper.setActive(arg_36_0._copyText.gameObject, false)

	if arg_36_0._finishCallback then
		arg_36_0._finishCallback(arg_36_0._finishCallbackObj)
	end
end

function var_0_0.playFullTextFadeOut(arg_37_0)
	ZProj.TweenHelper.KillByObj(arg_37_0._txtscreentext)
	ZProj.TweenHelper.DoFade(arg_37_0._txtscreentext, 1, 0, 0.5, arg_37_0._hideScreenTxt, arg_37_0, nil, EaseType.Linear)
end

function var_0_0._hideScreenTxt(arg_38_0)
	ZProj.TweenHelper.KillByObj(arg_38_0._txtscreentext)
	gohelper.setActive(arg_38_0._txtscreentext.gameObject, false)
end

function var_0_0.playTextFadeIn(arg_39_0, arg_39_1, arg_39_2, arg_39_3)
	arg_39_0._stepCo = arg_39_1

	gohelper.setActive(arg_39_0._txtscreentext.gameObject, true)

	arg_39_0._finishCallback = arg_39_2
	arg_39_0._finishCallbackObj = arg_39_3

	ZProj.TweenHelper.KillByObj(arg_39_0._txtscreentext)

	if arg_39_0._stepCo.conversation.showTimes[GameLanguageMgr.instance:getVoiceTypeStoryIndex()] < 0.1 then
		ZProj.UGUIHelper.SetColorAlpha(arg_39_0._txtscreentext, 1)
		arg_39_0:_fadeFinished()
	else
		local var_39_0 = arg_39_0._txtscreentext.text

		if string.match(var_39_0, "<color=#%x+>") then
			local var_39_1 = string.gsub(var_39_0, "<color=#(%x%x%x%x%x%x)(%x-)>", "<color=#%100>")

			arg_39_0._txtscreentext.text = var_39_1
		end

		arg_39_0._floatTweenId = ZProj.TweenHelper.DOTweenFloat(0, 1, arg_39_0._stepCo.conversation.showTimes[GameLanguageMgr.instance:getVoiceTypeStoryIndex()], arg_39_0._fadeUpdate, arg_39_0._fadeFinished, arg_39_0, nil, EaseType.Linear)
	end
end

function var_0_0._fadeUpdate(arg_40_0, arg_40_1)
	local var_40_0 = arg_40_0._txtscreentext.text
	local var_40_1 = math.ceil(255 * arg_40_1)
	local var_40_2 = string.format("%02x", var_40_1)

	if string.match(var_40_0, "<color=#%x+>") then
		local var_40_3 = string.gsub(var_40_0, "<color=#(%x%x%x%x%x%x)(%x+)>", "<color=#%1" .. var_40_2 .. ">")

		arg_40_0._txtscreentext.text = var_40_3

		return
	end

	ZProj.UGUIHelper.SetColorAlpha(arg_40_0._txtscreentext, arg_40_1)
end

function var_0_0._fadeFinished(arg_41_0)
	if arg_41_0._finishCallback then
		arg_41_0._finishCallback(arg_41_0._finishCallbackObj)
	end
end

function var_0_0.destroy(arg_42_0)
	arg_42_0:_removeEvent()
	TaskDispatcher.cancelTask(arg_42_0._viewFadeOutFinished, arg_42_0)
	TaskDispatcher.cancelTask(arg_42_0._startStoryViewIn, arg_42_0)
	TaskDispatcher.cancelTask(arg_42_0._viewFadeOut, arg_42_0)
	TaskDispatcher.cancelTask(arg_42_0._onShakeEnd, arg_42_0)

	if arg_42_0._floatTweenId then
		ZProj.TweenHelper.KillById(arg_42_0._floatTweenId)

		arg_42_0._floatTweenId = nil
	end

	ZProj.TweenHelper.KillByObj(arg_42_0._imagefulltop)
	ZProj.TweenHelper.KillByObj(arg_42_0._goupfade.transform)
	ZProj.TweenHelper.KillByObj(arg_42_0._txtscreentext)
end

return var_0_0
