module("modules.logic.versionactivity2_7.dungeon.view.map.scene.VersionActivity2_7DungeonMapScene", package.seeall)

slot0 = class("VersionActivity2_7DungeonMapScene", VersionActivityFixedDungeonMapScene)
slot1 = 1
slot2 = 0.16

function slot0.onInitView(slot0)
	uv0.super.onInitView(slot0)

	slot0._mainCameraGO = CameraMgr.instance:getMainCameraGO()
	slot0._mainRoot = CameraMgr.instance:getCameraTraceGO()
	slot0._mainCamera = CameraMgr.instance:getMainCamera()
	slot0._mainCameraAnim = gohelper.onceAddComponent(CameraMgr.instance:getCameraRootGO(), typeof(UnityEngine.Animator))
	slot0._mainCustomCameraData = slot0._mainCameraGO:GetComponent(PostProcessingMgr.PPCustomCamDataType)
	slot0._unitCameraGO = CameraMgr.instance:getUnitCameraGO()
	slot0._unitCamera = CameraMgr.instance:getUnitCamera()
	slot0._ppVolumeGo = gohelper.findChild(slot0._unitCameraGO, "PPVolume")
	slot0._unitPPVolume = slot0._ppVolumeGo:GetComponent(PostProcessingMgr.PPVolumeWrapType)
	slot1, slot2 = transformhelper.getLocalRotation(slot0._mainRoot.transform)
	slot0._ppvalue = {
		BloomActive = false,
		bloomThreshold = 0.7,
		localBloomActive = false
	}

	for slot7, slot8 in pairs(slot0._ppvalue) do
		-- Nothing
	end

	slot0._cameraParam = {
		runtimeAnimatorController = slot0._mainCameraAnim.runtimeAnimatorController,
		volumeTrigger = slot0._mainCustomCameraData.volumeTrigger,
		usePostProcess = slot0._mainCustomCameraData.usePostProcess,
		unitCameraGOActive = slot0._unitCameraGO.gameObject.activeSelf,
		unitCameraEnable = slot0._unitCamera.enabled,
		unitPPValue = {
			[slot7] = PostProcessingMgr.instance:getUnitPPValue(slot7)
		},
		orthographic = slot0._mainCamera.orthographic,
		Fov = slot0._mainCamera.fieldOfView,
		RotateY = slot2,
		IgnoreUIBlur = PostProcessingMgr.instance:getIgnoreUIBlur()
	}
	slot0._isNeedCircleMv = UIBlockMgrExtend.needCircleMv
end

function slot0.addEvents(slot0)
	uv0.super.addEvents(slot0)
	slot0:addEventCb(ViewMgr.instance, ViewEvent.OnOpenFullViewFinish, slot0._onOpenFullViewFinish, slot0, LuaEventSystem.Low)
	slot0:addEventCb(ViewMgr.instance, ViewEvent.OnOpenView, slot0._onOpenView, slot0)
	slot0:addEventCb(ViewMgr.instance, ViewEvent.OnCloseView, slot0._onCloseView, slot0)
	slot0:addEventCb(ViewMgr.instance, ViewEvent.OnCloseViewFinish, slot0._onCloseViewFinish, slot0)
	slot0:addEventCb(VersionActivityFixedDungeonController.instance, VersionActivityFixedDungeonEvent.SwitchBGM, slot0._switchBGM, slot0)
	slot0:addEventCb(VersionActivityFixedDungeonController.instance, VersionActivityFixedDungeonEvent.OpenFinishMapLevelView, slot0._openFinishMapLevelView, slot0)
end

