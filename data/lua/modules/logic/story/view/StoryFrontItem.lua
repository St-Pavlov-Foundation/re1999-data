module("modules.logic.story.view.StoryFrontItem", package.seeall)

slot0 = class("StoryFrontItem")

function slot0.init(slot0, slot1)
	slot0._frontGO = slot1
	slot0._txtscreentext = gohelper.findChildText(slot1, "txt_screentext")
	slot0._imagefulltop = gohelper.findChildImage(slot1, "image_fulltop")
	slot0._goupfade = gohelper.findChild(slot1, "go_upfade")
	slot0._goirregularshake = gohelper.findChild(slot1.transform.parent.gameObject, "#go_irregularshake")

	slot0:setFullTopShow()
	gohelper.setActive(slot0._txtscreentext.gameObject, false)

	slot0._imagefulltop.color.a = 1
	slot0._imagefulltop.color = Color.black

	slot0:_addEvent()
end

function slot0._addEvent(slot0)
	StoryController.instance:registerCallback(StoryEvent.PlayDarkFadeUp, slot0._playDarkUpFade, slot0)
	StoryController.instance:registerCallback(StoryEvent.PlayDarkFade, slot0._playDarkFade, slot0)
	StoryController.instance:registerCallback(StoryEvent.PlayWhiteFade, slot0._playWhiteFade, slot0)
end

function slot0._removeEvent(slot0)
	StoryController.instance:unregisterCallback(StoryEvent.PlayDarkFadeUp, slot0._playDarkUpFade, slot0)
	StoryController.instance:unregisterCallback(StoryEvent.PlayDarkFade, slot0._playDarkFade, slot0)
	StoryController.instance:unregisterCallback(StoryEvent.PlayWhiteFade, slot0._playWhiteFade, slot0)
end

function slot0.showFullScreenText(slot0, slot1, slot2)
	if not slot1 then
		slot0._finishCallback = nil
		slot0._finishCallbackObj = nil

		ZProj.TweenHelper.KillByObj(slot0._txtscreentext)
		ZProj.TweenHelper.KillByObj(slot0._copyText)

		if slot0._copyText then
			gohelper.destroy(slot0._copyText.gameObject)

			slot0._copyText = nil
		end
	end

	gohelper.setActive(slot0._txtscreentext.gameObject, slot1)

	slot0._diatxt = string.gsub(slot2, "<notShowInLog>", "")
	slot0._diatxt = StoryModel.instance:getStoryTxtByVoiceType(slot0._diatxt, StoryStepModel.instance:getStepListById(StoryController.instance._curStepId).conversation.audio or 0)
	slot0._txtscreentext.alignment = StoryTool.getTxtAlignment(slot0._diatxt)
	slot0._txtscreentext.text = StoryTool.getFilterAlignTxt(slot0._diatxt)
end

function slot0._getFadeTime(slot0)
	return not StoryModel.instance.skipFade and 1 or 0
end

function slot0.setFullTopShow(slot0)
	gohelper.setActive(slot0._imagefulltop.gameObject, not StoryModel.instance.skipFade and true or false)
end

function slot0.playStoryViewIn(slot0)
	slot1 = StoryModel.instance:isTypeSkip(StoryEnum.SkipType.InDarkFade, StoryController.instance._curStoryId)
	StoryModel.instance.skipFade = slot1

	ZProj.TweenHelper.KillByObj(slot0._imagefulltop)

	slot0._imagefulltop.color.a = 1

	slot0:setFullTopShow()

	if not slot1 then
		TaskDispatcher.runDelay(slot0._startStoryViewIn, slot0, 0.5)
	end
end

function slot0._startStoryViewIn(slot0)
	ZProj.TweenHelper.DoFade(slot0._imagefulltop, slot0._imagefulltop.color.a, 0, slot0:_getFadeTime(), function ()
		gohelper.setActive(uv0._imagefulltop.gameObject, false)
	end, nil, , EaseType.Linear)
end

