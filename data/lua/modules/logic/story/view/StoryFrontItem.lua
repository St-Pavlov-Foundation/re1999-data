-- chunkname: @modules/logic/story/view/StoryFrontItem.lua

module("modules.logic.story.view.StoryFrontItem", package.seeall)

local StoryFrontItem = class("StoryFrontItem")

function StoryFrontItem:init(go)
	self._frontGO = go
	self._txtscreentext = gohelper.findChildText(go, "txt_screentext")
	self._imagefulltop = gohelper.findChildImage(go, "image_fulltop")
	self._imageupfade = gohelper.findChildImage(go, "go_upfade")
	self._imageblock = gohelper.findChildImage(go, "#go_block")
	self._goupfade = gohelper.findChild(go, "go_upfade")
	self._goirregularshake = gohelper.findChild(go.transform.parent.gameObject, "#go_irregularshake")

	self:setFullTopShow()
	gohelper.setActive(self._txtscreentext.gameObject, false)

	self._imagefulltop.color.a = 1
	self._imagefulltop.color = Color.black

	self:_addEvent()
end

function StoryFrontItem:_addEvent()
	StoryController.instance:registerCallback(StoryEvent.PlayDarkFadeUp, self._playDarkUpFade, self)
	StoryController.instance:registerCallback(StoryEvent.PlayDarkFade, self._playDarkFade, self)
	StoryController.instance:registerCallback(StoryEvent.PlayWhiteFade, self._playWhiteFade, self)
end

function StoryFrontItem:_removeEvent()
	StoryController.instance:unregisterCallback(StoryEvent.PlayDarkFadeUp, self._playDarkUpFade, self)
	StoryController.instance:unregisterCallback(StoryEvent.PlayDarkFade, self._playDarkFade, self)
	StoryController.instance:unregisterCallback(StoryEvent.PlayWhiteFade, self._playWhiteFade, self)
end

function StoryFrontItem:showFullScreenText(show, txt)
	if not show then
		self._finishCallback = nil
		self._finishCallbackObj = nil
		self._fadeOutCallback = nil
		self._fadeOutCallbackObj = nil

		ZProj.TweenHelper.KillByObj(self._txtscreentext)
		ZProj.TweenHelper.KillByObj(self._copyText)

		if self._copyText then
			gohelper.destroy(self._copyText.gameObject)

			self._copyText = nil
		end
	end

	gohelper.setActive(self._txtscreentext.gameObject, show)

	self._diatxt = string.gsub(txt, "<notShowInLog>", "")

	local stepId = StoryModel.instance:getCurStepId()
	local stepCo = StoryStepModel.instance:getStepListById(stepId)

	self._diatxt = StoryModel.instance:getStoryTxtByVoiceType(self._diatxt, stepCo.conversation.audio or 0)
	self._txtscreentext.alignment = StoryTool.getTxtAlignment(self._diatxt)
	self._txtscreentext.text = StoryTool.getFilterAlignTxt(self._diatxt)

	self:_showGlitch(stepCo.conversation.effType == StoryEnum.ConversationEffectType.Glitch)
end

function StoryFrontItem:enableFrontRayCast(enable)
	self._txtscreentext.raycastTarget = enable
	self._imagefulltop.raycastTarget = enable
	self._imageblock.raycastTarget = enable
	self._imageupfade.raycastTarget = enable
end

function StoryFrontItem:_showGlitch(show)
	if show then
		if not self._goGlitch then
			self._glitchPath = ResUrl.getEffect("story/v2a6_fontglitch")
			self._effLoader = MultiAbLoader.New()

			self._effLoader:addPath(self._glitchPath)
			self._effLoader:startLoad(self._glitchEffLoaded, self)
		else
			local ctxt = self._txtscreentext.gameObject:GetComponent(typeof(UnityEngine.UI.CustomText))

			ctxt.isSetParticleShapeMesh = true
			ctxt.isSetParticleCount = true

			gohelper.setLayer(self._txtscreentext.gameObject, UnityLayer.UISecond, true)
			gohelper.setActive(self._goGlitch, true)
		end
	else
		gohelper.setLayer(self._txtscreentext.gameObject, UnityLayer.UITop, true)

		if self._goGlitch then
			gohelper.setActive(self._goGlitch, false)
		end

		local ctxt = self._txtscreentext.gameObject:GetComponent(typeof(UnityEngine.UI.CustomText))

		ctxt.isSetParticleShapeMesh = false
		ctxt.isSetParticleCount = false
	end
