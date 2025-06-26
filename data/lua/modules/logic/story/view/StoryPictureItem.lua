module("modules.logic.story.view.StoryPictureItem", package.seeall)

local var_0_0 = class("StoryPictureItem")

function var_0_0.init(arg_1_0, arg_1_1, arg_1_2, arg_1_3)
	arg_1_0.viewGO = arg_1_1
	arg_1_0._picParentGo = gohelper.create2d(arg_1_0.viewGO, arg_1_2)
	arg_1_0._picName = arg_1_2
	arg_1_0._picCo = arg_1_3
	arg_1_0._picGo = nil
	arg_1_0._picImg = nil
	arg_1_0._picLoaded = false

	if arg_1_3.delayTimes[GameLanguageMgr.instance:getVoiceTypeStoryIndex()] > 0 then
		TaskDispatcher.runDelay(arg_1_0._build, arg_1_0, arg_1_3.delayTimes[GameLanguageMgr.instance:getVoiceTypeStoryIndex()])
	else
		arg_1_0:_build()
	end
end

function var_0_0._build(arg_2_0)
	if not ViewMgr.instance:isOpen(ViewName.StoryView) then
		return
	end

	TaskDispatcher.cancelTask(arg_2_0._realDestroy, arg_2_0)

	if arg_2_0._pictureLoader then
		arg_2_0._pictureLoader:dispose()

		arg_2_0._pictureLoader = nil
	end

	if arg_2_0._picCo.picType == StoryEnum.PictureType.FullScreen then
		local var_2_0 = "ui/viewres/story/storyfullfocusitem.prefab"

		arg_2_0._pictureLoader = PrefabInstantiate.Create(arg_2_0._picParentGo)

		arg_2_0._pictureLoader:startLoad(var_2_0, arg_2_0._onFullFocusPictureLoaded, arg_2_0)
	else
		local var_2_1 = "ui/viewres/story/storynormalpicitem.prefab"

		arg_2_0._pictureLoader = PrefabInstantiate.Create(arg_2_0._picParentGo)

		arg_2_0._pictureLoader:startLoad(var_2_1, arg_2_0._onPicPrefabLoaded, arg_2_0)
	end
end