function slot0.playStoryViewOut(slot0, slot1, slot2, slot3)
	StoryModel.instance.skipFade = StoryModel.instance:isTypeSkip(StoryEnum.SkipType.OutDarkFade, StoryController.instance._curStoryId)

	slot0:setFullTopShow()

	slot0._imagefulltop.color.a = 0
	slot0._finishCallback = nil
	slot0._finishCallbackObj = nil

	ZProj.TweenHelper.KillByObj(slot0._txtscreentext)
	ZProj.TweenHelper.KillByObj(slot0._copyText)

	if slot0._copyText then
		gohelper.destroy(slot0._copyText.gameObject)

		slot0._copyText = nil
	end

	slot0._outCallback = slot1
	slot0._outCallbackObj = slot2

	ZProj.TweenHelper.KillByObj(slot0._imagefulltop)
	ZProj.TweenHelper.DoFade(slot0._imagefulltop, 0, 1, slot0:_getFadeTime(), slot0.enterStoryFinish, slot0, nil, EaseType.Linear)
end

function slot0.enterStoryFinish(slot0)
	gohelper.setActive(slot0._txtscreentext.gameObject, false)
	StoryController.instance:dispatchEvent(StoryEvent.Hide)
	ViewMgr.instance:registerCallback(ViewEvent.OnOpenFullView, slot0._onOpenView, slot0)
	TaskDispatcher.runDelay(slot0._viewFadeOut, slot0, 0.5)
	StoryController.instance:finished()
end

function slot0._onOpenView(slot0, slot1)
	ViewMgr.instance:unregisterCallback(ViewEvent.OnOpenFullView, slot0._onOpenView, slot0)

	if slot1 == ViewName.StoryView or slot1 == ViewName.StoryBackgroundView then
		TaskDispatcher.cancelTask(slot0._viewFadeOut, slot0)

		return
	end

	if StoryModel.instance:isStoryFinished(StoryController.instance._curStoryId) then
		StoryController.instance:closeStoryView()
	end
end

function slot0.cancelViewFadeOut(slot0)
	TaskDispatcher.cancelTask(slot0._viewFadeOut, slot0)
end

function slot0._viewFadeOut(slot0)
	ViewMgr.instance:unregisterCallback(ViewEvent.OnOpenFullView, slot0._onOpenView, slot0)
	StoryController.instance:closeStoryView()
	TaskDispatcher.runDelay(slot0._viewFadeOutFinished, slot0, 0.1)
	StoryController.instance:dispatchEvent(StoryEvent.FrontItemFadeOut)
end

function slot0._viewFadeOutFinished(slot0)
	gohelper.setActive(slot0._imagefulltop.gameObject, false)

	if slot0._outCallback then
		slot0._outCallback(slot0._outCallbackObj)
	end
end

function slot0._playDarkUpFade(slot0)
	gohelper.setActive(slot0._goupfade, true)
	transformhelper.setLocalPosXY(slot0._goupfade.transform, 0, 390)
	ZProj.TweenHelper.DOLocalMove(slot0._goupfade.transform, 0, 2800, 0, 1.5, function ()
		gohelper.setActive(uv0._goupfade, false)
	end)
end

function slot0._playDarkFade(slot0)
	StoryModel.instance.skipFade = false

	slot0:setFullTopShow()

	slot0._imagefulltop.color.a = 0
	slot0._imagefulltop.color = Color.black

	ZProj.TweenHelper.DoFade(slot0._imagefulltop, 0, 1, 1.5, slot0._playDarkFadeFinished, slot0, nil, EaseType.Linear)
end

function slot0._playDarkFadeFinished(slot0)
	StoryController.instance:dispatchEvent(StoryEvent.RefreshView)
	StoryController.instance:dispatchEvent(StoryEvent.RefreshBackground)
	ZProj.TweenHelper.KillByObj(slot0._imagefulltop)
	TaskDispatcher.runDelay(slot0._playDarkFadeInFinished, slot0, 0.5)
end

function slot0._playDarkFadeInFinished(slot0)
	ZProj.TweenHelper.DoFade(slot0._imagefulltop, 1, 0, 1.5, slot0._hideImageFullTop, slot0, nil, EaseType.Linear)
end

function slot0._hideImageFullTop(slot0)
	slot0._imagefulltop.color = Color.black

	gohelper.setActive(slot0._imagefulltop.gameObject, false)
end

