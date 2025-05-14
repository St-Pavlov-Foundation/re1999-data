module("modules.logic.story.view.StoryDialogItem", package.seeall)

local var_0_0 = class("StoryDialogItem")

function var_0_0.init(arg_1_0, arg_1_1)
	arg_1_0._conGo = arg_1_1
	arg_1_0._gonexticon = gohelper.findChild(arg_1_1, "nexticon")
	arg_1_0._goconversation = gohelper.findChild(arg_1_1, "#go_conversation")
	arg_1_0._goblackbottom = gohelper.findChild(arg_1_1, "#go_conversation/blackBottom")
	arg_1_0._contentGO = gohelper.findChild(arg_1_1, "#go_conversation/#go_contents")
	arg_1_0._goline = gohelper.findChild(arg_1_0._contentGO, "line")
	arg_1_0._norDiaGO = gohelper.findChild(arg_1_0._contentGO, "go_normalcontent")
	arg_1_0._txtcontentcn = gohelper.findChildText(arg_1_0._norDiaGO, "txt_contentcn")
	arg_1_0._conMat = arg_1_0._txtcontentcn.fontMaterial

	local var_1_0 = UnityEngine.Shader

	arg_1_0._LineMinYId = var_1_0.PropertyToID("_LineMinY")
	arg_1_0._LineMaxYId = var_1_0.PropertyToID("_LineMaxY")
	arg_1_0._txtdot = gohelper.findChild(arg_1_0._norDiaGO, "txt_contentcn/storytxtdot")
	arg_1_0._txtmarktop = gohelper.findChildText(arg_1_0._norDiaGO, "txt_contentcn/storymarktop")
	arg_1_0._dotMat = arg_1_0._txtdot.transform:GetComponent(gohelper.Type_Image).material
	arg_1_0._markTopMat = arg_1_0._txtmarktop.fontMaterial
	arg_1_0._conMark = gohelper.onceAddComponent(arg_1_0._txtcontentcn.gameObject, typeof(ZProj.TMPMark))

	arg_1_0._conMark:SetMarkGo(arg_1_0._txtdot)
	arg_1_0._conMark:SetMarkTopGo(arg_1_0._txtmarktop.gameObject)

	arg_1_0._magicDiaGO = gohelper.findChild(arg_1_0._contentGO, "go_magiccontent")
	arg_1_0._txtcontentmagic = gohelper.findChildText(arg_1_0._magicDiaGO, "txt_contentmagic")
	arg_1_0._gofirework = gohelper.findChild(arg_1_0._magicDiaGO, "txt_contentmagic/go_firework")
	arg_1_0._txtcontentreshapemagic = gohelper.findChildText(arg_1_0._magicDiaGO, "txt_contentreshapemagic")
	arg_1_0._goreshapefirework = gohelper.findChild(arg_1_0._magicDiaGO, "txt_contentreshapemagic/go_reshapefirework")

	arg_1_0:_showMagicItem(false)

	arg_1_0._goslidecontent = gohelper.findChild(arg_1_1, "#go_slidecontent")
	arg_1_0._slideItem = StoryDialogSlideItem.New()

	arg_1_0._slideItem:init(arg_1_0._goslidecontent)
	arg_1_0._slideItem:hideDialog()

	local var_1_1 = ViewMgr.instance:getContainer(ViewName.StoryView).viewGO

	arg_1_0._roleAudioGo = gohelper.findChild(var_1_1, "go_roleaudio")
	arg_1_0._roleLeftAudioGo = gohelper.findChild(arg_1_0._roleAudioGo, "left")
	arg_1_0._roleMidAudioGo = gohelper.findChild(arg_1_0._roleAudioGo, "middle")
	arg_1_0._roleRightAudioGo = gohelper.findChild(arg_1_0._roleAudioGo, "right")
	arg_1_0._fontNormalMat = arg_1_0._txtcontentcn.fontSharedMaterial

	arg_1_0:_loadRes()
	arg_1_0:_addEvent()
end

function var_0_0._loadRes(arg_2_0)
	arg_2_0._magicFirePath = ResUrl.getEffect("story/story_magicfont_particle")
	arg_2_0._reshapeMagicFirePath = ResUrl.getEffect("story/story_magicfont_particle_dark")
	arg_2_0._glitchPath = ResUrl.getEffect("story/v2a6_fontglitch")
	arg_2_0._effLoader = MultiAbLoader.New()

	arg_2_0._effLoader:addPath(arg_2_0._magicFirePath)
	arg_2_0._effLoader:addPath(arg_2_0._reshapeMagicFirePath)
	arg_2_0._effLoader:addPath(arg_2_0._glitchPath)
	arg_2_0._effLoader:startLoad(arg_2_0._magicFireEffectLoaded, arg_2_0)
end

function var_0_0._magicFireEffectLoaded(arg_3_0, arg_3_1)
	local var_3_0 = arg_3_1:getAssetItem(arg_3_0._magicFirePath)

	arg_3_0._magicFireGo = gohelper.clone(var_3_0:GetResource(arg_3_0._magicFirePath), arg_3_0._gofirework)

	gohelper.setActive(arg_3_0._magicFireGo, false)

	arg_3_0._magicFireAnim = arg_3_0._magicFireGo:GetComponent(typeof(UnityEngine.Animator))

	local var_3_1 = arg_3_1:getAssetItem(arg_3_0._reshapeMagicFirePath)

	arg_3_0._reshapeMagicFireGo = gohelper.clone(var_3_1:GetResource(arg_3_0._reshapeMagicFirePath), arg_3_0._goreshapefirework)

	gohelper.setActive(arg_3_0._reshapeMagicFireGo, false)

	arg_3_0._reshapeMagicFireAnim = arg_3_0._reshapeMagicFireGo:GetComponent(typeof(UnityEngine.Animator))

	local var_3_2 = arg_3_1:getAssetItem(arg_3_0._glitchPath)

	arg_3_0._glitchGo = gohelper.clone(var_3_2:GetResource(arg_3_0._glitchPath), arg_3_0._norDiaGO)

	gohelper.setActive(arg_3_0._glitchGo, false)
end

function var_0_0._addEvent(arg_4_0)
	StoryController.instance:registerCallback(StoryEvent.LogSelected, arg_4_0._btnlogOnClick, arg_4_0)
	ViewMgr.instance:registerCallback(ViewEvent.OnCloseView, arg_4_0._checkCloseView, arg_4_0)
end

function var_0_0._removeEvent(arg_5_0)
	StoryController.instance:unregisterCallback(StoryEvent.LogSelected, arg_5_0._btnlogOnClick, arg_5_0)
	ViewMgr.instance:unregisterCallback(ViewEvent.OnCloseView, arg_5_0._checkCloseView, arg_5_0)
end

function var_0_0._checkCloseView(arg_6_0, arg_6_1)
	if arg_6_1 == ViewName.StoryLogView then
		arg_6_0._isLogStop = false
	end
end

function var_0_0._btnlogOnClick(arg_7_0, arg_7_1)
	arg_7_0._isLogStop = true

	if arg_7_1 == arg_7_0._conAudioId then
		return
	end

	arg_7_0._playingAudioId = 0

	if arg_7_0._conAudioId ~= 0 and arg_7_0._conAudioId then
		AudioEffectMgr.instance:stopAudio(arg_7_0._conAudioId, 0)
	end
