module("modules.logic.story.view.StoryBackgroundView", package.seeall)

slot0 = class("StoryBackgroundView", BaseView)

function slot0.onInitView(slot0)
	slot0._gobottom = gohelper.findChild(slot0.viewGO, "#go_bottombg")
	slot0._simagebgold = gohelper.findChildSingleImage(slot0.viewGO, "#go_bottombg/#simage_bgold")
	slot0._simagebgoldtop = gohelper.findChildSingleImage(slot0.viewGO, "#go_bottombg/#simage_bgold/#simage_bgoldtop")
	slot0._bottombgSpine = gohelper.findChild(slot0.viewGO, "#go_bottombg/#go_bottombgspine")
	slot0._gofront = gohelper.findChild(slot0.viewGO, "#go_upbg")
	slot0._goblack = gohelper.findChild(slot0.viewGO, "#go_blackbg")
	slot0._simagebgimg = gohelper.findChildSingleImage(slot0.viewGO, "#go_upbg/#simage_bgimg")
	slot0._simagebgimgtop = gohelper.findChildSingleImage(slot0.viewGO, "#go_upbg/#simage_bgimg/#simage_bgtop")
	slot0._upbgspine = gohelper.findChild(slot0.viewGO, "#go_upbg/#go_upbgspine")
	slot0._gosideways = gohelper.findChild(slot0.viewGO, "#go_sideways")
	slot0._goblur = gohelper.findChild(slot0.viewGO, "#go_upbg/#simage_bgimg/#go_blur")
	slot0._gobliteff = gohelper.findChild(slot0.viewGO, "#go_blitbg")

	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0.addEvents(slot0)
end

function slot0.removeEvents(slot0)
end

function slot0._editableInitView(slot0)
	slot0._cimagebgold = slot0._simagebgold.gameObject:GetComponent(typeof(UnityEngine.UI.CustomImage))
	slot0._cimagebgimg = slot0._simagebgimg.gameObject:GetComponent(typeof(UnityEngine.UI.CustomImage))
	slot0._imagebgold = gohelper.findChildImage(slot0.viewGO, "#go_bottombg/#simage_bgold")
	slot0._imagebgoldtop = gohelper.findChildImage(slot0.viewGO, "#go_bottombg/#simage_bgold/#simage_bgoldtop")
	slot0._imagebg = gohelper.findChildImage(slot0.viewGO, "#go_upbg/#simage_bgimg")
	slot0._imagebgtop = gohelper.findChildImage(slot0.viewGO, "#go_upbg/#simage_bgimg/#simage_bgtop")
	slot0._imgFitHeight = slot0._simagebgimg.gameObject:GetComponent(typeof(ZProj.UIBgFitHeightAdapter))
	slot0._imgOldFitHeight = slot0._imagebgold.gameObject:GetComponent(typeof(ZProj.UIBgFitHeightAdapter))
	slot0._bgAnimator = slot0._gofront.gameObject:GetComponent(typeof(UnityEngine.Animator))
	slot0._bgBlur = slot0._simagebgimg.gameObject:GetComponent(typeof(UrpCustom.UIGaussianEffect))
	slot0._borderCanvas = slot0._goblack:GetComponent(typeof(UnityEngine.CanvasGroup))
	slot0._blitEff = slot0._gobliteff:GetComponent(typeof(UrpCustom.UIBlitEffect))

	slot0:_loadRes()
	slot0:_initData()
end

function slot0._loadRes(slot0)
	slot0._matLoader = MultiAbLoader.New()

	slot0._matLoader:addPath("ui/materials/dynamic/story_fisheye.mat")
	slot0._matLoader:addPath("ui/materials/dynamic/uibackgoundblur.mat")
	slot0._matLoader:addPath("ui/materials/dynamic/uibackgoundblur_zone.mat")
	slot0._matLoader:addPath("ui/materials/dynamic/story_dissolve.mat")
	slot0._matLoader:startLoad(function ()
		if uv0._matLoader:getAssetItem(uv1) then
			uv0._fisheyeMat = slot0:GetResource(uv1)
		else
			logError("Resource is not found at path : " .. uv1)
		end

		if uv0._matLoader:getAssetItem(uv2) then
			uv0._blurMat = slot1:GetResource(uv2)
		else
			logError("Resource is not found at path : " .. uv2)
		end

		if uv0._matLoader:getAssetItem(uv3) then
			uv0._blurZoneMat = slot2:GetResource(uv3)
		else
			logError("Resource is not found at path : " .. uv3)
		end

		if uv0._matLoader:getAssetItem(uv4) then
			uv0._dissolveMat = slot3:GetResource(uv4)
		else
			logError("Resource is not found at path : " .. uv4)
		end
	end, slot0)

	slot0.handleBgEffectFuncDict = {
		[StoryEnum.BgTransType.Hard] = slot0._hardTrans,
		[StoryEnum.BgTransType.TransparencyFade] = slot0._fadeTrans,
		[StoryEnum.BgTransType.DarkFade] = slot0._darkFadeTrans,
		[StoryEnum.BgTransType.WhiteFade] = slot0._whiteFadeTrans,
		[StoryEnum.BgTransType.UpDarkFade] = slot0._darkUpTrans,
		[StoryEnum.BgTransType.RightDarkFade] = slot0._rightDarkTrans,
		[StoryEnum.BgTransType.Fragmentate] = slot0._fragmentTrans,
		[StoryEnum.BgTransType.Dissolve] = slot0._dissolveTrans,
		[StoryEnum.BgTransType.LeftDarkFade] = slot0._leftDarkTrans,
		[StoryEnum.BgTransType.MovieChangeStart] = slot0._movieChangeStartTrans,
		[StoryEnum.BgTransType.MovieChangeSwitch] = slot0._movieChangeSwitchTrans,
		[StoryEnum.BgTransType.TurnPage3] = slot0._turnPageTrans
	}
end

function slot0._initData(slot0)
	slot0._borderCanvas.alpha = 0
	slot0._bgSpine = nil
	slot0._bgCo = {}
	slot0._lastBgCo = {}

	gohelper.setActive(slot0._gobottom, false)
	gohelper.setActive(slot0._gofront, false)
	slot0:_showBgBottom(false)
	slot0:_showBgTop(false)

	if StoryModel.instance.skipFade then
		gohelper.setActive(slot0._goblack, false)
	end
end

function slot0.onOpen(slot0)
	ViewMgr.instance:openView(ViewName.StoryHeroView, nil, false)
	ViewMgr.instance:openView(ViewName.StoryLeadRoleSpineView, nil, true)
	ViewMgr.instance:openView(ViewName.StoryView, nil, true)
	slot0:_addEvents()
end

function slot0._addEvents(slot0)
	slot0:addEventCb(StoryController.instance, StoryEvent.RefreshStep, slot0._onUpdateUI, slot0)
	slot0:addEventCb(StoryController.instance, StoryEvent.RefreshBackground, slot0._colorFadeBgRefresh, slot0)
	slot0:addEventCb(StoryController.instance, StoryEvent.ShowBackground, slot0._showBg, slot0)
end

function slot0._showBg(slot0)
	gohelper.setActive(slot0._gobottom, true)
	gohelper.setActive(slot0._gofront, true)
end

function slot0._onUpdateUI(slot0, slot1)
	slot0:_checkPlayBorderFade(slot1)

	if #slot1.branches > 0 then
		return
	end

	slot0._bgParam = slot1

	slot0:_checkPlayBgBlurFade()
	TaskDispatcher.cancelTask(slot0._startShake, slot0)

	if StoryStepModel.instance:getStepListById(slot0._bgParam.stepId).bg.transType == StoryEnum.BgTransType.Keep then
		return
	end

	slot0._lastBgCo = LuaUtil.deepCopy(slot0._bgCo)
	slot0._bgCo = slot2

	slot0:_resetData()
	TaskDispatcher.cancelTask(slot0._enterChange, slot0)
	TaskDispatcher.runDelay(slot0._enterChange, slot0, slot0._bgCo.waitTimes[GameLanguageMgr.instance:getVoiceTypeStoryIndex()])