function var_0_0._onPicPrefabLoaded(arg_3_0)
	arg_3_0._picLoaded = true
	arg_3_0._picGo = arg_3_0._pictureLoader:getInstGO()
	arg_3_0._picAni = arg_3_0._picGo:GetComponent(typeof(UnityEngine.Animator))
	arg_3_0._picAni.enabled = false

	transformhelper.setLocalPosXY(arg_3_0._picGo.transform, arg_3_0._picCo.pos[1], arg_3_0._picCo.pos[2])

	arg_3_0._simg = gohelper.findChildSingleImage(arg_3_0._picGo, "result")
	arg_3_0._txtTmp = gohelper.findChildText(arg_3_0._picGo, "txt_tmp")
	arg_3_0._gosptxt = gohelper.findChild(arg_3_0._picGo, "#go_sptxt")
	arg_3_0._spTxts = {}

	for iter_3_0 = 1, 3 do
		local var_3_0 = gohelper.findChildText(arg_3_0._gosptxt, "txt" .. iter_3_0)

		table.insert(arg_3_0._spTxts, var_3_0)
	end

	transformhelper.setLocalPosXY(arg_3_0._txtTmp.transform, 0, 0)
	transformhelper.setLocalPosXY(arg_3_0._gosptxt.transform, 0, 0)

	if arg_3_0._picCo.picType == StoryEnum.PictureType.PicTxt then
		gohelper.setActive(arg_3_0._simg.gameObject, false)

		local var_3_1 = GameLanguageMgr.instance:getLanguageTypeStoryIndex()
		local var_3_2 = GameLanguageMgr.instance:getShortCutByStoryIndex(var_3_1)
		local var_3_3 = string.splitToNumber(arg_3_0._picCo.picture, "#")
		local var_3_4 = StoryConfig.instance:getStoryPicTxtConfig(tonumber(var_3_3[1]))
		local var_3_5 = 0
		local var_3_6 = LuaUtil.containChinese(var_3_4[LangSettings.shortcutTab[LangSettings.zh]]) and var_3_4.fontType ~= 0 and arg_3_0._picCo.inType == StoryEnum.PictureInType.TxtFadeIn and 0 or var_3_4.fontType + 1

		if var_3_6 ~= 0 and not arg_3_0._spTxts[var_3_6] then
			logError(string.format("配置异常，目前还未设置相关fontType：%s的字体设定,请检查配置！", var_3_6))

			return
		end

		gohelper.setActive(arg_3_0._txtTmp.gameObject, var_3_6 == 0)
		gohelper.setActive(arg_3_0._gosptxt, var_3_6 ~= 0)

		for iter_3_1 = 1, 3 do
			gohelper.setActive(arg_3_0._spTxts[iter_3_1].gameObject, var_3_6 == iter_3_1)
		end

		local var_3_7 = var_3_4[var_3_2]
		local var_3_8 = 0.1 * LuaUtil.getStrLen(var_3_7) * var_3_3[2]

		if arg_3_0._picCo.inType ~= StoryEnum.PictureInType.TxtFadeIn and var_3_6 ~= 0 then
			arg_3_0._dtTweenId = ZProj.TweenHelper.DOText(arg_3_0._spTxts[var_3_6], var_3_7, var_3_8, nil, nil, nil, EaseType.Linear)
		end

		if arg_3_0._picCo.inType == StoryEnum.PictureInType.FadeIn or arg_3_0._picCo.inType == StoryEnum.PictureInType.TxtFadeIn then
			if var_3_6 == 0 then
				arg_3_0._txtTmp.text = var_3_7
			else
				arg_3_0._spTxts[var_3_6].text = var_3_7
			end

			ZProj.TweenHelper.DOFadeCanvasGroup(arg_3_0._picGo, 0, 1, arg_3_0._picCo.inTimes[GameLanguageMgr.instance:getVoiceTypeStoryIndex()], nil, nil, nil, EaseType.Linear)
		else
			arg_3_0._picGo:GetComponent(typeof(UnityEngine.CanvasGroup)).alpha = 1
		end

		if arg_3_0._picCo.effType == StoryEnum.PictureEffectType.Shake then
			if arg_3_0._picCo.effTimes[GameLanguageMgr.instance:getVoiceTypeStoryIndex()] < 0.1 then
				return
			end

			transformhelper.setLocalPosXY(arg_3_0._txtTmp.transform, arg_3_0._picCo.pos[1], arg_3_0._picCo.pos[2])
			transformhelper.setLocalPosXY(arg_3_0._gosptxt.transform, arg_3_0._picCo.pos[1], arg_3_0._picCo.pos[2])

			if arg_3_0._picCo.effDelayTimes[GameLanguageMgr.instance:getVoiceTypeStoryIndex()] < 0.1 then
				arg_3_0:_playShake()
			else
				TaskDispatcher.runDelay(arg_3_0._playShake, arg_3_0, arg_3_0._picCo.effDelayTimes[GameLanguageMgr.instance:getVoiceTypeStoryIndex()])
			end
		elseif arg_3_0._picCo.effType == StoryEnum.PictureEffectType.Scale then
			transformhelper.setLocalPosXY(arg_3_0._txtTmp.transform, arg_3_0._picCo.pos[1], arg_3_0._picCo.pos[2])
			transformhelper.setLocalPosXY(arg_3_0._gosptxt.transform, arg_3_0._picCo.pos[1], arg_3_0._picCo.pos[2])

			if arg_3_0._picCo.effDelayTimes[GameLanguageMgr.instance:getVoiceTypeStoryIndex()] < 0.1 then
				arg_3_0:_playScale()
			else
				TaskDispatcher.runDelay(arg_3_0._playScale, arg_3_0, arg_3_0._picCo.effDelayTimes[GameLanguageMgr.instance:getVoiceTypeStoryIndex()])
			end
		elseif arg_3_0._picCo.effType == StoryEnum.PictureEffectType.FollowBg then
			arg_3_0:_playFollowBg()
		end

		return
	end

	gohelper.setActive(arg_3_0._simg.gameObject, true)
	gohelper.setActive(arg_3_0._txtTmp.gameObject, false)
	gohelper.setActive(arg_3_0._gosptxt.gameObject, false)
	arg_3_0._simg:LoadImage(ResUrl.getStoryItem(arg_3_0._picCo.picture), arg_3_0._onPicImageLoaded, arg_3_0)