function slot0.removeEvents(slot0)
	uv0.super.removeEvents(slot0)
	slot0:removeEventCb(ViewMgr.instance, ViewEvent.OnOpenFullViewFinish, slot0._onOpenFullViewFinish, slot0, LuaEventSystem.Low)
	slot0:removeEventCb(ViewMgr.instance, ViewEvent.OnOpenView, slot0._onOpenView, slot0)
	slot0:removeEventCb(ViewMgr.instance, ViewEvent.OnCloseView, slot0._onCloseView, slot0)
	slot0:removeEventCb(ViewMgr.instance, ViewEvent.OnCloseViewFinish, slot0._onCloseViewFinish, slot0)
	slot0:removeEventCb(VersionActivityFixedDungeonController.instance, VersionActivityFixedDungeonEvent.SwitchBGM, slot0._switchBGM, slot0)
	slot0:removeEventCb(VersionActivityFixedDungeonController.instance, VersionActivityFixedDungeonEvent.OpenFinishMapLevelView, slot0._openFinishMapLevelView, slot0)
end

function slot0.onOpen(slot0)
	slot0:_onLoadRes()
	uv0.super.onOpen(slot0)
end

function slot0._checkCameraParam(slot0)
	if slot0:_isSpaceScene() then
		slot0:_setCameraParam()
	else
		slot0:_resetCameraParam()
	end
end

function slot0._onOpenFullViewFinish(slot0, slot1)
	if slot1 == slot0.viewName then
		slot0:_checkCameraParam()
	end
end

slot3 = {
	ViewName.VersionActivity2_7StoreView,
	ViewName.VersionActivity2_7TaskView,
	ViewName.DungeonRewardView
}

function slot0._onOpenView(slot0, slot1)
	if LuaUtil.tableContains(uv0, slot1) then
		slot0:_resetCameraParam()
	end

	if slot1 == ViewName.StoryFrontView then
		slot0:_playSceneBgm(false)
	end
end

function slot0._openFinishMapLevelView(slot0, slot1)
	slot0:_setLoadParent(slot1)
end

function slot0._onCloseView(slot0, slot1)
	if LuaUtil.tableContains(uv0, slot1) then
		slot0:_checkCameraParam()
	end

	if slot1 == ViewName.VersionActivity2_7DungeonMapLevelView then
		slot0:_setLoadParent(slot0.viewGO)
	end
end

function slot0._onCloseViewFinish(slot0, slot1)
	if slot1 == ViewName.StoryFrontView then
		slot0:_switchBGM()
		slot0:refreshMap()
	end
end

function slot0._switchBGM(slot0)
	slot0:_playSceneBgm(slot0:_isSpaceScene())
end

function slot0._setLoadParent(slot0, slot1)
	if slot0._loadObj then
		slot0._loadObj.transform:SetParent(slot1.transform, true)
	end
end

function slot0._cancelTask(slot0)
	TaskDispatcher.cancelTask(slot0._cutSpaceScene, slot0)
	TaskDispatcher.cancelTask(slot0._spaceSceneAnimFinish, slot0)
	TaskDispatcher.cancelTask(slot0._enterOrReturnSpace, slot0)
	TaskDispatcher.cancelTask(slot0._setMapPos, slot0)
end

function slot0.onClose(slot0)
	uv0.super.onClose(slot0)
	slot0:_cancelTask()
	slot0:_resetCameraParam()
	slot0:_playSceneBgm(false)

	if slot0._mainCameraAnim then
		slot0._mainCameraAnim.runtimeAnimatorController = slot0._cameraParam.runtimeAnimatorController
	end

	slot0._curEpisodeIndex = nil

	VersionActivity2_7DungeonController.instance:resetLoading()
end

function slot0.refreshMap(slot0, slot1, slot2)
	slot0._mapCfg = slot2 or VersionActivityFixedDungeonConfig.instance:getEpisodeMapConfig(slot0.activityDungeonMo.episodeId)
	slot0.needTween = slot1

	slot0:_checkGoSpaceOrReturn()
end

function slot0._initScene(slot0)
	if gohelper.findChild(slot0._sceneGo, "root/size") then
		uv0.super._initScene(slot0)
	else
		slot0._mapMinX = nil
		slot0._mapMaxX = nil
		slot0._mapMinY = nil
		slot0._mapMaxY = nil
	end
end

