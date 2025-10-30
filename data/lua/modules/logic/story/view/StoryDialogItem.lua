-- chunkname: @modules/logic/story/view/StoryDialogItem.lua

module("modules.logic.story.view.StoryDialogItem", package.seeall)

local StoryDialogItem = class("StoryDialogItem")

function StoryDialogItem:init(go)
	self._conGo = go
	self._gonexticon = gohelper.findChild(go, "nexticon")
	self._goconversation = gohelper.findChild(go, "#go_conversation")
	self._goblackbottom = gohelper.findChild(go, "#go_conversation/blackBottom")
	self._contentGO = gohelper.findChild(go, "#go_conversation/#go_contents")
	self._goline = gohelper.findChild(self._contentGO, "line")
	self._norDiaGO = gohelper.findChild(self._contentGO, "go_normalcontent")
	self._txtcontentcn = gohelper.findChildText(self._norDiaGO, "txt_contentcn")
	self._conMat = self._txtcontentcn.fontMaterial

	local _shader = UnityEngine.Shader

	self._LineMinYId = _shader.PropertyToID("_LineMinY")
	self._LineMaxYId = _shader.PropertyToID("_LineMaxY")
	self._txtdot = gohelper.findChild(self._norDiaGO, "txt_contentcn/storytxtdot")
	self._txtmarktop = gohelper.findChildText(self._norDiaGO, "txt_contentcn/storymarktop")
	self._dotMat = self._txtdot.transform:GetComponent(gohelper.Type_Image).material
	self._markTopMat = self._txtmarktop.fontMaterial
	self._conMark = gohelper.onceAddComponent(self._txtcontentcn.gameObject, typeof(ZProj.TMPMark))

	self._conMark:SetMarkGo(self._txtdot)
	self._conMark:SetMarkTopGo(self._txtmarktop.gameObject)

	self._magicDiaGO = gohelper.findChild(self._contentGO, "go_magiccontent")
	self._txtcontentmagic = gohelper.findChildText(self._magicDiaGO, "txt_contentmagic")
	self._gofirework = gohelper.findChild(self._magicDiaGO, "txt_contentmagic/go_firework")
	self._txtcontentreshapemagic = gohelper.findChildText(self._magicDiaGO, "txt_contentreshapemagic")
	self._goreshapefirework = gohelper.findChild(self._magicDiaGO, "txt_contentreshapemagic/go_reshapefirework")

	self:_showMagicItem(false)

	self._goslidecontent = gohelper.findChild(go, "#go_slidecontent")
	self._slideItem = StoryDialogSlideItem.New()

	self._slideItem:init(self._goslidecontent)
	self._slideItem:hideDialog()

	local storyviewGo = ViewMgr.instance:getContainer(ViewName.StoryView).viewGO

	self._roleAudioGo = gohelper.findChild(storyviewGo, "go_roleaudio")
	self._roleLeftAudioGo = gohelper.findChild(self._roleAudioGo, "left")
	self._roleMidAudioGo = gohelper.findChild(self._roleAudioGo, "middle")
	self._roleRightAudioGo = gohelper.findChild(self._roleAudioGo, "right")
	self._fontNormalMat = self._txtcontentcn.fontSharedMaterial

	self:_loadRes()
	self:_addEvent()
end

function StoryDialogItem:_loadRes()
	self._magicFirePath = ResUrl.getEffect("story/story_magicfont_particle")
	self._reshapeMagicFirePath = ResUrl.getEffect("story/story_magicfont_particle_dark")
	self._glitchPath = ResUrl.getEffect("story/v2a6_fontglitch")
	self._effLoader = MultiAbLoader.New()

	self._effLoader:addPath(self._magicFirePath)
	self._effLoader:addPath(self._reshapeMagicFirePath)
	self._effLoader:addPath(self._glitchPath)
	self._effLoader:startLoad(self._magicFireEffectLoaded, self)
end

function StoryDialogItem:_magicFireEffectLoaded(loader)
	local assetItem = loader:getAssetItem(self._magicFirePath)

	self._magicFireGo = gohelper.clone(assetItem:GetResource(self._magicFirePath), self._gofirework)

	gohelper.setActive(self._magicFireGo, false)

	self._magicFireAnim = self._magicFireGo:GetComponent(typeof(UnityEngine.Animator))

	local reshapeAssetItem = loader:getAssetItem(self._reshapeMagicFirePath)

	self._reshapeMagicFireGo = gohelper.clone(reshapeAssetItem:GetResource(self._reshapeMagicFirePath), self._goreshapefirework)

	gohelper.setActive(self._reshapeMagicFireGo, false)

	self._reshapeMagicFireAnim = self._reshapeMagicFireGo:GetComponent(typeof(UnityEngine.Animator))

	local glitchAssetItem = loader:getAssetItem(self._glitchPath)

	self._glitchGo = gohelper.clone(glitchAssetItem:GetResource(self._glitchPath), self._norDiaGO)

	gohelper.setActive(self._glitchGo, false)
end

function StoryDialogItem:_addEvent()
	StoryController.instance:registerCallback(StoryEvent.LogSelected, self._btnlogOnClick, self)
	ViewMgr.instance:registerCallback(ViewEvent.OnCloseView, self._checkCloseView, self)
end

function StoryDialogItem:_removeEvent()
	StoryController.instance:unregisterCallback(StoryEvent.LogSelected, self._btnlogOnClick, self)
	ViewMgr.instance:unregisterCallback(ViewEvent.OnCloseView, self._checkCloseView, self)
end

function StoryDialogItem:_checkCloseView(viewName)
	if viewName == ViewName.StoryLogView then
		self._isLogStop = false
	end
end

function StoryDialogItem:_btnlogOnClick(audioId)
	self._isLogStop = true

	if audioId == self._conAudioId then
		return
	end

	self._playingAudioId = 0

	if self._conAudioId ~= 0 and self._conAudioId then
		AudioEffectMgr.instance:stopAudio(self._conAudioId, 0)
	end