end

function var_0_0.hideDialog(arg_8_0)
	if arg_8_0._conTweenId then
		ZProj.TweenHelper.KillById(arg_8_0._conTweenId)

		arg_8_0._conTweenId = nil
	end

	if arg_8_0._magicConTweenId then
		ZProj.TweenHelper.KillById(arg_8_0._magicConTweenId)

		arg_8_0._magicConTweenId = nil
	end

	gohelper.setActive(arg_8_0._norDiaGO, false)

	local var_8_0, var_8_1, var_8_2 = transformhelper.getLocalPos(arg_8_0._txtcontentcn.transform)

	transformhelper.setLocalPos(arg_8_0._txtcontentcn.transform, var_8_0, var_8_1, 1)

	arg_8_0._txtcontentcn.text = ""

	arg_8_0._conMat:DisableKeyword("_GRADUAL_ON")
	arg_8_0._markTopMat:DisableKeyword("_GRADUAL_ON")
	TaskDispatcher.cancelTask(arg_8_0._delayShow, arg_8_0)
	arg_8_0:_showMagicItem(false)

	arg_8_0._finishCallback = nil
	arg_8_0._finishCallbackObj = nil

	local var_8_3, var_8_4, var_8_5 = transformhelper.getLocalPos(arg_8_0._txtcontentmagic.transform)

	transformhelper.setLocalPos(arg_8_0._txtcontentmagic.transform, var_8_3, var_8_4, 1)
	transformhelper.setLocalPos(arg_8_0._txtcontentreshapemagic.transform, var_8_3, var_8_4, 1)

	arg_8_0._txtcontentmagic.text = ""
	arg_8_0._txtcontentreshapemagic.text = ""
end

function var_0_0.playDialog(arg_9_0, arg_9_1, arg_9_2, arg_9_3, arg_9_4)
	arg_9_0._stepCo = arg_9_2

	local var_9_0 = arg_9_0._stepCo.conversation.audios[1] or 0
	local var_9_1 = StoryModel.instance:getStoryTxtByVoiceType(arg_9_1, var_9_0)

	arg_9_0:clearSlideDialog()

	if arg_9_0._stepCo.conversation.type == StoryEnum.ConversationType.SlideDialog then
		arg_9_0:playSlideDialog(var_9_1, arg_9_3, arg_9_4)

		return
	end

	arg_9_0._slideItem:hideDialog()
	gohelper.setActive(arg_9_0._goconversation, true)
	gohelper.setActive(arg_9_0._gonexticon, true)

	if arg_9_0._stepCo.conversation.effType == StoryEnum.ConversationEffectType.Magic or arg_9_0._stepCo.conversation.effType == StoryEnum.ConversationEffectType.ReshapeMagic then
		arg_9_0:playMagicText(var_9_1, arg_9_3, arg_9_4)
	else
		arg_9_0:playNormalText(var_9_1, arg_9_3, arg_9_4)
	end
end

function var_0_0.clearSlideDialog(arg_10_0)
	if arg_10_0._slideItem then
		arg_10_0._slideItem:clearSlideDialog()
	end
end

function var_0_0.playSlideDialog(arg_11_0, arg_11_1, arg_11_2, arg_11_3)
	local var_11_0 = string.split(arg_11_1, "#")

	if #var_11_0 ~= 3 then
		logError("配置异常，请检查配置[示例：gundongzimu_1#1.0#10.0](图片名#速度#时间)")

		return
	end

	gohelper.setActive(arg_11_0._goconversation, false)
	gohelper.setActive(arg_11_0._gonexticon, false)

	local var_11_1 = {
		img = var_11_0[1],
		speed = tonumber(var_11_0[2]),
		showTime = tonumber(var_11_0[3])
	}

	arg_11_0._slideItem:startShowDialog(var_11_1, arg_11_2, arg_11_3)
end

function var_0_0.playMagicText(arg_12_0, arg_12_1, arg_12_2, arg_12_3)
	gohelper.setActive(arg_12_0._goline, true)
	arg_12_0:_showMagicItem(true)
	TaskDispatcher.cancelTask(arg_12_0._playConAudio, arg_12_0)
	gohelper.setActive(arg_12_0._norDiaGO, false)

	arg_12_0._txt = StoryTool.filterSpTag(arg_12_1)
	arg_12_0._textShowFinished = false
	arg_12_0._playingAudioId = 0
	arg_12_0._finishCallback = arg_12_2
	arg_12_0._finishCallbackObj = arg_12_3
	arg_12_0._txtcontentmagic.text = arg_12_0._txt
	arg_12_0._txtcontentreshapemagic.text = arg_12_0._txt

	local var_12_0, var_12_1, var_12_2 = transformhelper.getLocalPos(arg_12_0._txtcontentmagic.transform)

	transformhelper.setLocalPos(arg_12_0._txtcontentmagic.transform, var_12_0, var_12_1, 1)
	transformhelper.setLocalPos(arg_12_0._txtcontentreshapemagic.transform, var_12_0, var_12_1, 1)

	local var_12_3 = arg_12_0:_getMagicWordShowTime(arg_12_1)

	arg_12_0._magicConTweenId = ZProj.TweenHelper.DOTweenFloat(0, 1, var_12_3, arg_12_0._magicConUpdate, arg_12_0._onMagicTextFinished, arg_12_0, nil, EaseType.Linear)

	arg_12_0._magicFireAnim:Play("story_magicfont_particle")
	arg_12_0._reshapeMagicFireAnim:Play("story_magicfont_particle")
	gohelper.setActive(arg_12_0._magicFireGo, arg_12_0._stepCo.conversation.effType == StoryEnum.ConversationEffectType.Magic)
	gohelper.setActive(arg_12_0._reshapeMagicFireGo, arg_12_0._stepCo.conversation.effType == StoryEnum.ConversationEffectType.ReshapeMagic)
	gohelper.setActive(arg_12_0._txtcontentmagic.gameObject, arg_12_0._stepCo.conversation.effType == StoryEnum.ConversationEffectType.Magic)
	gohelper.setActive(arg_12_0._txtcontentreshapemagic, arg_12_0._stepCo.conversation.effType == StoryEnum.ConversationEffectType.ReshapeMagic)

	if arg_12_0._stepCo.conversation.audioDelayTimes[GameLanguageMgr.instance:getVoiceTypeStoryIndex()] < 0.1 then
		arg_12_0:_playConAudio()
	else
		TaskDispatcher.runDelay(arg_12_0._playConAudio, arg_12_0, arg_12_0._stepCo.conversation.audioDelayTimes[GameLanguageMgr.instance:getVoiceTypeStoryIndex()])
	end

	if var_12_3 > 0 then
		arg_12_0._magicFireAnim.speed = 1 / var_12_3
		arg_12_0._reshapeMagicFireAnim.speed = 1 / var_12_3
	end
end