function slot0._reallyCutScene(slot0)
	if slot0._mapCfg.id == slot0._lastLoadMapId then
		if not slot0.loadedDone then
			return
		end

		slot0:_initElements()
		slot0:_setMapPos()
	else
		if slot0._lastLoadMapId and lua_chapter_map.configDict[slot0._lastLoadMapId].res == slot0._mapCfg.res then
			slot0._lastLoadMapId = slot0._mapCfg.id

			slot0:_initScene()
			slot0:_setMapPos()
			slot0:_addMapLight()
			slot0:_initElements()
			slot0:_addMapAudio()

			return
		end

		slot0._lastLoadMapId = slot0._mapCfg.id

		slot0:loadMap()
	end

	VersionActivityFixedDungeonModel.instance:setMapNeedTweenState(true)
end

slot0.UI_CLICK_BLOCK_KEY = "VersionActivity2_7DungeonMapScene_Click"

function slot0._startBlock(slot0)
	UIBlockMgrExtend.setNeedCircleMv(false)
	UIBlockMgr.instance:startBlock(uv0.UI_CLICK_BLOCK_KEY)
end

function slot0._endBlock(slot0)
	UIBlockMgrExtend.setNeedCircleMv(slot0._isNeedCircleMv)
	UIBlockMgr.instance:endBlock(uv0.UI_CLICK_BLOCK_KEY)
end

function slot0._checkGoSpaceOrReturn(slot0)
	slot0:_cancelTask()

	if slot0._curEpisodeIndex and not slot0:_isSpaceScene(slot2) and slot0:_isSpaceScene(DungeonConfig.instance:getEpisodeLevelIndexByEpisodeId(slot0.activityDungeonMo.episodeId)) then
		slot0._sceneAnimType = VersionActivity2_7DungeonEnum.SceneAnimType.GotoSpace

		slot0:_startBlock()
		slot0:_tweenPreSpaceScenePos()
	elseif slot2 and slot0:_isSpaceScene(slot2) and not slot0:_isSpaceScene(slot1) then
		slot0._sceneAnimType = VersionActivity2_7DungeonEnum.SceneAnimType.ReturnEarth

		slot0:_startBlock()
		slot0:_enterOrReturnSpace()
	else
		slot0._sceneAnimType = VersionActivity2_7DungeonEnum.SceneAnimType.Normal

		slot0:_reallyCutScene()
	end

	slot0._curEpisodeIndex = slot1
end

function slot0._getEpisodeCoByIndex(slot0, slot1)
	if not slot0._episodeList then
		slot0._episodeList = DungeonConfig.instance:getChapterEpisodeCOList(VersionActivityFixedHelper.getVersionActivityDungeonEnum().DungeonChapterId.Story)
	end

	if slot0._episodeList[slot1] then
		return lua_chapter_map.configDict[slot0._episodeList[slot1].id]
	end
end

function slot0._getPreSpaceScenePos(slot0)
	return slot0:_getEpisodeCoByIndex(slot0:_getFirstSpaceSceneEpisodeIndex() - 1).initPos
end

function slot0._getFirstSpaceSceneEpisodeIndex(slot0)
	return VersionActivity2_7DungeonEnum.SpaceSceneEpisodeIndexs[1] or 18
end

function slot0._tweenPreSpaceScenePos(slot0)
	slot2 = string.splitToNumber(slot0:_getPreSpaceScenePos(), "#")

	slot0._tempVector:Set(slot2[1], slot2[2], 0)

	if slot0._tempVector == slot0._oldScenePos then
		slot0:tweenFinishCallback()

		return
	end

	slot0:tweenSetScenePos(slot0._tempVector, slot0._oldScenePos)
end

function slot0.focusElementByCo(slot0, slot1)
	slot0._tempVector:Set(-string.splitToNumber(slot1.pos, "#")[1] or 0, -slot2[2] or 0, 0)
	slot0:tweenSetScenePos(slot0._tempVector)
end