end

function StoryDialogItem:hideDialog()
	if self._conTweenId then
		ZProj.TweenHelper.KillById(self._conTweenId)

		self._conTweenId = nil
	end

	if self._magicConTweenId then
		ZProj.TweenHelper.KillById(self._magicConTweenId)

		self._magicConTweenId = nil
	end

	gohelper.setActive(self._norDiaGO, false)

	local x, y, z = transformhelper.getLocalPos(self._txtcontentcn.transform)

	transformhelper.setLocalPos(self._txtcontentcn.transform, x, y, 1)

	self._txtcontentcn.text = ""

	self._conMat:DisableKeyword("_GRADUAL_ON")
	self._markTopMat:DisableKeyword("_GRADUAL_ON")
	TaskDispatcher.cancelTask(self._delayShow, self)
	self:_showMagicItem(false)

	self._finishCallback = nil
	self._finishCallbackObj = nil

	local x2, y2, z2 = transformhelper.getLocalPos(self._txtcontentmagic.transform)

	transformhelper.setLocalPos(self._txtcontentmagic.transform, x2, y2, 1)
	transformhelper.setLocalPos(self._txtcontentreshapemagic.transform, x2, y2, 1)

	self._txtcontentmagic.text = ""
	self._txtcontentreshapemagic.text = ""
end

function StoryDialogItem:playDialog(diaTxt, stepCo, callback, callbackobj)
	self._stepCo = stepCo

	local audioId = self._stepCo.conversation.audios[1] or 0
	local diatxt = StoryModel.instance:getStoryTxtByVoiceType(diaTxt, audioId)

	diatxt = string.gsub(diatxt, "<notShowInLog>", "")

	self:clearSlideDialog()

	if self._stepCo.conversation.type == StoryEnum.ConversationType.SlideDialog then
		self:playSlideDialog(diatxt, callback, callbackobj)

		return
	end

	self._slideItem:hideDialog()
	gohelper.setActive(self._goconversation, true)
	gohelper.setActive(self._gonexticon, true)

	if self._stepCo.conversation.effType == StoryEnum.ConversationEffectType.Magic or self._stepCo.conversation.effType == StoryEnum.ConversationEffectType.ReshapeMagic then
		self:playMagicText(diatxt, callback, callbackobj)
	else
		self:playNormalText(diatxt, callback, callbackobj)
	end
end

function StoryDialogItem:clearSlideDialog()
	if self._slideItem then
		self._slideItem:clearSlideDialog()
	end
end

function StoryDialogItem:playSlideDialog(txt, callback, callbackobj)
	local params = string.split(txt, "#")

	if #params ~= 3 then
		logError("配置异常，请检查配置[示例：gundongzimu_1#1.0#10.0](图片名#速度#时间)")

		return
	end

	gohelper.setActive(self._goconversation, false)
	gohelper.setActive(self._gonexticon, false)

	local data = {}

	data.img = params[1]
	data.speed = tonumber(params[2])
	data.showTime = tonumber(params[3])

	self._slideItem:startShowDialog(data, callback, callbackobj)
end

function StoryDialogItem:playMagicText(txt, callback, callbackobj)
	gohelper.setActive(self._goline, true)
	self:_showMagicItem(true)
	TaskDispatcher.cancelTask(self._playConAudio, self)
	gohelper.setActive(self._norDiaGO, false)

	self._txt = StoryTool.filterSpTag(txt)
	self._textShowFinished = false
	self._playingAudioId = 0
	self._finishCallback = callback
	self._finishCallbackObj = callbackobj
	self._txtcontentmagic.text = self._txt
	self._txtcontentreshapemagic.text = self._txt

	local x, y, z = transformhelper.getLocalPos(self._txtcontentmagic.transform)

	transformhelper.setLocalPos(self._txtcontentmagic.transform, x, y, 1)
	transformhelper.setLocalPos(self._txtcontentreshapemagic.transform, x, y, 1)

	local delay = self:_getMagicWordShowTime(txt)

	self._magicConTweenId = ZProj.TweenHelper.DOTweenFloat(0, 1, delay, self._magicConUpdate, self._onMagicTextFinished, self, nil, EaseType.Linear)

	self._magicFireAnim:Play("story_magicfont_particle")
	self._reshapeMagicFireAnim:Play("story_magicfont_particle")
	gohelper.setActive(self._magicFireGo, self._stepCo.conversation.effType == StoryEnum.ConversationEffectType.Magic)
	gohelper.setActive(self._reshapeMagicFireGo, self._stepCo.conversation.effType == StoryEnum.ConversationEffectType.ReshapeMagic)
	gohelper.setActive(self._txtcontentmagic.gameObject, self._stepCo.conversation.effType == StoryEnum.ConversationEffectType.Magic)
	gohelper.setActive(self._txtcontentreshapemagic, self._stepCo.conversation.effType == StoryEnum.ConversationEffectType.ReshapeMagic)

	if self._stepCo.conversation.audioDelayTimes[GameLanguageMgr.instance:getVoiceTypeStoryIndex()] < 0.1 then
		self:_playConAudio()
	else
		TaskDispatcher.runDelay(self._playConAudio, self, self._stepCo.conversation.audioDelayTimes[GameLanguageMgr.instance:getVoiceTypeStoryIndex()])
	end

	if delay > 0 then
		self._magicFireAnim.speed = 1 / delay
		self._reshapeMagicFireAnim.speed = 1 / delay
	end
end

function StoryDialogItem:_getMagicWordShowTime(txt)
	local result = string.gsub(txt, "%%", "--------")

	result = string.gsub(result, "%&", "--------")

	local wordSize = LuaUtil.getCharNum(result)
	local speed = 0.1

	if wordSize < 30 then
		speed = 0.2
	end

	if wordSize < 15 then
		speed = 0.5
	end

	if result and string.find(result, "<speed=%d[%d.]*>") then
		local speedTxt = string.sub(result, string.find(result, "<speed=%d[%d.]*>"))

		speed = speedTxt and tonumber(string.match(speedTxt, "%d[%d.]*")) or 1
	end

	return speed * wordSize
