module("modules.logic.scene.room.RoomScene", package.seeall)

slot0 = class("RoomScene", BaseScene)

function slot0._createAllComps(slot0)
	slot0:_addComp("director", RoomSceneDirector)
	slot0:_addComp("tween", RoomSceneTweenComp)
	slot0:_addComp("timer", RoomSceneTimerComp)
	slot0:_addComp("init", RoomSceneInitComp)
	slot0:_addComp("level", RoomSceneLevelComp)
	slot0:_addComp("loader", RoomSceneLoader)
	slot0:_addComp("preloader", RoomScenePreloader)
	slot0:_addComp("bloom", RoomSceneBloomComp)
	slot0:_addComp("go", RoomSceneGOComp)
	slot0:_addComp("bending", RoomSceneBendingComp)
	slot0:_addComp("camera", RoomSceneCameraComp)
	slot0:_addComp("light", RoomSceneLightComp)
	slot0:_addComp("weather", RoomSceneWeatherComp)
	slot0:_addComp("ambient", RoomSceneAmbientComp)
	slot0:_addComp("mapmgr", RoomSceneMapEntityMgr)
	slot0:_addComp("inventorymgr", RoomSceneInventoryEntitySelectMgr)
	slot0:_addComp("buildingmgr", RoomSceneBuildingEntityMgr)
	slot0:_addComp("charactermgr", RoomSceneCharacterEntityMgr)
	slot0:_addComp("vehiclemgr", RoomSceneVehicleEntityMgr)
	slot0:_addComp("crittermgr", RoomSceneCritterEntityMgr)
	slot0:_addComp("buildingcrittermgr", RoomSceneBuildingCritterMgr)
	slot0:_addComp("sitemgr", RoomSceneTransportSiteEntityMgr)
	slot0:_addComp("ocean", RoomSceneOceanComp)
	slot0:_addComp("fog", RoomSceneFogComp)
	slot0:_addComp("fsm", RoomSceneFSMComp)
	slot0:_addComp("view", RoomSceneViewComp)
	slot0:_addComp("touch", RoomSceneTouchComp)
	slot0:_addComp("graphics", RoomSceneGraphicsComp)
	slot0:_addComp("character", RoomSceneCharacterComp)
	slot0:_addComp("fovblock", RoomSceneCameraFOVBlockComp)
	slot0:_addComp("path", RoomScenePathComp)
	slot0:_addComp("debug", RoomSceneDebugComp)
	slot0:_addComp("audio", RoomSceneAudioComp)
	slot0:_addComp("cameraFollow", RoomSceneCameraFollowComp)
end

slot0.UnitCameraKey = "RoomScene_UnitCameraKey"

function slot0.onStart(slot0, slot1, slot2)
	RoomHelper.logElapse("RoomScene:onStart")
	GameResMgr:SetMaxFileLoadingCount(128)

	slot3 = CameraMgr.instance:getMainCamera()
	slot0._mainFarClipValue = slot3.farClipPlane
	slot0._mainNearClipValue = slot3.nearClipPlane

	CameraMgr.instance:setSceneCameraActive(false, uv0.UnitCameraKey)
	uv0.super.onStart(slot0, slot1, slot2)
	slot0:initPPVolume()
	GameGlobalMgr.instance:registerCallback(GameStateEvent.OnQualityChange, slot0.updatePPLevel, slot0)
end

function slot0.initPPVolume(slot0)
	if slot0._ppVolumeGo then
		return
	end

	slot0._highProfile = ConstAbCache.instance:getRes(RoomResourceEnum.PPVolume.High)
	slot0._middleProfile = ConstAbCache.instance:getRes(RoomResourceEnum.PPVolume.Middle)
	slot0._lowProfile = ConstAbCache.instance:getRes(RoomResourceEnum.PPVolume.Low)
	slot0._ppVolumeGo = gohelper.create3d(CameraMgr.instance:getMainCameraGO(), "PPVolume")
	slot0._ppVolumeWrap = gohelper.onceAddComponent(slot0._ppVolumeGo, PostProcessingMgr.PPVolumeWrapType)

	slot0:updatePPLevel()
end

function slot0.updatePPLevel(slot0)
	if not slot0._ppVolumeWrap then
		return
	end

	slot2 = slot0._highProfile

	if GameGlobalMgr.instance:getScreenState():getLocalQuality() == ModuleEnum.Performance.High then
		slot2 = slot0._highProfile
	elseif slot1 == ModuleEnum.Performance.Middle then
		slot2 = slot0._middleProfile
	elseif slot1 == ModuleEnum.Performance.Low then
		slot2 = slot0._lowProfile
	end

	slot0._ppVolumeWrap:SetProfile(slot2)
end

function slot0.onClose(slot0)
	RoomHelper.logElapse("RoomScene:onClose")
	GameGlobalMgr.instance:getScreenState():resetMaxFileLoadingCount()
	CameraMgr.instance:setSceneCameraActive(true, uv0.UnitCameraKey)
	uv0.super.onClose(slot0)
	GameGlobalMgr.instance:unregisterCallback(GameStateEvent.OnQualityChange, slot0.updatePPLevel, slot0)
	slot0:destroyPPVolume()

	if slot0._mainFarClipValue then
		slot2 = CameraMgr.instance:getMainCamera()
		slot2.farClipPlane = slot0._mainFarClipValue
		slot2.nearClipPlane = slot0._mainNearClipValue
		slot0._mainFarClipValue = nil
		slot0._mainNearClipValue = nil
	end
end

function slot0.destroyPPVolume(slot0)
	if not slot0._ppVolumeGo then
		return
	end

	gohelper.destroy(slot0._ppVolumeGo)

	slot0._ppVolumeGo = nil
	slot0._ppVolumeWrap = nil
	slot0._highProfile = nil
	slot0._middleProfile = nil
	slot0._lowProfile = nil
end

return slot0