end

function var_0_0._onPicImageLoaded(arg_4_0)
	arg_4_0._picAni.enabled = false

	ZProj.UGUIHelper.SetImageSize(arg_4_0._simg.gameObject)

	arg_4_0._picImg = arg_4_0._simg.gameObject:GetComponent(gohelper.Type_Image)

	local var_4_0, var_4_1 = ZProj.UGUIHelper.GetImageSpriteSize(arg_4_0._picImg, 0, 0)

	if var_4_0 >= 1920 or var_4_1 > 1080 then
		gohelper.onceAddComponent(arg_4_0._simg.gameObject, typeof(ZProj.UIBgFitHeightAdapter))
		transformhelper.setLocalScale(arg_4_0._simg.gameObject.transform, var_4_0 / 1920, var_4_1 / 1080, 1)
	end

	local var_4_2 = SLFramework.UGUI.GuiHelper.ParseColor(arg_4_0._picCo.picColor)
	local var_4_3 = 1

	if arg_4_0._picCo.picType ~= StoryEnum.PictureType.Transparency then
		arg_4_0._picImg.color.a = var_4_3
	else
		arg_4_0._picImg.color = var_4_2
		var_4_3 = var_4_2.a
	end

	if arg_4_0._picCo.inType == StoryEnum.PictureInType.FadeIn then
		ZProj.TweenHelper.DOFadeCanvasGroup(arg_4_0._picGo, 0, var_4_3, arg_4_0._picCo.inTimes[GameLanguageMgr.instance:getVoiceTypeStoryIndex()], nil, nil, nil, EaseType.Linear)
	end

	if arg_4_0._picCo.effType == StoryEnum.PictureEffectType.Shake then
		if arg_4_0._picCo.effTimes[GameLanguageMgr.instance:getVoiceTypeStoryIndex()] < 0.1 then
			return
		end

		if arg_4_0._picCo.effDelayTimes[GameLanguageMgr.instance:getVoiceTypeStoryIndex()] < 0.1 then
			arg_4_0:_playShake()
		else
			TaskDispatcher.runDelay(arg_4_0._playShake, arg_4_0, arg_4_0._picCo.effDelayTimes[GameLanguageMgr.instance:getVoiceTypeStoryIndex()])
		end
	elseif arg_4_0._picCo.effType == StoryEnum.PictureEffectType.Scale then
		if arg_4_0._picCo.effDelayTimes[GameLanguageMgr.instance:getVoiceTypeStoryIndex()] < 0.1 then
			arg_4_0:_playScale()
		else
			TaskDispatcher.runDelay(arg_4_0._playScale, arg_4_0, arg_4_0._picCo.effDelayTimes[GameLanguageMgr.instance:getVoiceTypeStoryIndex()])
		end
	elseif arg_4_0._picCo.effType == StoryEnum.PictureEffectType.FollowBg then
		arg_4_0:_playFollowBg()
	end
end

function var_0_0._playShake(arg_5_0)
	arg_5_0._picAni.enabled = true

	local var_5_0 = {
		"low",
		"middle",
		"high"
	}

	arg_5_0._picAni:Play(var_5_0[arg_5_0._picCo.effDegree])

	arg_5_0._picAni.speed = arg_5_0._picCo.effRate

	TaskDispatcher.runDelay(arg_5_0._shakeStop, arg_5_0, arg_5_0._picCo.effTimes[GameLanguageMgr.instance:getVoiceTypeStoryIndex()])
end

function var_0_0._shakeStop(arg_6_0)
	arg_6_0._picAni.speed = arg_6_0._picCo.effRate

	arg_6_0._picAni:SetBool("stoploop", true)
end