function var_0_0._getMagicWordShowTime(arg_13_0, arg_13_1)
	local var_13_0 = string.gsub(arg_13_1, "%%", "--------")
	local var_13_1 = string.gsub(var_13_0, "%&", "--------")
	local var_13_2 = LuaUtil.getCharNum(var_13_1)
	local var_13_3 = 0.1

	if var_13_2 < 30 then
		var_13_3 = 0.2
	end

	if var_13_2 < 15 then
		var_13_3 = 0.5
	end

	if var_13_1 and string.find(var_13_1, "<speed=%d[%d.]*>") then
		local var_13_4 = string.sub(var_13_1, string.find(var_13_1, "<speed=%d[%d.]*>"))

		var_13_3 = var_13_4 and tonumber(string.match(var_13_4, "%d[%d.]*")) or 1
	end

	return var_13_3 * var_13_2
end

function var_0_0._magicConUpdate(arg_14_0, arg_14_1)
	local var_14_0 = arg_14_0._stepCo.conversation.effType == StoryEnum.ConversationEffectType.Magic and recthelper.getWidth(arg_14_0._txtcontentmagic.gameObject.transform) or recthelper.getWidth(arg_14_0._txtcontentreshapemagic.gameObject.transform)

	if arg_14_1 > (var_14_0 + 100) / 2215 and var_14_0 > 1 then
		if arg_14_0._magicConTweenId then
			ZProj.TweenHelper.KillById(arg_14_0._magicConTweenId)

			arg_14_0._magicConTweenId = nil
		end

		arg_14_0:_onMagicTextFinished()

		return
	end

	local var_14_1 = 1107.5
	local var_14_2, var_14_3, var_14_4 = transformhelper.getLocalPos(arg_14_0._txtcontentmagic.transform)

	if arg_14_0._stepCo.conversation.effType == StoryEnum.ConversationEffectType.ReshapeMagic then
		local var_14_5

		var_14_2, var_14_3, var_14_5 = transformhelper.getLocalPos(arg_14_0._txtcontentreshapemagic.transform)
	end

	local var_14_6 = UnityEngine.Screen.width
	local var_14_7 = UnityEngine.Screen.height
	local var_14_8 = 0
	local var_14_9 = 1920
	local var_14_10 = transformhelper.getLocalPos(arg_14_0._contentGO.transform)
	local var_14_11 = 1920 * (1080 * var_14_6 / (1920 * var_14_7))

	if var_14_6 / var_14_7 >= 1.7777777777777777 then
		var_14_8 = 0.5 * (1080 * var_14_6 / var_14_7 - 1920) + (960 + var_14_10)
	else
		var_14_8 = 960 - 0.5 * (1920 - 1080 * var_14_6 / var_14_7) + var_14_10
	end

	local var_14_12 = (var_14_8 + arg_14_1 * (var_14_1 + 10)) / var_14_11
	local var_14_13 = arg_14_0._stepCo.conversation.effType == StoryEnum.ConversationEffectType.Magic and recthelper.uiPosToScreenPos(arg_14_0._txtcontentmagic.gameObject.transform, ViewMgr.instance:getUICanvas()).y or recthelper.uiPosToScreenPos(arg_14_0._txtcontentreshapemagic.gameObject.transform, ViewMgr.instance:getUICanvas()).y
	local var_14_14 = arg_14_0._stepCo.conversation.effType == StoryEnum.ConversationEffectType.Magic and recthelper.screenPosToAnchorPos(Vector2(var_14_12 * var_14_6, var_14_13), arg_14_0._gofirework.transform) or recthelper.screenPosToAnchorPos(Vector2(var_14_12 * var_14_6, var_14_13), arg_14_0._goreshapefirework.transform)

	if arg_14_0._stepCo.conversation.effType == StoryEnum.ConversationEffectType.Magic then
		transformhelper.setLocalPos(arg_14_0._txtcontentmagic.transform, var_14_2, var_14_3, 1 - var_14_12)
		transformhelper.setLocalPos(arg_14_0._magicFireGo.transform, var_14_14.x, var_14_14.y, 0)
	else
		transformhelper.setLocalPos(arg_14_0._txtcontentreshapemagic.transform, var_14_2, var_14_3, 1 - var_14_12)
		transformhelper.setLocalPos(arg_14_0._reshapeMagicFireGo.transform, var_14_14.x, var_14_14.y, 0)
	end
end

function var_0_0._magicConFinished(arg_15_0)
	local var_15_0, var_15_1, var_15_2 = transformhelper.getLocalPos(arg_15_0._txtcontentmagic.transform)

	transformhelper.setLocalPos(arg_15_0._txtcontentmagic.transform, var_15_0, var_15_1, 0)
	transformhelper.setLocalPos(arg_15_0._txtcontentreshapemagic.transform, var_15_0, var_15_1, 0)
	gohelper.setActive(arg_15_0._magicFireGo, false)
	gohelper.setActive(arg_15_0._reshapeMagicFireGo, false)

	arg_15_0._magicFireAnim.speed = 1
	arg_15_0._reshapeMagicFireAnim.speed = 1

	if arg_15_0._stepCo.conversation.type == StoryEnum.ConversationType.NoInteract or arg_15_0._stepCo.conversation.type == StoryEnum.ConversationType.None then
		return
	end

	if arg_15_0._finishCallback then
		arg_15_0._finishCallback(arg_15_0._finishCallbackObj)
	end
end