end

function StoryDialogItem:_magicConUpdate(value)
	local width = self._stepCo.conversation.effType == StoryEnum.ConversationEffectType.Magic and recthelper.getWidth(self._txtcontentmagic.gameObject.transform) or recthelper.getWidth(self._txtcontentreshapemagic.gameObject.transform)

	if value > (width + 100) / 2215 and width > 1 then
		if self._magicConTweenId then
			ZProj.TweenHelper.KillById(self._magicConTweenId)

			self._magicConTweenId = nil
		end

		self:_onMagicTextFinished()

		return
	end

	local conWidth = 1107.5
	local x, y, z = transformhelper.getLocalPos(self._txtcontentmagic.transform)

	if self._stepCo.conversation.effType == StoryEnum.ConversationEffectType.ReshapeMagic then
		x, y, z = transformhelper.getLocalPos(self._txtcontentreshapemagic.transform)
	end

	local screenWidth, screenheight = UnityEngine.Screen.width, UnityEngine.Screen.height
	local startPosX = 0
	local totalWidth = 1920
	local posX = transformhelper.getLocalPos(self._contentGO.transform)

	totalWidth = 1920 * (1080 * screenWidth / (1920 * screenheight))

	if screenWidth / screenheight >= 1.7777777777777777 then
		startPosX = 0.5 * (1080 * screenWidth / screenheight - 1920) + (960 + posX)
	else
		startPosX = 960 - 0.5 * (1920 - 1080 * screenWidth / screenheight) + posX
	end

	local rate = (startPosX + value * (conWidth + 10)) / totalWidth
	local screenposy = self._stepCo.conversation.effType == StoryEnum.ConversationEffectType.Magic and recthelper.uiPosToScreenPos(self._txtcontentmagic.gameObject.transform, ViewMgr.instance:getUICanvas()).y or recthelper.uiPosToScreenPos(self._txtcontentreshapemagic.gameObject.transform, ViewMgr.instance:getUICanvas()).y
	local psPos = self._stepCo.conversation.effType == StoryEnum.ConversationEffectType.Magic and recthelper.screenPosToAnchorPos(Vector2(rate * screenWidth, screenposy), self._gofirework.transform) or recthelper.screenPosToAnchorPos(Vector2(rate * screenWidth, screenposy), self._goreshapefirework.transform)

	if self._stepCo.conversation.effType == StoryEnum.ConversationEffectType.Magic then
		transformhelper.setLocalPos(self._txtcontentmagic.transform, x, y, 1 - rate)
		transformhelper.setLocalPos(self._magicFireGo.transform, psPos.x, psPos.y, 0)
	else
		transformhelper.setLocalPos(self._txtcontentreshapemagic.transform, x, y, 1 - rate)
		transformhelper.setLocalPos(self._reshapeMagicFireGo.transform, psPos.x, psPos.y, 0)
	end
end

function StoryDialogItem:_magicConFinished()
	local x, y, z = transformhelper.getLocalPos(self._txtcontentmagic.transform)

	transformhelper.setLocalPos(self._txtcontentmagic.transform, x, y, 0)
	transformhelper.setLocalPos(self._txtcontentreshapemagic.transform, x, y, 0)
	gohelper.setActive(self._magicFireGo, false)
	gohelper.setActive(self._reshapeMagicFireGo, false)

	self._magicFireAnim.speed = 1
	self._reshapeMagicFireAnim.speed = 1

	local isLimitNoInteractLock = StoryModel.instance:isLimitNoInteractLock(self._stepCo)

	if self._stepCo.conversation.type == StoryEnum.ConversationType.NoInteract or self._stepCo.conversation.type == StoryEnum.ConversationType.None or isLimitNoInteractLock then
		return
	end

	if self._finishCallback then
		self._finishCallback(self._finishCallbackObj)
	end
end