end

function slot0._checkPlayBorderFade(slot0, slot1)
	slot2 = StoryStepModel.instance:getStepListById(slot1.stepId).mourningBorder

	if slot0._fadeType and slot0._fadeType == slot2.borderType then
		return
	end

	slot0._fadeType = slot2.borderType

	if slot0._fadeType == StoryEnum.BorderType.Keep then
		return
	end

	if slot0._borderFadeId then
		ZProj.TweenHelper.KillById(slot0._borderFadeId)
	end

	if slot2.borderType == StoryEnum.BorderType.None then
		slot0._borderCanvas.alpha = 1
	elseif slot2.borderType == StoryEnum.BorderType.FadeOut then
		slot0._borderFadeId = ZProj.TweenHelper.DOFadeCanvasGroup(slot0._goblack, 1, 0, slot2.borderTimes[GameLanguageMgr.instance:getVoiceTypeStoryIndex()])
	elseif slot2.borderType == StoryEnum.BorderType.FadeIn then
		slot0._borderFadeId = ZProj.TweenHelper.DOFadeCanvasGroup(slot0._goblack, 0, 1, slot2.borderTimes[GameLanguageMgr.instance:getVoiceTypeStoryIndex()])
	end
end

function slot0._checkPlayBgBlurFade(slot0)
	if StoryStepModel.instance:getStepListById(slot0._bgParam.stepId).bg.bgType ~= StoryEnum.BgType.Picture then
		return
	end

	if slot1.transType == StoryEnum.BgTransType.Keep then
		return
	end

	if slot1.bgImg ~= slot0._bgCo.bgImg then
		return
	end

	if slot0._bgCo.effType ~= StoryEnum.BgEffectType.BgBlur then
		return
	end

	slot0:_actBgBlurFade()
end

function slot0._resetData(slot0)
	if slot0._goRightFade then
		gohelper.setActive(slot0._goRightFade, false)
	end

	if slot0._bgCo.transType ~= StoryEnum.BgTransType.RightDarkFade and slot0._goLeftFade then
		gohelper.setActive(slot0._goLeftFade, false)
	end

	if slot0._bgCo.transType ~= StoryEnum.BgTransType.MovieChangeStart and slot0._bgCo.transType ~= StoryEnum.BgTransType.MovieChangeSwitch then
		if slot0._bgMovieGo then
			gohelper.setActive(slot0._bgMovieGo, false)
		end

		if slot0._moveCameraAnimator and slot0._moveCameraAnimator.runtimeAnimatorController == slot0._cameraMovieAnimator then
			slot0._moveCameraAnimator.runtimeAnimatorController = nil
		end
	end

	gohelper.setActive(slot0._goblur, false)

	slot0._imgFitHeight.enabled = false
	slot0._imgOldFitHeight.enabled = false
	slot0._bgBlur.enabled = slot0._bgCo.effType == StoryEnum.BgEffectType.BgBlur
	slot0._cimagebgimg.vecInSide = Vector4.zero
	slot0._cimagebgold.vecInSide = Vector4.zero
	slot0._bgBlur.zoneImage = nil

	if slot0._imagebg.material ~= slot0._blurMat or slot0._bgCo.effType ~= StoryEnum.BgEffectType.BgBlur then
		slot0._imagebg.material = nil
	end

	slot0._imagebgtop.material = nil
	slot0._imagebgold.material = nil
	slot0._imagebgoldtop.material = nil

	slot0:_shakeStop()
	TaskDispatcher.cancelTask(slot0._shakeStop, slot0)
	ZProj.TweenHelper.KillByObj(slot0._simagebgimg.gameObject.transform)

	if slot0._dissolveId then
		ZProj.TweenHelper.KillById(slot0._dissolveId)

		slot0._dissolveId = nil
	end

	if slot0._blurId then
		ZProj.TweenHelper.KillById(slot0._blurId)

		slot0._blurId = nil
	end
end

function slot0._enterChange(slot0)
	slot0._rootAni = nil

	if slot0._loader then
		slot0._loader:dispose()

		slot0._loader = nil
	end

	if slot0._bgSubGo then
		gohelper.destroy(slot0._bgSubGo)

		slot0._bgSubGo = nil
	end

	slot0._matPath = nil
	slot0._prefabPath = nil

	if slot0.handleBgEffectFuncDict[slot0._bgCo.transType] then
		slot0.handleBgEffectFuncDict[slot0._bgCo.transType](slot0)
	else
		slot0:_commonTrans(slot0._bgCo.transType)
	end
end

function slot0._colorFadeBgRefresh(slot0)
	if StoryBgZoneModel.instance:getBgZoneByPath(slot0._bgCo.bgImg) then
		slot0._cimagebgimg.enabled = true

		gohelper.setActive(slot0._simagebgimgtop.gameObject, true)
	end

	slot0:_hardTrans()
end

function slot0._hardTrans(slot0)
	slot0:_refreshBg()
	slot0:_resetBgState()
end

function slot0._refreshBg(slot0)
	if not slot0._simagebgimg then
		return
	end

	if slot0._bgCo.bgType == StoryEnum.BgType.Picture then
		if slot0._bgCo.bgImg == "" then
			slot0:_showBgTop(false)
			slot0:_showBgBottom(false)

			return
		end

		slot0:_showBgTop(true)
		gohelper.setActive(slot0._upbgspine, false)
		slot0:_loadTopBg()

		if slot0._bgScaleId then
			ZProj.TweenHelper.KillById(slot0._bgScaleId)

			slot0._bgScaleId = nil
		end

		if slot0._bgPosId then
			ZProj.TweenHelper.KillById(slot0._bgPosId)

			slot0._bgPosId = nil
		end

		if slot0._bgRotateId then
			ZProj.TweenHelper.KillById(slot0._bgRotateId)

			slot0._bgRotateId = nil
		end

		if slot0._lastBgCo.bgType == StoryEnum.BgType.Picture then
			if not slot0._lastBgCo.bgImg or slot0._lastBgCo.bgImg == "" then
				slot0:_showBgBottom(false)

				return
			end

			slot0:_loadBottomBg()
		else
			gohelper.setActive(slot0._bottombgSpine, true)
			slot0:_showBgBottom(false)
			slot0:_onOldBgEffectLoaded()
		end
	else
		slot0:_showBgTop(false)

		if slot0._bgCo.bgImg == "" or string.split(slot0._bgCo.bgImg, ".")[1] == "" then
			gohelper.setActive(slot0._upbgspine, false)

			return
		end

		gohelper.setActive(slot0._upbgspine, true)

		slot0._effectLoader = PrefabInstantiate.Create(slot0._upbgspine)

		slot0._effectLoader:startLoad(slot0._bgCo.bgImg, slot0._onNewBgEffectLoaded, slot0)

		if slot0._lastBgCo.bgType == StoryEnum.BgType.Picture then
			if not slot0._lastBgCo.bgImg or slot0._lastBgCo.bgImg == "" then
				slot0:_showBgBottom(false)

				return
			end

			slot0:_loadBottomBg()
		else
			slot0:_showBgBottom(false)
			gohelper.setActive(slot0._bottombgSpine, true)
			slot0:_onOldBgEffectLoaded()
		end
	end
end