function var_0_0._playFollowBg(arg_7_0)
	local var_7_0 = ViewMgr.instance:getContainer(ViewName.StoryBackgroundView).viewGO

	arg_7_0._bgGo = gohelper.findChild(var_7_0, "#go_upbg")

	local var_7_1, var_7_2 = transformhelper.getLocalPos(arg_7_0._picGo.transform)

	arg_7_0._deltaPos = {
		var_7_1,
		var_7_2
	}

	TaskDispatcher.runRepeat(arg_7_0._followBg, arg_7_0, 0.02)
end

function var_0_0._followBg(arg_8_0)
	local var_8_0, var_8_1 = transformhelper.getLocalScale(arg_8_0._bgGo.transform)

	transformhelper.setLocalPosXY(arg_8_0._picGo.transform, var_8_0 * arg_8_0._deltaPos[1], var_8_1 * arg_8_0._deltaPos[2])
	transformhelper.setLocalScale(arg_8_0._picGo.transform, var_8_1, var_8_1, 1)
end

function var_0_0._playScale(arg_9_0)
	local var_9_0 = arg_9_0._picCo.effTimes[GameLanguageMgr.instance:getVoiceTypeStoryIndex()]
	local var_9_1 = SLFramework.UGUI.GuiHelper.ParseColor(arg_9_0._picCo.picColor)

	if var_9_0 < 0.1 then
		transformhelper.setLocalScale(arg_9_0._picGo.transform, arg_9_0._picCo.effRate, arg_9_0._picCo.effRate, 1)
		transformhelper.setLocalPosXY(arg_9_0._picGo.transform, arg_9_0._picCo.pos[1], arg_9_0._picCo.pos[2])

		if arg_9_0._picCo.picType ~= StoryEnum.PictureType.Transparency then
			return
		end

		arg_9_0._picImg.color = var_9_1

		return
	end

	arg_9_0._posTweenId = ZProj.TweenHelper.DOAnchorPos(arg_9_0._picGo.transform, arg_9_0._picCo.pos[1], arg_9_0._picCo.pos[2], var_9_0, nil, nil, nil, arg_9_0._picCo.effDegree)
	arg_9_0._scaleTweenId = ZProj.TweenHelper.DOScale(arg_9_0._picGo.transform, arg_9_0._picCo.effRate, arg_9_0._picCo.effRate, 1, var_9_0)

	if arg_9_0._picCo.picType ~= StoryEnum.PictureType.Transparency then
		return
	end

	arg_9_0._alphaTweenId = ZProj.TweenHelper.DoFade(arg_9_0._picImg, arg_9_0._picImg.color.a, var_9_1.a, var_9_0, nil, nil, nil, EaseType.Linear)
end

function var_0_0.resetStep(arg_10_0)
	TaskDispatcher.cancelTask(arg_10_0._playShake, arg_10_0)
	TaskDispatcher.cancelTask(arg_10_0._shakeStop, arg_10_0)
	ZProj.TweenHelper.KillByObj(arg_10_0._picGo)
end

function var_0_0._killTweenId(arg_11_0)
	if arg_11_0._dtTweenId then
		ZProj.TweenHelper.KillById(arg_11_0._dtTweenId)

		arg_11_0._dtTweenId = nil
	end

	if arg_11_0._posTweenId then
		ZProj.TweenHelper.KillById(arg_11_0._posTweenId)

		arg_11_0._posTweenId = nil
	end

	if arg_11_0._scaleTweenId then
		ZProj.TweenHelper.KillById(arg_11_0._scaleTweenId)

		arg_11_0._scaleTweenId = nil
	end

	if arg_11_0._alphaTweenId then
		ZProj.TweenHelper.KillById(arg_11_0._alphaTweenId)

		arg_11_0._alphaTweenId = nil
	end
end