function var_0_0.playNormalText(arg_16_0, arg_16_1, arg_16_2, arg_16_3)
	arg_16_0._txt = arg_16_1
	arg_16_0._textShowFinished = false

	TaskDispatcher.cancelTask(arg_16_0._playConAudio, arg_16_0)
	TaskDispatcher.cancelTask(arg_16_0._waitSecondFinished, arg_16_0)

	arg_16_0._playingAudioId = 0
	arg_16_0._finishCallback = arg_16_2
	arg_16_0._finishCallbackObj = arg_16_3
	arg_16_0._markIndexs = StoryTool.getMarkTextIndexs(arg_16_0._txt)
	arg_16_0._subemtext = StoryTool.filterSpTag(arg_16_0._txt)
	arg_16_0._markTop, arg_16_0._markContent = StoryTool.getMarkTopTextList(arg_16_0._subemtext)
	arg_16_0._subemtext = StoryTool.filterMarkTop(arg_16_0._subemtext)
	arg_16_0._txtcontentcn.text = string.gsub(arg_16_0._subemtext, "(<sprite=%d>)", "")
	arg_16_0._txtcontentmagic.text = ""
	arg_16_0._txtcontentreshapemagic.text = ""

	if arg_16_0._stepCo.conversation.effType == StoryEnum.ConversationEffectType.SoftLight then
		arg_16_0._txtcontentcn.alignment = TMPro.TextAlignmentOptions.Top

		if arg_16_0._txtcontentcn.fontSharedMaterial:IsKeywordEnabled("UNDERLAY_ON") == false then
			arg_16_0._txtcontentcn.fontSharedMaterial:EnableKeyword("UNDERLAY_ON")
			arg_16_0._txtcontentcn.fontSharedMaterial:SetFloat("_BloomFactor", 2.5)

			arg_16_0._txtcontentcn.fontSharedMaterial.renderQueue = 4995

			local var_16_0 = Color.New(0, 0, 0, 0.75)

			arg_16_0._txtcontentcn.fontSharedMaterial:SetColor("_UnderlayColor", var_16_0)
			arg_16_0._txtcontentcn.fontSharedMaterial:SetFloat("_UnderlayOffsetX", 0.143)
			arg_16_0._txtcontentcn.fontSharedMaterial:SetFloat("_UnderlayOffsetY", -0.1)
			arg_16_0._txtcontentcn.fontSharedMaterial:SetFloat("_UnderlayDilate", 0.107)
			arg_16_0._txtcontentcn.fontSharedMaterial:SetFloat("_UnderlaySoftness", 0.447)

			arg_16_0._txtcontentcn.fontSharedMaterial = arg_16_0._txtcontentcn.fontMaterial
		end

		StoryTool.enablePostProcess(true)
		PostProcessingMgr.instance:setUIPPValue("localBloomActive", true)
		PostProcessingMgr.instance:setUIPPValue("bloomDiffusion", 5)
		gohelper.setActive(arg_16_0._goline, false)
		gohelper.setActive(arg_16_0._goblackbottom, false)
		gohelper.setActive(arg_16_0._gonexticon, false)
		transformhelper.setLocalPosXY(arg_16_0._norDiaGO.transform, 475, -50)
	else
		arg_16_0._txtcontentcn.fontSharedMaterial:DisableKeyword("UNDERLAY_ON")

		arg_16_0._txtcontentcn.alignment = TMPro.TextAlignmentOptions.TopLeft
		arg_16_0._txtcontentcn.fontSharedMaterial = arg_16_0._fontNormalMat

		arg_16_0._txtcontentcn.fontSharedMaterial:SetFloat("_BloomFactor", 0)
		PostProcessingMgr.instance:setUIPPValue("localBloomActive", false)
		PostProcessingMgr.instance:setUIPPValue("bloomDiffusion", 7)

		local var_16_1 = arg_16_0._stepCo.conversation.type ~= StoryEnum.ConversationType.IrregularShake

		gohelper.setActive(arg_16_0._goline, var_16_1)
		gohelper.setActive(arg_16_0._goblackbottom, var_16_1)
		gohelper.setActive(arg_16_0._gonexticon, var_16_1)
		transformhelper.setLocalPosXY(arg_16_0._norDiaGO.transform, 550, 0)
	end

	arg_16_0:_checkPlayGlitch(arg_16_0._subemtext)

	arg_16_0._subemtext = string.gsub(arg_16_0._subemtext, "<glitch>", "<i><b>")
	arg_16_0._subemtext = string.gsub(arg_16_0._subemtext, "</glitch>", "</i></b>")

	if arg_16_0._stepCo.conversation.effType == StoryEnum.ConversationEffectType.Hard then
		arg_16_0:_playHardIn()
	else
		arg_16_0:_playGradualIn()
	end
end

function var_0_0._checkPlayGlitch(arg_17_0, arg_17_1)
	local var_17_0 = string.match(arg_17_1, "<glitch>")

	gohelper.setActive(arg_17_0._glitchGo, var_17_0)

	if not var_17_0 then
		return
	end

	StoryTool.enablePostProcess(true)

	local var_17_1 = string.gsub(arg_17_1, "<glitch>", "")
	local var_17_2 = string.gsub(var_17_1, "</glitch>", "")
	local var_17_3 = arg_17_0._txtcontentcn:GetTextInfo(var_17_2)
	local var_17_4 = {}
	local var_17_5 = gohelper.findChild(arg_17_0._glitchGo, "part_up"):GetComponent(typeof(UnityEngine.ParticleSystem))

	table.insert(var_17_4, var_17_5)

	local var_17_6 = gohelper.findChild(arg_17_0._glitchGo, "part_down")
	local var_17_7 = var_17_6:GetComponent(typeof(UnityEngine.ParticleSystem))

	table.insert(var_17_4, var_17_7)
	gohelper.setActive(var_17_6, var_17_3.lineCount > 1)

	local var_17_8 = CameraMgr.instance:getUICamera()
	local var_17_9 = var_17_3.characterInfo
	local var_17_10 = recthelper.getWidth(arg_17_0._txtcontentcn.transform) + 121.8684
	local var_17_11 = {}
	local var_17_12 = string.split(arg_17_1, "\n")

	if #var_17_12 > 1 then
		for iter_17_0 = 1, #var_17_12 do
			local var_17_13 = var_17_12[iter_17_0]
			local var_17_14 = string.find(var_17_13, "<glitch>")
			local var_17_15 = string.find(var_17_13, "<glitch>")
			local var_17_16 = {}

			if not var_17_15 then
				var_17_16.hasGlitch = false

				table.insert(var_17_11, var_17_16)
			else
				local var_17_17 = string.sub(var_17_13, 1, var_17_14 - 1)
				local var_17_18 = string.gsub(var_17_13, "<glitch>", "")
				local var_17_19 = string.find(var_17_18, "</glitch>")
				local var_17_20 = string.sub(var_17_18, 1, var_17_19 - 1)
				local var_17_21 = string.gsub(var_17_18, "</glitch>", "")
				local var_17_22 = var_17_3.lineInfo[iter_17_0 - 1]

				var_17_16.hasGlitch = true
				var_17_16.firstCharacterIndex = var_17_22.firstCharacterIndex
				var_17_16.startIndex = utf8.len(var_17_17)
				var_17_16.endIndex = utf8.len(var_17_20)
				var_17_16.lineTxt = var_17_21
				var_17_16.glitchTxt = var_17_13

				table.insert(var_17_11, var_17_16)
			end
		end
	else
		for iter_17_1 = 1, var_17_3.lineCount do
			local var_17_23 = var_17_3.lineInfo[iter_17_1 - 1]
			local var_17_24 = LuaUtil.subString(var_17_2, var_17_23.firstCharacterIndex + 1, var_17_23.firstCharacterIndex + var_17_23.characterCount + 1)
			local var_17_25 = iter_17_1 > 1 and var_17_11[iter_17_1 - 1].endIndex + 1 or 0
			local var_17_26 = string.len(var_17_24) + string.len("<glitch>")
			local var_17_27 = iter_17_1 > 1 and string.gsub(arg_17_1, var_17_11[iter_17_1 - 1].glitchTxt, "") or string.sub(arg_17_1, var_17_25, var_17_26)
			local var_17_28 = string.find(var_17_27, "<glitch>")
			local var_17_29 = var_17_28 and string.len(var_17_24) + string.len("<glitch>") + string.len("</glitch>") or string.len(var_17_24)
			local var_17_30 = iter_17_1 > 1 and string.gsub(arg_17_1, var_17_11[iter_17_1 - 1].glitchTxt, "") or string.sub(arg_17_1, var_17_25, var_17_29)
			local var_17_31 = string.find(var_17_30, "<glitch>")
			local var_17_32 = {}

			if not var_17_28 then
				var_17_32.hasGlitch = false

				table.insert(var_17_11, var_17_32)
			else
				local var_17_33 = string.sub(var_17_30, 1, var_17_31 - 1)
				local var_17_34 = string.gsub(var_17_30, "<glitch>", "")
				local var_17_35 = string.find(var_17_34, "</glitch>")
				local var_17_36 = string.sub(var_17_34, 1, var_17_35 - 1)

				var_17_32.hasGlitch = true
				var_17_32.firstCharacterIndex = var_17_23.firstCharacterIndex
				var_17_32.startIndex = utf8.len(var_17_33)
				var_17_32.endIndex = utf8.len(var_17_36)
				var_17_32.lineTxt = var_17_24
				var_17_32.glitchTxt = var_17_30

				table.insert(var_17_11, var_17_32)
			end
		end
	end

	for iter_17_2 = 1, #var_17_11 do
		local var_17_37, var_17_38, var_17_39 = transformhelper.getLocalPos(var_17_4[iter_17_2].transform)

		if not var_17_11[iter_17_2].hasGlitch then
			transformhelper.setLocalPos(var_17_4[iter_17_2].transform, -10000, var_17_38, var_17_39)
		else
			local var_17_40 = var_17_9[0]
			local var_17_41 = var_17_9[var_17_11[iter_17_2].startIndex]
			local var_17_42 = var_17_9[var_17_11[iter_17_2].endIndex - 1]
			local var_17_43 = var_17_8:WorldToScreenPoint(arg_17_0._txtcontentcn.transform:TransformPoint(var_17_40.bottomLeft))
			local var_17_44 = var_17_8:WorldToScreenPoint(arg_17_0._txtcontentcn.transform:TransformPoint(var_17_41.bottomLeft))
			local var_17_45 = var_17_8:WorldToScreenPoint(arg_17_0._txtcontentcn.transform:TransformPoint(var_17_42.bottomRight))
			local var_17_46 = UnityEngine.Screen.width
			local var_17_47 = UnityEngine.Screen.height
			local var_17_48 = math.min(1, 0.9 * var_17_46 / (1.6 * var_17_47))
			local var_17_49 = 1080 * (var_17_44.x - var_17_43.x) / (var_17_47 * var_17_48)
			local var_17_50 = 1144.8 * (var_17_45.x - var_17_44.x) / (var_17_47 * var_17_48)
			local var_17_51 = var_17_49 / var_17_10
			local var_17_52 = var_17_50 / var_17_10
			local var_17_53 = 647 * (2 * var_17_51 + var_17_52)
			local var_17_54, var_17_55, var_17_56 = transformhelper.getLocalPos(var_17_4[iter_17_2].transform)

			transformhelper.setLocalPos(var_17_4[iter_17_2].transform, var_17_53, var_17_55, var_17_56)

			local var_17_57 = 12 * var_17_52 * var_17_48
			local var_17_58 = 0.4 * var_17_48

			var_17_4[iter_17_2].shape.scale = Vector3(var_17_57, var_17_58, 0)

			ZProj.ParticleSystemHelper.SetMaxParticles(var_17_4[iter_17_2], math.floor(30 * var_17_52))
		end
	end