function slot0._onNewBgImgLoaded(slot0)
	if not slot0._imagebg or not slot0._imagebg.sprite then
		return
	end

	gohelper.setActive(slot0.viewGO, true)

	slot1, slot2 = ZProj.UGUIHelper.GetImageSpriteSize(slot0._imagebg, 0, 0)
	slot0._imgFitHeight.enabled = slot2 < 1080

	if slot2 >= 1080 then
		transformhelper.setLocalScale(slot0._simagebgimg.transform, 1.05, 1.05, 1.05)
	end

	slot0._imagebg:SetNativeSize()
	slot0:_checkPlayEffect()
end

function slot0._showBgBottom(slot0, slot1)
	gohelper.setActive(slot0._simagebgold.gameObject, slot1)

	if not slot1 then
		slot0._simagebgold:UnLoadImage()
	end
end

function slot0._showBgTop(slot0, slot1)
	gohelper.setActive(slot0._simagebgimg.gameObject, slot1)

	if not slot1 then
		slot0._simagebgimg:UnLoadImage()
	end
end

function slot0._loadBottomBg(slot0)
	gohelper.setActive(slot0._simagebgold.gameObject, true)
	gohelper.setActive(slot0._bottombgSpine, false)
	slot0._simagebgold:UnLoadImage()
	slot0._simagebgoldtop:UnLoadImage()

	slot1 = StoryBgZoneModel.instance:getBgZoneByPath(slot0._lastBgCo.bgImg)

	gohelper.setActive(slot0._simagebgoldtop.gameObject, slot1)

	if slot1 then
		slot0._simagebgoldtop:LoadImage(ResUrl.getStoryRes(slot1.path), slot0._onOldBgImgTopLoaded, slot0)
		transformhelper.setLocalPosXY(slot0._simagebgoldtop.gameObject.transform, slot1.offsetX, slot1.offsetY)
		slot0._simagebgold:LoadImage(ResUrl.getStoryRes(slot1.sourcePath), slot0._onOldBgImgLoaded, slot0)

		slot0._cimagebgold.vecInSide = Vector4.zero
	else
		slot0._simagebgold:LoadImage(ResUrl.getStoryRes(slot0._lastBgCo.bgImg), slot0._onOldBgImgLoaded, slot0)

		slot0._cimagebgold.vecInSide = Vector4.zero
	end
end

function slot0._loadTopBg(slot0)
	gohelper.setActive(slot0._simagebgimgtop.gameObject, false)

	slot0._cimagebgimg.enabled = true

	if StoryBgZoneModel.instance:getBgZoneByPath(slot0._bgCo.bgImg) then
		if slot0._simagebgimgtop.curImageUrl == ResUrl.getStoryRes(slot1.path) then
			slot0:_onNewBgImgTopLoaded()
		else
			slot0._simagebgimgtop:UnLoadImage()
			gohelper.setActive(slot0._simagebgimgtop.gameObject, true)
			slot0._simagebgimgtop:LoadImage(ResUrl.getStoryRes(slot1.path), slot0._onNewBgImgTopLoaded, slot0)
			transformhelper.setLocalPosXY(slot0._simagebgimgtop.gameObject.transform, slot1.offsetX, slot1.offsetY)
		end
	else
		if slot0._simagebgimg.curImageUrl == ResUrl.getStoryRes(slot0._bgCo.bgImg) then
			slot0:_onNewBgImgLoaded()
		else
			slot0._simagebgimg:UnLoadImage()
			slot0._simagebgimg:LoadImage(ResUrl.getStoryRes(slot0._bgCo.bgImg), slot0._onNewBgImgLoaded, slot0)
		end

		slot0._cimagebgimg.vecInSide = Vector4.zero
	end
end

function slot0._onNewBgImgTopLoaded(slot0)
	slot0._imagebgtop:SetNativeSize()
	slot0:_setZoneMat()

	if slot0._simagebgimg.curImageUrl == ResUrl.getStoryRes(StoryBgZoneModel.instance:getBgZoneByPath(slot0._bgCo.bgImg).sourcePath) then
		slot0:_onNewZoneBgImgLoaded()
	else
		slot0._simagebgimg:UnLoadImage()
		slot0._simagebgimg:LoadImage(ResUrl.getStoryRes(slot1.sourcePath), slot0._onNewZoneBgImgLoaded, slot0)
	end
end

function slot0._onNewZoneBgImgLoaded(slot0)
	gohelper.setActive(slot0._simagebgimgtop.gameObject, true)
	slot0:_onNewBgImgLoaded()
	slot0:_setZoneMat()
end

function slot0._setZoneMat(slot0)
	if not slot0._imagebg or not slot0._imagebg.material or not slot0._imagebgtop or not slot0._imagebgtop.sprite then
		return
	end

	slot1 = StoryBgZoneModel.instance:getBgZoneByPath(slot0._bgCo.bgImg)
	slot0._cimagebgimg.vecInSide = Vector4(recthelper.getWidth(slot0._imagebgtop.transform), recthelper.getHeight(slot0._imagebgtop.transform), slot1.offsetX, slot1.offsetY)

	if slot0._bgBlur.enabled then
		slot0._bgBlur.zoneImage = slot0._imagebgtop
	end
end

function slot0._onOldBgImgTopLoaded(slot0)
	slot0._imagebgoldtop:SetNativeSize()
end

function slot0._onOldBgImgLoaded(slot0)
	slot1, slot2 = ZProj.UGUIHelper.GetImageSpriteSize(slot0._imagebgold, 0, 0)

	transformhelper.setLocalPosXY(slot0._simagebgold.gameObject.transform, slot0._lastBgCo.offset[1], slot0._lastBgCo.offset[2])
	transformhelper.setLocalRotation(slot0._simagebgold.gameObject.transform, 0, 0, slot0._lastBgCo.angle)
	transformhelper.setLocalScale(slot0._gobottom.transform, slot0._lastBgCo.scale, slot0._lastBgCo.scale, 1)

	slot0._imgOldFitHeight.enabled = slot2 < 1080

	if slot2 >= 1080 then
		transformhelper.setLocalScale(slot0._simagebgold.transform, 1.05, 1.05, 1.05)
	end

	slot0._imagebgold:SetNativeSize()
end

function slot0._onNewBgEffectLoaded(slot0)
	if slot0._bgEffectGo then
		gohelper.destroy(slot0._bgEffectGo)

		slot0._bgEffectGo = nil
	end

	slot0._bgEffectGo = slot0._effectLoader:getInstGO()

	slot0:_checkPlayEffect()
end

function slot0._onOldBgEffectLoaded(slot0)
	if slot0._bgEffectOldGo then
		gohelper.destroy(slot0._bgEffectOldGo)

		slot0._bgEffectOldGo = nil
	end

	if slot0._bgEffectGo then
		slot0._bgEffectOldGo = gohelper.clone(slot0._bgEffectGo, slot0._bottombgSpine, "effectold")

		gohelper.destroy(slot0._bgEffectGo)

		slot0._bgEffectGo = nil
	end
end

function slot0._advanceLoadBgOld(slot0)
	slot0._simagebgold:UnLoadImage()
	slot0._simagebgoldtop:UnLoadImage()

	slot1 = StoryBgZoneModel.instance:getBgZoneByPath(slot0._bgCo.bgImg)

	gohelper.setActive(slot0._simagebgoldtop.gameObject, slot1)

	if slot1 then
		slot0._simagebgoldtop:LoadImage(ResUrl.getStoryRes(slot1.path), slot0._onOldBgImgTopLoaded, slot0)
		transformhelper.setLocalPosXY(slot0._simagebgoldtop.gameObject.transform, slot1.offsetX, slot1.offsetY)
		slot0._simagebgold:LoadImage(ResUrl.getStoryRes(slot1.sourcePath), function ()
			uv0._imagebgold.color = Color.white

			uv0._imagebgold:SetNativeSize()
			uv0:_onNewBgImgLoaded()
		end)
	else
		slot0._simagebgold:LoadImage(ResUrl.getStoryRes(slot0._bgCo.bgImg), function ()
			uv0._imagebgold.color = Color.white

			uv0._imagebgold:SetNativeSize()
			uv0:_onNewBgImgLoaded()
		end)
	end