function StoryDialogItem:playNormalText(txt, callback, callbackobj)
	self._txt = txt
	self._textShowFinished = false

	TaskDispatcher.cancelTask(self._playConAudio, self)
	TaskDispatcher.cancelTask(self._waitSecondFinished, self)

	self._playingAudioId = 0
	self._finishCallback = callback
	self._finishCallbackObj = callbackobj
	self._markIndexs = StoryTool.getMarkTextIndexs(self._txt)
	self._subemtext = StoryTool.filterSpTag(self._txt)
	self._markTop, self._markContent = StoryTool.getMarkTopTextList(self._subemtext)
	self._subemtext = StoryTool.filterMarkTop(self._subemtext)
	self._txtcontentcn.text = string.gsub(self._subemtext, "(<sprite=%d>)", "")
	self._txtcontentmagic.text = ""
	self._txtcontentreshapemagic.text = ""

	if self._stepCo.conversation.effType == StoryEnum.ConversationEffectType.SoftLight then
		self._txtcontentcn.alignment = TMPro.TextAlignmentOptions.Top

		if self._txtcontentcn.fontSharedMaterial:IsKeywordEnabled("UNDERLAY_ON") == false then
			self._txtcontentcn.fontSharedMaterial:EnableKeyword("UNDERLAY_ON")
			self._txtcontentcn.fontSharedMaterial:SetFloat("_BloomFactor", 2.5)

			self._txtcontentcn.fontSharedMaterial.renderQueue = 4995

			local color = Color.New(0, 0, 0, 0.75)

			self._txtcontentcn.fontSharedMaterial:SetColor("_UnderlayColor", color)
			self._txtcontentcn.fontSharedMaterial:SetFloat("_UnderlayOffsetX", 0.143)
			self._txtcontentcn.fontSharedMaterial:SetFloat("_UnderlayOffsetY", -0.1)
			self._txtcontentcn.fontSharedMaterial:SetFloat("_UnderlayDilate", 0.107)
			self._txtcontentcn.fontSharedMaterial:SetFloat("_UnderlaySoftness", 0.447)

			self._txtcontentcn.fontSharedMaterial = self._txtcontentcn.fontMaterial
		end

		StoryTool.enablePostProcess(true)
		PostProcessingMgr.instance:setUIPPValue("localBloomActive", true)
		PostProcessingMgr.instance:setUIPPValue("bloomDiffusion", 5)
		gohelper.setActive(self._goline, false)
		gohelper.setActive(self._goblackbottom, false)
		gohelper.setActive(self._gonexticon, false)
		transformhelper.setLocalPosXY(self._norDiaGO.transform, 475, -50)
	else
		self._txtcontentcn.fontSharedMaterial:DisableKeyword("UNDERLAY_ON")

		self._txtcontentcn.alignment = TMPro.TextAlignmentOptions.TopLeft
		self._txtcontentcn.fontSharedMaterial = self._fontNormalMat

		self._txtcontentcn.fontSharedMaterial:SetFloat("_BloomFactor", 0)
		PostProcessingMgr.instance:setUIPPValue("localBloomActive", false)
		PostProcessingMgr.instance:setUIPPValue("bloomDiffusion", 7)

		local showContent = self._stepCo.conversation.type ~= StoryEnum.ConversationType.IrregularShake

		gohelper.setActive(self._goline, showContent)
		gohelper.setActive(self._goblackbottom, showContent)
		gohelper.setActive(self._gonexticon, showContent)
		transformhelper.setLocalPosXY(self._norDiaGO.transform, 550, 0)
	end

	self:_checkPlayGlitch(self._subemtext)

	self._subemtext = string.gsub(self._subemtext, "<glitch>", "<i><b>")
	self._subemtext = string.gsub(self._subemtext, "</glitch>", "</i></b>")

	if self._stepCo.conversation.effType == StoryEnum.ConversationEffectType.Hard then
		self:_playHardIn()
	else
		self:_playGradualIn()
	end
end

function StoryDialogItem:_checkPlayGlitch(txt)
	local hasGlitch = string.match(txt, "<glitch>")

	gohelper.setActive(self._glitchGo, hasGlitch)

	if not hasGlitch then
		return
	end

	StoryTool.enablePostProcess(true)

	local lineTxt = string.gsub(txt, "<glitch>", "")

	lineTxt = string.gsub(lineTxt, "</glitch>", "")

	local textInfo = self._txtcontentcn:GetTextInfo(lineTxt)
	local particleSystems = {}
	local goGlitchScreen = gohelper.findChild(self._glitchGo, "part_screen")

	gohelper.setActive(goGlitchScreen, false)

	local goGlitchUp = gohelper.findChild(self._glitchGo, "part_up")

	gohelper.setActive(goGlitchUp, true)

	local parGlitchUp = goGlitchUp:GetComponent(typeof(UnityEngine.ParticleSystem))

	table.insert(particleSystems, parGlitchUp)

	local goGlitchDown = gohelper.findChild(self._glitchGo, "part_down")
	local parGlitchDown = goGlitchDown:GetComponent(typeof(UnityEngine.ParticleSystem))

	table.insert(particleSystems, parGlitchDown)
	gohelper.setActive(goGlitchDown, textInfo.lineCount > 1)

	local uiCamera = CameraMgr.instance:getUICamera()
	local characterInfo = textInfo.characterInfo
	local lineLength = recthelper.getWidth(self._txtcontentcn.transform) + 121.8684
	local lineDatas = {}
	local glitchWords = string.split(txt, "\n")

	if #glitchWords > 1 then
		for index = 1, #glitchWords do
			local curGlitchTxt = glitchWords[index]
			local glitchStartIndex = string.find(curGlitchTxt, "<glitch>")
			local lineHasGlitch = string.find(curGlitchTxt, "<glitch>")
			local data = {}

			if not lineHasGlitch then
				data.hasGlitch = false

				table.insert(lineDatas, data)
			else
				local startTxt = string.sub(curGlitchTxt, 1, glitchStartIndex - 1)
				local subGlicthTxt = string.gsub(curGlitchTxt, "<glitch>", "")
				local glitchEndIndex = string.find(subGlicthTxt, "</glitch>")
				local endTxt = string.sub(subGlicthTxt, 1, glitchEndIndex - 1)
				local curLineText = string.gsub(subGlicthTxt, "</glitch>", "")
				local lineInfo = textInfo.lineInfo[index - 1]

				data.hasGlitch = true
				data.firstCharacterIndex = lineInfo.firstCharacterIndex
				data.startIndex = utf8.len(startTxt)
				data.endIndex = utf8.len(endTxt)
				data.lineTxt = curLineText
				data.glitchTxt = curGlitchTxt

				table.insert(lineDatas, data)
			end
		end
	else
		for index = 1, textInfo.lineCount do
			local lineInfo = textInfo.lineInfo[index - 1]
			local curLineText = LuaUtil.subString(lineTxt, lineInfo.firstCharacterIndex + 1, lineInfo.firstCharacterIndex + lineInfo.characterCount + 1)
			local startIndex = index > 1 and lineDatas[index - 1].endIndex + 1 or 0
			local checkEndIndex = string.len(curLineText) + string.len("<glitch>")
			local checkGlitchTxt = index > 1 and string.gsub(txt, lineDatas[index - 1].glitchTxt, "") or string.sub(txt, startIndex, checkEndIndex)
			local lineHasGlitch = string.find(checkGlitchTxt, "<glitch>")
			local endIndex = lineHasGlitch and string.len(curLineText) + string.len("<glitch>") + string.len("</glitch>") or string.len(curLineText)
			local curGlitchTxt = index > 1 and string.gsub(txt, lineDatas[index - 1].glitchTxt, "") or string.sub(txt, startIndex, endIndex)
			local glitchStartIndex = string.find(curGlitchTxt, "<glitch>")
			local data = {}

			if not lineHasGlitch then
				data.hasGlitch = false

				table.insert(lineDatas, data)
			else
				local startTxt = string.sub(curGlitchTxt, 1, glitchStartIndex - 1)
				local subGlicthTxt = string.gsub(curGlitchTxt, "<glitch>", "")
				local glitchEndIndex = string.find(subGlicthTxt, "</glitch>")
				local endTxt = string.sub(subGlicthTxt, 1, glitchEndIndex - 1)

				data.hasGlitch = true
				data.firstCharacterIndex = lineInfo.firstCharacterIndex
				data.startIndex = utf8.len(startTxt)
				data.endIndex = utf8.len(endTxt)
				data.lineTxt = curLineText
				data.glitchTxt = curGlitchTxt

				table.insert(lineDatas, data)
			end
		end
	end

	for i = 1, #lineDatas do
		local x, y, z = transformhelper.getLocalPos(particleSystems[i].transform)

		if not lineDatas[i].hasGlitch then
			transformhelper.setLocalPos(particleSystems[i].transform, -10000, y, z)
		else
			local firstChar = characterInfo[0]
			local startGlitchChar = characterInfo[lineDatas[i].startIndex]
			local endGlitchChar = characterInfo[lineDatas[i].endIndex - 1]
			local firstBL = uiCamera:WorldToScreenPoint(self._txtcontentcn.transform:TransformPoint(firstChar.bottomLeft))
			local startBL = uiCamera:WorldToScreenPoint(self._txtcontentcn.transform:TransformPoint(startGlitchChar.bottomLeft))
			local endBR = uiCamera:WorldToScreenPoint(self._txtcontentcn.transform:TransformPoint(endGlitchChar.bottomRight))
			local w = UnityEngine.Screen.width
			local h = UnityEngine.Screen.height
			local percent = math.min(1, 0.9 * w / (1.6 * h))
			local startTxtLength = 1080 * (startBL.x - firstBL.x) / (h * percent)
			local glitchTxtLength = 1144.8 * (endBR.x - startBL.x) / (h * percent)
			local scaleA = startTxtLength / lineLength
			local scaleB = glitchTxtLength / lineLength
			local posX = 647 * (2 * scaleA + scaleB)
			local x, y, z = transformhelper.getLocalPos(particleSystems[i].transform)

			transformhelper.setLocalPos(particleSystems[i].transform, posX, y, z)

			local shapeX = 12 * scaleB * percent
			local shapeY = 0.4 * percent

			particleSystems[i].shape.scale = Vector3(shapeX, shapeY, 0)

			ZProj.ParticleSystemHelper.SetMaxParticles(particleSystems[i], math.floor(30 * scaleB))
		end
	end
