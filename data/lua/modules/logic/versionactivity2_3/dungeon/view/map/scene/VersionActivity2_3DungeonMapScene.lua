﻿-- chunkname: @modules/logic/versionactivity2_3/dungeon/view/map/scene/VersionActivity2_3DungeonMapScene.lua

module("modules.logic.versionactivity2_3.dungeon.view.map.scene.VersionActivity2_3DungeonMapScene", package.seeall)

local VersionActivity2_3DungeonMapScene = class("VersionActivity2_3DungeonMapScene", BaseView)

function VersionActivity2_3DungeonMapScene:onInitView()
	self._gofullscreen = gohelper.findChild(self.viewGO, "#go_fullscreen")
	self._drag = SLFramework.UGUI.UIDragListener.Get(self._gofullscreen)

	if self._editableInitView then
		self:_editableInitView()
	end
end

function VersionActivity2_3DungeonMapScene:addEvents()
	self:addEventCb(ViewMgr.instance, ViewEvent.OnOpenView, self._onOpenView, self)
	self:addEventCb(ViewMgr.instance, ViewEvent.OnCloseView, self._onCloseView, self)
	self:addEventCb(GameGlobalMgr.instance, GameStateEvent.OnScreenResize, self._onScreenResize, self)
	self:addEventCb(VersionActivityDungeonBaseController.instance, VersionActivityDungeonEvent.OnModeChange, self.onModeChange, self)
	self:addEventCb(VersionActivityDungeonBaseController.instance, VersionActivityDungeonEvent.OnActivityDungeonMoChange, self.onActivityDungeonMoChange, self)
	self:addEventCb(VersionActivity2_3DungeonController.instance, VersionActivity2_3DungeonEvent.OnClickElement, self.onClickElement, self)
	self:addEventCb(VersionActivity2_3DungeonController.instance, VersionActivity2_3DungeonEvent.FocusElement, self.onFocusElement, self)
	self:addEventCb(VersionActivity2_3DungeonController.instance, VersionActivity2_3DungeonEvent.ManualClickElement, self.manualClickElement, self)

	if self._drag then
		self._drag:AddDragBeginListener(self._onDragBegin, self)
		self._drag:AddDragEndListener(self._onDragEnd, self)
		self._drag:AddDragListener(self._onDrag, self)
	end
end

function VersionActivity2_3DungeonMapScene:removeEvents()
	self:removeEventCb(ViewMgr.instance, ViewEvent.OnOpenView, self._onOpenView, self)
	self:removeEventCb(ViewMgr.instance, ViewEvent.OnCloseView, self._onCloseView, self)
	self:removeEventCb(GameGlobalMgr.instance, GameStateEvent.OnScreenResize, self._onScreenResize, self)
	self:removeEventCb(VersionActivityDungeonBaseController.instance, VersionActivityDungeonEvent.OnModeChange, self.onModeChange, self)
	self:removeEventCb(VersionActivityDungeonBaseController.instance, VersionActivityDungeonEvent.OnActivityDungeonMoChange, self.onActivityDungeonMoChange, self)
	self:removeEventCb(VersionActivity2_3DungeonController.instance, VersionActivity2_3DungeonEvent.OnClickElement, self.onClickElement, self)
	self:removeEventCb(VersionActivity2_3DungeonController.instance, VersionActivity2_3DungeonEvent.FocusElement, self.onFocusElement, self)
	self:removeEventCb(VersionActivity2_3DungeonController.instance, VersionActivity2_3DungeonEvent.ManualClickElement, self.manualClickElement, self)

	if self._drag then
		self._drag:RemoveDragBeginListener()
		self._drag:RemoveDragListener()
		self._drag:RemoveDragEndListener()
	end
end

function VersionActivity2_3DungeonMapScene:_onOpenView(viewName)
	if viewName == ViewName.StoryView then
		self:_disposeScene()
		GameGCMgr.instance:dispatchEvent(GameGCEvent.DelayFullGC, 0, self)
	end
end

function VersionActivity2_3DungeonMapScene:_onCloseView(viewName)
	if viewName == ViewName.StoryView then
		self:loadMap()
	end
end

function VersionActivity2_3DungeonMapScene:_onScreenResize()
	if self._sceneGo then
		local camera = CameraMgr.instance:getMainCamera()
		local scale = GameUtil.getAdapterScale()

		camera.orthographicSize = VersionActivity2_3DungeonEnum.DungeonMapCameraSize * scale

		self:_initScene()
	end
end

function VersionActivity2_3DungeonMapScene:onModeChange()
	self:refreshMap()