end

function slot0._checkPlayEffect(slot0)
	if slot0._lastBgSubGo and slot0._lastBgCo.effType ~= StoryEnum.BgEffectType.BgGray then
		gohelper.destroy(slot0._lastBgSubGo)

		slot0._lastBgSubGo = nil
	end

	if slot0._bgCo.effType ~= StoryEnum.BgEffectType.Interfere then
		slot0:_resetInterfere()
	end

	if slot0._bgCo.effType ~= StoryEnum.BgEffectType.Sketch then
		slot0:_resetSketch()
	end

	if slot0._bgCo.effType ~= StoryEnum.BgEffectType.BlindFilter then
		slot0:_resetBlindFilter()
	end

	slot0:_actFullGrayUpdate(0.5)
	slot0:_actBgGrayUpdate(0)

	if slot0._bgCo.effType == StoryEnum.BgEffectType.BgBlur then
		slot0:_actBgBlur()

		return
	elseif slot0._bgCo.effType == StoryEnum.BgEffectType.FishEye then
		slot0:_actFishEye()
	elseif slot0._bgCo.effType == StoryEnum.BgEffectType.Shake then
		slot0:_actShake()
	elseif slot0._bgCo.effType == StoryEnum.BgEffectType.FullBlur then
		slot0:_actFullBlur()
	elseif slot0._bgCo.effType == StoryEnum.BgEffectType.BgGray then
		slot0:_actBgGray()
	elseif slot0._bgCo.effType == StoryEnum.BgEffectType.FullGray then
		slot0:_actFullGray()
	elseif slot0._bgCo.effType == StoryEnum.BgEffectType.Interfere then
		slot0:_showInterfere()
	elseif slot0._bgCo.effType == StoryEnum.BgEffectType.Sketch then
		slot0:_showSketch()
	elseif slot0._bgCo.effType == StoryEnum.BgEffectType.BlindFilter then
		slot0:_showBlindFilter()
	end

	slot0._bgBlur.blurWeight = 0

	gohelper.setActive(slot0._goblur, false)

	slot0._bgBlur.enabled = false
	slot0._cimagebgimg.vecInSide = Vector4.zero
	slot0._bgBlur.zoneImage = nil
end

function slot0._resetBgState(slot0)
	if slot0._bgCo.transTimes[GameLanguageMgr.instance:getVoiceTypeStoryIndex()] < 0.05 then
		transformhelper.setLocalPosXY(slot0._simagebgimg.gameObject.transform, slot0._bgCo.offset[1], slot0._bgCo.offset[2])
		transformhelper.setLocalRotation(slot0._simagebgimg.gameObject.transform, 0, 0, slot0._bgCo.angle)
		transformhelper.setLocalScale(slot0._gofront.transform, slot0._bgCo.scale, slot0._bgCo.scale, 1)
	else
		slot0._bgPosId = ZProj.TweenHelper.DOAnchorPos(slot0._simagebgimg.gameObject.transform, slot0._bgCo.offset[1], slot0._bgCo.offset[2], slot1, nil, , , slot0._bgCo.effType == StoryEnum.BgEffectType.MoveCurve and slot0._bgCo.effDegree or EaseType.InCubic)
		slot0._bgRotateId = ZProj.TweenHelper.DOLocalRotate(slot0._simagebgimg.gameObject.transform, 0, 0, slot0._bgCo.angle, slot1, nil, , , EaseType.InSine)
		slot0._bgScaleId = ZProj.TweenHelper.DOScale(slot0._gofront.gameObject.transform, slot0._bgCo.scale, slot0._bgCo.scale, 1, slot1, nil, , , EaseType.InQuad)
	end
end

function slot0._hideBg(slot0)
	slot0:_showBgBottom(false)
end

function slot0._fadeTrans(slot0)
	if slot0._bgCo.bgType == StoryEnum.BgType.Picture then
		slot0._imagebg.color.a = 0
		slot0._imagebg.color = Color.white

		slot0:_showBgTop(true)
		slot0:_resetBgState()

		if slot0._bgFadeId then
			ZProj.TweenHelper.KillById(slot0._bgFadeId)
		end

		slot0._bgFadeId = ZProj.TweenHelper.DOFadeCanvasGroup(slot0._imagebg.gameObject, 0, 1, slot0._bgCo.fadeTimes[GameLanguageMgr.instance:getVoiceTypeStoryIndex()], slot0._hideBg, slot0, nil, EaseType.Linear)

		slot0:_showBgBottom(true)
		slot0:_loadTopBg()

		if not slot0._lastBgCo or not next(slot0._lastBgCo) or slot0._lastBgCo.bgImg == "" then
			return
		end

		slot0._simagebgold:UnLoadImage()
		slot0._simagebgoldtop:UnLoadImage()

		slot1 = StoryBgZoneModel.instance:getBgZoneByPath(slot0._lastBgCo.bgImg)

		gohelper.setActive(slot0._simagebgoldtop.gameObject, slot1)

		if slot1 then
			slot0._simagebgoldtop:LoadImage(ResUrl.getStoryRes(slot1.path), slot0._onOldBgImgTopLoaded, slot0)
			transformhelper.setLocalPosXY(slot0._simagebgoldtop.gameObject.transform, slot1.offsetX, slot1.offsetY)
			slot0._simagebgold:LoadImage(ResUrl.getStoryRes(slot1.sourcePath), function ()
				uv0._imagebgold.color = Color.white

				uv0:_onOldBgImgLoaded()
				uv0:_refreshBg()
			end)
		else
			slot0._simagebgold:LoadImage(ResUrl.getStoryRes(slot0._lastBgCo.bgImg), function ()
				uv0._imagebgold.color = Color.white

				uv0:_onOldBgImgLoaded()
				uv0:_refreshBg()
			end)
		end
	end
end

function slot0._darkFadeTrans(slot0)
	StoryController.instance:dispatchEvent(StoryEvent.PlayDarkFade)
end

function slot0._whiteFadeTrans(slot0)
	StoryController.instance:dispatchEvent(StoryEvent.PlayWhiteFade)
end

function slot0._darkUpTrans(slot0)
	StoryController.instance:dispatchEvent(StoryEvent.PlayDarkFadeUp)
	slot0:_refreshBg()
	slot0:_resetBgState()
end

function slot0._commonTrans(slot0, slot1)
	slot0._curTransType = slot1
	slot3 = {}

	if StoryBgEffectTransModel.instance:getStoryBgEffectTransByType(slot1).prefab and slot2.prefab ~= "" then
		slot0._prefabPath = ResUrl.getStoryBgEffect(slot2.prefab)

		table.insert(slot3, slot0._prefabPath)
	end

	slot0:loadRes(slot3, slot0._onBgResLoaded, slot0)
end

function slot0._onBgResLoaded(slot0)
	if slot0._prefabPath then
		slot0._bgSubGo = gohelper.clone(slot0._loader:getAssetItem(slot0._prefabPath):GetResource(), slot0._imagebg.gameObject)

		if slot0._bgSubGo:GetComponent(typeof(ZProj.MaterialPropsCtrl)) and slot3.mas ~= nil and slot3.mas[0] ~= nil then
			slot0._imagebg.material = slot3.mas[0]
			slot0._imagebgtop.material = slot3.mas[0]

			StoryTool.enablePostProcess(true)
		end

		if slot0._curTransType == StoryEnum.BgTransType.Distort then
			StoryTool.enablePostProcess(true)

			slot0._rootAni = gohelper.findChild(slot0._bgSubGo, "root"):GetComponent(typeof(UnityEngine.Animator))

			TaskDispatcher.runDelay(slot0._distortEnd, slot0, slot0._bgCo.transTimes[GameLanguageMgr.instance:getVoiceTypeStoryIndex()])
		end
	end

	slot0:_showBgBottom(true)

	if slot0._bgCo.bgImg ~= "" then
		slot0:_advanceLoadBgOld()
	end

	TaskDispatcher.runDelay(slot0._commonTransFinished, slot0, StoryBgEffectTransModel.instance:getStoryBgEffectTransByType(slot0._curTransType).transTime)