end

function StoryDialogItem:_playHardIn()
	self:_showMagicItem(false)
	gohelper.setActive(self._norDiaGO, true)
	self:conFinished()
end

function StoryDialogItem:_playGradualIn()
	self._conMat:EnableKeyword("_GRADUAL_ON")
	self._conMat:DisableKeyword("_DISSOLVE_ON")
	self._markTopMat:EnableKeyword("_GRADUAL_ON")
	self._markTopMat:DisableKeyword("_DISSOLVE_ON")

	local height = UnityEngine.Screen.height

	self._conMat:SetFloat(self._LineMinYId, height)
	self._conMat:SetFloat(self._LineMaxYId, height)
	self._markTopMat:SetFloat(self._LineMinYId, height)
	self._markTopMat:SetFloat(self._LineMaxYId, height)

	self._subMeshs = {}

	local subMeshs = self._txtcontentcn.gameObject:GetComponentsInChildren(typeof(TMPro.TMP_SubMeshUI), true)

	if subMeshs then
		local iter = subMeshs:GetEnumerator()

		while iter:MoveNext() do
			local subMesh = iter.Current.gameObject:GetComponent(typeof(TMPro.TMP_SubMeshUI))

			table.insert(self._subMeshs, subMesh)
		end
	end

	for _, v in pairs(self._subMeshs) do
		if v.materialForRendering then
			v.materialForRendering:SetFloat(self._LineMinYId, height)
			v.materialForRendering:SetFloat(self._LineMaxYId, height)
			v.materialForRendering:EnableKeyword("_GRADUAL_ON")
		end
	end

	self._dotMat:SetFloat(self._LineMinYId, height)
	self._dotMat:SetFloat(self._LineMaxYId, height)
	self:_showMagicItem(false)
	gohelper.setActive(self._norDiaGO, true)

	local x, y, z = transformhelper.getLocalPos(self._txtcontentcn.transform)

	transformhelper.setLocalPos(self._txtcontentcn.transform, x, y, 1)
	TaskDispatcher.cancelTask(self._delayShow, self)
	TaskDispatcher.runDelay(self._delayShow, self, 0.05)
end

function StoryDialogItem:_showMagicItem(show)
	if show then
		if self._magicFireGo then
			StoryTool.enablePostProcess(true)
			gohelper.setActive(self._reshapeMagicFireGo, self._stepCo.conversation.effType == StoryEnum.ConversationEffectType.ReshapeMagic)
		end

		if self._reshapeMagicFireGo then
			StoryTool.enablePostProcess(true)
			gohelper.setActive(self._reshapeMagicFireGo, self._stepCo.conversation.effType == StoryEnum.ConversationEffectType.ReshapeMagic)
		end
	else
		self._txtcontentmagic.text = ""
		self._txtcontentreshapemagic.text = ""

		gohelper.setActive(self._magicFireGo, false)
		gohelper.setActive(self._reshapeMagicFireGo, false)
	end
end