end

function VersionActivity2_3DungeonMapScene:onActivityDungeonMoChange()
	local needTween = VersionActivity2_3DungeonModel.instance:getMapNeedTweenState()

	self:refreshMap(needTween)
end

function VersionActivity2_3DungeonMapScene:onClickElement(elementComp)
	if type(elementComp) ~= "table" then
		elementComp = self.viewContainer.mapSceneElements:getElementComp(tonumber(elementComp))
	end

	if elementComp then
		local config = elementComp:getConfig()

		self:focusElementByCo(config)
	end
end

function VersionActivity2_3DungeonMapScene:focusElementByCo(elementCo)
	local pos = string.splitToNumber(elementCo.pos, "#")
	local x = -pos[1] or 0
	local x, y = x, -pos[2] or 0

	self._tempVector:Set(x, y, 0)
	self:tweenSetScenePos(self._tempVector)
end

function VersionActivity2_3DungeonMapScene:onFocusElement(elementId, isForce)
	local elementComp = self.mapSceneElementsView:getElementComp(elementId)

	if elementComp or isForce then
		local config

		if elementComp then
			config = elementComp:getConfig()
		else
			config = DungeonConfig.instance:getChapterMapElement(elementId)
		end

		if config then
			self:focusElementByCo(config)
		end
	else
		self:changeToElementEpisode(elementId)
	end
end

function VersionActivity2_3DungeonMapScene:changeToElementEpisode(elementId)
	local config = lua_chapter_map_element.configDict[elementId]

	if not config then
		return
	end

	local mapId = config.mapId

	self._mapCfg = lua_chapter_map.configDict[mapId]

	local pos = string.splitToNumber(config.pos, "#")

	self.tempInitPosX = -pos[1] or 0
	self.tempInitPosY = -pos[2] or 0

	local episodeId = DungeonConfig.instance:getEpisodeIdByMapCo(self._mapCfg)

	if VersionActivityDungeonBaseEnum.DungeonMode.Story ~= self.activityDungeonMo.mode then
		self.activityDungeonMo:changeMode(VersionActivityDungeonBaseEnum.DungeonMode.Story)
	end

	self.activityDungeonMo:changeEpisode(episodeId)
end

function VersionActivity2_3DungeonMapScene:manualClickElement(elementId)
	local elementComp = self.mapSceneElementsView:getElementComp(elementId)

	if elementComp then
		self.mapSceneElementsView:manualClickElement(elementId)
	else
		self.mapSceneElementsView:setInitClickElement(elementId)
		self:changeToElementEpisode(elementId)
	end
end

function VersionActivity2_3DungeonMapScene:_onDragBegin(param, pointerEventData)
	self._dragBeginPos = self:getDragWorldPos(pointerEventData)

	DungeonController.instance:dispatchEvent(DungeonEvent.OnBeginDragMap)
end

function VersionActivity2_3DungeonMapScene:_onDrag(param, pointerEventData)
	if not self._dragBeginPos then
		return
	end

	local pos = self:getDragWorldPos(pointerEventData)
	local deltaPos = pos - self._dragBeginPos

	self._dragBeginPos = pos

	self._tempVector:Set(self._scenePos.x + deltaPos.x, self._scenePos.y + deltaPos.y)
	self:directSetScenePos(self._tempVector)
end

function VersionActivity2_3DungeonMapScene:_onDragEnd(param, pointerEventData)
	self._dragBeginPos = nil
end

function VersionActivity2_3DungeonMapScene:getDragWorldPos(pointerEventData)
	local mainCamera = CameraMgr.instance:getMainCamera()
	local refPos = self._gofullscreen.transform.position
	local worldPos = SLFramework.UGUI.RectTrHelper.ScreenPosToWorldPos(pointerEventData.position, mainCamera, refPos)

	return worldPos
end

function VersionActivity2_3DungeonMapScene:_editableInitView()
	self.mapSceneElementsView = self.viewContainer.mapSceneElements

	if ViewMgr.instance:isOpen(ViewName.MainThumbnailView) then
		MainThumbnailHeroView.setCameraIdle()
	end

	self._tempVector = Vector3()
	self._dragDeltaPos = Vector3()
	self._scenePos = Vector3()

	self:_initMapRootNode()
end