end

function slot0._commonTransFinished(slot0)
	slot0:_refreshBg()
	slot0:_resetBgState()

	if StoryBgEffectTransModel.instance:getStoryBgEffectTransByType(slot0._curTransType).transTime > 0 then
		slot0._imagebg.material = nil
		slot0._imagebgtop.material = nil
	end
end

function slot0._distortEnd(slot0)
	if slot0._rootAni then
		slot0._rootAni:SetBool("change", true)
	end
end

function slot0._rightDarkTrans(slot0)
	if not slot0._goRightFade then
		slot0._goRightFade = slot0.viewContainer:getResInst(slot0.viewContainer:getSetting().otherRes[1], slot0._gosideways)
		slot0._rightAnim = slot0._goRightFade:GetComponent(typeof(UnityEngine.Animation))
	end

	gohelper.setActive(slot0._goRightFade, true)
	slot0._rightAnim:Play()
	TaskDispatcher.runDelay(slot0._changeRightDark, slot0, 0.2)
end

function slot0._changeRightDark(slot0)
	slot0:_refreshBg()
	slot0:_resetBgState()

	if slot0._goLeftFade then
		gohelper.setActive(slot0._goLeftFade, false)
	end
end

function slot0._leftDarkTrans(slot0)
	if not slot0._goLeftFade then
		slot0._goLeftFade = slot0.viewContainer:getResInst(slot0.viewContainer:getSetting().otherRes[2], slot0._gosideways)
		slot0._leftAnim = slot0._goLeftFade:GetComponent(typeof(UnityEngine.Animation))
	else
		gohelper.setActive(slot0._goLeftFade, true)
	end

	if slot0._goRightFade then
		gohelper.setActive(slot0._goRightFade, false)
	end

	slot0._leftAnim:Play()
	TaskDispatcher.runDelay(slot0._leftDarkTransFinished, slot0, 1.5)
end

function slot0._leftDarkTransFinished(slot0)
	slot0:_refreshBg()
	slot0:_resetBgState()
end

function slot0._fragmentTrans(slot0)
end

function slot0._movieChangeStartTrans(slot0)
	slot0._curTransType = StoryEnum.BgTransType.MovieChangeStart

	if not slot0._bgMovieGo then
		slot0._moviePrefabPath = ResUrl.getStoryBgEffect(StoryBgEffectTransModel.instance:getStoryBgEffectTransByType(slot0._curTransType).prefab)

		table.insert({}, slot0._moviePrefabPath)
	end

	if not slot0._cameraMovieAnimator then
		slot0._cameraAnimPath = "ui/animations/dynamic/custommaterialpass.controller"

		table.insert(slot2, slot0._cameraAnimPath)
	end

	slot0:loadRes(slot2, slot0._onMoveChangeBgResLoaded, slot0)
end

function slot0._onMoveChangeBgResLoaded(slot0)
	if not slot0._bgMovieGo and slot0._moviePrefabPath then
		slot0._bgMovieGo = gohelper.clone(slot0._loader:getAssetItem(slot0._moviePrefabPath):GetResource(), slot0._imagebg.gameObject)
		slot0._simageMovieCurBg = gohelper.findChildSingleImage(slot0._bgMovieGo, "#now/#simage_dec")
		slot0._simageMovieNewBg = gohelper.findChildSingleImage(slot0._bgMovieGo, "#next/#simage_dec")
	end

	gohelper.setActive(slot0._bgMovieGo, true)

	slot0._movieAnim = slot0._bgMovieGo:GetComponent(gohelper.Type_Animator)

	if not slot0._cameraMovieAnimator then
		slot0._cameraMovieAnimator = slot0._loader:getAssetItem(slot0._cameraAnimPath):GetResource()
	end

	slot0._moveCameraAnimator = CameraMgr.instance:getCameraRootAnimator()
	slot0._moveCameraAnimator.enabled = true
	slot0._moveCameraAnimator.runtimeAnimatorController = slot0._cameraMovieAnimator

	slot0:_setMovieNowBg()
	slot0._movieAnim:Play("idle", 0, 0)
end

function slot0._movieChangeSwitchTrans(slot0)
	slot0._curTransType = StoryEnum.BgTransType.MovieChangeSwitch

	if not slot0._bgMovieGo then
		return
	end

	slot0._moveCameraAnimator = CameraMgr.instance:getCameraRootAnimator()
	slot0._moveCameraAnimator.enabled = true
	slot0._moveCameraAnimator.runtimeAnimatorController = slot0._cameraMovieAnimator

	slot0._simageMovieNewBg:LoadImage(ResUrl.getStoryRes(slot0._bgCo.bgImg))

	if slot0._movieAnim then
		slot0._movieAnim:Play("switch", 0, 0)
		slot0._moveCameraAnimator:Play("dynamicblur", 0, 0)
		TaskDispatcher.runDelay(slot0._setMovieNowBg, slot0, 0.3)
	end
end

function slot0._setMovieNowBg(slot0)
	slot0._simageMovieCurBg:LoadImage(ResUrl.getStoryRes(slot0._bgCo.bgImg))
end

function slot0._turnPageTrans(slot0)
	slot0._curTransType = StoryEnum.BgTransType.TurnPage3
	slot2 = {}

	if not slot0._turnPageGo then
		slot0._turnPagePrefabPath = ResUrl.getStoryBgEffect(StoryBgEffectTransModel.instance:getStoryBgEffectTransByType(slot0._curTransType).prefab)

		table.insert(slot2, slot0._turnPagePrefabPath)
	end

	slot0:loadRes(slot2, slot0._onTurnPageBgResLoaded, slot0)
end

function slot0._onTurnPageBgResLoaded(slot0)
	if not slot0._turnPageGo and slot0._turnPagePrefabPath then
		slot0._turnPageGo = gohelper.clone(slot0._loader:getAssetItem(slot0._turnPagePrefabPath):GetResource(), slot0._imagebg.gameObject)
		slot0._turnPageAnim = slot0._turnPageGo:GetComponent(typeof(UnityEngine.Animation))
	end

	gohelper.setActive(slot0._turnPageGo, true)
	StoryTool.enablePostProcess(true)

	slot0._imgAnim = gohelper.findChild(ViewMgr.instance:getContainer(ViewName.StoryView).viewGO, "#go_middle/#go_img2"):GetComponent(typeof(UnityEngine.Animation))

	slot0._imgAnim:Play()
	slot0._turnPageAnim:Play()
	TaskDispatcher.runDelay(slot0._onTurnPageFinished, slot0, 0.67)
end

function slot0._onTurnPageFinished(slot0)
	if slot0._turnPageGo then
		gohelper.destroy(slot0._turnPageGo)

		slot0._turnPageGo = nil
	end

	slot0._imgAnim:GetComponent(gohelper.Type_RectMask2D).padding = Vector4(0, 0, 0, 0)
end