end

function StoryFrontItem:playGlitch()
	StoryTool.enablePostProcess(true)
	gohelper.setActive(self._txtscreentext.gameObject, true)
	self:_showGlitch(true)
end

function StoryFrontItem:_glitchEffLoaded(loader)
	local glitchAssetItem = loader:getAssetItem(self._glitchPath)

	self._goGlitch = gohelper.clone(glitchAssetItem:GetResource(self._glitchPath), self._txtscreentext.gameObject)

	gohelper.setActive(self._goGlitch, true)

	local goGlitchUp = gohelper.findChild(self._goGlitch, "part_up")
	local goGlitchDown = gohelper.findChild(self._goGlitch, "part_down")
	local goScreen = gohelper.findChild(self._goGlitch, "part_screen")

	gohelper.setActive(goGlitchUp, false)
	gohelper.setActive(goGlitchDown, false)
	gohelper.setActive(goScreen, true)

	local ctxt = self._txtscreentext.gameObject:GetComponent(typeof(UnityEngine.UI.CustomText))

	ctxt.isSetParticleShapeMesh = true
	ctxt.isSetParticleCount = true
	ctxt.particle = goScreen:GetComponent(typeof(UnityEngine.ParticleSystem))

	gohelper.setLayer(self._txtscreentext.gameObject, UnityLayer.UISecond, true)
end

function StoryFrontItem:_getFadeTime()
	local time = not StoryModel.instance.skipFade and 1 or 0

	return time
end

function StoryFrontItem:setFullTopShow()
	gohelper.setActive(self._imagefulltop.gameObject, not StoryModel.instance.skipFade and true or false)
end

function StoryFrontItem:playStoryViewIn()
	local skip = StoryModel.instance:isTypeSkip(StoryEnum.SkipType.InDarkFade, StoryModel.instance:getCurStoryId())

	StoryModel.instance.skipFade = skip

	ZProj.TweenHelper.KillByObj(self._imagefulltop)

	self._imagefulltop.color.a = 1

	self:setFullTopShow()

	if not skip then
		TaskDispatcher.runDelay(self._startStoryViewIn, self, 0.5)
	end
end

function StoryFrontItem:_startStoryViewIn()
	local alpha = self._imagefulltop.color.a

	ZProj.TweenHelper.DoFade(self._imagefulltop, alpha, 0, self:_getFadeTime(), function()
		gohelper.setActive(self._imagefulltop.gameObject, false)
	end, nil, nil, EaseType.Linear)
end

function StoryFrontItem:playStoryViewOut(callback, callbackobj, isSkip)
	local skip = StoryModel.instance:isTypeSkip(StoryEnum.SkipType.OutDarkFade, StoryModel.instance:getCurStoryId())

	StoryModel.instance.skipFade = skip

	self:setFullTopShow()

	self._imagefulltop.color.a = 0
	self._finishCallback = nil
	self._finishCallbackObj = nil
	self._fadeOutCallback = nil
	self._fadeOutCallbackObj = nil

	ZProj.TweenHelper.KillByObj(self._txtscreentext)
	ZProj.TweenHelper.KillByObj(self._copyText)

	if self._copyText then
		gohelper.destroy(self._copyText.gameObject)

		self._copyText = nil
	end

	self._outCallback = callback
	self._outCallbackObj = callbackobj

	ZProj.TweenHelper.KillByObj(self._imagefulltop)
	ZProj.TweenHelper.DoFade(self._imagefulltop, 0, 1, self:_getFadeTime(), self.enterStoryFinish, self, nil, EaseType.Linear)
end