function slot0.tweenFinishCallback(slot0)
	uv0.super.tweenFinishCallback(slot0)

	if slot0._sceneAnimType == VersionActivity2_7DungeonEnum.SceneAnimType.GotoSpace then
		TaskDispatcher.cancelTask(slot0._enterOrReturnSpace, slot0)
		TaskDispatcher.runDelay(slot0._enterOrReturnSpace, slot0, uv1)

		slot0.needTween = false
	end
end

function slot0._loadSceneFinish(slot0)
	slot0.loadedDone = true

	slot0:disposeOldMap()

	slot1 = slot0._sceneUrl
	slot0._sceneGo = gohelper.clone(slot0._mapLoader:getAssetItem(slot1):GetResource(slot1), slot0._sceneRoot, slot0._mapCfg.id)
	slot0._sceneTrans = slot0._sceneGo.transform

	DungeonController.instance:dispatchEvent(DungeonMapElementEvent.OnLoadSceneFinish, {
		mapConfig = slot0._mapCfg,
		mapSceneGo = slot0._sceneGo
	})
	TaskDispatcher.cancelTask(slot0._setMapPos, slot0)
	slot0:_initScene()

	if slot0._sceneAnimType == VersionActivity2_7DungeonEnum.SceneAnimType.ReturnEarth then
		slot0:_tweenPreSpaceScenePos()
		slot0:_resetCameraParam()
	else
		if slot0._sceneAnimType == VersionActivity2_7DungeonEnum.SceneAnimType.GotoSpace then
			slot0._sceneAnimType = VersionActivity2_7DungeonEnum.SceneAnimType.Normal
		end

		slot0:_setMapPos()
	end

	slot0:_addMapLight()
	slot0:_initElements()
	slot0:_addMapAudio()
	VersionActivity2_7DungeonController.instance:loadingFinish(slot0.activityDungeonMo.episodeId, slot0._sceneGo)
end

function slot0._enterOrReturnSpace(slot0)
	gohelper.setActive(slot0._loadObj, true)

	slot1 = slot0._sceneAnimType == VersionActivity2_7DungeonEnum.SceneAnimType.GotoSpace

	slot0:_playEnterOrReturnSpaceAnim(slot1, 0)

	slot2 = slot1 and VersionActivity2_7DungeonEnum.GotoSpaceAnimName or VersionActivity2_7DungeonEnum.returnAnimName

	slot0:_playSceneAnimBgm(slot1)

	slot3 = 2.2

	if slot0._animClipTime and slot0._animClipTime[slot2] then
		slot3 = slot0._animClipTime[slot2]
	end

	TaskDispatcher.cancelTask(slot0._cutSpaceScene, slot0)
	TaskDispatcher.runDelay(slot0._cutSpaceScene, slot0, uv0)
	TaskDispatcher.cancelTask(slot0._spaceSceneAnimFinish, slot0)
	TaskDispatcher.runDelay(slot0._spaceSceneAnimFinish, slot0, slot3)
end

function slot0._playEnterOrReturnSpaceAnim(slot0, slot1, slot2)
	if slot0._mainCameraAnim then
		slot0._mainCameraAnim.enabled = true

		slot0._mainCameraAnim:Play(slot1 and VersionActivity2_7DungeonEnum.GotoSpaceAnimName or VersionActivity2_7DungeonEnum.returnAnimName, 0, slot2 or 0)
	end

	if slot0._loadAnim then
		slot0._loadAnim:Play(slot3, 0, slot2 or 0)
	end

	if slot2 == 1 then
		slot0:_playSceneBgm(slot1)
	else
		slot0:_playSceneAnimBgm(slot1)
	end
end

function slot0._playSceneBgm(slot0, slot1)
	slot2 = AudioEnum2_7.VersionActivity2_7SpaceBGM

	AudioMgr.instance:trigger(slot1 and slot2.play_2_7_yuzhou_ui_checkpoint_amb_space or slot2.stop_2_7_yuzhou_ui_checkpoint_amb_space)
end