function slot0._dissolveTrans(slot0)
	if slot0._bgCo.bgType == StoryEnum.BgType.Picture then
		slot0:_showBgBottom(true)
		gohelper.setActive(slot0._bottombgSpine, false)

		if slot0._bgCo.bgImg ~= "" then
			slot0:_advanceLoadBgOld()
		end
	else
		slot0:_showBgBottom(false)
		gohelper.setActive(slot0._bottombgSpine, true)

		if string.split(slot0._bgCo.bgImg, ".")[1] ~= "" then
			slot0._effectLoader = PrefabInstantiate.Create(slot0._bottombgSpine)

			slot0._effectLoader:startLoad(slot0._bgCo.bgImg)
		end
	end

	slot0._imagebg:SetNativeSize()

	slot0._imagebg.material = slot0._dissolveMat
	slot0._imagebgtop.material = slot0._dissolveMat

	slot0:_dissolveChange(0)

	slot0._dissolveId = ZProj.TweenHelper.DOTweenFloat(0, -1.2, 2, slot0._dissolveChange, slot0._dissolveFinished, slot0, nil, EaseType.Linear)
end

function slot0._dissolveChange(slot0, slot1)
	slot0._imagebg.material:SetFloat(ShaderPropertyId.DissolveFactor, slot1)
	slot0._imagebgtop.material:SetFloat(ShaderPropertyId.DissolveFactor, slot1)
end

function slot0._dissolveFinished(slot0)
	slot0:_refreshBg()
	slot0:_resetBgState()

	slot0._imagebg.material = nil
	slot0._imagebgtop.material = nil
end

function slot0._actBgBlur(slot0)
	StoryTool.enablePostProcess(true)
	PostProcessingMgr.instance:setUIBlurActive(0)
	PostProcessingMgr.instance:setFreezeVisble(false)

	slot0._imagebg.material = slot0._blurMat
	slot0._imagebgtop.material = slot0._blurZoneMat
	slot0._bgBlur.enabled = true
	slot0._bgBlur.blurFactor = 0

	if slot0._bgCo.effTimes[GameLanguageMgr.instance:getVoiceTypeStoryIndex()] > 0.1 then
		slot0._blurId = ZProj.TweenHelper.DOTweenFloat(slot0._bgBlur.blurWeight, ({
			0,
			0.8,
			0.9,
			1
		})[slot0._bgCo.effDegree + 1], slot2, slot0._blurChange, slot0._blurFinished, slot0, nil, EaseType.Linear)
	else
		slot0:_blurChange(slot1[slot0._bgCo.effDegree + 1])
	end
end

function slot0._blurChange(slot0, slot1)
	slot0._bgBlur.blurWeight = slot1
end

function slot0._blurFinished(slot0)
	if slot0._blurId then
		ZProj.TweenHelper.KillById(slot0._blurId)

		slot0._blurId = nil
	end
end

function slot0._actBgBlurFade(slot0)
	if slot0._bgCo.effType == StoryEnum.BgEffectType.BgBlur and slot0._bgCo.effTimes[GameLanguageMgr.instance:getVoiceTypeStoryIndex()] > 0.1 then
		return
	end

	PostProcessingMgr.instance:setUIBlurActive(0)
	PostProcessingMgr.instance:setFreezeVisble(false)

	slot0._blurId = ZProj.TweenHelper.DOTweenFloat(slot0._bgBlur.blurWeight, 0, 1.5, slot0._blurChange, slot0._blurFinished, slot0, nil, EaseType.Linear)
end

function slot0._actFishEye(slot0)
	slot0._imagebg.material = slot0._fisheyeMat
	slot0._imagebgtop.material = slot0._fisheyeMat
end

function slot0._actShake(slot0)
	if slot0._bgCo.effTimes[GameLanguageMgr.instance:getVoiceTypeStoryIndex()] < 0.1 then
		return
	end

	if slot0._bgCo.effDelayTimes[GameLanguageMgr.instance:getVoiceTypeStoryIndex()] < 0.1 then
		slot0:_startShake()
	else
		TaskDispatcher.runDelay(slot0._startShake, slot0, slot0._bgCo.effDelayTimes[GameLanguageMgr.instance:getVoiceTypeStoryIndex()])
	end
end

function slot0._startShake(slot0)
	slot0._bgAnimator.enabled = true

	slot0._bgAnimator:SetBool("stoploop", false)
	slot0._bgAnimator:Play(({
		"idle",
		"low",
		"middle",
		"high"
	})[slot0._bgCo.effDegree + 1])

	slot0._bgAnimator.speed = slot0._bgCo.effRate

	TaskDispatcher.runDelay(slot0._shakeStop, slot0, slot0._bgCo.effTimes[GameLanguageMgr.instance:getVoiceTypeStoryIndex()])
end

function slot0._shakeStop(slot0)
	if slot0._bgAnimator then
		slot0._bgAnimator:SetBool("stoploop", true)
	end
end

function slot0._actFullBlur(slot0)
	PostProcessingMgr.instance:setUIBlurActive(3)
	PostProcessingMgr.instance:setFreezeVisble(true)
	StoryController.instance:dispatchEvent(StoryEvent.PlayFullBlurIn, slot0._bgCo.effDegree, slot0._bgCo.effTimes[GameLanguageMgr.instance:getVoiceTypeStoryIndex()])
end

function slot0._actBgGray(slot0)
	if slot0._bgGrayId then
		ZProj.TweenHelper.KillById(slot0._bgGrayId)

		slot0._bgGrayId = nil
	end

	slot0:_actFullGrayUpdate(0.5)

	if slot0._bgCo.effDegree == 0 then
		slot0._prefabPath = ResUrl.getStoryBgEffect("v1a9_saturation")

		slot0:loadRes({
			slot0._prefabPath
		}, slot0._actBgGrayLoaded, slot0)
	else
		if not slot0._prefabPath or not slot0._bgSubGo then
			return
		end

		if not slot0._bgSubGo:GetComponent(typeof(ZProj.MaterialPropsCtrl)) then
			return
		end

		StoryTool.enablePostProcess(true)

		if slot0._bgCo.effTimes[GameLanguageMgr.instance:getVoiceTypeStoryIndex()] < 0.1 then
			slot0:_actBgGrayUpdate(0)
		else
			slot0._bgGrayId = ZProj.TweenHelper.DOTweenFloat(slot1.float_01, 0, slot0._bgCo.effTimes[GameLanguageMgr.instance:getVoiceTypeStoryIndex()], slot0._actBgGrayUpdate, slot0._actBgGrayFinished, slot0)
		end
	end
end

function slot0._actBgGrayLoaded(slot0)
	if slot0._bgSubGo and slot0._lastBgCo.effType == StoryEnum.BgEffectType.BgGray then
		if not slot0._lastBgSubGo then
			slot0._lastBgSubGo = gohelper.clone(slot0._bgSubGo, slot0._imagebgold.gameObject)
		end

		slot1 = slot0._lastBgSubGo:GetComponent(typeof(ZProj.MaterialPropsCtrl))
		slot0._imagebgold.material = slot1.mas[0]
		slot0._imagebgoldtop.material = slot1.mas[0]
	end

	if slot0._prefabPath then
		if slot0._bgSubGo and slot0._lastBgCo.effType == StoryEnum.BgEffectType.BgGray then
			gohelper.destroy(slot0._bgSubGo)
		end

		slot0._bgSubGo = gohelper.clone(slot0._loader:getAssetItem(slot0._prefabPath):GetResource(), slot0._imagebg.gameObject)
		slot2 = slot0._bgSubGo:GetComponent(typeof(ZProj.MaterialPropsCtrl))
		slot0._imagebg.material = slot2.mas[0]
		slot0._imagebgtop.material = slot2.mas[0]

		StoryTool.enablePostProcess(true)

		if slot0._bgCo.effTimes[GameLanguageMgr.instance:getVoiceTypeStoryIndex()] < 0.1 then
			slot0:_actBgGrayUpdate(1)
		else
			slot0._bgGrayId = ZProj.TweenHelper.DOTweenFloat(0, 1, slot0._bgCo.effTimes[GameLanguageMgr.instance:getVoiceTypeStoryIndex()], slot0._actBgGrayUpdate, slot0._actGrayFinished, slot0)
		end
	end