function StoryFrontItem:enterStoryFinish()
	gohelper.setActive(self._txtscreentext.gameObject, false)
	StoryController.instance:dispatchEvent(StoryEvent.Hide)
	ViewMgr.instance:registerCallback(ViewEvent.OnOpenFullView, self._onOpenView, self)
	TaskDispatcher.runDelay(self._viewFadeOut, self, 0.5)
	StoryController.instance:finished()
end

function StoryFrontItem:_onOpenView(viewName)
	ViewMgr.instance:unregisterCallback(ViewEvent.OnOpenFullView, self._onOpenView, self)

	if viewName == ViewName.StoryView or viewName == ViewName.StoryBackgroundView then
		TaskDispatcher.cancelTask(self._viewFadeOut, self)

		return
	end

	local storyId = StoryModel.instance:getCurStoryId()

	if StoryModel.instance:isStoryFinished(storyId) then
		StoryController.instance:closeStoryView()
	end
end

function StoryFrontItem:cancelViewFadeOut()
	TaskDispatcher.cancelTask(self._viewFadeOut, self)
end

function StoryFrontItem:_viewFadeOut()
	ViewMgr.instance:unregisterCallback(ViewEvent.OnOpenFullView, self._onOpenView, self)
	StoryController.instance:closeStoryView()
	TaskDispatcher.runDelay(self._viewFadeOutFinished, self, 0.1)
	StoryController.instance:dispatchEvent(StoryEvent.FrontItemFadeOut)
end

function StoryFrontItem:_viewFadeOutFinished()
	gohelper.setActive(self._imagefulltop.gameObject, false)

	if self._outCallback then
		self._outCallback(self._outCallbackObj)
	end
end

function StoryFrontItem:_playDarkUpFade()
	gohelper.setActive(self._goupfade, true)
	transformhelper.setLocalPosXY(self._goupfade.transform, 0, 390)
	ZProj.TweenHelper.DOLocalMove(self._goupfade.transform, 0, 2800, 0, 1.5, function()
		gohelper.setActive(self._goupfade, false)
	end)
end

function StoryFrontItem:_playDarkFade()
	StoryModel.instance.skipFade = false

	self:setFullTopShow()

	self._imagefulltop.color.a = 0
	self._imagefulltop.color = Color.black

	ZProj.TweenHelper.DoFade(self._imagefulltop, 0, 1, 1.5, self._playDarkFadeFinished, self, nil, EaseType.Linear)
end

function StoryFrontItem:_playDarkFadeFinished()
	StoryController.instance:dispatchEvent(StoryEvent.RefreshView)
	StoryController.instance:dispatchEvent(StoryEvent.RefreshBackground)
	ZProj.TweenHelper.KillByObj(self._imagefulltop)
	TaskDispatcher.runDelay(self._playDarkFadeInFinished, self, 0.5)
end

function StoryFrontItem:_playDarkFadeInFinished()
	ZProj.TweenHelper.DoFade(self._imagefulltop, 1, 0, 1.5, self._hideImageFullTop, self, nil, EaseType.Linear)
end

function StoryFrontItem:_hideImageFullTop()
	self._imagefulltop.color = Color.black

	gohelper.setActive(self._imagefulltop.gameObject, false)
end

function StoryFrontItem:_playWhiteFade()
	StoryModel.instance.skipFade = false

	self:setFullTopShow()

	self._imagefulltop.color.a = 0
	self._imagefulltop.color = Color.white

	ZProj.TweenHelper.DoFade(self._imagefulltop, 0, 1, 1.5, self._playWhiteFadeFinished, self, nil, EaseType.Linear)
end

function StoryFrontItem:_playWhiteFadeFinished()
	StoryController.instance:dispatchEvent(StoryEvent.RefreshView)
	StoryController.instance:dispatchEvent(StoryEvent.RefreshBackground)
	ZProj.TweenHelper.KillByObj(self._imagefulltop)
	TaskDispatcher.runDelay(self._playDarkFadeInFinished, self, 0.5)
end