end

function var_0_0._playHardIn(arg_18_0)
	arg_18_0:_showMagicItem(false)
	gohelper.setActive(arg_18_0._norDiaGO, true)
	arg_18_0:conFinished()
end

function var_0_0._playGradualIn(arg_19_0)
	arg_19_0._conMat:EnableKeyword("_GRADUAL_ON")
	arg_19_0._conMat:DisableKeyword("_DISSOLVE_ON")
	arg_19_0._markTopMat:EnableKeyword("_GRADUAL_ON")
	arg_19_0._markTopMat:DisableKeyword("_DISSOLVE_ON")

	local var_19_0 = UnityEngine.Screen.height

	arg_19_0._conMat:SetFloat(arg_19_0._LineMinYId, var_19_0)
	arg_19_0._conMat:SetFloat(arg_19_0._LineMaxYId, var_19_0)
	arg_19_0._markTopMat:SetFloat(arg_19_0._LineMinYId, var_19_0)
	arg_19_0._markTopMat:SetFloat(arg_19_0._LineMaxYId, var_19_0)

	arg_19_0._subMeshs = {}

	local var_19_1 = arg_19_0._txtcontentcn.gameObject:GetComponentsInChildren(typeof(TMPro.TMP_SubMeshUI), true)

	if var_19_1 then
		local var_19_2 = var_19_1:GetEnumerator()

		while var_19_2:MoveNext() do
			local var_19_3 = var_19_2.Current.gameObject:GetComponent(typeof(TMPro.TMP_SubMeshUI))

			table.insert(arg_19_0._subMeshs, var_19_3)
		end
	end

	for iter_19_0, iter_19_1 in pairs(arg_19_0._subMeshs) do
		if iter_19_1.materialForRendering then
			iter_19_1.materialForRendering:SetFloat(arg_19_0._LineMinYId, var_19_0)
			iter_19_1.materialForRendering:SetFloat(arg_19_0._LineMaxYId, var_19_0)
			iter_19_1.materialForRendering:EnableKeyword("_GRADUAL_ON")
		end
	end

	arg_19_0._dotMat:SetFloat(arg_19_0._LineMinYId, var_19_0)
	arg_19_0._dotMat:SetFloat(arg_19_0._LineMaxYId, var_19_0)
	arg_19_0:_showMagicItem(false)
	gohelper.setActive(arg_19_0._norDiaGO, true)

	local var_19_4, var_19_5, var_19_6 = transformhelper.getLocalPos(arg_19_0._txtcontentcn.transform)

	transformhelper.setLocalPos(arg_19_0._txtcontentcn.transform, var_19_4, var_19_5, 1)
	TaskDispatcher.cancelTask(arg_19_0._delayShow, arg_19_0)
	TaskDispatcher.runDelay(arg_19_0._delayShow, arg_19_0, 0.05)
end

function var_0_0._showMagicItem(arg_20_0, arg_20_1)
	if arg_20_1 then
		if arg_20_0._magicFireGo then
			StoryTool.enablePostProcess(true)
			gohelper.setActive(arg_20_0._reshapeMagicFireGo, arg_20_0._stepCo.conversation.effType == StoryEnum.ConversationEffectType.ReshapeMagic)
		end

		if arg_20_0._reshapeMagicFireGo then
			StoryTool.enablePostProcess(true)
			gohelper.setActive(arg_20_0._reshapeMagicFireGo, arg_20_0._stepCo.conversation.effType == StoryEnum.ConversationEffectType.ReshapeMagic)
		end
	else
		arg_20_0._txtcontentmagic.text = ""
		arg_20_0._txtcontentreshapemagic.text = ""

		gohelper.setActive(arg_20_0._magicFireGo, false)
		gohelper.setActive(arg_20_0._reshapeMagicFireGo, false)
	end
end

