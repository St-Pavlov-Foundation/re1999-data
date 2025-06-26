module("modules.logic.story.view.StoryBackgroundView", package.seeall)

local var_0_0 = class("StoryBackgroundView", BaseView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._gobottom = gohelper.findChild(arg_1_0.viewGO, "#go_bottombg")
	arg_1_0._simagebgold = gohelper.findChildSingleImage(arg_1_0.viewGO, "#go_bottombg/#simage_bgold")
	arg_1_0._simagebgoldtop = gohelper.findChildSingleImage(arg_1_0.viewGO, "#go_bottombg/#simage_bgold/#simage_bgoldtop")
	arg_1_0._bottombgSpine = gohelper.findChild(arg_1_0.viewGO, "#go_bottombg/#go_bottombgspine")
	arg_1_0._gofront = gohelper.findChild(arg_1_0.viewGO, "#go_upbg")
	arg_1_0._goblack = gohelper.findChild(arg_1_0.viewGO, "#go_blackbg")
	arg_1_0._simagebgimg = gohelper.findChildSingleImage(arg_1_0.viewGO, "#go_upbg/#simage_bgimg")
	arg_1_0._simagebgimgtop = gohelper.findChildSingleImage(arg_1_0.viewGO, "#go_upbg/#simage_bgimg/#simage_bgtop")
	arg_1_0._upbgspine = gohelper.findChild(arg_1_0.viewGO, "#go_upbg/#go_upbgspine")
	arg_1_0._gosideways = gohelper.findChild(arg_1_0.viewGO, "#go_sideways")
	arg_1_0._goblur = gohelper.findChild(arg_1_0.viewGO, "#go_upbg/#simage_bgimg/#go_blur")
	arg_1_0._gobliteff = gohelper.findChild(arg_1_0.viewGO, "#go_blitbg")
	arg_1_0._gobliteffsecond = gohelper.findChild(arg_1_0.viewGO, "#go_blitbgsecond")

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

function var_0_0._editableInitView(arg_4_0)
	arg_4_0._cimagebgold = arg_4_0._simagebgold.gameObject:GetComponent(typeof(UnityEngine.UI.CustomImage))
	arg_4_0._cimagebgimg = arg_4_0._simagebgimg.gameObject:GetComponent(typeof(UnityEngine.UI.CustomImage))
	arg_4_0._imagebgold = gohelper.findChildImage(arg_4_0.viewGO, "#go_bottombg/#simage_bgold")
	arg_4_0._imagebgoldtop = gohelper.findChildImage(arg_4_0.viewGO, "#go_bottombg/#simage_bgold/#simage_bgoldtop")
	arg_4_0._imagebg = gohelper.findChildImage(arg_4_0.viewGO, "#go_upbg/#simage_bgimg")
	arg_4_0._imagebgtop = gohelper.findChildImage(arg_4_0.viewGO, "#go_upbg/#simage_bgimg/#simage_bgtop")
	arg_4_0._imgFitHeight = arg_4_0._simagebgimg.gameObject:GetComponent(typeof(ZProj.UIBgFitHeightAdapter))
	arg_4_0._imgOldFitHeight = arg_4_0._imagebgold.gameObject:GetComponent(typeof(ZProj.UIBgFitHeightAdapter))
	arg_4_0._bgAnimator = arg_4_0._gofront.gameObject:GetComponent(typeof(UnityEngine.Animator))
	arg_4_0._bgBlur = arg_4_0._simagebgimg.gameObject:GetComponent(typeof(UrpCustom.UIGaussianEffect))
	arg_4_0._borderCanvas = arg_4_0._goblack:GetComponent(typeof(UnityEngine.CanvasGroup))
	arg_4_0._blitEff = arg_4_0._gobliteff:GetComponent(typeof(UrpCustom.UIBlitEffect))
	arg_4_0._blitEffSecond = arg_4_0._gobliteffsecond:GetComponent(typeof(UrpCustom.UIBlitEffect))

	arg_4_0:_loadRes()
	arg_4_0:_initData()
end

function var_0_0._loadRes(arg_5_0)
	local var_5_0 = "ui/materials/dynamic/story_fisheye.mat"
	local var_5_1 = "ui/materials/dynamic/uibackgoundblur.mat"
	local var_5_2 = "ui/materials/dynamic/uibackgoundblur_zone.mat"
	local var_5_3 = "ui/materials/dynamic/story_dissolve.mat"

	arg_5_0._matLoader = MultiAbLoader.New()

	arg_5_0._matLoader:addPath(var_5_0)
	arg_5_0._matLoader:addPath(var_5_1)
	arg_5_0._matLoader:addPath(var_5_2)
	arg_5_0._matLoader:addPath(var_5_3)
	arg_5_0._matLoader:startLoad(function()
		local var_6_0 = arg_5_0._matLoader:getAssetItem(var_5_0)

		if var_6_0 then
			arg_5_0._fisheyeMat = var_6_0:GetResource(var_5_0)
		else
			logError("Resource is not found at path : " .. var_5_0)
		end

		local var_6_1 = arg_5_0._matLoader:getAssetItem(var_5_1)

		if var_6_1 then
			arg_5_0._blurMat = var_6_1:GetResource(var_5_1)
		else
			logError("Resource is not found at path : " .. var_5_1)
		end

		local var_6_2 = arg_5_0._matLoader:getAssetItem(var_5_2)

		if var_6_2 then
			arg_5_0._blurZoneMat = var_6_2:GetResource(var_5_2)
		else
			logError("Resource is not found at path : " .. var_5_2)
		end

		local var_6_3 = arg_5_0._matLoader:getAssetItem(var_5_3)

		if var_6_3 then
			arg_5_0._dissolveMat = var_6_3:GetResource(var_5_3)
		else
			logError("Resource is not found at path : " .. var_5_3)
		end
	end, arg_5_0)

	arg_5_0.handleBgEffectFuncDict = {
		[StoryEnum.BgTransType.Hard] = arg_5_0._hardTrans,
		[StoryEnum.BgTransType.TransparencyFade] = arg_5_0._fadeTrans,
		[StoryEnum.BgTransType.DarkFade] = arg_5_0._darkFadeTrans,
		[StoryEnum.BgTransType.WhiteFade] = arg_5_0._whiteFadeTrans,
		[StoryEnum.BgTransType.UpDarkFade] = arg_5_0._darkUpTrans,
		[StoryEnum.BgTransType.RightDarkFade] = arg_5_0._rightDarkTrans,
		[StoryEnum.BgTransType.Fragmentate] = arg_5_0._fragmentTrans,
		[StoryEnum.BgTransType.Dissolve] = arg_5_0._dissolveTrans,
		[StoryEnum.BgTransType.LeftDarkFade] = arg_5_0._leftDarkTrans,
		[StoryEnum.BgTransType.MovieChangeStart] = arg_5_0._movieChangeStartTrans,
		[StoryEnum.BgTransType.MovieChangeSwitch] = arg_5_0._movieChangeSwitchTrans,
		[StoryEnum.BgTransType.TurnPage3] = arg_5_0._turnPageTrans,
		[StoryEnum.BgTransType.ShakeCamera] = arg_5_0._shakeCameraTrans
	}
end

function var_0_0._initData(arg_7_0)
	arg_7_0._borderCanvas.alpha = 0
	arg_7_0._bgSpine = nil
	arg_7_0._bgCo = {}
	arg_7_0._lastBgCo = {}

	gohelper.setActive(arg_7_0._gobottom, false)
	gohelper.setActive(arg_7_0._gofront, false)
	arg_7_0:_showBgBottom(false)
	arg_7_0:_showBgTop(false)

	if StoryModel.instance.skipFade then
		gohelper.setActive(arg_7_0._goblack, false)
	end
end

function var_0_0.onOpen(arg_8_0)
	ViewMgr.instance:openView(ViewName.StoryHeroView, nil, false)
	ViewMgr.instance:openView(ViewName.StoryLeadRoleSpineView, nil, true)
	ViewMgr.instance:openView(ViewName.StoryView, nil, true)
	arg_8_0:_addEvents()
end

function var_0_0._addEvents(arg_9_0)
	arg_9_0:addEventCb(StoryController.instance, StoryEvent.RefreshStep, arg_9_0._onUpdateUI, arg_9_0)
	arg_9_0:addEventCb(StoryController.instance, StoryEvent.RefreshBackground, arg_9_0._colorFadeBgRefresh, arg_9_0)
	arg_9_0:addEventCb(StoryController.instance, StoryEvent.ShowBackground, arg_9_0._showBg, arg_9_0)
end

function var_0_0._showBg(arg_10_0)
	gohelper.setActive(arg_10_0._gobottom, true)
	gohelper.setActive(arg_10_0._gofront, true)
end

function var_0_0._onUpdateUI(arg_11_0, arg_11_1)
	arg_11_0:_checkPlayBorderFade(arg_11_1)

	if #arg_11_1.branches > 0 then
		return
	end

	arg_11_0._bgParam = arg_11_1

	arg_11_0:_checkPlayBgBlurFade()
	TaskDispatcher.cancelTask(arg_11_0._startShake, arg_11_0)

	local var_11_0 = StoryStepModel.instance:getStepListById(arg_11_0._bgParam.stepId).bg

	if var_11_0.transType == StoryEnum.BgTransType.Keep then
		return
	end

	arg_11_0._lastBgCo = LuaUtil.deepCopy(arg_11_0._bgCo)
	arg_11_0._bgCo = var_11_0

	arg_11_0:_resetData()
	TaskDispatcher.cancelTask(arg_11_0._enterChange, arg_11_0)
	TaskDispatcher.runDelay(arg_11_0._enterChange, arg_11_0, arg_11_0._bgCo.waitTimes[GameLanguageMgr.instance:getVoiceTypeStoryIndex()])
end

function var_0_0._checkPlayBorderFade(arg_12_0, arg_12_1)
	local var_12_0 = StoryStepModel.instance:getStepListById(arg_12_1.stepId).mourningBorder

	if arg_12_0._fadeType and arg_12_0._fadeType == var_12_0.borderType then
		return
	end

	arg_12_0._fadeType = var_12_0.borderType

	if arg_12_0._fadeType == StoryEnum.BorderType.Keep then
		return
	end

	if arg_12_0._borderFadeId then
		ZProj.TweenHelper.KillById(arg_12_0._borderFadeId)
	end

	if var_12_0.borderType == StoryEnum.BorderType.None then
		arg_12_0._borderCanvas.alpha = 1
	elseif var_12_0.borderType == StoryEnum.BorderType.FadeOut then
		arg_12_0._borderFadeId = ZProj.TweenHelper.DOFadeCanvasGroup(arg_12_0._goblack, 1, 0, var_12_0.borderTimes[GameLanguageMgr.instance:getVoiceTypeStoryIndex()])
	elseif var_12_0.borderType == StoryEnum.BorderType.FadeIn then
		arg_12_0._borderFadeId = ZProj.TweenHelper.DOFadeCanvasGroup(arg_12_0._goblack, 0, 1, var_12_0.borderTimes[GameLanguageMgr.instance:getVoiceTypeStoryIndex()])
	end
end

function var_0_0._checkPlayBgBlurFade(arg_13_0)
	local var_13_0 = StoryStepModel.instance:getStepListById(arg_13_0._bgParam.stepId).bg

	if var_13_0.bgType ~= StoryEnum.BgType.Picture then
		return
	end

	if var_13_0.transType == StoryEnum.BgTransType.Keep then
		return
	end

	if var_13_0.bgImg ~= arg_13_0._bgCo.bgImg then
		return
	end

	if arg_13_0._bgCo.effType ~= StoryEnum.BgEffectType.BgBlur then
		return
	end

	arg_13_0:_actBgBlurFade()
end

function var_0_0._resetData(arg_14_0)
	if arg_14_0._goRightFade then
		gohelper.setActive(arg_14_0._goRightFade, false)
	end

	if arg_14_0._bgCo.transType ~= StoryEnum.BgTransType.RightDarkFade and arg_14_0._goLeftFade then
		gohelper.setActive(arg_14_0._goLeftFade, false)
	end

	if arg_14_0._bgCo.transType ~= StoryEnum.BgTransType.MovieChangeStart and arg_14_0._bgCo.transType ~= StoryEnum.BgTransType.MovieChangeSwitch then
		if arg_14_0._bgMovieGo then
			gohelper.setActive(arg_14_0._bgMovieGo, false)
		end

		if arg_14_0._moveCameraAnimator and arg_14_0._moveCameraAnimator.runtimeAnimatorController == arg_14_0._cameraMovieAnimator then
			arg_14_0._moveCameraAnimator.runtimeAnimatorController = nil
		end
	end

	gohelper.setActive(arg_14_0._goblur, false)

	arg_14_0._imgFitHeight.enabled = false
	arg_14_0._imgOldFitHeight.enabled = false
	arg_14_0._bgBlur.enabled = arg_14_0._bgCo.effType == StoryEnum.BgEffectType.BgBlur
	arg_14_0._cimagebgimg.vecInSide = Vector4.zero
	arg_14_0._cimagebgold.vecInSide = Vector4.zero
	arg_14_0._bgBlur.zoneImage = nil

	if not arg_14_0:_ignoreClearMat() then
		arg_14_0._imagebg.material = nil
	end

	arg_14_0._imagebgtop.material = nil
	arg_14_0._imagebgold.material = nil
	arg_14_0._imagebgoldtop.material = nil

	arg_14_0:_shakeStop()
	TaskDispatcher.cancelTask(arg_14_0._shakeStop, arg_14_0)
	ZProj.TweenHelper.KillByObj(arg_14_0._simagebgimg.gameObject.transform)

	if arg_14_0._dissolveId then
		ZProj.TweenHelper.KillById(arg_14_0._dissolveId)

		arg_14_0._dissolveId = nil
	end

	if arg_14_0._blurId then
		ZProj.TweenHelper.KillById(arg_14_0._blurId)

		arg_14_0._blurId = nil
	end
end

function var_0_0._ignoreClearMat(arg_15_0)
	if arg_15_0._imagebg.material == arg_15_0._blurMat and arg_15_0._bgCo.effType == StoryEnum.BgEffectType.BgBlur then
		return true
	end

	if (arg_15_0._lastBgCo.transType == StoryEnum.BgTransType.MeltOut15 or arg_15_0._lastBgCo.transType == StoryEnum.BgTransType.MeltOut25) and (arg_15_0._bgCo.transType == StoryEnum.BgTransType.MeltIn15 or arg_15_0._bgCo.transType == StoryEnum.BgTransType.MeltIn25 or arg_15_0._bgCo.transType == StoryEnum.BgTransType.Hard) then
		return true
	end

	return false
end

function var_0_0._enterChange(arg_16_0)
	arg_16_0._rootAni = nil

	if arg_16_0._loader then
		arg_16_0._loader:dispose()

		arg_16_0._loader = nil
	end

	if arg_16_0._bgSubGo then
		gohelper.destroy(arg_16_0._bgSubGo)

		arg_16_0._bgSubGo = nil
	end

	arg_16_0._matPath = nil
	arg_16_0._prefabPath = nil

	if arg_16_0.handleBgEffectFuncDict[arg_16_0._bgCo.transType] then
		arg_16_0.handleBgEffectFuncDict[arg_16_0._bgCo.transType](arg_16_0)
	else
		arg_16_0:_commonTrans(arg_16_0._bgCo.transType)
	end
end

function var_0_0._colorFadeBgRefresh(arg_17_0)
	if StoryBgZoneModel.instance:getBgZoneByPath(arg_17_0._bgCo.bgImg) then
		arg_17_0._cimagebgimg.enabled = true

		gohelper.setActive(arg_17_0._simagebgimgtop.gameObject, true)
	end

	arg_17_0:_hardTrans()
end

function var_0_0._hardTrans(arg_18_0)
	arg_18_0:_refreshBg()
	arg_18_0:_resetBgState()
end

function var_0_0._refreshBg(arg_19_0)
	if arg_19_0._lastCaptureTexture then
		UnityEngine.RenderTexture.ReleaseTemporary(arg_19_0._lastCaptureTexture)

		arg_19_0._lastCaptureTexture = nil
	end

	if not arg_19_0._simagebgimg then
		return
	end

	if arg_19_0._bgCo.bgType == StoryEnum.BgType.Picture then
		arg_19_0._lastCaptureTexture = UnityEngine.RenderTexture.GetTemporary(arg_19_0._blitEff.capturedTexture.width, arg_19_0._blitEff.capturedTexture.height, 0, UnityEngine.RenderTextureFormat.ARGB32)

		UnityEngine.Graphics.CopyTexture(arg_19_0._blitEff.capturedTexture, arg_19_0._lastCaptureTexture)

		if arg_19_0._bgCo.bgImg == "" then
			arg_19_0:_showBgTop(false)
			arg_19_0:_showBgBottom(false)

			return
		end

		arg_19_0:_showBgTop(true)
		gohelper.setActive(arg_19_0._upbgspine, false)
		arg_19_0:_loadTopBg()

		if arg_19_0._bgScaleId then
			ZProj.TweenHelper.KillById(arg_19_0._bgScaleId)

			arg_19_0._bgScaleId = nil
		end

		if arg_19_0._bgPosId then
			ZProj.TweenHelper.KillById(arg_19_0._bgPosId)

			arg_19_0._bgPosId = nil
		end

		if arg_19_0._bgRotateId then
			ZProj.TweenHelper.KillById(arg_19_0._bgRotateId)

			arg_19_0._bgRotateId = nil
		end

		if arg_19_0._lastBgCo.bgType == StoryEnum.BgType.Picture then
			if not arg_19_0._lastBgCo.bgImg or arg_19_0._lastBgCo.bgImg == "" then
				arg_19_0:_showBgBottom(false)

				return
			end

			arg_19_0:_loadBottomBg()
		else
			gohelper.setActive(arg_19_0._bottombgSpine, true)
			arg_19_0:_showBgBottom(false)
			arg_19_0:_onOldBgEffectLoaded()
		end
	else
		arg_19_0:_showBgTop(false)

		if arg_19_0._bgCo.bgImg == "" or string.split(arg_19_0._bgCo.bgImg, ".")[1] == "" then
			gohelper.setActive(arg_19_0._upbgspine, false)

			return
		end

		gohelper.setActive(arg_19_0._upbgspine, true)

		arg_19_0._effectLoader = PrefabInstantiate.Create(arg_19_0._upbgspine)

		arg_19_0._effectLoader:startLoad(arg_19_0._bgCo.bgImg, arg_19_0._onNewBgEffectLoaded, arg_19_0)

		if arg_19_0._lastBgCo.bgType == StoryEnum.BgType.Picture then
			if not arg_19_0._lastBgCo.bgImg or arg_19_0._lastBgCo.bgImg == "" then
				arg_19_0:_showBgBottom(false)

				return
			end

			arg_19_0:_loadBottomBg()
		else
			arg_19_0:_showBgBottom(false)
			gohelper.setActive(arg_19_0._bottombgSpine, true)
			arg_19_0:_onOldBgEffectLoaded()
		end
	end
end

function var_0_0._onNewBgImgLoaded(arg_20_0)
	if arg_20_0._bgCo.transType == StoryEnum.BgTransType.Hard and arg_20_0._bgCo.effType == StoryEnum.BgEffectType.None then
		arg_20_0._imagebg.material = nil
	end

	if not arg_20_0._imagebg or not arg_20_0._imagebg.sprite then
		return
	end

	gohelper.setActive(arg_20_0.viewGO, true)

	local var_20_0, var_20_1 = ZProj.UGUIHelper.GetImageSpriteSize(arg_20_0._imagebg, 0, 0)

	arg_20_0._imgFitHeight.enabled = var_20_1 < 1080

	if var_20_1 >= 1080 then
		transformhelper.setLocalScale(arg_20_0._simagebgimg.transform, 1.05, 1.05, 1.05)
	end

	arg_20_0._imagebg:SetNativeSize()
	arg_20_0:_checkPlayEffect()
end

function var_0_0._showBgBottom(arg_21_0, arg_21_1)
	gohelper.setActive(arg_21_0._simagebgold.gameObject, arg_21_1)

	if not arg_21_1 then
		arg_21_0._simagebgold:UnLoadImage()
	end
end

function var_0_0._showBgTop(arg_22_0, arg_22_1)
	gohelper.setActive(arg_22_0._simagebgimg.gameObject, arg_22_1)

	if not arg_22_1 then
		arg_22_0._simagebgimg:UnLoadImage()
	end
end

function var_0_0._loadBottomBg(arg_23_0)
	gohelper.setActive(arg_23_0._simagebgold.gameObject, true)
	gohelper.setActive(arg_23_0._bottombgSpine, false)
	arg_23_0._simagebgold:UnLoadImage()
	arg_23_0._simagebgoldtop:UnLoadImage()

	local var_23_0 = StoryBgZoneModel.instance:getBgZoneByPath(arg_23_0._lastBgCo.bgImg)

	gohelper.setActive(arg_23_0._simagebgoldtop.gameObject, var_23_0)

	if var_23_0 then
		arg_23_0._simagebgoldtop:LoadImage(ResUrl.getStoryRes(var_23_0.path), arg_23_0._onOldBgImgTopLoaded, arg_23_0)
		transformhelper.setLocalPosXY(arg_23_0._simagebgoldtop.gameObject.transform, var_23_0.offsetX, var_23_0.offsetY)
		arg_23_0._simagebgold:LoadImage(ResUrl.getStoryRes(var_23_0.sourcePath), arg_23_0._onOldBgImgLoaded, arg_23_0)

		arg_23_0._cimagebgold.vecInSide = Vector4.zero
	else
		arg_23_0._simagebgold:LoadImage(ResUrl.getStoryRes(arg_23_0._lastBgCo.bgImg), arg_23_0._onOldBgImgLoaded, arg_23_0)

		arg_23_0._cimagebgold.vecInSide = Vector4.zero
	end
end

function var_0_0._loadTopBg(arg_24_0)
	local var_24_0 = StoryBgZoneModel.instance:getBgZoneByPath(arg_24_0._bgCo.bgImg)

	gohelper.setActive(arg_24_0._simagebgimgtop.gameObject, false)

	arg_24_0._cimagebgimg.enabled = true

	if var_24_0 then
		if arg_24_0._simagebgimgtop.curImageUrl == ResUrl.getStoryRes(var_24_0.path) then
			arg_24_0:_onNewBgImgTopLoaded()
		else
			arg_24_0._simagebgimgtop:UnLoadImage()
			gohelper.setActive(arg_24_0._simagebgimgtop.gameObject, true)
			arg_24_0._simagebgimgtop:LoadImage(ResUrl.getStoryRes(var_24_0.path), arg_24_0._onNewBgImgTopLoaded, arg_24_0)
			transformhelper.setLocalPosXY(arg_24_0._simagebgimgtop.gameObject.transform, var_24_0.offsetX, var_24_0.offsetY)
		end
	else
		if arg_24_0._simagebgimg.curImageUrl == ResUrl.getStoryRes(arg_24_0._bgCo.bgImg) then
			arg_24_0:_onNewBgImgLoaded()
		else
			arg_24_0._simagebgimg:UnLoadImage()
			arg_24_0._simagebgimg:LoadImage(ResUrl.getStoryRes(arg_24_0._bgCo.bgImg), arg_24_0._onNewBgImgLoaded, arg_24_0)
		end

		arg_24_0._cimagebgimg.vecInSide = Vector4.zero
	end
end

function var_0_0._onNewBgImgTopLoaded(arg_25_0)
	local var_25_0 = StoryBgZoneModel.instance:getBgZoneByPath(arg_25_0._bgCo.bgImg)

	arg_25_0._imagebgtop:SetNativeSize()
	arg_25_0:_setZoneMat()

	if arg_25_0._simagebgimg.curImageUrl == ResUrl.getStoryRes(var_25_0.sourcePath) then
		arg_25_0:_onNewZoneBgImgLoaded()
	else
		arg_25_0._simagebgimg:UnLoadImage()
		arg_25_0._simagebgimg:LoadImage(ResUrl.getStoryRes(var_25_0.sourcePath), arg_25_0._onNewZoneBgImgLoaded, arg_25_0)
	end
end

function var_0_0._onNewZoneBgImgLoaded(arg_26_0)
	gohelper.setActive(arg_26_0._simagebgimgtop.gameObject, true)
	arg_26_0:_onNewBgImgLoaded()
	arg_26_0:_setZoneMat()
end

function var_0_0._setZoneMat(arg_27_0)
	if not arg_27_0._imagebg or not arg_27_0._imagebg.material or not arg_27_0._imagebgtop or not arg_27_0._imagebgtop.sprite then
		return
	end

	local var_27_0 = StoryBgZoneModel.instance:getBgZoneByPath(arg_27_0._bgCo.bgImg)
	local var_27_1 = Vector4(recthelper.getWidth(arg_27_0._imagebgtop.transform), recthelper.getHeight(arg_27_0._imagebgtop.transform), var_27_0.offsetX, var_27_0.offsetY)

	arg_27_0._cimagebgimg.vecInSide = var_27_1

	if arg_27_0._bgBlur.enabled then
		arg_27_0._bgBlur.zoneImage = arg_27_0._imagebgtop
	end
end

function var_0_0._onOldBgImgTopLoaded(arg_28_0)
	arg_28_0._imagebgoldtop:SetNativeSize()
end

function var_0_0._onOldBgImgLoaded(arg_29_0)
	local var_29_0, var_29_1 = ZProj.UGUIHelper.GetImageSpriteSize(arg_29_0._imagebgold, 0, 0)

	transformhelper.setLocalPosXY(arg_29_0._simagebgold.gameObject.transform, arg_29_0._lastBgCo.offset[1], arg_29_0._lastBgCo.offset[2])
	transformhelper.setLocalRotation(arg_29_0._simagebgold.gameObject.transform, 0, 0, arg_29_0._lastBgCo.angle)
	transformhelper.setLocalScale(arg_29_0._gobottom.transform, arg_29_0._lastBgCo.scale, arg_29_0._lastBgCo.scale, 1)

	arg_29_0._imgOldFitHeight.enabled = var_29_1 < 1080

	if var_29_1 >= 1080 then
		transformhelper.setLocalScale(arg_29_0._simagebgold.transform, 1.05, 1.05, 1.05)
	end

	arg_29_0._imagebgold:SetNativeSize()
end

function var_0_0._onNewBgEffectLoaded(arg_30_0)
	if arg_30_0._bgEffectGo then
		gohelper.destroy(arg_30_0._bgEffectGo)

		arg_30_0._bgEffectGo = nil
	end

	arg_30_0._bgEffectGo = arg_30_0._effectLoader:getInstGO()

	arg_30_0:_checkPlayEffect()
end

function var_0_0._onOldBgEffectLoaded(arg_31_0)
	if arg_31_0._bgEffectOldGo then
		gohelper.destroy(arg_31_0._bgEffectOldGo)

		arg_31_0._bgEffectOldGo = nil
	end

	if arg_31_0._bgEffectGo then
		arg_31_0._bgEffectOldGo = gohelper.clone(arg_31_0._bgEffectGo, arg_31_0._bottombgSpine, "effectold")

		gohelper.destroy(arg_31_0._bgEffectGo)

		arg_31_0._bgEffectGo = nil
	end
end

function var_0_0._advanceLoadBgOld(arg_32_0)
	arg_32_0._simagebgold:UnLoadImage()
	arg_32_0._simagebgoldtop:UnLoadImage()

	local var_32_0 = StoryBgZoneModel.instance:getBgZoneByPath(arg_32_0._bgCo.bgImg)

	gohelper.setActive(arg_32_0._simagebgoldtop.gameObject, var_32_0)

	if var_32_0 then
		arg_32_0._simagebgoldtop:LoadImage(ResUrl.getStoryRes(var_32_0.path), arg_32_0._onOldBgImgTopLoaded, arg_32_0)
		transformhelper.setLocalPosXY(arg_32_0._simagebgoldtop.gameObject.transform, var_32_0.offsetX, var_32_0.offsetY)
		arg_32_0._simagebgold:LoadImage(ResUrl.getStoryRes(var_32_0.sourcePath), function()
			arg_32_0._imagebgold.color = Color.white

			arg_32_0._imagebgold:SetNativeSize()
			arg_32_0:_onNewBgImgLoaded()
		end)
	else
		arg_32_0._simagebgold:LoadImage(ResUrl.getStoryRes(arg_32_0._bgCo.bgImg), function()
			arg_32_0._imagebgold.color = Color.white

			arg_32_0._imagebgold:SetNativeSize()
			arg_32_0:_onNewBgImgLoaded()
		end)
	end
end

function var_0_0._checkPlayEffect(arg_35_0)
	if arg_35_0._lastBgSubGo and arg_35_0._lastBgCo.effType ~= StoryEnum.BgEffectType.BgGray then
		gohelper.destroy(arg_35_0._lastBgSubGo)

		arg_35_0._lastBgSubGo = nil
	end

	if arg_35_0._bgCo.effType ~= StoryEnum.BgEffectType.Interfere then
		arg_35_0:_resetInterfere()
	end

	if arg_35_0._bgCo.effType ~= StoryEnum.BgEffectType.Sketch then
		arg_35_0:_resetSketch()
	end

	if arg_35_0._bgCo.effType ~= StoryEnum.BgEffectType.BlindFilter then
		arg_35_0:_resetBlindFilter()
	end

	if arg_35_0._bgCo.effType ~= StoryEnum.BgEffectType.Opposition then
		arg_35_0:_resetOpposition()
	end

	if arg_35_0._bgCo.effType ~= StoryEnum.BgEffectType.RgbSplit then
		arg_35_0:_resetRgbSplit()
	end

	arg_35_0:_actFullGrayUpdate(0.5)
	arg_35_0:_actBgGrayUpdate(0)

	if arg_35_0._bgCo.effType == StoryEnum.BgEffectType.BgBlur then
		arg_35_0:_actBgBlur()

		return
	elseif arg_35_0._bgCo.effType == StoryEnum.BgEffectType.FishEye then
		arg_35_0:_actFishEye()
	elseif arg_35_0._bgCo.effType == StoryEnum.BgEffectType.Shake then
		arg_35_0:_actShake()
	elseif arg_35_0._bgCo.effType == StoryEnum.BgEffectType.FullBlur then
		arg_35_0:_actFullBlur()
	elseif arg_35_0._bgCo.effType == StoryEnum.BgEffectType.BgGray then
		arg_35_0:_actBgGray()
	elseif arg_35_0._bgCo.effType == StoryEnum.BgEffectType.FullGray then
		arg_35_0:_actFullGray()
	elseif arg_35_0._bgCo.effType == StoryEnum.BgEffectType.Interfere then
		arg_35_0:_showInterfere()
	elseif arg_35_0._bgCo.effType == StoryEnum.BgEffectType.Sketch then
		arg_35_0:_showSketch()
	elseif arg_35_0._bgCo.effType == StoryEnum.BgEffectType.BlindFilter then
		arg_35_0:_showBlindFilter()
	elseif arg_35_0._bgCo.effType == StoryEnum.BgEffectType.Opposition then
		arg_35_0:_showOpposition()
	elseif arg_35_0._bgCo.effType == StoryEnum.BgEffectType.RgbSplit then
		arg_35_0:_showRgbSplit()
	end

	arg_35_0._bgBlur.blurWeight = 0

	gohelper.setActive(arg_35_0._goblur, false)

	arg_35_0._bgBlur.enabled = false
	arg_35_0._cimagebgimg.vecInSide = Vector4.zero
	arg_35_0._bgBlur.zoneImage = nil
end

function var_0_0._resetBgState(arg_36_0)
	local var_36_0 = arg_36_0._bgCo.transTimes[GameLanguageMgr.instance:getVoiceTypeStoryIndex()]

	if var_36_0 < 0.05 then
		transformhelper.setLocalPosXY(arg_36_0._simagebgimg.gameObject.transform, arg_36_0._bgCo.offset[1], arg_36_0._bgCo.offset[2])
		transformhelper.setLocalRotation(arg_36_0._simagebgimg.gameObject.transform, 0, 0, arg_36_0._bgCo.angle)
		transformhelper.setLocalScale(arg_36_0._gofront.transform, arg_36_0._bgCo.scale, arg_36_0._bgCo.scale, 1)
	else
		local var_36_1 = arg_36_0._bgCo.effType == StoryEnum.BgEffectType.MoveCurve and arg_36_0._bgCo.effDegree or EaseType.InCubic

		arg_36_0._bgPosId = ZProj.TweenHelper.DOAnchorPos(arg_36_0._simagebgimg.gameObject.transform, arg_36_0._bgCo.offset[1], arg_36_0._bgCo.offset[2], var_36_0, nil, nil, nil, var_36_1)
		arg_36_0._bgRotateId = ZProj.TweenHelper.DOLocalRotate(arg_36_0._simagebgimg.gameObject.transform, 0, 0, arg_36_0._bgCo.angle, var_36_0, nil, nil, nil, EaseType.InSine)
		arg_36_0._bgScaleId = ZProj.TweenHelper.DOScale(arg_36_0._gofront.gameObject.transform, arg_36_0._bgCo.scale, arg_36_0._bgCo.scale, 1, var_36_0, nil, nil, nil, EaseType.InQuad)
	end
end

function var_0_0._hideBg(arg_37_0)
	arg_37_0:_showBgBottom(false)
end

function var_0_0._fadeTrans(arg_38_0)
	if arg_38_0._bgCo.bgType == StoryEnum.BgType.Picture then
		arg_38_0._imagebg.color.a = 0
		arg_38_0._imagebg.color = Color.white

		arg_38_0:_showBgTop(true)
		arg_38_0:_resetBgState()

		if arg_38_0._bgFadeId then
			ZProj.TweenHelper.KillById(arg_38_0._bgFadeId)
		end

		arg_38_0._bgFadeId = ZProj.TweenHelper.DOFadeCanvasGroup(arg_38_0._imagebg.gameObject, 0, 1, arg_38_0._bgCo.fadeTimes[GameLanguageMgr.instance:getVoiceTypeStoryIndex()], arg_38_0._hideBg, arg_38_0, nil, EaseType.Linear)

		arg_38_0:_showBgBottom(true)
		arg_38_0:_loadTopBg()

		if not arg_38_0._lastBgCo or not next(arg_38_0._lastBgCo) or arg_38_0._lastBgCo.bgImg == "" then
			return
		end

		arg_38_0._simagebgold:UnLoadImage()
		arg_38_0._simagebgoldtop:UnLoadImage()

		local var_38_0 = StoryBgZoneModel.instance:getBgZoneByPath(arg_38_0._lastBgCo.bgImg)

		gohelper.setActive(arg_38_0._simagebgoldtop.gameObject, var_38_0)

		if var_38_0 then
			arg_38_0._simagebgoldtop:LoadImage(ResUrl.getStoryRes(var_38_0.path), arg_38_0._onOldBgImgTopLoaded, arg_38_0)
			transformhelper.setLocalPosXY(arg_38_0._simagebgoldtop.gameObject.transform, var_38_0.offsetX, var_38_0.offsetY)
			arg_38_0._simagebgold:LoadImage(ResUrl.getStoryRes(var_38_0.sourcePath), function()
				arg_38_0._imagebgold.color = Color.white

				arg_38_0:_onOldBgImgLoaded()
				arg_38_0:_refreshBg()
			end)
		else
			arg_38_0._simagebgold:LoadImage(ResUrl.getStoryRes(arg_38_0._lastBgCo.bgImg), function()
				arg_38_0._imagebgold.color = Color.white

				arg_38_0:_onOldBgImgLoaded()
				arg_38_0:_refreshBg()
			end)
		end
	end
end

function var_0_0._darkFadeTrans(arg_41_0)
	StoryController.instance:dispatchEvent(StoryEvent.PlayDarkFade)
end

function var_0_0._whiteFadeTrans(arg_42_0)
	StoryController.instance:dispatchEvent(StoryEvent.PlayWhiteFade)
end

function var_0_0._darkUpTrans(arg_43_0)
	StoryController.instance:dispatchEvent(StoryEvent.PlayDarkFadeUp)
	arg_43_0:_refreshBg()
	arg_43_0:_resetBgState()
end

function var_0_0._commonTrans(arg_44_0, arg_44_1)
	arg_44_0._curTransType = arg_44_1

	local var_44_0 = StoryBgEffectTransModel.instance:getStoryBgEffectTransByType(arg_44_1)
	local var_44_1 = {}

	if var_44_0.prefab and var_44_0.prefab ~= "" then
		arg_44_0._prefabPath = ResUrl.getStoryBgEffect(var_44_0.prefab)

		table.insert(var_44_1, arg_44_0._prefabPath)
	end

	arg_44_0:loadRes(var_44_1, arg_44_0._onBgResLoaded, arg_44_0)
end

function var_0_0._onBgResLoaded(arg_45_0)
	if arg_45_0._prefabPath then
		local var_45_0 = arg_45_0._loader:getAssetItem(arg_45_0._prefabPath)

		arg_45_0._bgSubGo = gohelper.clone(var_45_0:GetResource(), arg_45_0._imagebg.gameObject)

		local var_45_1 = typeof(ZProj.MaterialPropsCtrl)
		local var_45_2 = arg_45_0._bgSubGo:GetComponent(var_45_1)

		if var_45_2 and var_45_2.mas ~= nil and var_45_2.mas[0] ~= nil then
			arg_45_0._imagebg.material = var_45_2.mas[0]
			arg_45_0._imagebgtop.material = var_45_2.mas[0]

			StoryTool.enablePostProcess(true)
		end

		if arg_45_0._curTransType == StoryEnum.BgTransType.Distort then
			StoryTool.enablePostProcess(true)

			arg_45_0._rootAni = gohelper.findChild(arg_45_0._bgSubGo, "root"):GetComponent(typeof(UnityEngine.Animator))

			TaskDispatcher.runDelay(arg_45_0._distortEnd, arg_45_0, arg_45_0._bgCo.transTimes[GameLanguageMgr.instance:getVoiceTypeStoryIndex()])
		end
	end

	arg_45_0:_showBgBottom(true)

	if arg_45_0._bgCo.bgImg ~= "" then
		arg_45_0:_advanceLoadBgOld()
	end

	local var_45_3 = StoryBgEffectTransModel.instance:getStoryBgEffectTransByType(arg_45_0._curTransType).transTime

	TaskDispatcher.runDelay(arg_45_0._commonTransFinished, arg_45_0, var_45_3)
end

function var_0_0._commonTransFinished(arg_46_0)
	arg_46_0:_refreshBg()
	arg_46_0:_resetBgState()

	if StoryBgEffectTransModel.instance:getStoryBgEffectTransByType(arg_46_0._curTransType).transTime > 0 then
		arg_46_0._imagebg.material = nil
		arg_46_0._imagebgtop.material = nil
	end
end

function var_0_0._distortEnd(arg_47_0)
	if arg_47_0._rootAni then
		arg_47_0._rootAni:SetBool("change", true)
	end
end

function var_0_0._rightDarkTrans(arg_48_0)
	if not arg_48_0._goRightFade then
		local var_48_0 = arg_48_0.viewContainer:getSetting().otherRes[1]

		arg_48_0._goRightFade = arg_48_0.viewContainer:getResInst(var_48_0, arg_48_0._gosideways)
		arg_48_0._rightAnim = arg_48_0._goRightFade:GetComponent(typeof(UnityEngine.Animation))
	end

	gohelper.setActive(arg_48_0._goRightFade, true)
	arg_48_0._rightAnim:Play()
	TaskDispatcher.runDelay(arg_48_0._changeRightDark, arg_48_0, 0.2)
end

function var_0_0._changeRightDark(arg_49_0)
	arg_49_0:_refreshBg()
	arg_49_0:_resetBgState()

	if arg_49_0._goLeftFade then
		gohelper.setActive(arg_49_0._goLeftFade, false)
	end
end

function var_0_0._leftDarkTrans(arg_50_0)
	if not arg_50_0._goLeftFade then
		local var_50_0 = arg_50_0.viewContainer:getSetting().otherRes[2]

		arg_50_0._goLeftFade = arg_50_0.viewContainer:getResInst(var_50_0, arg_50_0._gosideways)
		arg_50_0._leftAnim = arg_50_0._goLeftFade:GetComponent(typeof(UnityEngine.Animation))
	else
		gohelper.setActive(arg_50_0._goLeftFade, true)
	end

	if arg_50_0._goRightFade then
		gohelper.setActive(arg_50_0._goRightFade, false)
	end

	arg_50_0._leftAnim:Play()
	TaskDispatcher.runDelay(arg_50_0._leftDarkTransFinished, arg_50_0, 1.5)
end

function var_0_0._leftDarkTransFinished(arg_51_0)
	arg_51_0:_refreshBg()
	arg_51_0:_resetBgState()
end

function var_0_0._fragmentTrans(arg_52_0)
	return
end

function var_0_0._movieChangeStartTrans(arg_53_0)
	arg_53_0._curTransType = StoryEnum.BgTransType.MovieChangeStart

	local var_53_0 = StoryBgEffectTransModel.instance:getStoryBgEffectTransByType(arg_53_0._curTransType)
	local var_53_1 = {}

	if not arg_53_0._bgMovieGo then
		arg_53_0._moviePrefabPath = ResUrl.getStoryBgEffect(var_53_0.prefab)

		table.insert(var_53_1, arg_53_0._moviePrefabPath)
	end

	if not arg_53_0._cameraMovieAnimator then
		arg_53_0._cameraAnimPath = "ui/animations/dynamic/custommaterialpass.controller"

		table.insert(var_53_1, arg_53_0._cameraAnimPath)
	end

	arg_53_0:loadRes(var_53_1, arg_53_0._onMoveChangeBgResLoaded, arg_53_0)
end

function var_0_0._onMoveChangeBgResLoaded(arg_54_0)
	if not arg_54_0._bgMovieGo and arg_54_0._moviePrefabPath then
		local var_54_0 = arg_54_0._loader:getAssetItem(arg_54_0._moviePrefabPath)

		arg_54_0._bgMovieGo = gohelper.clone(var_54_0:GetResource(), arg_54_0._imagebg.gameObject)
		arg_54_0._simageMovieCurBg = gohelper.findChildSingleImage(arg_54_0._bgMovieGo, "#now/#simage_dec")
		arg_54_0._simageMovieNewBg = gohelper.findChildSingleImage(arg_54_0._bgMovieGo, "#next/#simage_dec")
	end

	gohelper.setActive(arg_54_0._bgMovieGo, true)

	arg_54_0._movieAnim = arg_54_0._bgMovieGo:GetComponent(gohelper.Type_Animator)

	if not arg_54_0._cameraMovieAnimator then
		arg_54_0._cameraMovieAnimator = arg_54_0._loader:getAssetItem(arg_54_0._cameraAnimPath):GetResource()
	end

	arg_54_0._moveCameraAnimator = CameraMgr.instance:getCameraRootAnimator()
	arg_54_0._moveCameraAnimator.enabled = true
	arg_54_0._moveCameraAnimator.runtimeAnimatorController = arg_54_0._cameraMovieAnimator

	arg_54_0:_setMovieNowBg()
	arg_54_0._movieAnim:Play("idle", 0, 0)
end

function var_0_0._movieChangeSwitchTrans(arg_55_0)
	arg_55_0._curTransType = StoryEnum.BgTransType.MovieChangeSwitch

	if not arg_55_0._bgMovieGo then
		return
	end

	arg_55_0._moveCameraAnimator = CameraMgr.instance:getCameraRootAnimator()
	arg_55_0._moveCameraAnimator.enabled = true
	arg_55_0._moveCameraAnimator.runtimeAnimatorController = arg_55_0._cameraMovieAnimator

	arg_55_0._simageMovieNewBg:LoadImage(ResUrl.getStoryRes(arg_55_0._bgCo.bgImg))

	if arg_55_0._movieAnim then
		arg_55_0._movieAnim:Play("switch", 0, 0)
		arg_55_0._moveCameraAnimator:Play("dynamicblur", 0, 0)
		TaskDispatcher.runDelay(arg_55_0._setMovieNowBg, arg_55_0, 0.3)
	end
end

function var_0_0._setMovieNowBg(arg_56_0)
	arg_56_0._simageMovieCurBg:LoadImage(ResUrl.getStoryRes(arg_56_0._bgCo.bgImg))
end

function var_0_0._turnPageTrans(arg_57_0)
	arg_57_0._curTransType = StoryEnum.BgTransType.TurnPage3

	local var_57_0 = StoryBgEffectTransModel.instance:getStoryBgEffectTransByType(arg_57_0._curTransType)
	local var_57_1 = {}

	if not arg_57_0._turnPageGo then
		arg_57_0._turnPagePrefabPath = ResUrl.getStoryBgEffect(var_57_0.prefab)

		table.insert(var_57_1, arg_57_0._turnPagePrefabPath)
	end

	arg_57_0:loadRes(var_57_1, arg_57_0._onTurnPageBgResLoaded, arg_57_0)
end

function var_0_0._onTurnPageBgResLoaded(arg_58_0)
	if not arg_58_0._turnPageGo and arg_58_0._turnPagePrefabPath then
		local var_58_0 = arg_58_0._loader:getAssetItem(arg_58_0._turnPagePrefabPath)

		arg_58_0._turnPageGo = gohelper.clone(var_58_0:GetResource(), arg_58_0._imagebg.gameObject)
		arg_58_0._turnPageAnim = arg_58_0._turnPageGo:GetComponent(typeof(UnityEngine.Animation))
	end

	gohelper.setActive(arg_58_0._turnPageGo, true)
	StoryTool.enablePostProcess(true)

	local var_58_1 = ViewMgr.instance:getContainer(ViewName.StoryView).viewGO

	arg_58_0._imgAnim = gohelper.findChild(var_58_1, "#go_middle/#go_img2"):GetComponent(typeof(UnityEngine.Animation))

	arg_58_0._imgAnim:Play()
	arg_58_0._turnPageAnim:Play()
	TaskDispatcher.runDelay(arg_58_0._onTurnPageFinished, arg_58_0, 0.67)
end

function var_0_0._onTurnPageFinished(arg_59_0)
	if arg_59_0._turnPageGo then
		gohelper.destroy(arg_59_0._turnPageGo)

		arg_59_0._turnPageGo = nil
	end

	arg_59_0._imgAnim:GetComponent(gohelper.Type_RectMask2D).padding = Vector4(0, 0, 0, 0)
end

function var_0_0._shakeCameraTrans(arg_60_0)
	arg_60_0._curTransType = StoryEnum.BgTransType.ShakeCamera
	arg_60_0._bgTrans = StoryBgTransCameraShake.New()

	arg_60_0._bgTrans:init()
	arg_60_0._bgTrans:start(arg_60_0._onShakeCameraFinished, arg_60_0)
end

function var_0_0._onShakeCameraFinished(arg_61_0)
	if arg_61_0._bgTrans then
		arg_61_0._bgTrans:destroy()

		arg_61_0._bgTrans = nil
	end
end

function var_0_0._dissolveTrans(arg_62_0)
	if arg_62_0._bgCo.bgType == StoryEnum.BgType.Picture then
		arg_62_0:_showBgBottom(true)
		gohelper.setActive(arg_62_0._bottombgSpine, false)

		if arg_62_0._bgCo.bgImg ~= "" then
			arg_62_0:_advanceLoadBgOld()
		end
	else
		arg_62_0:_showBgBottom(false)
		gohelper.setActive(arg_62_0._bottombgSpine, true)

		if string.split(arg_62_0._bgCo.bgImg, ".")[1] ~= "" then
			arg_62_0._effectLoader = PrefabInstantiate.Create(arg_62_0._bottombgSpine)

			arg_62_0._effectLoader:startLoad(arg_62_0._bgCo.bgImg)
		end
	end

	arg_62_0._imagebg:SetNativeSize()

	arg_62_0._imagebg.material = arg_62_0._dissolveMat
	arg_62_0._imagebgtop.material = arg_62_0._dissolveMat

	arg_62_0:_dissolveChange(0)

	arg_62_0._dissolveId = ZProj.TweenHelper.DOTweenFloat(0, -1.2, 2, arg_62_0._dissolveChange, arg_62_0._dissolveFinished, arg_62_0, nil, EaseType.Linear)
end

function var_0_0._dissolveChange(arg_63_0, arg_63_1)
	arg_63_0._imagebg.material:SetFloat(ShaderPropertyId.DissolveFactor, arg_63_1)
	arg_63_0._imagebgtop.material:SetFloat(ShaderPropertyId.DissolveFactor, arg_63_1)
end

function var_0_0._dissolveFinished(arg_64_0)
	arg_64_0:_refreshBg()
	arg_64_0:_resetBgState()

	arg_64_0._imagebg.material = nil
	arg_64_0._imagebgtop.material = nil
end

function var_0_0._actBgBlur(arg_65_0)
	StoryTool.enablePostProcess(true)
	PostProcessingMgr.instance:setUIBlurActive(0)
	PostProcessingMgr.instance:setFreezeVisble(false)

	arg_65_0._imagebg.material = arg_65_0._blurMat
	arg_65_0._imagebgtop.material = arg_65_0._blurZoneMat
	arg_65_0._bgBlur.enabled = true

	local var_65_0 = {
		0,
		0.8,
		0.9,
		1
	}

	arg_65_0._bgBlur.blurFactor = 0

	local var_65_1 = arg_65_0._bgCo.effTimes[GameLanguageMgr.instance:getVoiceTypeStoryIndex()]

	if var_65_1 > 0.1 then
		arg_65_0._blurId = ZProj.TweenHelper.DOTweenFloat(arg_65_0._bgBlur.blurWeight, var_65_0[arg_65_0._bgCo.effDegree + 1], var_65_1, arg_65_0._blurChange, arg_65_0._blurFinished, arg_65_0, nil, EaseType.Linear)
	else
		arg_65_0:_blurChange(var_65_0[arg_65_0._bgCo.effDegree + 1])
	end
end

function var_0_0._blurChange(arg_66_0, arg_66_1)
	arg_66_0._bgBlur.blurWeight = arg_66_1
end

function var_0_0._blurFinished(arg_67_0)
	if arg_67_0._blurId then
		ZProj.TweenHelper.KillById(arg_67_0._blurId)

		arg_67_0._blurId = nil
	end
end

function var_0_0._actBgBlurFade(arg_68_0)
	local var_68_0 = arg_68_0._bgCo.effTimes[GameLanguageMgr.instance:getVoiceTypeStoryIndex()]

	if arg_68_0._bgCo.effType == StoryEnum.BgEffectType.BgBlur and var_68_0 > 0.1 then
		return
	end

	PostProcessingMgr.instance:setUIBlurActive(0)
	PostProcessingMgr.instance:setFreezeVisble(false)

	local var_68_1 = arg_68_0._bgBlur.blurWeight

	arg_68_0._blurId = ZProj.TweenHelper.DOTweenFloat(var_68_1, 0, 1.5, arg_68_0._blurChange, arg_68_0._blurFinished, arg_68_0, nil, EaseType.Linear)
end

function var_0_0._actFishEye(arg_69_0)
	arg_69_0._imagebg.material = arg_69_0._fisheyeMat
	arg_69_0._imagebgtop.material = arg_69_0._fisheyeMat
end

function var_0_0._actShake(arg_70_0)
	if arg_70_0._bgCo.effTimes[GameLanguageMgr.instance:getVoiceTypeStoryIndex()] < 0.1 then
		return
	end

	if arg_70_0._bgCo.effDelayTimes[GameLanguageMgr.instance:getVoiceTypeStoryIndex()] < 0.1 then
		arg_70_0:_startShake()
	else
		TaskDispatcher.runDelay(arg_70_0._startShake, arg_70_0, arg_70_0._bgCo.effDelayTimes[GameLanguageMgr.instance:getVoiceTypeStoryIndex()])
	end
end

function var_0_0._startShake(arg_71_0)
	arg_71_0._bgAnimator.enabled = true

	arg_71_0._bgAnimator:SetBool("stoploop", false)

	local var_71_0 = {
		"idle",
		"low",
		"middle",
		"high"
	}

	arg_71_0._bgAnimator:Play(var_71_0[arg_71_0._bgCo.effDegree + 1])

	arg_71_0._bgAnimator.speed = arg_71_0._bgCo.effRate

	TaskDispatcher.runDelay(arg_71_0._shakeStop, arg_71_0, arg_71_0._bgCo.effTimes[GameLanguageMgr.instance:getVoiceTypeStoryIndex()])
end

function var_0_0._shakeStop(arg_72_0)
	if arg_72_0._bgAnimator then
		arg_72_0._bgAnimator:SetBool("stoploop", true)
	end
end

function var_0_0._actFullBlur(arg_73_0)
	PostProcessingMgr.instance:setUIBlurActive(3)
	PostProcessingMgr.instance:setFreezeVisble(true)
	StoryController.instance:dispatchEvent(StoryEvent.PlayFullBlurIn, arg_73_0._bgCo.effDegree, arg_73_0._bgCo.effTimes[GameLanguageMgr.instance:getVoiceTypeStoryIndex()])
end

function var_0_0._actBgGray(arg_74_0)
	if arg_74_0._bgGrayId then
		ZProj.TweenHelper.KillById(arg_74_0._bgGrayId)

		arg_74_0._bgGrayId = nil
	end

	arg_74_0:_actFullGrayUpdate(0.5)

	if arg_74_0._bgCo.effDegree == 0 then
		arg_74_0._prefabPath = ResUrl.getStoryBgEffect("v1a9_saturation")

		arg_74_0:loadRes({
			arg_74_0._prefabPath
		}, arg_74_0._actBgGrayLoaded, arg_74_0)
	else
		if not arg_74_0._prefabPath or not arg_74_0._bgSubGo then
			return
		end

		local var_74_0 = arg_74_0._bgSubGo:GetComponent(typeof(ZProj.MaterialPropsCtrl))

		if not var_74_0 then
			return
		end

		StoryTool.enablePostProcess(true)

		if arg_74_0._bgCo.effTimes[GameLanguageMgr.instance:getVoiceTypeStoryIndex()] < 0.1 then
			arg_74_0:_actBgGrayUpdate(0)
		else
			local var_74_1 = var_74_0.float_01

			arg_74_0._bgGrayId = ZProj.TweenHelper.DOTweenFloat(var_74_1, 0, arg_74_0._bgCo.effTimes[GameLanguageMgr.instance:getVoiceTypeStoryIndex()], arg_74_0._actBgGrayUpdate, arg_74_0._actBgGrayFinished, arg_74_0)
		end
	end
end

function var_0_0._actBgGrayLoaded(arg_75_0)
	if arg_75_0._bgSubGo and arg_75_0._lastBgCo.effType == StoryEnum.BgEffectType.BgGray then
		if not arg_75_0._lastBgSubGo then
			arg_75_0._lastBgSubGo = gohelper.clone(arg_75_0._bgSubGo, arg_75_0._imagebgold.gameObject)
		end

		local var_75_0 = arg_75_0._lastBgSubGo:GetComponent(typeof(ZProj.MaterialPropsCtrl))

		arg_75_0._imagebgold.material = var_75_0.mas[0]
		arg_75_0._imagebgoldtop.material = var_75_0.mas[0]
	end

	if arg_75_0._prefabPath then
		if arg_75_0._bgSubGo and arg_75_0._lastBgCo.effType == StoryEnum.BgEffectType.BgGray then
			gohelper.destroy(arg_75_0._bgSubGo)
		end

		local var_75_1 = arg_75_0._loader:getAssetItem(arg_75_0._prefabPath)

		arg_75_0._bgSubGo = gohelper.clone(var_75_1:GetResource(), arg_75_0._imagebg.gameObject)

		local var_75_2 = arg_75_0._bgSubGo:GetComponent(typeof(ZProj.MaterialPropsCtrl))

		arg_75_0._imagebg.material = var_75_2.mas[0]
		arg_75_0._imagebgtop.material = var_75_2.mas[0]

		StoryTool.enablePostProcess(true)

		if arg_75_0._bgCo.effTimes[GameLanguageMgr.instance:getVoiceTypeStoryIndex()] < 0.1 then
			arg_75_0:_actBgGrayUpdate(1)
		else
			arg_75_0._bgGrayId = ZProj.TweenHelper.DOTweenFloat(0, 1, arg_75_0._bgCo.effTimes[GameLanguageMgr.instance:getVoiceTypeStoryIndex()], arg_75_0._actBgGrayUpdate, arg_75_0._actGrayFinished, arg_75_0)
		end
	end
end

function var_0_0._actBgGrayUpdate(arg_76_0, arg_76_1)
	if not arg_76_0._bgSubGo then
		return
	end

	local var_76_0 = arg_76_0._bgSubGo:GetComponent(typeof(ZProj.MaterialPropsCtrl))

	if not var_76_0 then
		return
	end

	var_76_0.float_01 = arg_76_1
end

function var_0_0._actGrayFinished(arg_77_0)
	if arg_77_0._bgGrayId then
		ZProj.TweenHelper.KillById(arg_77_0._bgGrayId)

		arg_77_0._bgGrayId = nil
	end
end

function var_0_0._actFullGray(arg_78_0)
	arg_78_0:_actBgGrayUpdate(0)

	if arg_78_0._bgGrayId then
		ZProj.TweenHelper.KillById(arg_78_0._bgGrayId)

		arg_78_0._bgGrayId = nil
	end

	if arg_78_0._bgCo.effDegree == 0 then
		StoryTool.enablePostProcess(true)

		if arg_78_0._bgCo.effTimes[GameLanguageMgr.instance:getVoiceTypeStoryIndex()] < 0.1 then
			arg_78_0:_actFullGrayUpdate(1)
		else
			arg_78_0._bgGrayId = ZProj.TweenHelper.DOTweenFloat(0.5, 1, arg_78_0._bgCo.effTimes[GameLanguageMgr.instance:getVoiceTypeStoryIndex()], arg_78_0._actFullGrayUpdate, arg_78_0._actGrayFinished, arg_78_0)
		end
	elseif arg_78_0._bgCo.effTimes[GameLanguageMgr.instance:getVoiceTypeStoryIndex()] < 0.1 then
		arg_78_0:_actFullGrayUpdate(0.5)
	else
		local var_78_0 = PostProcessingMgr.instance:getUIPPValue("Saturation")

		arg_78_0._bgGrayId = ZProj.TweenHelper.DOTweenFloat(var_78_0, 0.5, arg_78_0._bgCo.effTimes[GameLanguageMgr.instance:getVoiceTypeStoryIndex()], arg_78_0._actFullGrayUpdate, arg_78_0._actGrayFinished, arg_78_0)
	end
end

function var_0_0._actFullGrayUpdate(arg_79_0, arg_79_1)
	PostProcessingMgr.instance:setUIPPValue("saturation", arg_79_1)
	PostProcessingMgr.instance:setUIPPValue("Saturation", arg_79_1)
end

function var_0_0._resetInterfere(arg_80_0)
	if arg_80_0._interfereGo then
		gohelper.destroy(arg_80_0._interfereGo)

		arg_80_0._interfereGo = nil
	end

	local var_80_0 = ViewMgr.instance:getContainer(ViewName.StoryView).viewGO

	gohelper.setLayer(var_80_0, UnityLayer.UISecond, true)

	local var_80_1 = ViewMgr.instance:getContainer(ViewName.StoryLeadRoleSpineView).viewGO
	local var_80_2 = gohelper.findChild(var_80_1, "#go_spineroot")

	gohelper.setLayer(var_80_2, UnityLayer.UIThird, true)
	gohelper.setLayer(arg_80_0._gobliteff, UnityLayer.UI, true)
end

function var_0_0._showInterfere(arg_81_0)
	if arg_81_0._interfereGo then
		arg_81_0:_setInterfere()
	else
		arg_81_0._interfereEffPrefPath = ResUrl.getStoryBgEffect("glitch_common")

		local var_81_0 = {}

		table.insert(var_81_0, arg_81_0._interfereEffPrefPath)
		arg_81_0:loadRes(var_81_0, arg_81_0._onInterfereResLoaded, arg_81_0)
	end
end

function var_0_0._onInterfereResLoaded(arg_82_0)
	if arg_82_0._interfereEffPrefPath then
		local var_82_0 = arg_82_0._loader:getAssetItem(arg_82_0._interfereEffPrefPath)
		local var_82_1 = ViewMgr.instance:getContainer(ViewName.StoryFrontView).viewGO

		arg_82_0._interfereGo = gohelper.clone(var_82_0:GetResource(), var_82_1)

		arg_82_0:_setInterfere()
	end
end

function var_0_0._setInterfere(arg_83_0)
	StoryTool.enablePostProcess(true)
	gohelper.setAsFirstSibling(arg_83_0._interfereGo)
	arg_83_0._interfereGo:GetComponent(typeof(UnityEngine.UI.Image)).material:SetTexture("_MainTex", arg_83_0._blitEff.capturedTexture)

	local var_83_0 = ViewMgr.instance:getContainer(ViewName.StoryView).viewGO

	gohelper.setLayer(var_83_0, UnityLayer.UITop, true)

	local var_83_1 = ViewMgr.instance:getContainer(ViewName.StoryLeadRoleSpineView).viewGO
	local var_83_2 = gohelper.findChild(var_83_1, "#go_spineroot")

	gohelper.setLayer(var_83_2, UnityLayer.UITop, true)
	gohelper.setLayer(arg_83_0._gobliteff, UnityLayer.UISecond, true)
end

function var_0_0._resetSketch(arg_84_0)
	if arg_84_0._bgSketchId then
		ZProj.TweenHelper.KillById(arg_84_0._bgSketchId)

		arg_84_0._bgSketchId = nil
	end

	if arg_84_0._sketchGo then
		gohelper.destroy(arg_84_0._sketchGo)

		arg_84_0._sketchGo = nil
	end

	local var_84_0 = ViewMgr.instance:getContainer(ViewName.StoryView).viewGO

	gohelper.setLayer(var_84_0, UnityLayer.UISecond, true)

	local var_84_1 = ViewMgr.instance:getContainer(ViewName.StoryLeadRoleSpineView).viewGO
	local var_84_2 = gohelper.findChild(var_84_1, "#go_spineroot")

	gohelper.setLayer(var_84_2, UnityLayer.UIThird, true)
	gohelper.setLayer(arg_84_0._gobliteff, UnityLayer.UI, true)
end

function var_0_0._showSketch(arg_85_0)
	if arg_85_0._bgSketchId then
		ZProj.TweenHelper.KillById(arg_85_0._bgSketchId)

		arg_85_0._bgSketchId = nil
	end

	if arg_85_0._bgCo.effDegree == 0 and not arg_85_0._sketchGo then
		return
	end

	if arg_85_0._sketchGo then
		arg_85_0:_setSketch()
	else
		arg_85_0._sketchEffPrefPath = ResUrl.getStoryBgEffect("storybg_sketch")

		local var_85_0 = {}

		table.insert(var_85_0, arg_85_0._sketchEffPrefPath)
		arg_85_0:loadRes(var_85_0, arg_85_0._onSketchResLoaded, arg_85_0)
	end
end

local var_0_1 = {
	1,
	0.4,
	0.2,
	0
}

function var_0_0._onSketchResLoaded(arg_86_0)
	if arg_86_0._sketchEffPrefPath then
		local var_86_0 = arg_86_0._loader:getAssetItem(arg_86_0._sketchEffPrefPath)
		local var_86_1 = ViewMgr.instance:getContainer(ViewName.StoryFrontView).viewGO

		arg_86_0._sketchGo = gohelper.clone(var_86_0:GetResource(), var_86_1)

		arg_86_0:_setSketch()
	end
end

function var_0_0._setSketch(arg_87_0)
	StoryTool.enablePostProcess(true)
	gohelper.setAsFirstSibling(arg_87_0._sketchGo)

	arg_87_0._imgSketch = arg_87_0._sketchGo:GetComponent(typeof(UnityEngine.UI.Image))

	arg_87_0._imgSketch.material:SetTexture("_MainTex", arg_87_0._blitEff.capturedTexture)

	if arg_87_0._bgCo.effTimes[GameLanguageMgr.instance:getVoiceTypeStoryIndex()] < 0.1 then
		arg_87_0:_sketchUpdate(var_0_1[arg_87_0._bgCo.effDegree + 1])
	else
		local var_87_0 = arg_87_0._bgCo.effDegree > 0 and 1 or arg_87_0._imgSketch.material:GetFloat("_SourceColLerp")

		arg_87_0._bgSketchId = ZProj.TweenHelper.DOTweenFloat(var_87_0, var_0_1[arg_87_0._bgCo.effDegree + 1], arg_87_0._bgCo.effTimes[GameLanguageMgr.instance:getVoiceTypeStoryIndex()], arg_87_0._sketchUpdate, arg_87_0._sketchFinished, arg_87_0)
	end

	local var_87_1 = ViewMgr.instance:getContainer(ViewName.StoryView).viewGO

	gohelper.setLayer(var_87_1, UnityLayer.UITop, true)

	local var_87_2 = ViewMgr.instance:getContainer(ViewName.StoryLeadRoleSpineView).viewGO
	local var_87_3 = gohelper.findChild(var_87_2, "#go_spineroot")

	gohelper.setLayer(var_87_3, UnityLayer.UITop, true)
	gohelper.setLayer(arg_87_0._gobliteff, UnityLayer.UISecond, true)
end

function var_0_0._sketchUpdate(arg_88_0, arg_88_1)
	arg_88_0._imgSketch.material:SetFloat("_SourceColLerp", arg_88_1)
end

function var_0_0._sketchFinished(arg_89_0)
	if arg_89_0._bgSketchId then
		ZProj.TweenHelper.KillById(arg_89_0._bgSketchId)

		arg_89_0._bgSketchId = nil
	end
end

function var_0_0._resetBlindFilter(arg_90_0)
	if arg_90_0._bgFilterId then
		ZProj.TweenHelper.KillById(arg_90_0._bgFilterId)

		arg_90_0._bgFilterId = nil
	end

	if arg_90_0._filterGo then
		gohelper.destroy(arg_90_0._filterGo)

		arg_90_0._filterGo = nil
	end

	local var_90_0 = ViewMgr.instance:getContainer(ViewName.StoryView).viewGO

	gohelper.setLayer(var_90_0, UnityLayer.UISecond, true)

	local var_90_1 = ViewMgr.instance:getContainer(ViewName.StoryLeadRoleSpineView).viewGO
	local var_90_2 = gohelper.findChild(var_90_1, "#go_spineroot")

	gohelper.setLayer(var_90_2, UnityLayer.UIThird, true)
	gohelper.setLayer(arg_90_0._gobliteff, UnityLayer.UI, true)
end

function var_0_0._showBlindFilter(arg_91_0)
	if arg_91_0._bgFilterId then
		ZProj.TweenHelper.KillById(arg_91_0._bgFilterId)

		arg_91_0._bgFilterId = nil
	end

	if arg_91_0._bgCo.effDegree == 0 and not arg_91_0._filterGo then
		return
	end

	if arg_91_0._filterGo then
		arg_91_0:_setBlindFilter()
	else
		arg_91_0._filterEffPrefPath = ResUrl.getStoryBgEffect("storybg_blinder")

		local var_91_0 = {}

		table.insert(var_91_0, arg_91_0._filterEffPrefPath)
		arg_91_0:loadRes(var_91_0, arg_91_0._onFilterResLoaded, arg_91_0)
	end
end

function var_0_0._onFilterResLoaded(arg_92_0)
	if arg_92_0._filterEffPrefPath then
		local var_92_0 = arg_92_0._loader:getAssetItem(arg_92_0._filterEffPrefPath)
		local var_92_1 = ViewMgr.instance:getContainer(ViewName.StoryFrontView).viewGO

		arg_92_0._filterGo = gohelper.clone(var_92_0:GetResource(), var_92_1)

		arg_92_0:_setBlindFilter()
	end
end

local var_0_2 = {
	1,
	0.4,
	0.2,
	0
}

function var_0_0._setBlindFilter(arg_93_0)
	StoryTool.enablePostProcess(true)
	gohelper.setAsFirstSibling(arg_93_0._filterGo)

	arg_93_0._imgFilter = arg_93_0._filterGo:GetComponent(typeof(UnityEngine.UI.Image))

	arg_93_0._imgFilter.material:SetTexture("_MainTex", arg_93_0._blitEff.capturedTexture)

	if arg_93_0._bgCo.effTimes[GameLanguageMgr.instance:getVoiceTypeStoryIndex()] < 0.1 then
		arg_93_0:_filterUpdate(var_0_2[arg_93_0._bgCo.effDegree + 1])
	else
		local var_93_0 = arg_93_0._bgCo.effDegree > 0 and 1 or arg_93_0._imgFilter.material:GetFloat("_SourceColLerp")

		arg_93_0._bgFilterId = ZProj.TweenHelper.DOTweenFloat(var_93_0, var_0_2[arg_93_0._bgCo.effDegree + 1], arg_93_0._bgCo.effTimes[GameLanguageMgr.instance:getVoiceTypeStoryIndex()], arg_93_0._filterUpdate, arg_93_0._filterFinished, arg_93_0)
	end

	local var_93_1 = ViewMgr.instance:getContainer(ViewName.StoryView).viewGO

	gohelper.setLayer(var_93_1, UnityLayer.UITop, true)

	local var_93_2 = ViewMgr.instance:getContainer(ViewName.StoryLeadRoleSpineView).viewGO
	local var_93_3 = gohelper.findChild(var_93_2, "#go_spineroot")

	gohelper.setLayer(var_93_3, UnityLayer.UITop, true)
	gohelper.setLayer(arg_93_0._gobliteff, UnityLayer.UISecond, true)
end

function var_0_0._filterUpdate(arg_94_0, arg_94_1)
	arg_94_0._imgFilter.material:SetFloat("_SourceColLerp", arg_94_1)
end

function var_0_0._filterFinished(arg_95_0)
	if arg_95_0._bgFilterId then
		ZProj.TweenHelper.KillById(arg_95_0._bgFilterId)

		arg_95_0._bgFilterId = nil
	end
end

function var_0_0._resetOpposition(arg_96_0)
	if arg_96_0._bgOppositionId then
		ZProj.TweenHelper.KillById(arg_96_0._bgOppositionId)

		arg_96_0._bgOppositionId = nil
	end

	if arg_96_0._oppositionGo then
		gohelper.destroy(arg_96_0._oppositionGo)

		arg_96_0._oppositionGo = nil
	end

	local var_96_0 = ViewMgr.instance:getContainer(ViewName.StoryView).viewGO

	gohelper.setLayer(var_96_0, UnityLayer.UISecond, true)

	local var_96_1 = ViewMgr.instance:getContainer(ViewName.StoryLeadRoleSpineView).viewGO
	local var_96_2 = gohelper.findChild(var_96_1, "#go_spineroot")

	gohelper.setLayer(var_96_2, UnityLayer.UIThird, true)
	gohelper.setLayer(arg_96_0._gobliteff, UnityLayer.UI, true)
end

function var_0_0._showOpposition(arg_97_0)
	if arg_97_0._bgOppositionId then
		ZProj.TweenHelper.KillById(arg_97_0._bgOppositionId)

		arg_97_0._bgOppositionId = nil
	end

	if arg_97_0._bgCo.effDegree == 0 and not arg_97_0._oppositionGo then
		return
	end

	if arg_97_0._oppositionGo then
		arg_97_0:_setOpposition()
	else
		arg_97_0._oppositonPrefPath = ResUrl.getStoryBgEffect("storybg_colorinverse")

		local var_97_0 = {}

		table.insert(var_97_0, arg_97_0._oppositonPrefPath)
		arg_97_0:loadRes(var_97_0, arg_97_0._onOppositionResLoaded, arg_97_0)
	end
end

function var_0_0._onOppositionResLoaded(arg_98_0)
	if arg_98_0._oppositonPrefPath then
		local var_98_0 = arg_98_0._loader:getAssetItem(arg_98_0._oppositonPrefPath)
		local var_98_1 = ViewMgr.instance:getContainer(ViewName.StoryFrontView).viewGO

		arg_98_0._oppositionGo = gohelper.clone(var_98_0:GetResource(), var_98_1)

		arg_98_0:_setOpposition()
	end
end

local var_0_3 = {
	1,
	0.4,
	0.2,
	0
}

function var_0_0._setOpposition(arg_99_0)
	StoryTool.enablePostProcess(true)
	gohelper.setAsFirstSibling(arg_99_0._oppositionGo)

	arg_99_0._imgOpposition = arg_99_0._oppositionGo:GetComponent(typeof(UnityEngine.UI.Image))

	arg_99_0._imgOpposition.material:SetTexture("_MainTex", arg_99_0._blitEff.capturedTexture)

	if arg_99_0._bgCo.effTimes[GameLanguageMgr.instance:getVoiceTypeStoryIndex()] < 0.1 then
		arg_99_0:_oppositionUpdate(var_0_3[arg_99_0._bgCo.effDegree + 1])
	else
		local var_99_0 = arg_99_0._bgCo.effDegree > 0 and 1 or arg_99_0._imgOpposition.material:GetFloat("_ColorInverseFactor")

		arg_99_0._bgOppositionId = ZProj.TweenHelper.DOTweenFloat(var_99_0, var_0_3[arg_99_0._bgCo.effDegree + 1], arg_99_0._bgCo.effTimes[GameLanguageMgr.instance:getVoiceTypeStoryIndex()], arg_99_0._oppositionUpdate, arg_99_0._oppositionFinished, arg_99_0)
	end

	local var_99_1 = ViewMgr.instance:getContainer(ViewName.StoryView).viewGO

	gohelper.setLayer(var_99_1, UnityLayer.UITop, true)

	local var_99_2 = ViewMgr.instance:getContainer(ViewName.StoryLeadRoleSpineView).viewGO
	local var_99_3 = gohelper.findChild(var_99_2, "#go_spineroot")

	gohelper.setLayer(var_99_3, UnityLayer.UITop, true)
	gohelper.setLayer(arg_99_0._gobliteff, UnityLayer.UISecond, true)
end

function var_0_0._oppositionUpdate(arg_100_0, arg_100_1)
	arg_100_0._imgOpposition.material:SetFloat("_ColorInverseFactor", arg_100_1)
end

function var_0_0._oppositionFinished(arg_101_0)
	if arg_101_0._bgOppositionId then
		ZProj.TweenHelper.KillById(arg_101_0._bgOppositionId)

		arg_101_0._bgOppositionId = nil
	end
end

function var_0_0._resetRgbSplit(arg_102_0)
	if arg_102_0._rbgSplitGo then
		gohelper.destroy(arg_102_0._rbgSplitGo)

		arg_102_0._rbgSplitGo = nil
	end

	gohelper.setLayer(arg_102_0._gobliteff, UnityLayer.UI, true)
end

function var_0_0._showRgbSplit(arg_103_0)
	if arg_103_0._bgCo.effDegree == StoryEnum.BgRgbSplitType.Trans then
		arg_103_0:_showTransRgbSplit()
	elseif arg_103_0._bgCo.effDegree == StoryEnum.BgRgbSplitType.Once then
		arg_103_0:_showOnceRgbSplit()
	elseif arg_103_0._bgCo.effDegree == StoryEnum.BgRgbSplitType.LoopWeak then
		arg_103_0:_showLoopWeakRgbSplit()
	elseif arg_103_0._bgCo.effDegree == StoryEnum.BgRgbSplitType.LoopStrong then
		arg_103_0:_showLoopStrongRgbSplit()
	end
end

function var_0_0._showTransRgbSplit(arg_104_0)
	if arg_104_0._rbgSplitGo then
		gohelper.destroy(arg_104_0._rbgSplitGo)

		arg_104_0._rbgSplitGo = nil
	end

	arg_104_0._transRgbSplitPrefPath = ResUrl.getStoryBgEffect("storybg_rgbsplit_changebg_doublerole")

	local var_104_0 = {}

	table.insert(var_104_0, arg_104_0._transRgbSplitPrefPath)
	arg_104_0:loadRes(var_104_0, arg_104_0._onTransRgbSplitResLoaded, arg_104_0)
end

function var_0_0._onTransRgbSplitResLoaded(arg_105_0)
	if arg_105_0._transRgbSplitPrefPath then
		local var_105_0 = arg_105_0._loader:getAssetItem(arg_105_0._transRgbSplitPrefPath)
		local var_105_1 = ViewMgr.instance:getContainer(ViewName.StoryFrontView).viewGO

		arg_105_0._rbgSplitGo = gohelper.clone(var_105_0:GetResource(), var_105_1)

		arg_105_0:_setTransRgbSplit()
	end
end

function var_0_0._setTransRgbSplit(arg_106_0)
	StoryTool.enablePostProcess(true)
	gohelper.setAsFirstSibling(arg_106_0._rbgSplitGo)

	arg_106_0._imgOld = gohelper.findChildImage(arg_106_0._rbgSplitGo, "image_old")
	arg_106_0._imgNew = gohelper.findChildImage(arg_106_0._rbgSplitGo, "image_new")
	arg_106_0._goAnim = gohelper.findChild(arg_106_0._rbgSplitGo, "anim")

	gohelper.setActive(arg_106_0._imgOld.gameObject, true)
	gohelper.setActive(arg_106_0._imgNew.gameObject, true)
	gohelper.setActive(arg_106_0._goAnim, true)
	gohelper.setLayer(arg_106_0._gobliteff, UnityLayer.UISecond, true)
	arg_106_0._imgOld.material:SetTexture("_MainTex", arg_106_0._lastCaptureTexture)
	arg_106_0._imgNew.material:SetTexture("_MainTex", arg_106_0._blitEffSecond.capturedTexture)
	TaskDispatcher.runDelay(arg_106_0._resetRgbSplit, arg_106_0, 1.2)
end

function var_0_0._showOnceRgbSplit(arg_107_0)
	if arg_107_0._rbgSplitGo then
		gohelper.destroy(arg_107_0._rbgSplitGo)

		arg_107_0._rbgSplitGo = nil
	end

	arg_107_0._onceRgbSplitPrefPath = ResUrl.getStoryBgEffect("storybg_rgbsplit_once")

	local var_107_0 = {}

	table.insert(var_107_0, arg_107_0._onceRgbSplitPrefPath)
	arg_107_0:loadRes(var_107_0, arg_107_0._onOnceRgbSplitResLoaded, arg_107_0)
end

function var_0_0._onOnceRgbSplitResLoaded(arg_108_0)
	if arg_108_0._onceRgbSplitPrefPath then
		local var_108_0 = arg_108_0._loader:getAssetItem(arg_108_0._onceRgbSplitPrefPath)
		local var_108_1 = ViewMgr.instance:getContainer(ViewName.StoryHeroView).viewGO

		arg_108_0._rbgSplitGo = gohelper.clone(var_108_0:GetResource(), var_108_1)

		StoryTool.enablePostProcess(true)
		gohelper.setAsFirstSibling(arg_108_0._rbgSplitGo)

		arg_108_0._img = arg_108_0._rbgSplitGo:GetComponent(typeof(UnityEngine.UI.Image))

		gohelper.setActive(arg_108_0._img.gameObject, true)
		arg_108_0._img.material:SetTexture("_MainTex", arg_108_0._blitEff.capturedTexture)
		TaskDispatcher.runDelay(arg_108_0._resetRgbSplit, arg_108_0, 0.267)
	end
end

function var_0_0._showLoopWeakRgbSplit(arg_109_0)
	if arg_109_0._rbgSplitGo then
		gohelper.destroy(arg_109_0._rbgSplitGo)

		arg_109_0._rbgSplitGo = nil
	end

	arg_109_0._loopWeakRgbSplitPrefPath = ResUrl.getStoryBgEffect("storybg_rgbsplit_loop")

	local var_109_0 = {}

	table.insert(var_109_0, arg_109_0._loopWeakRgbSplitPrefPath)
	arg_109_0:loadRes(var_109_0, arg_109_0._onLoopWeakRgbSplitResLoaded, arg_109_0)
end

function var_0_0._onLoopWeakRgbSplitResLoaded(arg_110_0)
	if arg_110_0._loopWeakRgbSplitPrefPath then
		local var_110_0 = arg_110_0._loader:getAssetItem(arg_110_0._loopWeakRgbSplitPrefPath)
		local var_110_1 = ViewMgr.instance:getContainer(ViewName.StoryHeroView).viewGO

		arg_110_0._rbgSplitGo = gohelper.clone(var_110_0:GetResource(), var_110_1)

		StoryTool.enablePostProcess(true)
		gohelper.setAsFirstSibling(arg_110_0._rbgSplitGo)

		arg_110_0._img = arg_110_0._rbgSplitGo:GetComponent(typeof(UnityEngine.UI.Image))

		gohelper.setActive(arg_110_0._img.gameObject, true)
		arg_110_0._img.material:SetTexture("_MainTex", arg_110_0._blitEff.capturedTexture)
	end
end

function var_0_0._showLoopStrongRgbSplit(arg_111_0)
	if arg_111_0._rbgSplitGo then
		gohelper.destroy(arg_111_0._rbgSplitGo)

		arg_111_0._rbgSplitGo = nil
	end

	arg_111_0._loopStrongRgbSplitPrefPath = ResUrl.getStoryBgEffect("storybg_rgbsplit_loop_strong")

	local var_111_0 = {}

	table.insert(var_111_0, arg_111_0._loopStrongRgbSplitPrefPath)
	arg_111_0:loadRes(var_111_0, arg_111_0._onLoopStrongRgbSplitResLoaded, arg_111_0)
end

function var_0_0._onLoopStrongRgbSplitResLoaded(arg_112_0)
	if arg_112_0._loopStrongRgbSplitPrefPath then
		local var_112_0 = arg_112_0._loader:getAssetItem(arg_112_0._loopStrongRgbSplitPrefPath)
		local var_112_1 = ViewMgr.instance:getContainer(ViewName.StoryHeroView).viewGO

		arg_112_0._rbgSplitGo = gohelper.clone(var_112_0:GetResource(), var_112_1)

		StoryTool.enablePostProcess(true)
		gohelper.setAsFirstSibling(arg_112_0._rbgSplitGo)

		arg_112_0._img = arg_112_0._rbgSplitGo:GetComponent(typeof(UnityEngine.UI.Image))

		gohelper.setActive(arg_112_0._img.gameObject, true)
		arg_112_0._img.material:SetTexture("_MainTex", arg_112_0._blitEff.capturedTexture)
	end
end

function var_0_0.loadRes(arg_113_0, arg_113_1, arg_113_2, arg_113_3)
	if arg_113_0._loader then
		arg_113_0._loader:dispose()

		arg_113_0._loader = nil
	end

	if arg_113_1 and #arg_113_1 > 0 then
		arg_113_0._loader = MultiAbLoader.New()

		arg_113_0._loader:setPathList(arg_113_1)
		arg_113_0._loader:startLoad(arg_113_2, arg_113_3)
	elseif arg_113_2 then
		arg_113_2(arg_113_3)
	end
end

function var_0_0.onClose(arg_114_0)
	arg_114_0:_clearBg()

	if arg_114_0._bgFadeId then
		ZProj.TweenHelper.KillById(arg_114_0._bgFadeId)
	end

	gohelper.setActive(arg_114_0.viewGO, false)
	ViewMgr.instance:closeView(ViewName.StoryHeroView)
	arg_114_0:_removeEvents()
end

function var_0_0._clearBg(arg_115_0)
	if arg_115_0._blurId then
		ZProj.TweenHelper.KillById(arg_115_0._blurId)

		arg_115_0._blurId = nil
	end

	if arg_115_0._bgScaleId then
		ZProj.TweenHelper.KillById(arg_115_0._bgScaleId)

		arg_115_0._bgScaleId = nil
	end

	if arg_115_0._bgPosId then
		ZProj.TweenHelper.KillById(arg_115_0._bgPosId)

		arg_115_0._bgPosId = nil
	end

	if arg_115_0._bgRotateId then
		ZProj.TweenHelper.KillById(arg_115_0._bgRotateId)

		arg_115_0._bgRotateId = nil
	end

	if arg_115_0._bgGrayId then
		ZProj.TweenHelper.KillById(arg_115_0._bgGrayId)

		arg_115_0._bgGrayId = nil
	end

	if arg_115_0._bgSketchId then
		ZProj.TweenHelper.KillById(arg_115_0._bgSketchId)

		arg_115_0._bgSketchId = nil
	end

	if arg_115_0._bgFilterId then
		ZProj.TweenHelper.KillById(arg_115_0._bgFilterId)

		arg_115_0._bgFilterId = nil
	end

	if arg_115_0._bgOppositionId then
		ZProj.TweenHelper.KillById(arg_115_0._bgOppositionId)

		arg_115_0._bgOppositionId = nil
	end

	TaskDispatcher.cancelTask(arg_115_0._resetRgbSplit, arg_115_0)
	TaskDispatcher.cancelTask(arg_115_0._onTurnPageFinished, arg_115_0)
	TaskDispatcher.cancelTask(arg_115_0._changeRightDark, arg_115_0)
	TaskDispatcher.cancelTask(arg_115_0._enterChange, arg_115_0)
	TaskDispatcher.cancelTask(arg_115_0._startShake, arg_115_0)
	TaskDispatcher.cancelTask(arg_115_0._shakeStop, arg_115_0)
	TaskDispatcher.cancelTask(arg_115_0._distortEnd, arg_115_0)
	TaskDispatcher.cancelTask(arg_115_0._leftDarkTransFinished, arg_115_0)
	TaskDispatcher.cancelTask(arg_115_0._commonTransFinished, arg_115_0)

	if arg_115_0._bgTrans then
		arg_115_0._bgTrans:destroy()

		arg_115_0._bgTrans = nil
	end

	if arg_115_0._simagebgimg then
		arg_115_0._simagebgimg:UnLoadImage()

		arg_115_0._simagebgimg = nil
	end

	if arg_115_0._simagebgimgtop then
		arg_115_0._simagebgimgtop:UnLoadImage()

		arg_115_0._simagebgimgtop = nil
	end

	if arg_115_0._simagebgold then
		arg_115_0._simagebgold:UnLoadImage()

		arg_115_0._simagebgold = nil
	end

	if arg_115_0._simagebgoldtop then
		arg_115_0._simagebgoldtop:UnLoadImage()

		arg_115_0._simagebgoldtop = nil
	end
end

function var_0_0._removeEvents(arg_116_0)
	arg_116_0:removeEventCb(StoryController.instance, StoryEvent.RefreshStep, arg_116_0._onUpdateUI, arg_116_0)
	arg_116_0:removeEventCb(StoryController.instance, StoryEvent.RefreshBackground, arg_116_0._colorFadeBgRefresh, arg_116_0)
	arg_116_0:removeEventCb(StoryController.instance, StoryEvent.ShowBackground, arg_116_0._showBg, arg_116_0)
end

function var_0_0.onDestroyView(arg_117_0)
	if arg_117_0._lastCaptureTexture then
		UnityEngine.RenderTexture.ReleaseTemporary(arg_117_0._lastCaptureTexture)

		arg_117_0._lastCaptureTexture = nil
	end

	arg_117_0:_clearBg()
	arg_117_0:_actFullGrayUpdate(0.5)

	if arg_117_0._borderFadeId then
		ZProj.TweenHelper.KillById(arg_117_0._borderFadeId)
	end

	if arg_117_0._loader then
		arg_117_0._loader:dispose()

		arg_117_0._loader = nil
	end

	if arg_117_0._matLoader then
		arg_117_0._matLoader:dispose()

		arg_117_0._matLoader = nil
	end
end

return var_0_0