function StoryDialogItem:_delayShow()
	self._conMark:SetMarks(self._markIndexs)
	self._conMark:SetMarksTop(self._markTop, self._markContent)

	self._textInfo = self._txtcontentcn:GetTextInfo(self._subemtext)
	self._lineInfoList = {}

	local totalVisibleCharacterCount = 0

	for i = 1, self._textInfo.lineCount do
		local lineInfo = self._textInfo.lineInfo[i - 1]
		local prevLineTotalCount = totalVisibleCharacterCount + 1

		totalVisibleCharacterCount = totalVisibleCharacterCount + lineInfo.visibleCharacterCount

		table.insert(self._lineInfoList, {
			lineInfo,
			prevLineTotalCount,
			totalVisibleCharacterCount
		})
	end

	self._contentX, self._contentY, _ = transformhelper.getLocalPos(self._txtcontentcn.transform)
	self._curLine = nil

	local delay = self:_getDelayTime(totalVisibleCharacterCount)

	if self._conTweenId then
		ZProj.TweenHelper.KillById(self._conTweenId)

		self._conTweenId = nil
	end

	if self._stepCo.conversation.audioDelayTimes[GameLanguageMgr.instance:getVoiceTypeStoryIndex()] < 0.1 then
		self:_playConAudio()
	else
		TaskDispatcher.runDelay(self._playConAudio, self, self._stepCo.conversation.audioDelayTimes[GameLanguageMgr.instance:getVoiceTypeStoryIndex()])
	end

	self._conTweenId = ZProj.TweenHelper.DOTweenFloat(1, totalVisibleCharacterCount, delay, self._conUpdate, self._onTextFinished, self, nil, EaseType.Linear)
end

function StoryDialogItem:_getDelayTime(characterCount)
	local speed = 1

	if self._txt and string.find(self._txt, "<speed=%d[%d.]*>") then
		local speedTxt = string.sub(self._txt, string.find(self._txt, "<speed=%d[%d.]*>"))

		speed = speedTxt and tonumber(string.match(speedTxt, "%d[%d.]*")) or 1
	end

	local time = 0.08 * characterCount
	local curStoryIndex = GameLanguageMgr.instance:getLanguageTypeStoryIndex()

	if curStoryIndex == LanguageEnum.LanguageStoryType.EN then
		time = time * 0.67
	end

	time = time / speed

	return time
end

function StoryDialogItem:_playConAudio()
	if self._isLogStop then
		return
	end

	self:stopConAudio()

	if StoryModel.instance:isSpecialVideoPlaying() then
		return
	end

	self._conAudioId = self._stepCo.conversation.audios[1] or 0

	if self._conAudioId ~= 0 then
		local param = {}

		param.loopNum = 1
		param.fadeInTime = 0
		param.fadeOutTime = 0
		param.volume = 100
		param.audioGo = self:_getDialogGo()
		param.callback = self._onConAudioFinished
		param.callbackTarget = self
		self._playingAudioId = self._conAudioId

		local isS01Story = StoryModel.instance:isS01Story()
		local curVoice = GameConfig:GetCurVoiceShortcut()

		if curVoice == "jp" or curVoice == "kr" then
			if isS01Story then
				param.audioLang = curVoice

				AudioEffectMgr.instance:playAudio(self._conAudioId, param, param.audioLang)
			else
				AudioEffectMgr.instance:playAudio(self._conAudioId, param)
			end
		else
			AudioEffectMgr.instance:playAudio(self._conAudioId, param)
		end
	else
		self._playingAudioId = 0
	end

	self._hasLowPassAudio = false

	if #self._stepCo.conversation.audios > 1 then
		for _, v in pairs(self._stepCo.conversation.audios) do
			if v == AudioEnum.Story.Play_Lowpass then
				self._hasLowPassAudio = true

				AudioMgr.instance:trigger(AudioEnum.Story.Play_Lowpass)

				return
			end
		end
	end
end

function StoryDialogItem:_getDialogGo()
	local audioGo = self._roleMidAudioGo

	if #self._stepCo.heroList > 0 and self._stepCo.conversation.showList[1] then
		if not self._stepCo.heroList[self._stepCo.conversation.showList[1] + 1] then
			return audioGo
		end

		local pos = self._stepCo.heroList[self._stepCo.conversation.showList[1] + 1].heroDir

		if pos and pos == 0 then
			audioGo = self._roleLeftAudioGo
		end

		if pos and pos == 2 then
			audioGo = self._roleRightAudioGo
		end
	end

	return audioGo
end

function StoryDialogItem:_onTextFinished()
	if self._magicConTweenId then
		ZProj.TweenHelper.KillById(self._magicConTweenId)
		gohelper.setActive(self._magicFireGo, false)
		gohelper.setActive(self._reshapeMagicFireGo, false)

		self._magicFireAnim.speed = 1
		self._reshapeMagicFireAnim.speed = 1
		self._magicConTweenId = nil
	end

	if self._conTweenId then
		ZProj.TweenHelper.KillById(self._conTweenId)

		self._conTweenId = nil
	end

	local x, y, z = transformhelper.getLocalPos(self._txtcontentcn.transform)

	transformhelper.setLocalPos(self._txtcontentcn.transform, x, y, 0)

	local x, y, z = transformhelper.getLocalPos(self._txtcontentmagic.transform)

	transformhelper.setLocalPos(self._txtcontentmagic.transform, x, y, 0)
	transformhelper.setLocalPos(self._txtcontentreshapemagic.transform, x, y, 0)
	self._conMat:DisableKeyword("_GRADUAL_ON")
	self._markTopMat:DisableKeyword("_GRADUAL_ON")

	for _, v in pairs(self._subMeshs) do
		if v.materialForRendering then
			v.materialForRendering:DisableKeyword("_GRADUAL_ON")
		end
	end

	self._textShowFinished = true

	local isAuto = StoryModel.instance:isStoryAuto()
	local isLimitNoInteractLock = StoryModel.instance:isLimitNoInteractLock(self._stepCo)

	if self._stepCo.conversation.type ~= StoryEnum.ConversationType.NoInteract and self._stepCo.conversation.type ~= StoryEnum.ConversationType.None and not isLimitNoInteractLock then
		isAuto = isAuto or self._stepCo.conversation.isAuto
	end

	if not isAuto or self._playingAudioId == 0 then
		self:conFinished()
	end