function slot0._playWhiteFade(slot0)
	StoryModel.instance.skipFade = false

	slot0:setFullTopShow()

	slot0._imagefulltop.color.a = 0
	slot0._imagefulltop.color = Color.white

	ZProj.TweenHelper.DoFade(slot0._imagefulltop, 0, 1, 1.5, slot0._playWhiteFadeFinished, slot0, nil, EaseType.Linear)
end

function slot0._playWhiteFadeFinished(slot0)
	StoryController.instance:dispatchEvent(StoryEvent.RefreshView)
	StoryController.instance:dispatchEvent(StoryEvent.RefreshBackground)
	ZProj.TweenHelper.KillByObj(slot0._imagefulltop)
	TaskDispatcher.runDelay(slot0._playDarkFadeInFinished, slot0, 0.5)
end

function slot0._playWhiteFadeInFinished(slot0)
	ZProj.TweenHelper.DoFade(slot0._imagefulltop, 1, 0, 1.5, slot0._hideImageFullTop, slot0, nil, EaseType.Linear)
end

function slot0.playIrregularShakeText(slot0, slot1, slot2, slot3)
	slot0._stepCo = slot1

	gohelper.setActive(slot0._goirregularshake, true)

	slot0._shakefinishCallback = slot2
	slot0._shakefinishCallbackObj = slot3

	if not slot0._goshake then
		slot4 = ViewMgr.instance:getContainer(ViewName.StoryFrontView)
		slot0._goshake = slot4:getResInst(slot4:getSetting().otherRes[1], slot0._goirregularshake)
	end

	slot0._shakeAni = slot0._goshake:GetComponent(typeof(UnityEngine.Animator))
	gohelper.findChildText(slot0._goshake, "tex_ani/#tex").text = slot0._stepCo.conversation.diaTexts[GameLanguageMgr.instance:getLanguageTypeStoryIndex()]

	if slot0._stepCo.conversation.showTimes[GameLanguageMgr.instance:getVoiceTypeStoryIndex()] - 0.17 < 0.1 then
		if slot0._shakefinishCallback then
			slot0._shakefinishCallback(slot0._shakefinishCallbackObj)

			slot0._shakefinishCallback = nil
			slot0._shakefinishCallbackObj = nil
		end

		return
	end

	TaskDispatcher.runDelay(slot0._onShakeEnd, slot0, slot5)
end

function slot0._onShakeEnd(slot0)
	slot0._shakeAni:Play("close", 0, 0)
	TaskDispatcher.runDelay(function ()
		gohelper.setActive(uv0._goirregularshake, false)

		if uv0._shakefinishCallback then
			uv0._shakefinishCallback(uv0._shakefinishCallbackObj)

			uv0._shakefinishCallback = nil
			uv0._shakefinishCallbackObj = nil
		end
	end, nil, 0.17)
end

function slot0.wordByWord(slot0, slot1, slot2, slot3)
	slot0._stepCo = slot1

	gohelper.setActive(slot0._txtscreentext.gameObject, true)

	slot0._finishCallback = slot2
	slot0._finishCallbackObj = slot3

	ZProj.UGUIHelper.SetColorAlpha(slot0._txtscreentext, 1)

	if slot0._stepCo.conversation.showTimes[GameLanguageMgr.instance:getVoiceTypeStoryIndex()] < 0.1 then
		if slot0._finishCallback then
			slot0._finishCallback(slot0._finishCallbackObj)

			slot0._finishCallback = nil
			slot0._finishCallbackObj = nil
		end

		return
	end

	slot0:_startWordByWord()
end

function slot0._startWordByWord(slot0)
	ZProj.TweenHelper.KillByObj(slot0._txtscreentext)

	slot0._txtscreentext.text = ""
	slot0._txtscreentext.alignment = StoryTool.getTxtAlignment(slot0._stepCo.conversation.diaTexts[GameLanguageMgr.instance:getLanguageTypeStoryIndex()])

	ZProj.TweenHelper.DOText(slot0._txtscreentext, StoryTool.getFilterAlignTxt(slot0._stepCo.conversation.diaTexts[GameLanguageMgr.instance:getLanguageTypeStoryIndex()]), slot0._stepCo.conversation.showTimes[GameLanguageMgr.instance:getVoiceTypeStoryIndex()], function ()
		if uv0._finishCallback then
			uv0._finishCallback(uv0._finishCallbackObj)
		end
	end)