end

function slot0._actBgGrayUpdate(slot0, slot1)
	if not slot0._bgSubGo then
		return
	end

	if not slot0._bgSubGo:GetComponent(typeof(ZProj.MaterialPropsCtrl)) then
		return
	end

	slot2.float_01 = slot1
end

function slot0._actGrayFinished(slot0)
	if slot0._bgGrayId then
		ZProj.TweenHelper.KillById(slot0._bgGrayId)

		slot0._bgGrayId = nil
	end
end

function slot0._actFullGray(slot0)
	slot0:_actBgGrayUpdate(0)

	if slot0._bgGrayId then
		ZProj.TweenHelper.KillById(slot0._bgGrayId)

		slot0._bgGrayId = nil
	end

	if slot0._bgCo.effDegree == 0 then
		StoryTool.enablePostProcess(true)

		if slot0._bgCo.effTimes[GameLanguageMgr.instance:getVoiceTypeStoryIndex()] < 0.1 then
			slot0:_actFullGrayUpdate(1)
		else
			slot0._bgGrayId = ZProj.TweenHelper.DOTweenFloat(0.5, 1, slot0._bgCo.effTimes[GameLanguageMgr.instance:getVoiceTypeStoryIndex()], slot0._actFullGrayUpdate, slot0._actGrayFinished, slot0)
		end
	elseif slot0._bgCo.effTimes[GameLanguageMgr.instance:getVoiceTypeStoryIndex()] < 0.1 then
		slot0:_actFullGrayUpdate(0.5)
	else
		slot0._bgGrayId = ZProj.TweenHelper.DOTweenFloat(PostProcessingMgr.instance:getUIPPValue("Saturation"), 0.5, slot0._bgCo.effTimes[GameLanguageMgr.instance:getVoiceTypeStoryIndex()], slot0._actFullGrayUpdate, slot0._actGrayFinished, slot0)
	end
end

function slot0._actFullGrayUpdate(slot0, slot1)
	PostProcessingMgr.instance:setUIPPValue("saturation", slot1)
	PostProcessingMgr.instance:setUIPPValue("Saturation", slot1)
end

function slot0._resetInterfere(slot0)
	if slot0._interfereGo then
		gohelper.destroy(slot0._interfereGo)

		slot0._interfereGo = nil
	end

	gohelper.setLayer(ViewMgr.instance:getContainer(ViewName.StoryView).viewGO, UnityLayer.UISecond, true)
	gohelper.setLayer(gohelper.findChild(ViewMgr.instance:getContainer(ViewName.StoryLeadRoleSpineView).viewGO, "#go_spineroot"), UnityLayer.UIThird, true)
	gohelper.setLayer(slot0._gobliteff, UnityLayer.UI, true)
end

function slot0._showInterfere(slot0)
	if slot0._interfereGo then
		slot0:_setInterfere()
	else
		slot0._interfereEffPrefPath = ResUrl.getStoryBgEffect("glitch_common")
		slot1 = {}

		table.insert(slot1, slot0._interfereEffPrefPath)
		slot0:loadRes(slot1, slot0._onInterfereResLoaded, slot0)
	end
end

function slot0._onInterfereResLoaded(slot0)
	if slot0._interfereEffPrefPath then
		slot0._interfereGo = gohelper.clone(slot0._loader:getAssetItem(slot0._interfereEffPrefPath):GetResource(), ViewMgr.instance:getContainer(ViewName.StoryFrontView).viewGO)

		slot0:_setInterfere()
	end
end

function slot0._setInterfere(slot0)
	StoryTool.enablePostProcess(true)
	gohelper.setAsFirstSibling(slot0._interfereGo)
	slot0._interfereGo:GetComponent(typeof(UnityEngine.UI.Image)).material:SetTexture("_MainTex", slot0._blitEff.capturedTexture)
	gohelper.setLayer(ViewMgr.instance:getContainer(ViewName.StoryView).viewGO, UnityLayer.UITop, true)
	gohelper.setLayer(gohelper.findChild(ViewMgr.instance:getContainer(ViewName.StoryLeadRoleSpineView).viewGO, "#go_spineroot"), UnityLayer.UITop, true)
	gohelper.setLayer(slot0._gobliteff, UnityLayer.UISecond, true)
end

function slot0._resetSketch(slot0)
	if slot0._bgSketchId then
		ZProj.TweenHelper.KillById(slot0._bgSketchId)

		slot0._bgSketchId = nil
	end

	if slot0._sketchGo then
		gohelper.destroy(slot0._sketchGo)

		slot0._sketchGo = nil
	end

	gohelper.setLayer(ViewMgr.instance:getContainer(ViewName.StoryView).viewGO, UnityLayer.UISecond, true)
	gohelper.setLayer(gohelper.findChild(ViewMgr.instance:getContainer(ViewName.StoryLeadRoleSpineView).viewGO, "#go_spineroot"), UnityLayer.UIThird, true)
	gohelper.setLayer(slot0._gobliteff, UnityLayer.UI, true)
end

function slot0._showSketch(slot0)
	if slot0._bgSketchId then
		ZProj.TweenHelper.KillById(slot0._bgSketchId)

		slot0._bgSketchId = nil
	end

	if slot0._bgCo.effDegree == 0 and not slot0._sketchGo then
		return
	end

	if slot0._sketchGo then
		slot0:_setSketch()
	else
		slot0._sketchEffPrefPath = ResUrl.getStoryBgEffect("storybg_sketch")
		slot1 = {}

		table.insert(slot1, slot0._sketchEffPrefPath)
		slot0:loadRes(slot1, slot0._onSketchResLoaded, slot0)
	end
end

slot1 = {
	1,
	0.4,
	0.2,
	0
}

function slot0._onSketchResLoaded(slot0)
	if slot0._sketchEffPrefPath then
		slot0._sketchGo = gohelper.clone(slot0._loader:getAssetItem(slot0._sketchEffPrefPath):GetResource(), ViewMgr.instance:getContainer(ViewName.StoryFrontView).viewGO)

		slot0:_setSketch()
	end
end

function slot0._setSketch(slot0)
	StoryTool.enablePostProcess(true)
	gohelper.setAsFirstSibling(slot0._sketchGo)

	slot0._imgSketch = slot0._sketchGo:GetComponent(typeof(UnityEngine.UI.Image))

	slot0._imgSketch.material:SetTexture("_MainTex", slot0._blitEff.capturedTexture)

	if slot0._bgCo.effTimes[GameLanguageMgr.instance:getVoiceTypeStoryIndex()] < 0.1 then
		slot0:_sketchUpdate(uv0[slot0._bgCo.effDegree + 1])
	else
		slot0._bgSketchId = ZProj.TweenHelper.DOTweenFloat(slot0._bgCo.effDegree > 0 and 1 or slot0._imgSketch.material:GetFloat("_SourceColLerp"), uv0[slot0._bgCo.effDegree + 1], slot0._bgCo.effTimes[GameLanguageMgr.instance:getVoiceTypeStoryIndex()], slot0._sketchUpdate, slot0._sketchFinished, slot0)
	end

	gohelper.setLayer(ViewMgr.instance:getContainer(ViewName.StoryView).viewGO, UnityLayer.UITop, true)
	gohelper.setLayer(gohelper.findChild(ViewMgr.instance:getContainer(ViewName.StoryLeadRoleSpineView).viewGO, "#go_spineroot"), UnityLayer.UITop, true)
	gohelper.setLayer(slot0._gobliteff, UnityLayer.UISecond, true)