function var_0_0._delayShow(arg_21_0)
	arg_21_0._conMark:SetMarks(arg_21_0._markIndexs)
	arg_21_0._conMark:SetMarksTop(arg_21_0._markTop, arg_21_0._markContent)

	arg_21_0._textInfo = arg_21_0._txtcontentcn:GetTextInfo(arg_21_0._subemtext)
	arg_21_0._lineInfoList = {}

	local var_21_0 = 0

	for iter_21_0 = 1, arg_21_0._textInfo.lineCount do
		local var_21_1 = arg_21_0._textInfo.lineInfo[iter_21_0 - 1]
		local var_21_2 = var_21_0 + 1

		var_21_0 = var_21_0 + var_21_1.visibleCharacterCount

		table.insert(arg_21_0._lineInfoList, {
			var_21_1,
			var_21_2,
			var_21_0
		})
	end

	arg_21_0._contentX, arg_21_0._contentY, _ = transformhelper.getLocalPos(arg_21_0._txtcontentcn.transform)
	arg_21_0._curLine = nil

	local var_21_3 = arg_21_0:_getDelayTime(var_21_0)

	if arg_21_0._conTweenId then
		ZProj.TweenHelper.KillById(arg_21_0._conTweenId)

		arg_21_0._conTweenId = nil
	end

	if arg_21_0._stepCo.conversation.audioDelayTimes[GameLanguageMgr.instance:getVoiceTypeStoryIndex()] < 0.1 then
		arg_21_0:_playConAudio()
	else
		TaskDispatcher.runDelay(arg_21_0._playConAudio, arg_21_0, arg_21_0._stepCo.conversation.audioDelayTimes[GameLanguageMgr.instance:getVoiceTypeStoryIndex()])
	end

	arg_21_0._conTweenId = ZProj.TweenHelper.DOTweenFloat(1, var_21_0, var_21_3, arg_21_0._conUpdate, arg_21_0._onTextFinished, arg_21_0, nil, EaseType.Linear)
end

function var_0_0._getDelayTime(arg_22_0, arg_22_1)
	local var_22_0 = 1

	if arg_22_0._txt and string.find(arg_22_0._txt, "<speed=%d[%d.]*>") then
		local var_22_1 = string.sub(arg_22_0._txt, string.find(arg_22_0._txt, "<speed=%d[%d.]*>"))

		var_22_0 = var_22_1 and tonumber(string.match(var_22_1, "%d[%d.]*")) or 1
	end

	local var_22_2 = 0.08 * arg_22_1

	if GameLanguageMgr.instance:getLanguageTypeStoryIndex() == LanguageEnum.LanguageStoryType.EN then
		var_22_2 = var_22_2 * 0.67
	end

	return var_22_2 / var_22_0
end

function var_0_0._playConAudio(arg_23_0)
	if arg_23_0._isLogStop then
		return
	end

	arg_23_0:stopConAudio()

	if StoryModel.instance:isSpecialVideoPlaying() then
		return
	end

	arg_23_0._conAudioId = arg_23_0._stepCo.conversation.audios[1] or 0

	if arg_23_0._conAudioId ~= 0 then
		local var_23_0 = {}

		var_23_0.loopNum = 1
		var_23_0.fadeInTime = 0
		var_23_0.fadeOutTime = 0
		var_23_0.volume = 100
		var_23_0.audioGo = arg_23_0:_getDialogGo()
		var_23_0.callback = arg_23_0._onConAudioFinished
		var_23_0.callbackTarget = arg_23_0
		arg_23_0._playingAudioId = arg_23_0._conAudioId

		AudioEffectMgr.instance:playAudio(arg_23_0._conAudioId, var_23_0)
	else
		arg_23_0._playingAudioId = 0
	end

	arg_23_0._hasLowPassAudio = false

	if #arg_23_0._stepCo.conversation.audios > 1 then
		for iter_23_0, iter_23_1 in pairs(arg_23_0._stepCo.conversation.audios) do
			if iter_23_1 == AudioEnum.Story.Play_Lowpass then
				arg_23_0._hasLowPassAudio = true

				AudioMgr.instance:trigger(AudioEnum.Story.Play_Lowpass)

				return
			end
		end
	end
end

function var_0_0._getDialogGo(arg_24_0)
	local var_24_0 = arg_24_0._roleMidAudioGo

	if #arg_24_0._stepCo.heroList > 0 and arg_24_0._stepCo.conversation.showList[1] then
		if not arg_24_0._stepCo.heroList[arg_24_0._stepCo.conversation.showList[1] + 1] then
			return var_24_0
		end

		local var_24_1 = arg_24_0._stepCo.heroList[arg_24_0._stepCo.conversation.showList[1] + 1].heroDir

		if var_24_1 and var_24_1 == 0 then
			var_24_0 = arg_24_0._roleLeftAudioGo
		end

		if var_24_1 and var_24_1 == 2 then
			var_24_0 = arg_24_0._roleRightAudioGo
		end
	end

	return var_24_0
end

function var_0_0._onTextFinished(arg_25_0)
	if arg_25_0._magicConTweenId then
		ZProj.TweenHelper.KillById(arg_25_0._magicConTweenId)
		gohelper.setActive(arg_25_0._magicFireGo, false)
		gohelper.setActive(arg_25_0._reshapeMagicFireGo, false)

		arg_25_0._magicFireAnim.speed = 1
		arg_25_0._reshapeMagicFireAnim.speed = 1
		arg_25_0._magicConTweenId = nil
	end

	if arg_25_0._conTweenId then
		ZProj.TweenHelper.KillById(arg_25_0._conTweenId)

		arg_25_0._conTweenId = nil
	end

	local var_25_0, var_25_1, var_25_2 = transformhelper.getLocalPos(arg_25_0._txtcontentcn.transform)

	transformhelper.setLocalPos(arg_25_0._txtcontentcn.transform, var_25_0, var_25_1, 0)

	local var_25_3, var_25_4, var_25_5 = transformhelper.getLocalPos(arg_25_0._txtcontentmagic.transform)

	transformhelper.setLocalPos(arg_25_0._txtcontentmagic.transform, var_25_3, var_25_4, 0)
	transformhelper.setLocalPos(arg_25_0._txtcontentreshapemagic.transform, var_25_3, var_25_4, 0)
	arg_25_0._conMat:DisableKeyword("_GRADUAL_ON")
	arg_25_0._markTopMat:DisableKeyword("_GRADUAL_ON")

	for iter_25_0, iter_25_1 in pairs(arg_25_0._subMeshs) do
		if iter_25_1.materialForRendering then
			iter_25_1.materialForRendering:DisableKeyword("_GRADUAL_ON")
		end
	end

	arg_25_0._textShowFinished = true

	local var_25_6 = StoryModel.instance:isStoryAuto()

	if arg_25_0._stepCo.conversation.type ~= StoryEnum.ConversationType.NoInteract and arg_25_0._stepCo.conversation.type ~= StoryEnum.ConversationType.None then
		var_25_6 = var_25_6 or arg_25_0._stepCo.conversation.isAuto
	end

	if not var_25_6 or arg_25_0._playingAudioId == 0 then
		arg_25_0:conFinished()
	end
end

function var_0_0._onMagicTextFinished(arg_26_0)
	arg_26_0._textShowFinished = true

	arg_26_0:_magicConFinished()
end

function var_0_0._onConAudioFinished(arg_27_0, arg_27_1)
	if arg_27_0._textShowFinished then
		if arg_27_0._stepCo.conversation.effType == StoryEnum.ConversationEffectType.Magic or arg_27_0._stepCo.conversation.effType == StoryEnum.ConversationEffectType.ReshapeMagic then
			arg_27_0:_magicConFinished()
		else
			arg_27_0:conFinished()
		end
	end

	if arg_27_0._playingAudioId == arg_27_1 then
		arg_27_0._playingAudioId = 0
	end