end

function slot0.lineShow(slot0, slot1, slot2, slot3, slot4)
	slot0._stepCo = slot2

	gohelper.setActive(slot0._txtscreentext.gameObject, true)

	slot0._finishCallback = slot3
	slot0._finishCallbackObj = slot4

	ZProj.UGUIHelper.SetColorAlpha(slot0._txtscreentext, 1)

	if slot0._stepCo.conversation.showTimes[GameLanguageMgr.instance:getVoiceTypeStoryIndex()] < 0.1 then
		if slot0._finishCallback then
			slot0._finishCallback(slot0._finishCallbackObj)
		end

		return
	end

	slot0:_startShowLine(slot1)
end

function slot0._startShowLine(slot0, slot1)
	if not slot0._copyText then
		slot2 = gohelper.cloneInPlace(slot0._txtscreentext.gameObject, "copytext")
		slot0._copyCanvasGroup = gohelper.onceAddComponent(slot2, typeof(UnityEngine.CanvasGroup))
		slot0._copyText = slot2:GetComponent(gohelper.Type_Text)
	end

	slot0._copyText.alignment = StoryTool.getTxtAlignment(slot0._diatxt)
	slot0._diatxt = StoryTool.getFilterAlignTxt(slot0._diatxt)
	slot0._diatxt = StoryModel.instance:getStoryTxtByVoiceType(slot0._diatxt, slot0._stepCo.conversation.audio or 0)

	gohelper.setActive(slot0._copyText.gameObject, true)

	slot3 = #slot0:_getLineWord(slot1) == 0 and slot0._stepCo.conversation.showTimes[GameLanguageMgr.instance:getVoiceTypeStoryIndex()] or slot0._stepCo.conversation.showTimes[GameLanguageMgr.instance:getVoiceTypeStoryIndex()] / #slot2

	function (slot0)
		slot1 = " "

		if #string.split("", "\n") > 1 then
			for slot7 = 2, slot3 do
				slot1 = string.format("%s\n%s", slot1, " ")
			end
		end

		if #uv0 > 1 then
			for slot7 = 1, #uv0 do
				slot8 = #string.split(uv0[slot7], "\n") or 1

				if slot7 < slot0 then
					slot12 = slot2
					slot2 = string.format("%s\n%s", slot12, uv0[slot7])

					for slot12 = 1, slot8 do
						slot13, slot14, slot15, slot16 = string.match(string.split(uv0[slot7], "\n")[slot12], "(.*)<size=(%d+)>(.*)</size>(%s*)")
						slot1 = (not slot14 or not tonumber(slot14) or string.format("%s\n%s", slot1, string.format("<size=%s> </size>", slot14))) and string.format("%s\n%s", string.format("%s\n%s", slot1, string.format("<size=%s> </size>", slot14)), " ")
					end
				elseif slot7 == slot0 then
					for slot12 = 1, slot8 do
						slot2 = string.format("%s\n%s", slot2, " ")
					end

					slot1 = string.format("%s\n%s", slot1, uv0[slot7])
				else
					for slot12 = 1, slot8 do
						slot2 = string.format("%s\n%s", slot2, " ")
						slot1 = string.format("%s\n%s", slot1, " ")
					end
				end
			end
		end

		uv1._txtscreentext.text = slot2
		uv1._copyText.text = slot1

		ZProj.TweenHelper.KillByObj(uv1._txtscreentext)
		ZProj.TweenHelper.KillByObj(uv1._copyText)
		ZProj.UGUIHelper.SetColorAlpha(uv1._txtscreentext, 1)
		ZProj.TweenHelper.DOFadeCanvasGroup(uv1._copyText.gameObject, 0, 1, uv2, function ()
			if uv0 - #uv1 >= 0 then
				uv2:_lineWordShowFinished()
			else
				uv0 = uv0 + 1

				uv3(uv0)
			end
		end, nil, , EaseType.Linear)
	end(1)
end