function slot0._playSceneAnimBgm(slot0, slot1)
	slot2 = AudioEnum2_7.VersionActivity2_7SpaceBGM

	AudioMgr.instance:trigger(slot1 and slot2.play_2_7_yuzhou_ui_checkinspace or slot2.play_2_7_yuzhou_ui_checkoutspace)
end

function slot0._cutSpaceScene(slot0)
	slot0:_reallyCutScene()

	if slot0:_isSpaceScene() then
		slot0:_setCameraParam()
	end
end

function slot0._spaceSceneAnimFinish(slot0)
	slot0:_setLoadParent(slot0.viewGO)
	gohelper.setActive(slot0._loadObj, false)

	if not slot0:_isSpaceScene() then
		slot0._mainCameraAnim.enabled = false
	end

	if slot0._sceneAnimType == VersionActivity2_7DungeonEnum.SceneAnimType.ReturnEarth then
		slot0.needTween = true

		TaskDispatcher.cancelTask(slot0._setMapPos, slot0)

		if slot0._curEpisodeIndex == slot0:_getFirstSpaceSceneEpisodeIndex() - 1 then
			slot0:_setMapPos()
		else
			TaskDispatcher.runDelay(slot0._setMapPos, slot0, uv0)
		end

		slot0._sceneAnimType = VersionActivity2_7DungeonEnum.SceneAnimType.Normal
	end

	slot0:_playSceneBgm(slot1)
	slot0:_endBlock()
end

function slot0._onLoadRes(slot0)
	if slot0._loader then
		slot0._loader:dispose()
	end

	slot0._loader = MultiAbLoader.New()

	slot0._loader:setPathList({
		VersionActivity2_7DungeonEnum.SceneLoadObj,
		VersionActivity2_7DungeonEnum.SceneLoadAnim
	})
	slot0._loader:startLoad(slot0._onLoadedFinish, slot0)
end

function slot0._onLoadedFinish(slot0)
	slot1 = VersionActivity2_7DungeonEnum.SceneLoadAnim
	slot2 = VersionActivity2_7DungeonEnum.SceneLoadObj
	slot0._loadObj = gohelper.clone(slot0._loader:getAssetItem(slot2):GetResource(slot2), slot0.viewGO)
	slot0._loadAnim = gohelper.onceAddComponent(slot0._loadObj, typeof(UnityEngine.Animator))

	gohelper.setActive(slot0._loadObj, false)

	slot0._mainCameraAnim.runtimeAnimatorController = slot0._loader:getAssetItem(slot1):GetResource(slot1)
	slot0._mainCameraAnim.enabled = false

	if not slot0._animClipTime then
		slot0._animClipTime = {}

		if slot3 then
			for slot8 = 0, slot3.animationClips.Length - 1 do
				slot9 = slot3.animationClips[slot8]
				slot0._animClipTime[slot9.name] = slot9.length
			end
		end
	end

	slot0:_playEnterOrReturnSpaceAnim(slot0:_isSpaceScene(), 1)
end

function slot0._setCameraParam(slot0)
	slot0._mainCustomCameraData.usePostProcess = true
	slot0._mainCustomCameraData.volumeTrigger = slot0._ppVolumeGo.transform

	gohelper.setActive(slot0._unitCameraGO, true)

	slot0._unitCamera.enabled = false

	for slot4, slot5 in pairs(slot0._ppvalue) do
		PostProcessingMgr.instance:setUnitPPValue(slot4, slot5)
	end

	PostProcessingMgr.instance:setIgnoreUIBlur(true)
end

function slot0._resetCameraParam(slot0)
	slot0._mainCustomCameraData.usePostProcess = slot0._cameraParam.usePostProcess
	slot0._mainCustomCameraData.volumeTrigger = slot0._cameraParam.volumeTrigger

	gohelper.setActive(slot0._unitCameraGO, slot0._cameraParam.unitCameraGOActive)

	slot0._unitCamera.enabled = slot0._cameraParam.unitCameraEnable

	for slot5, slot6 in pairs(slot0._ppvalue) do
		PostProcessingMgr.instance:setUnitPPValue(slot5, slot0._cameraParam.unitPPValue[slot5])
	end

	PostProcessingMgr.instance:setIgnoreUIBlur(slot0._cameraParam.IgnoreUIBlur)