end

function var_0_0.stopConAudio(arg_28_0)
	if arg_28_0._hasLowPassAudio then
		AudioMgr.instance:trigger(AudioEnum.Story.Stop_Lowpass)
	end

	if arg_28_0._isLogStop then
		return
	end

	arg_28_0._playingAudioId = 0

	if arg_28_0._conAudioId ~= 0 and arg_28_0._conAudioId then
		AudioEffectMgr.instance:stopAudio(arg_28_0._conAudioId, 0)
	end
end

function var_0_0._conUpdate(arg_29_0, arg_29_1)
	local var_29_0 = UnityEngine.Screen.width
	local var_29_1 = arg_29_0._txtcontentcn.transform
	local var_29_2 = CameraMgr.instance:getUICamera()

	arg_29_0._subMeshs = {}

	local var_29_3 = arg_29_0._txtcontentcn.gameObject:GetComponentsInChildren(typeof(TMPro.TMP_SubMeshUI), true)

	if var_29_3 then
		local var_29_4 = var_29_3:GetEnumerator()

		while var_29_4:MoveNext() do
			local var_29_5 = var_29_4.Current.gameObject:GetComponent(typeof(TMPro.TMP_SubMeshUI))

			table.insert(arg_29_0._subMeshs, var_29_5)
		end
	end

	for iter_29_0, iter_29_1 in ipairs(arg_29_0._lineInfoList) do
		local var_29_6 = iter_29_1[1]
		local var_29_7 = iter_29_1[2]
		local var_29_8 = iter_29_1[3]

		if var_29_7 <= arg_29_1 and arg_29_1 <= var_29_8 then
			local var_29_9 = arg_29_0._textInfo.characterInfo
			local var_29_10 = var_29_9[var_29_6.firstVisibleCharacterIndex]
			local var_29_11 = var_29_9[var_29_6.lastVisibleCharacterIndex]
			local var_29_12 = var_29_2:WorldToScreenPoint(var_29_1:TransformPoint(var_29_10.bottomLeft))
			local var_29_13 = var_29_12
			local var_29_14 = var_29_12.y

			for iter_29_2 = var_29_6.firstVisibleCharacterIndex, var_29_6.lastVisibleCharacterIndex do
				local var_29_15 = var_29_9[iter_29_2]
				local var_29_16 = var_29_2:WorldToScreenPoint(var_29_1:TransformPoint(var_29_15.bottomLeft))

				if var_29_14 > var_29_16.y then
					var_29_14 = var_29_16.y
				end
			end

			var_29_13.y = var_29_14

			local var_29_17 = var_29_2:WorldToScreenPoint(var_29_1:TransformPoint(var_29_10.topLeft))
			local var_29_18 = var_29_17
			local var_29_19 = var_29_17.y

			for iter_29_3 = var_29_6.firstVisibleCharacterIndex, var_29_6.lastVisibleCharacterIndex do
				local var_29_20 = var_29_9[iter_29_3]
				local var_29_21 = var_29_2:WorldToScreenPoint(var_29_1:TransformPoint(var_29_20.topLeft))

				if var_29_19 < var_29_21.y then
					var_29_19 = var_29_21.y
				end
			end

			var_29_18.y = var_29_19

			local var_29_22 = var_29_2:WorldToScreenPoint(var_29_1:TransformPoint(var_29_11.bottomRight))

			if iter_29_0 == 1 then
				arg_29_0._conMat:SetFloat(arg_29_0._LineMinYId, var_29_13.y)
				arg_29_0._conMat:SetFloat(arg_29_0._LineMaxYId, var_29_18.y + 10)
				arg_29_0._markTopMat:SetFloat(arg_29_0._LineMinYId, var_29_13.y - 100)
				arg_29_0._markTopMat:SetFloat(arg_29_0._LineMaxYId, var_29_18.y - 90)

				for iter_29_4, iter_29_5 in pairs(arg_29_0._subMeshs) do
					if iter_29_5.materialForRendering then
						iter_29_5.materialForRendering:SetFloat(arg_29_0._LineMinYId, var_29_13.y)
						iter_29_5.materialForRendering:SetFloat(arg_29_0._LineMaxYId, var_29_18.y + 10)
						iter_29_5.materialForRendering:EnableKeyword("_GRADUAL_ON")
					end
				end

				arg_29_0._dotMat:SetFloat(arg_29_0._LineMinYId, var_29_13.y - 10)
				arg_29_0._dotMat:SetFloat(arg_29_0._LineMaxYId, var_29_18.y)
			else
				arg_29_0._conMat:SetFloat(arg_29_0._LineMinYId, var_29_13.y)
				arg_29_0._conMat:SetFloat(arg_29_0._LineMaxYId, var_29_18.y)
				arg_29_0._markTopMat:SetFloat(arg_29_0._LineMinYId, var_29_13.y)
				arg_29_0._markTopMat:SetFloat(arg_29_0._LineMaxYId, var_29_18.y)

				for iter_29_6, iter_29_7 in pairs(arg_29_0._subMeshs) do
					if iter_29_7.materialForRendering then
						iter_29_7.materialForRendering:SetFloat(arg_29_0._LineMinYId, var_29_13.y)
						iter_29_7.materialForRendering:SetFloat(arg_29_0._LineMaxYId, var_29_18.y)
						iter_29_7.materialForRendering:EnableKeyword("_GRADUAL_ON")
					end
				end

				arg_29_0._dotMat:SetFloat(arg_29_0._LineMinYId, var_29_13.y - 10)
				arg_29_0._dotMat:SetFloat(arg_29_0._LineMaxYId, var_29_18.y)
			end

			local var_29_23 = arg_29_0._txtcontentcn.gameObject

			gohelper.setActive(var_29_23, false)
			gohelper.setActive(var_29_23, true)

			local var_29_24 = var_29_7 == var_29_8 and 1 or (arg_29_1 - var_29_7) / (var_29_8 - var_29_7)
			local var_29_25 = Mathf.Lerp(var_29_13.x - 10, var_29_22.x + 10, var_29_24)
			local var_29_26 = arg_29_0._stepCo.conversation.effType == StoryEnum.ConversationEffectType.SoftLight and 0 or 1 - var_29_25 / var_29_0

			transformhelper.setLocalPos(arg_29_0._txtcontentcn.transform, arg_29_0._contentX, arg_29_0._contentY, var_29_26)

			if arg_29_0._stepCo.conversation.effType == StoryEnum.ConversationEffectType.SoftLight then
				arg_29_0._conMat:SetFloat(arg_29_0._LineMinYId, 0)
				arg_29_0._conMat:SetFloat(arg_29_0._LineMaxYId, 0)

				if #arg_29_0._lineInfoList > 1 then
					transformhelper.setLocalPosXY(arg_29_0._norDiaGO.transform, 475, 50 * (#arg_29_0._lineInfoList - 2))
				end
			end
		end
	end
end

function var_0_0.conFinished(arg_30_0)
	arg_30_0._textShowFinished = true

	if arg_30_0._stepCo and (arg_30_0._stepCo.conversation.type == StoryEnum.ConversationType.NoInteract or arg_30_0._stepCo.conversation.type == StoryEnum.ConversationType.None) then
		return
	end

	if arg_30_0._magicConTweenId then
		ZProj.TweenHelper.KillById(arg_30_0._magicConTweenId)
		gohelper.setActive(arg_30_0._magicFireGo, false)
		gohelper.setActive(arg_30_0._reshapeMagicFireGo, false)

		arg_30_0._magicFireAnim.speed = 1
		arg_30_0._reshapeMagicFireAnim.speed = 1
		arg_30_0._magicConTweenId = nil
	end

	if arg_30_0._conTweenId then
		ZProj.TweenHelper.KillById(arg_30_0._conTweenId)

		arg_30_0._conTweenId = nil
	end

	arg_30_0._conMat:SetFloat(arg_30_0._LineMinYId, 0)
	arg_30_0._conMat:SetFloat(arg_30_0._LineMaxYId, 0)
	arg_30_0._markTopMat:SetFloat(arg_30_0._LineMinYId, 0)
	arg_30_0._markTopMat:SetFloat(arg_30_0._LineMaxYId, 0)

	arg_30_0._subMeshs = {}

	local var_30_0 = arg_30_0._txtcontentcn.gameObject:GetComponentsInChildren(typeof(TMPro.TMP_SubMeshUI), true)

	if var_30_0 then
		local var_30_1 = var_30_0:GetEnumerator()

		while var_30_1:MoveNext() do
			local var_30_2 = var_30_1.Current.gameObject:GetComponent(typeof(TMPro.TMP_SubMeshUI))

			table.insert(arg_30_0._subMeshs, var_30_2)
		end
	end

	for iter_30_0, iter_30_1 in pairs(arg_30_0._subMeshs) do
		if iter_30_1.materialForRendering then
			iter_30_1.materialForRendering:SetFloat(arg_30_0._LineMinYId, 0)
			iter_30_1.materialForRendering:SetFloat(arg_30_0._LineMaxYId, 0)
		end
	end

	local var_30_3, var_30_4, var_30_5 = transformhelper.getLocalPos(arg_30_0._txtcontentcn.transform)

	transformhelper.setLocalPos(arg_30_0._txtcontentcn.transform, var_30_3, var_30_4, 0)

	local var_30_6, var_30_7, var_30_8 = transformhelper.getLocalPos(arg_30_0._txtcontentmagic.transform)

	transformhelper.setLocalPos(arg_30_0._txtcontentmagic.transform, var_30_6, var_30_7, 0)
	transformhelper.setLocalPos(arg_30_0._txtcontentreshapemagic.transform, var_30_6, var_30_7, 0)
	arg_30_0._conMat:DisableKeyword("_GRADUAL_ON")
	arg_30_0._markTopMat:DisableKeyword("_GRADUAL_ON")

	if arg_30_0._finishCallback then
		arg_30_0._finishCallback(arg_30_0._finishCallbackObj)
	end
end

function var_0_0.playNorDialogFadeIn(arg_31_0, arg_31_1, arg_31_2)
	ZProj.TweenHelper.DoFade(arg_31_0._txtcontentcn, 0, 1, 2, function()
		if arg_31_1 then
			arg_31_1(arg_31_2)
		end
	end, nil, nil, EaseType.Linear)
end

function var_0_0.playWordByWord(arg_33_0, arg_33_1, arg_33_2)
	arg_33_0._txtcontentcn.text = ""

	ZProj.TweenHelper.DOText(arg_33_0._txtcontentcn, arg_33_0._diatxt, 2, function()
		if arg_33_1 then
			arg_33_1(arg_33_2)
		end
	end)
end

function var_0_0.startAutoEnterNext(arg_35_0)
	if arg_35_0._playingAudioId == 0 and arg_35_0._textShowFinished then
		if arg_35_0._stepCo.conversation.effType == StoryEnum.ConversationEffectType.Magic or arg_35_0._stepCo.conversation.effType == StoryEnum.ConversationEffectType.ReshapeMagic then
			arg_35_0:_magicConFinished()
		else
			arg_35_0:conFinished()
		end
	end
end

function var_0_0.checkAutoEnterNext(arg_36_0, arg_36_1, arg_36_2)
	arg_36_0._diaFinishedCallback = arg_36_1
	arg_36_0._diaFinishedCallbackObj = arg_36_2

	TaskDispatcher.cancelTask(arg_36_0._onSecond, arg_36_0)
	TaskDispatcher.cancelTask(arg_36_0._waitSecondFinished, arg_36_0)
	TaskDispatcher.runRepeat(arg_36_0._onSecond, arg_36_0, 0.1)
end

function var_0_0._onSecond(arg_37_0)
	if arg_37_0._playingAudioId == 0 and arg_37_0._textShowFinished then
		TaskDispatcher.cancelTask(arg_37_0._onSecond, arg_37_0)
		TaskDispatcher.cancelTask(arg_37_0._waitSecondFinished, arg_37_0)
		TaskDispatcher.runDelay(arg_37_0._waitSecondFinished, arg_37_0, 2)
	end
end

function var_0_0.isAudioPlaying(arg_38_0)
	return arg_38_0._playingAudioId ~= 0
end

function var_0_0._waitSecondFinished(arg_39_0)
	if arg_39_0._diaFinishedCallback then
		arg_39_0._diaFinishedCallback(arg_39_0._diaFinishedCallbackObj)
	end
end

function var_0_0.storyFinished(arg_40_0)
	arg_40_0._finishCallback = nil
	arg_40_0._finishCallbackObj = nil
end

function var_0_0.destroy(arg_41_0)
	arg_41_0._txtcontentcn.fontSharedMaterial = arg_41_0._fontNormalMat

	arg_41_0:_removeEvent()
	TaskDispatcher.cancelTask(arg_41_0._playConAudio, arg_41_0)
	TaskDispatcher.cancelTask(arg_41_0._onSecond, arg_41_0)
	TaskDispatcher.cancelTask(arg_41_0._waitSecondFinished, arg_41_0)
	arg_41_0:stopConAudio()

	if arg_41_0._slideItem then
		arg_41_0._slideItem:destroy()

		arg_41_0._slideItem = nil
	end

	if arg_41_0._conTweenId then
		ZProj.TweenHelper.KillById(arg_41_0._conTweenId)

		arg_41_0._conTweenId = nil
	end

	if arg_41_0._magicConTweenId then
		ZProj.TweenHelper.KillById(arg_41_0._magicConTweenId)

		arg_41_0._magicConTweenId = nil
	end

	if arg_41_0._effLoader then
		arg_41_0._effLoader:dispose()

		arg_41_0._effLoader = nil
	end

	TaskDispatcher.cancelTask(arg_41_0._delayShow, arg_41_0)

	arg_41_0._finishCallback = nil
	arg_41_0._finishCallbackObj = nil

	arg_41_0._conMat:DisableKeyword("_GRADUAL_ON")
	arg_41_0._markTopMat:DisableKeyword("_GRADUAL_ON")
	arg_41_0:_removeEvent()

	if arg_41_0._matLoader then
		arg_41_0._matLoader:dispose()

		arg_41_0._matLoader = nil
	end
end

return var_0_0