function VersionActivity2_3DungeonMapScene:_initMapRootNode()
	self._sceneRoot = UnityEngine.GameObject.New(VersionActivity2_3DungeonEnum.SceneRootName)

	local mainTrans = CameraMgr.instance:getMainCameraTrs().parent
	local _, y, _ = transformhelper.getLocalPos(mainTrans)

	transformhelper.setLocalPos(self._sceneRoot.transform, 0, y, 0)

	local sceneRoot = CameraMgr.instance:getSceneRoot()

	gohelper.addChild(sceneRoot, self._sceneRoot)
	DungeonController.instance:dispatchEvent(DungeonEvent.OnCreateMapRootGoDone, self._sceneRoot)
end

function VersionActivity2_3DungeonMapScene:onUpdateParam()
	self:refreshMap()
end

function VersionActivity2_3DungeonMapScene:onOpen()
	MainCameraMgr.instance:addView(self.viewName, self._initCamera, nil, self)
	self:refreshMap()
end

function VersionActivity2_3DungeonMapScene:_initCamera()
	local camera = CameraMgr.instance:getMainCamera()

	camera.orthographic = true

	local scale = GameUtil.getAdapterScale()

	camera.orthographicSize = VersionActivity2_3DungeonEnum.DungeonMapCameraSize * scale
end

function VersionActivity2_3DungeonMapScene:refreshMap(needTween, mapCfg)
	self._mapCfg = mapCfg or VersionActivity2_3DungeonConfig.instance:getEpisodeMapConfig(self.activityDungeonMo.episodeId)
	self.needTween = needTween

	if self._mapCfg.id == self._lastLoadMapId then
		if not self.loadedDone then
			return
		end

		self:_initElements()
		self:_setMapPos()
	else
		self._lastLoadMapId = self._mapCfg.id

		self:loadMap()
	end

	VersionActivity2_3DungeonModel.instance:setMapNeedTweenState(true)
end

function VersionActivity2_3DungeonMapScene:_initElements()
	DungeonController.instance:dispatchEvent(DungeonMapElementEvent.OnInitElements)
end

function VersionActivity2_3DungeonMapScene:loadMap()
	DungeonController.instance:dispatchEvent(DungeonMapElementEvent.OnChangeMap)

	if self.loadedDone then
		self._oldMapLoader = self._mapLoader
		self._oldSceneGo = self._sceneGo
		self._mapLoader = nil
	end

	if self._mapLoader then
		self._mapLoader:dispose()

		self._mapLoader = nil
	end

	self.loadedDone = false
	self._mapLoader = MultiAbLoader.New()

	local allResPath = {}

	self:buildLoadRes(allResPath, self._mapCfg)

	self._sceneUrl = allResPath[1]
	self._mapLightUrl = allResPath[2]
	self._sceneCanvas = allResPath[3]
	self._mapAudioUrl = allResPath[4]

	self._mapLoader:addPath(self._sceneUrl)
	self._mapLoader:addPath(self._mapLightUrl)
	self._mapLoader:addPath(self._sceneCanvas)
	self._mapLoader:addPath(self._mapAudioUrl)
	self._mapLoader:startLoad(self._loadSceneFinish, self)
end

function VersionActivity2_3DungeonMapScene:buildLoadRes(allResPath, mapCfg)
	table.insert(allResPath, ResUrl.getDungeonMapRes(mapCfg.res))
	table.insert(allResPath, "scenes/m_s08_hddt/scene_prefab/m_s08_hddt_light.prefab")
end

function VersionActivity2_3DungeonMapScene:_loadSceneFinish()
	self.loadedDone = true

	self:disposeOldMap()

	local assetUrl = self._sceneUrl
	local assetItem = self._mapLoader:getAssetItem(assetUrl)
	local mainPrefab = assetItem:GetResource(assetUrl)

	self._sceneGo = gohelper.clone(mainPrefab, self._sceneRoot, self._mapCfg.id)
	self._sceneTrans = self._sceneGo.transform

	DungeonController.instance:dispatchEvent(DungeonMapElementEvent.OnLoadSceneFinish, {
		mapConfig = self._mapCfg,
		mapSceneGo = self._sceneGo
	})
	self:_initScene()
	self:_setMapPos()
	self:_addMapLight()
	self:_initElements()
	self:_addMapAudio()
	self:_focusUnfinishStoryElement()
end