end

function slot0._initCamera(slot0)
	if not slot0:_isSpaceScene() then
		uv0.super._initCamera(slot0)
	end
end

function slot0._resetCamera(slot0)
	if not slot0:_isSpaceScene() then
		uv0.super._resetCamera(slot0)
	end
end

function slot0._isSpaceScene(slot0, slot1)
	for slot6, slot7 in ipairs(VersionActivity2_7DungeonEnum.SpaceSceneEpisodeIndexs) do
		if (slot1 or DungeonConfig.instance:getEpisodeLevelIndexByEpisodeId(slot0.activityDungeonMo.episodeId)) == slot7 then
			return true
		end
	end
end

function slot0._onDragBegin(slot0, slot1, slot2)
	uv0.super._onDragBegin(slot0, slot1, slot2)
	slot0:killTween()
end

function slot0._onDrag(slot0, slot1, slot2)
	if slot0:_isSpaceScene() then
		slot3 = slot2.delta.x
		slot4, slot5, slot6 = transformhelper.getLocalRotation(slot0._mainRoot.transform)

		if slot5 > 200 then
			slot5 = slot5 - 360
		end

		slot0:directSetCameraRotate(slot4, Mathf.Clamp(slot5 + slot3, -35, 35), slot6)
	else
		uv0.super._onDrag(slot0, slot1, slot2)
	end
end

function slot0._onDragEnd(slot0, slot1, slot2)
	slot0:killTween()

	if slot0:_isSpaceScene() then
		slot3, slot4, slot5 = transformhelper.getLocalRotation(slot0._mainRoot.transform)
		slot6 = slot0._cameraParam.RotateY

		if slot4 > 200 then
			slot6 = 360
		end

		slot0._rotateTweenId = ZProj.TweenHelper.DOTweenFloat(slot4, slot6, VersionActivity2_7DungeonEnum.DragEndAnimTime, slot0.tweenFrameRotateCallback, slot0.tweenFinishRotateCallback, slot0, nil, EaseType.OutCubic)
	else
		slot0._dragBeginPos = nil
	end
end

function slot0.killTween(slot0)
	uv0.super.killTween(slot0)

	if slot0._rotateTweenId then
		ZProj.TweenHelper.KillById(slot0._rotateTweenId)
	end
end

function slot0.tweenFrameRotateCallback(slot0, slot1)
	slot2, slot3, slot4 = transformhelper.getLocalRotation(slot0._mainRoot.transform)

	transformhelper.setLocalRotation(slot0._mainRoot.transform, slot2, slot1, slot4)
end

function slot0.tweenFinishRotateCallback(slot0)
	slot1, slot2, slot3 = transformhelper.getLocalRotation(slot0._mainRoot.transform)

	transformhelper.setLocalRotation(slot0._mainRoot.transform, slot1, slot2, slot3)
end

function slot0.directSetCameraRotate(slot0, slot1, slot2, slot3)
	if not slot0._mainRoot or gohelper.isNil(slot0._mainRoot) then
		return
	end

	transformhelper.setLocalRotationLerp(slot0._mainRoot.transform, slot1, slot2, slot3, Time.deltaTime * VersionActivity2_7DungeonEnum.DragSpeed)
	VersionActivityFixedHelper.getVersionActivityDungeonController().instance:dispatchEvent(VersionActivityFixedDungeonEvent.OnMapPosChanged, slot0._scenePos, slot0.needTween)
	slot0:_updateElementArrow()
end

function slot0.onDestroyView(slot0)
	uv0.super.onDestroyView(slot0)

	if slot0._loader then
		slot0._loader:dispose()

		slot0._loader = nil
	end

	if slot0._loadObj then
		gohelper.destroy(slot0._loadObj)

		slot0._loadObj = nil
		slot0._loadAnim = nil
	end
end

return slot0