end

function StoryDialogItem:_onMagicTextFinished()
	self._textShowFinished = true

	self:_magicConFinished()
end

function StoryDialogItem:_onConAudioFinished(audioId)
	if self._textShowFinished then
		if self._stepCo.conversation.effType == StoryEnum.ConversationEffectType.Magic or self._stepCo.conversation.effType == StoryEnum.ConversationEffectType.ReshapeMagic then
			self:_magicConFinished()
		else
			self:conFinished()
		end
	end

	if self._playingAudioId == audioId then
		self._playingAudioId = 0
	end
end

function StoryDialogItem:stopConAudio()
	if self._hasLowPassAudio then
		AudioMgr.instance:trigger(AudioEnum.Story.Stop_Lowpass)
	end

	if self._isLogStop then
		return
	end

	self._playingAudioId = 0

	if self._conAudioId ~= 0 and self._conAudioId then
		AudioEffectMgr.instance:stopAudio(self._conAudioId, 0)
	end
end

function StoryDialogItem:_conUpdate(value)
	local screenWidth = UnityEngine.Screen.width
	local contentTransform = self._txtcontentcn.transform
	local uiCamera = CameraMgr.instance:getUICamera()

	self._subMeshs = {}

	local subMeshs = self._txtcontentcn.gameObject:GetComponentsInChildren(typeof(TMPro.TMP_SubMeshUI), true)

	if subMeshs then
		local iter = subMeshs:GetEnumerator()

		while iter:MoveNext() do
			local subMesh = iter.Current.gameObject:GetComponent(typeof(TMPro.TMP_SubMeshUI))

			table.insert(self._subMeshs, subMesh)
		end
	end

	for i, v in ipairs(self._lineInfoList) do
		local lineInfo = v[1]
		local startCount = v[2]
		local endCount = v[3]

		if startCount <= value and value <= endCount then
			local characterInfo = self._textInfo.characterInfo
			local firstChar = characterInfo[lineInfo.firstVisibleCharacterIndex]
			local lastChar = characterInfo[lineInfo.lastVisibleCharacterIndex]
			local firstBL = uiCamera:WorldToScreenPoint(contentTransform:TransformPoint(firstChar.bottomLeft))
			local maxBL = firstBL
			local minbly = firstBL.y

			for j = lineInfo.firstVisibleCharacterIndex, lineInfo.lastVisibleCharacterIndex do
				local char = characterInfo[j]
				local tl = uiCamera:WorldToScreenPoint(contentTransform:TransformPoint(char.bottomLeft))

				if minbly > tl.y then
					minbly = tl.y
				end
			end

			maxBL.y = minbly

			local firstTL = uiCamera:WorldToScreenPoint(contentTransform:TransformPoint(firstChar.topLeft))
			local maxTL = firstTL
			local maxtly = firstTL.y

			for j = lineInfo.firstVisibleCharacterIndex, lineInfo.lastVisibleCharacterIndex do
				local char = characterInfo[j]
				local tl = uiCamera:WorldToScreenPoint(contentTransform:TransformPoint(char.topLeft))

				if maxtly < tl.y then
					maxtly = tl.y
				end
			end

			maxTL.y = maxtly

			local lastBR = uiCamera:WorldToScreenPoint(contentTransform:TransformPoint(lastChar.bottomRight))

			if i == 1 then
				self._conMat:SetFloat(self._LineMinYId, maxBL.y)
				self._conMat:SetFloat(self._LineMaxYId, maxTL.y + 10)
				self._markTopMat:SetFloat(self._LineMinYId, maxBL.y - 100)
				self._markTopMat:SetFloat(self._LineMaxYId, maxTL.y - 90)

				for _, mesh in pairs(self._subMeshs) do
					if mesh.materialForRendering then
						mesh.materialForRendering:SetFloat(self._LineMinYId, maxBL.y)
						mesh.materialForRendering:SetFloat(self._LineMaxYId, maxTL.y + 10)
						mesh.materialForRendering:EnableKeyword("_GRADUAL_ON")
					end
				end

				self._dotMat:SetFloat(self._LineMinYId, maxBL.y - 10)
				self._dotMat:SetFloat(self._LineMaxYId, maxTL.y)
			else
				self._conMat:SetFloat(self._LineMinYId, maxBL.y)
				self._conMat:SetFloat(self._LineMaxYId, maxTL.y)
				self._markTopMat:SetFloat(self._LineMinYId, maxBL.y)
				self._markTopMat:SetFloat(self._LineMaxYId, maxTL.y)

				for _, mesh in pairs(self._subMeshs) do
					if mesh.materialForRendering then
						mesh.materialForRendering:SetFloat(self._LineMinYId, maxBL.y)
						mesh.materialForRendering:SetFloat(self._LineMaxYId, maxTL.y)
						mesh.materialForRendering:EnableKeyword("_GRADUAL_ON")
					end
				end

				self._dotMat:SetFloat(self._LineMinYId, maxBL.y - 10)
				self._dotMat:SetFloat(self._LineMaxYId, maxTL.y)
			end

			local go = self._txtcontentcn.gameObject

			gohelper.setActive(go, false)
			gohelper.setActive(go, true)

			local rate = startCount == endCount and 1 or (value - startCount) / (endCount - startCount)
			local screenPosX = Mathf.Lerp(maxBL.x - 10, lastBR.x + 10, rate)
			local posZ = self._stepCo.conversation.effType == StoryEnum.ConversationEffectType.SoftLight and 0 or 1 - screenPosX / screenWidth

			transformhelper.setLocalPos(self._txtcontentcn.transform, self._contentX, self._contentY, posZ)

			if self._stepCo.conversation.effType == StoryEnum.ConversationEffectType.SoftLight then
				self._conMat:SetFloat(self._LineMinYId, 0)
				self._conMat:SetFloat(self._LineMaxYId, 0)

				if #self._lineInfoList > 1 then
					transformhelper.setLocalPosXY(self._norDiaGO.transform, 475, 50 * (#self._lineInfoList - 2))
				end
			end
		end
	end
end

function StoryDialogItem:conFinished()
	self._textShowFinished = true

	if self._stepCo and (self._stepCo.conversation.type == StoryEnum.ConversationType.NoInteract or self._stepCo.conversation.type == StoryEnum.ConversationType.None) then
		return
	end

	if self._magicConTweenId then
		ZProj.TweenHelper.KillById(self._magicConTweenId)
		gohelper.setActive(self._magicFireGo, false)
		gohelper.setActive(self._reshapeMagicFireGo, false)

		self._magicFireAnim.speed = 1
		self._reshapeMagicFireAnim.speed = 1
		self._magicConTweenId = nil
	end

	if self._conTweenId then
		ZProj.TweenHelper.KillById(self._conTweenId)

		self._conTweenId = nil
	end

	self._conMat:SetFloat(self._LineMinYId, 0)
	self._conMat:SetFloat(self._LineMaxYId, 0)
	self._markTopMat:SetFloat(self._LineMinYId, 0)
	self._markTopMat:SetFloat(self._LineMaxYId, 0)

	self._subMeshs = {}

	local subMeshs = self._txtcontentcn.gameObject:GetComponentsInChildren(typeof(TMPro.TMP_SubMeshUI), true)

	if subMeshs then
		local iter = subMeshs:GetEnumerator()

		while iter:MoveNext() do
			local subMesh = iter.Current.gameObject:GetComponent(typeof(TMPro.TMP_SubMeshUI))

			table.insert(self._subMeshs, subMesh)
		end
	end

	for _, v in pairs(self._subMeshs) do
		if v.materialForRendering then
			v.materialForRendering:SetFloat(self._LineMinYId, 0)
			v.materialForRendering:SetFloat(self._LineMaxYId, 0)
		end
	end

	local x, y, z = transformhelper.getLocalPos(self._txtcontentcn.transform)

	transformhelper.setLocalPos(self._txtcontentcn.transform, x, y, 0)

	local x, y, z = transformhelper.getLocalPos(self._txtcontentmagic.transform)

	transformhelper.setLocalPos(self._txtcontentmagic.transform, x, y, 0)
	transformhelper.setLocalPos(self._txtcontentreshapemagic.transform, x, y, 0)
	self._conMat:DisableKeyword("_GRADUAL_ON")
	self._markTopMat:DisableKeyword("_GRADUAL_ON")

	if self._finishCallback then
		self._finishCallback(self._finishCallbackObj)
	end
end

function StoryDialogItem:playNorDialogFadeIn(callback, callbackobj)
	ZProj.TweenHelper.DoFade(self._txtcontentcn, 0, 1, 2, function()
		if callback then
			callback(callbackobj)
		end
	end, nil, nil, EaseType.Linear)
end

function StoryDialogItem:playWordByWord(callback, callbackobj)
	self._txtcontentcn.text = ""

	ZProj.TweenHelper.DOText(self._txtcontentcn, self._diatxt, 2, function()
		if callback then
			callback(callbackobj)
		end
	end)
end

function StoryDialogItem:startAutoEnterNext()
	if self._playingAudioId == 0 and self._textShowFinished then
		if self._stepCo.conversation.effType == StoryEnum.ConversationEffectType.Magic or self._stepCo.conversation.effType == StoryEnum.ConversationEffectType.ReshapeMagic then
			self:_magicConFinished()
		else
			self:conFinished()
		end
	end
end

function StoryDialogItem:checkAutoEnterNext(callback, callbackobj)
	self._diaFinishedCallback = callback
	self._diaFinishedCallbackObj = callbackobj

	TaskDispatcher.cancelTask(self._onSecond, self)
	TaskDispatcher.cancelTask(self._waitSecondFinished, self)
	TaskDispatcher.runRepeat(self._onSecond, self, 0.1)
end

function StoryDialogItem:_onSecond()
	if self._playingAudioId == 0 and self._textShowFinished then
		TaskDispatcher.cancelTask(self._onSecond, self)
		TaskDispatcher.cancelTask(self._waitSecondFinished, self)
		TaskDispatcher.runDelay(self._waitSecondFinished, self, 2)
	end
end

function StoryDialogItem:isAudioPlaying()
	return self._playingAudioId ~= 0
end

function StoryDialogItem:_waitSecondFinished()
	if self._diaFinishedCallback then
		self._diaFinishedCallback(self._diaFinishedCallbackObj)
	end
end

function StoryDialogItem:storyFinished()
	self._finishCallback = nil
	self._finishCallbackObj = nil
end

function StoryDialogItem:destroy()
	self._txtcontentcn.fontSharedMaterial = self._fontNormalMat

	self:_removeEvent()
	TaskDispatcher.cancelTask(self._playConAudio, self)
	TaskDispatcher.cancelTask(self._onSecond, self)
	TaskDispatcher.cancelTask(self._waitSecondFinished, self)
	self:stopConAudio()

	if self._slideItem then
		self._slideItem:destroy()

		self._slideItem = nil
	end

	if self._conTweenId then
		ZProj.TweenHelper.KillById(self._conTweenId)

		self._conTweenId = nil
	end

	if self._magicConTweenId then
		ZProj.TweenHelper.KillById(self._magicConTweenId)

		self._magicConTweenId = nil
	end

	if self._effLoader then
		self._effLoader:dispose()

		self._effLoader = nil
	end

	TaskDispatcher.cancelTask(self._delayShow, self)

	self._finishCallback = nil
	self._finishCallbackObj = nil

	self._conMat:DisableKeyword("_GRADUAL_ON")
	self._markTopMat:DisableKeyword("_GRADUAL_ON")
	self:_removeEvent()

	if self._matLoader then
		self._matLoader:dispose()

		self._matLoader = nil
	end
end

return StoryDialogItem