function slot0._getLineWord(slot0, slot1)
	slot3 = {}

	for slot8 = 0, math.floor(#string.split(slot0._diatxt, "\n") / slot1) - 1 do
		for slot13 = 2, slot1 do
			slot9 = string.format("%s\n%s", slot2[slot8 * slot1 + 1], slot2[slot8 * slot1 + slot13])
		end

		table.insert(slot3, slot9)
	end

	if slot4 * slot1 < #slot2 then
		slot5 = slot2[slot4 * slot1 + 1]

		if #slot2 - slot4 * slot1 > 1 then
			for slot9 = 2, #slot2 - slot4 * slot1 do
				slot5 = string.format("%s\n%s", slot5, slot2[slot1 * slot4 + slot9])
			end
		end

		table.insert(slot3, slot5)
	end

	return slot3
end

function slot0._lineWordShowFinished(slot0)
	slot0._txtscreentext.text = "\n" .. slot0._diatxt

	gohelper.setActive(slot0._copyText.gameObject, false)

	if slot0._finishCallback then
		slot0._finishCallback(slot0._finishCallbackObj)
	end
end

function slot0.playFullTextFadeOut(slot0)
	ZProj.TweenHelper.KillByObj(slot0._txtscreentext)
	ZProj.TweenHelper.DoFade(slot0._txtscreentext, 1, 0, 0.5, slot0._hideScreenTxt, slot0, nil, EaseType.Linear)
end

function slot0._hideScreenTxt(slot0)
	ZProj.TweenHelper.KillByObj(slot0._txtscreentext)
	gohelper.setActive(slot0._txtscreentext.gameObject, false)
end

function slot0.playTextFadeIn(slot0, slot1, slot2, slot3)
	slot0._stepCo = slot1

	gohelper.setActive(slot0._txtscreentext.gameObject, true)

	slot0._finishCallback = slot2
	slot0._finishCallbackObj = slot3

	ZProj.TweenHelper.KillByObj(slot0._txtscreentext)

	if slot0._stepCo.conversation.showTimes[GameLanguageMgr.instance:getVoiceTypeStoryIndex()] < 0.1 then
		ZProj.UGUIHelper.SetColorAlpha(slot0._txtscreentext, 1)
		slot0:_fadeFinished()
	else
		if string.match(slot0._txtscreentext.text, "<color=#%x+>") then
			slot0._txtscreentext.text = string.gsub(slot4, "<color=#(%x%x%x%x%x%x)(%x-)>", "<color=#%100>")
		end

		slot0._floatTweenId = ZProj.TweenHelper.DOTweenFloat(0, 1, slot0._stepCo.conversation.showTimes[GameLanguageMgr.instance:getVoiceTypeStoryIndex()], slot0._fadeUpdate, slot0._fadeFinished, slot0, nil, EaseType.Linear)
	end
end

function slot0._fadeUpdate(slot0, slot1)
	if string.match(slot0._txtscreentext.text, "<color=#%x+>") then
		slot0._txtscreentext.text = string.gsub(slot2, "<color=#(%x%x%x%x%x%x)(%x+)>", "<color=#%1" .. string.format("%02x", math.ceil(255 * slot1)) .. ">")

		return
	end

	ZProj.UGUIHelper.SetColorAlpha(slot0._txtscreentext, slot1)
end

function slot0._fadeFinished(slot0)
	if slot0._finishCallback then
		slot0._finishCallback(slot0._finishCallbackObj)
	end
end

function slot0.destroy(slot0)
	slot0:_removeEvent()
	TaskDispatcher.cancelTask(slot0._viewFadeOutFinished, slot0)
	TaskDispatcher.cancelTask(slot0._startStoryViewIn, slot0)
	TaskDispatcher.cancelTask(slot0._viewFadeOut, slot0)
	TaskDispatcher.cancelTask(slot0._onShakeEnd, slot0)

	if slot0._floatTweenId then
		ZProj.TweenHelper.KillById(slot0._floatTweenId)

		slot0._floatTweenId = nil
	end

	ZProj.TweenHelper.KillByObj(slot0._imagefulltop)
	ZProj.TweenHelper.KillByObj(slot0._goupfade.transform)
	ZProj.TweenHelper.KillByObj(slot0._txtscreentext)
end

return slot0