function var_0_0.reset(arg_12_0, arg_12_1, arg_12_2)
	if not arg_12_0._picGo then
		return
	end

	arg_12_0.viewGO = arg_12_1
	arg_12_0._picCo = arg_12_2

	TaskDispatcher.cancelTask(arg_12_0._realDestroy, arg_12_0)
	TaskDispatcher.cancelTask(arg_12_0._followBg, arg_12_0)
	arg_12_0:_killTweenId()

	if arg_12_0._picCo.picType == StoryEnum.PictureType.FullScreen then
		arg_12_0:_setFullPicture()
	else
		arg_12_0._picAni.enabled = false

		arg_12_0:_setNormalPicture()

		if arg_12_0._picCo.effType == StoryEnum.PictureEffectType.Shake then
			if arg_12_0._picCo.effTimes[GameLanguageMgr.instance:getVoiceTypeStoryIndex()] < 0.1 then
				return
			end

			if arg_12_0._picCo.effDelayTimes[GameLanguageMgr.instance:getVoiceTypeStoryIndex()] < 0.1 then
				arg_12_0:_playShake()
			else
				TaskDispatcher.runDelay(arg_12_0._playShake, arg_12_0, arg_12_0._picCo.effDelayTimes[GameLanguageMgr.instance:getVoiceTypeStoryIndex()])
			end
		elseif arg_12_0._picCo.effType == StoryEnum.PictureEffectType.Scale then
			if arg_12_0._picCo.effDelayTimes[GameLanguageMgr.instance:getVoiceTypeStoryIndex()] < 0.1 then
				arg_12_0:_playScale()
			else
				TaskDispatcher.runDelay(arg_12_0._playScale, arg_12_0, arg_12_0._picCo.effDelayTimes[GameLanguageMgr.instance:getVoiceTypeStoryIndex()])
			end
		elseif arg_12_0._picCo.effType == StoryEnum.PictureEffectType.FollowBg then
			arg_12_0:_playFollowBg()
		end
	end
end

function var_0_0.isFloatType(arg_13_0)
	return arg_13_0._picCo.picType == StoryEnum.PictureType.Float
end

function var_0_0._setNormalPicture(arg_14_0)
	arg_14_0._simg:UnLoadImage()
	arg_14_0._simg:LoadImage(ResUrl.getStoryItem(arg_14_0._picCo.picture), arg_14_0._onPictureLoaded, arg_14_0)

	if arg_14_0._picCo.picType ~= StoryEnum.PictureType.Transparency then
		return
	end

	local var_14_0 = SLFramework.UGUI.GuiHelper.ParseColor(arg_14_0._picCo.picColor)

	arg_14_0._picImg.color = Color.New(var_14_0.r, var_14_0.g, var_14_0.b, arg_14_0._picImg.color.a)
end

function var_0_0._setFullPicture(arg_15_0)
	if not arg_15_0._picParentGo then
		return
	end

	arg_15_0._picParentGo.transform:SetParent(arg_15_0.viewGO.transform)

	arg_15_0._picImg = arg_15_0._picGo:GetComponent(gohelper.Type_Image)

	local var_15_0 = SLFramework.UGUI.GuiHelper.ParseColor(arg_15_0._picCo.picColor)

	arg_15_0._picImg.color = var_15_0

	ZProj.TweenHelper.DOFadeCanvasGroup(arg_15_0._picGo, 0, var_15_0.a, arg_15_0._picCo.inTimes[GameLanguageMgr.instance:getVoiceTypeStoryIndex()], nil, nil, nil, EaseType.Linear)
end

function var_0_0._onFullFocusPictureLoaded(arg_16_0)
	arg_16_0._picLoaded = true

	if not arg_16_0._pictureLoader then
		return
	end

	arg_16_0._picGo = arg_16_0._pictureLoader:getInstGO()
	arg_16_0._picGo.name = arg_16_0._picName

	arg_16_0:_setFullPicture()

	if arg_16_0._setDestroy then
		TaskDispatcher.runDelay(arg_16_0._realDestroy, arg_16_0, 0.1)
	end
end