end

function slot0._sketchUpdate(slot0, slot1)
	slot0._imgSketch.material:SetFloat("_SourceColLerp", slot1)
end

function slot0._sketchFinished(slot0)
	if slot0._bgSketchId then
		ZProj.TweenHelper.KillById(slot0._bgSketchId)

		slot0._bgSketchId = nil
	end
end

function slot0._resetBlindFilter(slot0)
	if slot0._bgFilterId then
		ZProj.TweenHelper.KillById(slot0._bgFilterId)

		slot0._bgFilterId = nil
	end

	if slot0._filterGo then
		gohelper.destroy(slot0._filterGo)

		slot0._filterGo = nil
	end

	gohelper.setLayer(ViewMgr.instance:getContainer(ViewName.StoryView).viewGO, UnityLayer.UISecond, true)
	gohelper.setLayer(gohelper.findChild(ViewMgr.instance:getContainer(ViewName.StoryLeadRoleSpineView).viewGO, "#go_spineroot"), UnityLayer.UIThird, true)
	gohelper.setLayer(slot0._gobliteff, UnityLayer.UI, true)
end

function slot0._showBlindFilter(slot0)
	if slot0._bgFilterId then
		ZProj.TweenHelper.KillById(slot0._bgFilterId)

		slot0._bgFilterId = nil
	end

	if slot0._bgCo.effDegree == 0 and not slot0._filterGo then
		return
	end

	if slot0._filterGo then
		slot0:_setBlindFilter()
	else
		slot0._filterEffPrefPath = ResUrl.getStoryBgEffect("storybg_blinder")
		slot1 = {}

		table.insert(slot1, slot0._filterEffPrefPath)
		slot0:loadRes(slot1, slot0._onFilterResLoaded, slot0)
	end
end

function slot0._onFilterResLoaded(slot0)
	if slot0._filterEffPrefPath then
		slot0._filterGo = gohelper.clone(slot0._loader:getAssetItem(slot0._filterEffPrefPath):GetResource(), ViewMgr.instance:getContainer(ViewName.StoryFrontView).viewGO)

		slot0:_setBlindFilter()
	end
end

slot2 = {
	1,
	0.4,
	0.2,
	0
}

function slot0._setBlindFilter(slot0)
	StoryTool.enablePostProcess(true)
	gohelper.setAsFirstSibling(slot0._filterGo)

	slot0._imgFilter = slot0._filterGo:GetComponent(typeof(UnityEngine.UI.Image))

	slot0._imgFilter.material:SetTexture("_MainTex", slot0._blitEff.capturedTexture)

	if slot0._bgCo.effTimes[GameLanguageMgr.instance:getVoiceTypeStoryIndex()] < 0.1 then
		slot0:_filterUpdate(uv0[slot0._bgCo.effDegree + 1])
	else
		slot0._bgFilterId = ZProj.TweenHelper.DOTweenFloat(slot0._bgCo.effDegree > 0 and 1 or slot0._imgFilter.material:GetFloat("_SourceColLerp"), uv0[slot0._bgCo.effDegree + 1], slot0._bgCo.effTimes[GameLanguageMgr.instance:getVoiceTypeStoryIndex()], slot0._filterUpdate, slot0._filterFinished, slot0)
	end

	gohelper.setLayer(ViewMgr.instance:getContainer(ViewName.StoryView).viewGO, UnityLayer.UITop, true)
	gohelper.setLayer(gohelper.findChild(ViewMgr.instance:getContainer(ViewName.StoryLeadRoleSpineView).viewGO, "#go_spineroot"), UnityLayer.UITop, true)
	gohelper.setLayer(slot0._gobliteff, UnityLayer.UISecond, true)
end

function slot0._filterUpdate(slot0, slot1)
	slot0._imgFilter.material:SetFloat("_SourceColLerp", slot1)
end

function slot0._filterFinished(slot0)
	if slot0._bgFilterId then
		ZProj.TweenHelper.KillById(slot0._bgFilterId)

		slot0._bgFilterId = nil
	end
end

function slot0.loadRes(slot0, slot1, slot2, slot3)
	if slot0._loader then
		slot0._loader:dispose()

		slot0._loader = nil
	end

	if slot1 and #slot1 > 0 then
		slot0._loader = MultiAbLoader.New()

		slot0._loader:setPathList(slot1)
		slot0._loader:startLoad(slot2, slot3)
	elseif slot2 then
		slot2(slot3)
	end
end

function slot0.onClose(slot0)
	slot0:_clearBg()

	if slot0._bgFadeId then
		ZProj.TweenHelper.KillById(slot0._bgFadeId)
	end

	gohelper.setActive(slot0.viewGO, false)
	ViewMgr.instance:closeView(ViewName.StoryHeroView)
	slot0:_removeEvents()
end

function slot0._clearBg(slot0)
	if slot0._blurId then
		ZProj.TweenHelper.KillById(slot0._blurId)

		slot0._blurId = nil
	end

	if slot0._bgScaleId then
		ZProj.TweenHelper.KillById(slot0._bgScaleId)

		slot0._bgScaleId = nil
	end

	if slot0._bgPosId then
		ZProj.TweenHelper.KillById(slot0._bgPosId)

		slot0._bgPosId = nil
	end

	if slot0._bgRotateId then
		ZProj.TweenHelper.KillById(slot0._bgRotateId)

		slot0._bgRotateId = nil
	end

	if slot0._bgGrayId then
		ZProj.TweenHelper.KillById(slot0._bgGrayId)

		slot0._bgGrayId = nil
	end

	if slot0._bgSketchId then
		ZProj.TweenHelper.KillById(slot0._bgSketchId)

		slot0._bgSketchId = nil
	end

	TaskDispatcher.cancelTask(slot0._onTurnPageFinished, slot0)
	TaskDispatcher.cancelTask(slot0._changeRightDark, slot0)
	TaskDispatcher.cancelTask(slot0._enterChange, slot0)
	TaskDispatcher.cancelTask(slot0._startShake, slot0)
	TaskDispatcher.cancelTask(slot0._shakeStop, slot0)
	TaskDispatcher.cancelTask(slot0._distortEnd, slot0)
	TaskDispatcher.cancelTask(slot0._leftDarkTransFinished, slot0)
	TaskDispatcher.cancelTask(slot0._commonTransFinished, slot0)

	if slot0._simagebgimg then
		slot0._simagebgimg:UnLoadImage()

		slot0._simagebgimg = nil
	end

	if slot0._simagebgimgtop then
		slot0._simagebgimgtop:UnLoadImage()

		slot0._simagebgimgtop = nil
	end

	if slot0._simagebgold then
		slot0._simagebgold:UnLoadImage()

		slot0._simagebgold = nil
	end

	if slot0._simagebgoldtop then
		slot0._simagebgoldtop:UnLoadImage()

		slot0._simagebgoldtop = nil
	end
end

function slot0._removeEvents(slot0)
	slot0:removeEventCb(StoryController.instance, StoryEvent.RefreshStep, slot0._onUpdateUI, slot0)
	slot0:removeEventCb(StoryController.instance, StoryEvent.RefreshBackground, slot0._colorFadeBgRefresh, slot0)
	slot0:removeEventCb(StoryController.instance, StoryEvent.ShowBackground, slot0._showBg, slot0)
end

function slot0.onDestroyView(slot0)
	slot0:_clearBg()
	slot0:_actFullGrayUpdate(0.5)

	if slot0._borderFadeId then
		ZProj.TweenHelper.KillById(slot0._borderFadeId)
	end

	if slot0._loader then
		slot0._loader:dispose()

		slot0._loader = nil
	end

	if slot0._matLoader then
		slot0._matLoader:dispose()

		slot0._matLoader = nil
	end
end

return slot0