function StoryFrontItem:_playWhiteFadeInFinished()
	ZProj.TweenHelper.DoFade(self._imagefulltop, 1, 0, 1.5, self._hideImageFullTop, self, nil, EaseType.Linear)
end

function StoryFrontItem:playIrregularShakeText(co, callback, callbackobj)
	self._stepCo = co

	gohelper.setActive(self._goirregularshake, true)

	self._shakefinishCallback = callback
	self._shakefinishCallbackObj = callbackobj

	if not self._goshake then
		local viewContainer = ViewMgr.instance:getContainer(ViewName.StoryFrontView)

		self._goshake = viewContainer:getResInst(viewContainer:getSetting().otherRes[1], self._goirregularshake)
	end

	local txt = gohelper.findChildText(self._goshake, "tex_ani/#tex")

	self._shakeAni = self._goshake:GetComponent(typeof(UnityEngine.Animator))
	txt.text = self._stepCo.conversation.diaTexts[GameLanguageMgr.instance:getLanguageTypeStoryIndex()]

	local delayTime = self._stepCo.conversation.showTimes[GameLanguageMgr.instance:getVoiceTypeStoryIndex()] - 0.17

	if delayTime < 0.1 then
		if self._shakefinishCallback then
			self._shakefinishCallback(self._shakefinishCallbackObj)

			self._shakefinishCallback = nil
			self._shakefinishCallbackObj = nil
		end

		return
	end

	TaskDispatcher.runDelay(self._onShakeEnd, self, delayTime)
end

function StoryFrontItem:_onShakeEnd()
	self._shakeAni:Play("close", 0, 0)
	TaskDispatcher.runDelay(function()
		gohelper.setActive(self._goirregularshake, false)

		if self._shakefinishCallback then
			self._shakefinishCallback(self._shakefinishCallbackObj)

			self._shakefinishCallback = nil
			self._shakefinishCallbackObj = nil
		end
	end, nil, 0.17)
end

function StoryFrontItem:wordByWord(co, callback, callbackobj)
	self._stepCo = co

	gohelper.setActive(self._txtscreentext.gameObject, true)

	self._finishCallback = callback
	self._finishCallbackObj = callbackobj

	ZProj.UGUIHelper.SetColorAlpha(self._txtscreentext, 1)

	if self._stepCo.conversation.showTimes[GameLanguageMgr.instance:getVoiceTypeStoryIndex()] < 0.1 then
		if self._finishCallback then
			self._finishCallback(self._finishCallbackObj)

			self._finishCallback = nil
			self._finishCallbackObj = nil
		end

		return
	end

	self:_startWordByWord()
end

function StoryFrontItem:_startWordByWord()
	ZProj.TweenHelper.KillByObj(self._txtscreentext)

	self._txtscreentext.text = ""

	local align = StoryTool.getTxtAlignment(self._stepCo.conversation.diaTexts[GameLanguageMgr.instance:getLanguageTypeStoryIndex()])

	self._txtscreentext.alignment = align

	local txt = StoryTool.getFilterAlignTxt(self._stepCo.conversation.diaTexts[GameLanguageMgr.instance:getLanguageTypeStoryIndex()])

	ZProj.TweenHelper.DOText(self._txtscreentext, txt, self._stepCo.conversation.showTimes[GameLanguageMgr.instance:getVoiceTypeStoryIndex()], function()
		if self._finishCallback then
			self._finishCallback(self._finishCallbackObj)

			self._finishCallback = nil
			self._finishCallbackObj = nil
		end
	end)
end

function StoryFrontItem:lineShow(lineCount, co, callback, callbackobj)
	self._stepCo = co

	gohelper.setActive(self._txtscreentext.gameObject, true)

	self._finishCallback = callback
	self._finishCallbackObj = callbackobj

	ZProj.UGUIHelper.SetColorAlpha(self._txtscreentext, 1)

	if self._stepCo.conversation.showTimes[GameLanguageMgr.instance:getVoiceTypeStoryIndex()] < 0.1 then
		if self._finishCallback then
			self._finishCallback(self._finishCallbackObj)

			self._finishCallback = nil
			self._finishCallbackObj = nil
		end

		return
	end

	self:_startShowLine(lineCount)