function var_0_0.destroyPicture(arg_17_0, arg_17_1, arg_17_2, arg_17_3)
	arg_17_0._picDestroyCo = arg_17_1
	arg_17_0._destroyKeepTime = arg_17_3 or 0

	if not arg_17_0._picDestroyCo then
		return
	end

	if arg_17_2 then
		arg_17_0:onDestroy()

		return
	end

	TaskDispatcher.cancelTask(arg_17_0._playShake, arg_17_0)
	TaskDispatcher.cancelTask(arg_17_0._realDestroy, arg_17_0)
	TaskDispatcher.cancelTask(arg_17_0._startDestroy, arg_17_0)
	TaskDispatcher.cancelTask(arg_17_0._checkDestroyItem, arg_17_0)

	if arg_17_0._picDestroyCo.picType == StoryEnum.PictureType.FullScreen then
		TaskDispatcher.runDelay(arg_17_0._startDestroy, arg_17_0, 0.1 + arg_17_0._destroyKeepTime)
	elseif arg_17_0._picDestroyCo.delayTimes[GameLanguageMgr.instance:getVoiceTypeStoryIndex()] > 0 then
		TaskDispatcher.runDelay(arg_17_0._startDestroy, arg_17_0, arg_17_0._picDestroyCo.delayTimes[GameLanguageMgr.instance:getVoiceTypeStoryIndex()])
	else
		arg_17_0:_startDestroy()
	end
end

function var_0_0._startDestroy(arg_18_0)
	arg_18_0._setDestroy = true

	if arg_18_0._picDestroyCo.outType == StoryEnum.PictureOutType.Hard then
		arg_18_0:onDestroy()
	else
		if not arg_18_0._picGo then
			return
		end

		if not arg_18_0._picLoaded then
			return
		end

		ZProj.TweenHelper.KillByObj(arg_18_0._picImg)

		if arg_18_0._picDestroyCo.outTimes[GameLanguageMgr.instance:getVoiceTypeStoryIndex()] > 0.1 then
			local var_18_0 = arg_18_0._picGo:GetComponent(typeof(UnityEngine.CanvasGroup)).alpha

			ZProj.TweenHelper.DOFadeCanvasGroup(arg_18_0._picGo, var_18_0, 0, arg_18_0._picDestroyCo.outTimes[GameLanguageMgr.instance:getVoiceTypeStoryIndex()] - 0.1, arg_18_0.onDestroy, arg_18_0, nil, EaseType.Linear)
		else
			arg_18_0:onDestroy()
		end
	end
end

function var_0_0.onDestroy(arg_19_0)
	TaskDispatcher.cancelTask(arg_19_0._build, arg_19_0)

	if arg_19_0._picDestroyCo and arg_19_0._picDestroyCo.picType == StoryEnum.PictureType.FullScreen then
		TaskDispatcher.runRepeat(arg_19_0._checkDestroyItem, arg_19_0, 0.1)
	else
		arg_19_0:_realDestroy()
	end
end

function var_0_0._checkDestroyItem(arg_20_0)
	if not arg_20_0._picLoaded then
		return
	end

	TaskDispatcher.cancelTask(arg_20_0._checkDestroyItem, arg_20_0)
	arg_20_0:_realDestroy()
end

function var_0_0._realDestroy(arg_21_0)
	arg_21_0:_killTweenId()

	if not arg_21_0._picLoaded then
		return
	end

	if arg_21_0._pictureLoader and arg_21_0._pictureLoader:getAssetItem() then
		arg_21_0._pictureLoader:getAssetItem():Release()
		arg_21_0._pictureLoader:dispose()

		arg_21_0._pictureLoader = nil
	end

	TaskDispatcher.cancelTask(arg_21_0._playShake, arg_21_0)
	TaskDispatcher.cancelTask(arg_21_0._followBg, arg_21_0)
	TaskDispatcher.cancelTask(arg_21_0._realDestroy, arg_21_0)
	TaskDispatcher.cancelTask(arg_21_0._checkDestroyItem, arg_21_0)
	TaskDispatcher.cancelTask(arg_21_0._startDestroy, arg_21_0)
	TaskDispatcher.cancelTask(arg_21_0._build, arg_21_0)
	ZProj.TweenHelper.KillByObj(arg_21_0._picGo)
	TaskDispatcher.cancelTask(arg_21_0._shakeStop, arg_21_0)

	if arg_21_0._simg then
		arg_21_0._simg:UnLoadImage()

		arg_21_0._simg = nil
	end

	gohelper.destroy(arg_21_0._picParentGo)
end

return var_0_0