function VersionActivity2_3DungeonMapScene:_initScene()
	local sizeGo = gohelper.findChild(self._sceneGo, "root/size")
	local box = sizeGo:GetComponentInChildren(typeof(UnityEngine.BoxCollider))

	self._mapSize = box.size

	local boxScaleX, boxScaleY, boxScaleZ = transformhelper.getLocalScale(sizeGo.transform, 0, 0, 0)
	local canvasGo
	local scale = GameUtil.getAdapterScale()

	if scale ~= 1 then
		canvasGo = ViewMgr.instance:getUILayer(UILayerName.Hud)
	else
		canvasGo = ViewMgr.instance:getUIRoot()
	end

	local worldcorners = canvasGo.transform:GetWorldCorners()
	local uiCamera = CameraMgr.instance:getUICamera()
	local uiCameraSize = uiCamera and uiCamera.orthographicSize or 5
	local cameraSizeRate = VersionActivity2_3DungeonEnum.DungeonMapCameraSize / uiCameraSize
	local posTL = worldcorners[1] * scale * cameraSizeRate
	local posBR = worldcorners[3] * scale * cameraSizeRate

	self._viewWidth = math.abs(posBR.x - posTL.x)
	self._viewHeight = math.abs(posBR.y - posTL.y)
	self._mapMinX = posTL.x - (self._mapSize.x * boxScaleX - self._viewWidth)
	self._mapMaxX = posTL.x
	self._mapMinY = posTL.y
	self._mapMaxY = posTL.y + (self._mapSize.y * boxScaleY - self._viewHeight)
end

function VersionActivity2_3DungeonMapScene:_setMapPos()
	if self.tempInitPosX then
		self._tempVector:Set(self.tempInitPosX, self.tempInitPosY, 0)

		self.tempInitPosX = nil
		self.tempInitPosY = nil
	else
		local pos = self._mapCfg.initPos
		local posParam = string.splitToNumber(pos, "#")

		self._tempVector:Set(posParam[1], posParam[2], 0)
	end

	if self.needTween then
		self:tweenSetScenePos(self._tempVector, self._oldScenePos)

		self.needTween = nil
	else
		self:directSetScenePos(self._tempVector)
	end
end

function VersionActivity2_3DungeonMapScene:_addMapLight()
	local assetUrl = self._mapLightUrl
	local assetItem = self._mapLoader:getAssetItem(assetUrl)
	local mainPrefab = assetItem:GetResource(assetUrl)

	gohelper.clone(mainPrefab, self._sceneGo)
end

function VersionActivity2_3DungeonMapScene:_addMapAudio()
	if not self._mapAudioUrl then
		return
	end

	local assetUrl = self._mapAudioUrl
	local assetItem = self._mapLoader:getAssetItem(assetUrl)
	local mainPrefab = assetItem:GetResource(assetUrl)

	self._mapAudioGo = gohelper.clone(mainPrefab, self._sceneGo, "audio")

	gohelper.addChild(self._sceneGo, self._mapAudioGo)
	gohelper.setActive(self._mapAudioGo, true)
	transformhelper.setLocalPos(self._mapAudioGo.transform, 0, 0, 0)

	local areaAudio = self._mapCfg.areaAudio

	if string.nilorempty(areaAudio) then
		return
	end

	local audioGo = gohelper.findChild(self._mapAudioGo, "audio")

	if areaAudio == "all" then
		local transform = audioGo.transform
		local itemCount = transform.childCount

		for i = 1, itemCount do
			local child = transform:GetChild(i - 1)

			gohelper.setActive(child.gameObject, true)
		end

		return
	end

	local areaList = string.split(areaAudio, "#")

	for i, areaName in ipairs(areaList) do
		local areaGo = gohelper.findChild(audioGo, areaName)

		gohelper.setActive(areaGo, true)
	end
end

function VersionActivity2_3DungeonMapScene:_focusUnfinishStoryElement()
	local elementCo = VersionActivity2_3DungeonModel.instance:checkAndGetUnfinishStoryElementCo(self._mapCfg.id)

	if elementCo then
		VersionActivity2_3DungeonController.instance:dispatchEvent(VersionActivity2_3DungeonEvent.FocusElement, elementCo.id)
	end
end

function VersionActivity2_3DungeonMapScene:tweenSetScenePos(targetPos, srcPos)
	self._tweenTargetPosX, self._tweenTargetPosY = self:getTargetPos(targetPos)
	self._tweenStartPosX, self._tweenStartPosY = self:getTargetPos(srcPos or self._scenePos)

	self:killTween()

	self.tweenId = ZProj.TweenHelper.DOTweenFloat(0, 1, DungeonEnum.DefaultTweenMapTime, self.tweenFrameCallback, self.tweenFinishCallback, self)

	self:tweenFrameCallback(0)
end