end

function StoryFrontItem:_startShowLine(lineCount)
	if not self._copyText then
		local copyObj = gohelper.cloneInPlace(self._txtscreentext.gameObject, "copytext")

		self._copyCanvasGroup = gohelper.onceAddComponent(copyObj, typeof(UnityEngine.CanvasGroup))
		self._copyText = copyObj:GetComponent(gohelper.Type_Text)
	end

	self._copyText.alignment = StoryTool.getTxtAlignment(self._diatxt)
	self._diatxt = StoryTool.getFilterAlignTxt(self._diatxt)
	self._diatxt = StoryModel.instance:getStoryTxtByVoiceType(self._diatxt, self._stepCo.conversation.audio or 0)

	gohelper.setActive(self._copyText.gameObject, true)

	local lineWords = self:_getLineWord(lineCount)
	local lineShowTime = #lineWords == 0 and self._stepCo.conversation.showTimes[GameLanguageMgr.instance:getVoiceTypeStoryIndex()] or self._stepCo.conversation.showTimes[GameLanguageMgr.instance:getVoiceTypeStoryIndex()] / #lineWords
	local index = 1

	local function showLine(index)
		local cpstr = " "
		local str = ""
		local firstLineCount = #string.split(str, "\n")

		if firstLineCount > 1 then
			for j = 2, firstLineCount do
				cpstr = string.format("%s\n%s", cpstr, " ")
			end
		end

		if #lineWords >= 1 then
			for i = 1, #lineWords do
				local indexLineCount = #string.split(lineWords[i], "\n")

				indexLineCount = indexLineCount or 1

				if i < index then
					str = string.format("%s\n%s", str, lineWords[i])

					for j = 1, indexLineCount do
						local _, size, _, _ = string.match(string.split(lineWords[i], "\n")[j], "(.*)<size=(%d+)>(.*)</size>(%s*)")

						if size and tonumber(size) then
							cpstr = string.format("%s\n%s", cpstr, string.format("<size=%s> </size>", size))
						else
							cpstr = string.format("%s\n%s", cpstr, " ")
						end
					end
				elseif i == index then
					for j = 1, indexLineCount do
						str = string.format("%s\n%s", str, " ")
					end

					cpstr = string.format("%s\n%s", cpstr, lineWords[i])
				else
					for j = 1, indexLineCount do
						str = string.format("%s\n%s", str, " ")
						cpstr = string.format("%s\n%s", cpstr, " ")
					end
				end
			end
		end

		self._txtscreentext.text = str
		self._copyText.text = cpstr

		ZProj.TweenHelper.KillByObj(self._txtscreentext)
		ZProj.TweenHelper.KillByObj(self._copyText)
		ZProj.UGUIHelper.SetColorAlpha(self._txtscreentext, 1)
		ZProj.TweenHelper.DOFadeCanvasGroup(self._copyText.gameObject, 0, 1, lineShowTime, function()
			if index - #lineWords >= 0 then
				self:_lineWordShowFinished()
			else
				index = index + 1

				showLine(index)
			end
		end, nil, nil, EaseType.Linear)
	end

	showLine(index)
end