function VersionActivity2_3DungeonMapScene:getTargetPos(targetPos)
	local x, y = targetPos.x, targetPos.y

	if not self._mapMinX or not self._mapMaxX or not self._mapMinY or not self._mapMaxY then
		local pos = self._mapCfg and self._mapCfg.initPos
		local posParam = string.splitToNumber(pos, "#")

		x = posParam[1] or 0
		y = posParam[2] or 0
	else
		if x < self._mapMinX then
			x = self._mapMinX
		elseif x > self._mapMaxX then
			x = self._mapMaxX
		end

		if y < self._mapMinY then
			y = self._mapMinY
		elseif y > self._mapMaxY then
			y = self._mapMaxY
		end
	end

	return x, y
end

function VersionActivity2_3DungeonMapScene:tweenFrameCallback(value)
	local x = Mathf.Lerp(self._tweenStartPosX, self._tweenTargetPosX, value)
	local y = Mathf.Lerp(self._tweenStartPosY, self._tweenTargetPosY, value)

	self._tempVector:Set(x, y, 0)
	self:directSetScenePos(self._tempVector)
end

function VersionActivity2_3DungeonMapScene:tweenFinishCallback()
	self._tempVector:Set(self._tweenTargetPosX, self._tweenTargetPosY, 0)
	self:directSetScenePos(self._tempVector)
end

function VersionActivity2_3DungeonMapScene:directSetScenePos(targetPos)
	local x, y = self:getTargetPos(targetPos)

	self._scenePos.x = x
	self._scenePos.y = y

	if not self._sceneTrans or gohelper.isNil(self._sceneTrans) then
		return
	end

	transformhelper.setLocalPos(self._sceneTrans, self._scenePos.x, self._scenePos.y, 0)
	VersionActivity2_3DungeonController.instance:dispatchEvent(VersionActivity2_3DungeonEvent.OnMapPosChanged, self._scenePos, self.needTween)
	self:_updateElementArrow()
end

function VersionActivity2_3DungeonMapScene:_updateElementArrow()
	DungeonController.instance:dispatchEvent(DungeonMapElementEvent.OnUpdateElementArrow)
end

function VersionActivity2_3DungeonMapScene:setVisible(isVisible)
	gohelper.setActive(self._sceneRoot, isVisible)

	if isVisible then
		self:_initCamera()
	end
end

function VersionActivity2_3DungeonMapScene:getSceneGo()
	return self._sceneGo
end

function VersionActivity2_3DungeonMapScene:onClose()
	self:killTween()
	self:_resetCamera()
end

function VersionActivity2_3DungeonMapScene:killTween()
	if self.tweenId then
		ZProj.TweenHelper.KillById(self.tweenId)
	end
end

function VersionActivity2_3DungeonMapScene:_resetCamera()
	local camera = CameraMgr.instance:getMainCamera()

	camera.orthographicSize = 5
	camera.orthographic = false
end

function VersionActivity2_3DungeonMapScene:onDestroyView()
	gohelper.destroy(self._sceneRoot)
	self:disposeOldMap()
	self:_disposeScene()

	if self._mapLoader then
		self._mapLoader:dispose()
	end
end

function VersionActivity2_3DungeonMapScene:disposeOldMap()
	if self._sceneTrans then
		self._oldScenePos = self._scenePos
	else
		self._oldScenePos = nil
	end

	DungeonController.instance:dispatchEvent(DungeonMapElementEvent.OnDisposeOldMap, self.viewName)

	if self._oldSceneGo then
		gohelper.destroy(self._oldSceneGo)

		self._oldSceneGo = nil
	end

	if self._mapAudioGo then
		self._mapAudioGo = nil

		AudioMgr.instance:trigger(AudioEnum.UI.stop_ui_noise_allarea)
	end

	if self._oldMapLoader then
		self._oldMapLoader:dispose()

		self._oldMapLoader = nil
	end
end

function VersionActivity2_3DungeonMapScene:_disposeScene()
	self._oldScenePos = self._scenePos

	DungeonController.instance:dispatchEvent(DungeonMapElementEvent.OnDisposeScene)

	if self._mapAudioGo then
		self._mapAudioGo = nil

		AudioMgr.instance:trigger(AudioEnum.UI.stop_ui_noise_allarea)
	end

	if self._sceneGo then
		gohelper.destroy(self._sceneGo)

		self._sceneGo = nil
	end

	self._sceneTrans = nil
	self._elementRoot = nil

	if self._mapLoader then
		self._mapLoader:dispose()

		self._mapLoader = nil
	end

	self._mapAudioGo = nil
end

return VersionActivity2_3DungeonMapScene