function StoryFrontItem:_getLineWord(lineCount)
	local spWords = string.split(self._diatxt, "\n")
	local lineWords = {}
	local count = math.floor(#spWords / lineCount)

	for i = 0, count - 1 do
		local word1 = spWords[i * lineCount + 1]

		for j = 2, lineCount do
			word1 = string.format("%s\n%s", word1, spWords[i * lineCount + j])
		end

		table.insert(lineWords, word1)
	end

	if count * lineCount < #spWords then
		local word2 = spWords[count * lineCount + 1]

		if #spWords - count * lineCount > 1 then
			for j = 2, #spWords - count * lineCount do
				word2 = string.format("%s\n%s", word2, spWords[lineCount * count + j])
			end
		end

		table.insert(lineWords, word2)
	end

	return lineWords
end

function StoryFrontItem:_lineWordShowFinished()
	self._txtscreentext.text = "\n" .. self._diatxt

	if self._finishCallback then
		self._finishCallback(self._finishCallbackObj)

		self._finishCallback = nil
		self._finishCallback = nil
	end

	if self._copyText then
		gohelper.setActive(self._copyText.gameObject, false)

		self._copyText.text = ""
	end
end

function StoryFrontItem:playFullTextFadeOut(outTime, callback, callbackObj)
	local fadeOutTime = outTime or 0.5

	self._fadeOutCallback = callback
	self._fadeOutCallbackObj = callbackObj

	ZProj.TweenHelper.KillByObj(self._txtscreentext)
	ZProj.TweenHelper.DoFade(self._txtscreentext, 1, 0, fadeOutTime, self._hideScreenTxt, self, nil, EaseType.Linear)
end

function StoryFrontItem:_hideScreenTxt()
	ZProj.TweenHelper.KillByObj(self._txtscreentext)
	gohelper.setActive(self._txtscreentext.gameObject, false)

	if self._fadeOutCallback then
		self._fadeOutCallback(self._fadeOutCallbackObj)

		self._fadeOutCallback = nil
		self._fadeOutCallbackObj = nil
	end
end

function StoryFrontItem:playTextFadeIn(co, callback, callbackobj)
	self._stepCo = co

	gohelper.setActive(self._txtscreentext.gameObject, true)

	self._finishCallback = callback
	self._finishCallbackObj = callbackobj

	ZProj.TweenHelper.KillByObj(self._txtscreentext)

	if self._stepCo.conversation.showTimes[GameLanguageMgr.instance:getVoiceTypeStoryIndex()] < 0.1 then
		ZProj.UGUIHelper.SetColorAlpha(self._txtscreentext, 1)
		self:_fadeFinished()
	else
		local txt = self._txtscreentext.text

		if string.match(txt, "<color=#%x+>") then
			txt = string.gsub(txt, "<color=#(%x%x%x%x%x%x)(%x-)>", "<color=#%100>")
			self._txtscreentext.text = txt
		end

		self._floatTweenId = ZProj.TweenHelper.DOTweenFloat(0, 1, self._stepCo.conversation.showTimes[GameLanguageMgr.instance:getVoiceTypeStoryIndex()], self._fadeUpdate, self._fadeFinished, self, nil, EaseType.Linear)
	end
end

function StoryFrontItem:_fadeUpdate(value)
	local txt = self._txtscreentext.text
	local result = math.ceil(255 * value)
	local alpha = string.format("%02x", result)

	if string.match(txt, "<color=#%x+>") then
		txt = string.gsub(txt, "<color=#(%x%x%x%x%x%x)(%x+)>", "<color=#%1" .. alpha .. ">")
		self._txtscreentext.text = txt

		return
	end

	ZProj.UGUIHelper.SetColorAlpha(self._txtscreentext, value)
end

function StoryFrontItem:_fadeFinished()
	if self._finishCallback then
		self._finishCallback(self._finishCallbackObj)

		self._finishCallback = nil
		self._finishCallbackObj = nil
	end
end

function StoryFrontItem:destroy()
	self:_removeEvent()

	self._finishCallback = nil
	self._finishCallbackObj = nil
	self._outCallback = nil
	self._outCallbackObj = nil
	self._fadeOutCallback = nil
	self._fadeOutCallbackObj = nil

	TaskDispatcher.cancelTask(self._viewFadeOutFinished, self)
	TaskDispatcher.cancelTask(self._startStoryViewIn, self)
	TaskDispatcher.cancelTask(self._viewFadeOut, self)
	TaskDispatcher.cancelTask(self._onShakeEnd, self)

	if self._floatTweenId then
		ZProj.TweenHelper.KillById(self._floatTweenId)

		self._floatTweenId = nil
	end

	ZProj.TweenHelper.KillByObj(self._imagefulltop)
	ZProj.TweenHelper.KillByObj(self._goupfade.transform)
	ZProj.TweenHelper.KillByObj(self._txtscreentext)
end

return StoryFrontItem
