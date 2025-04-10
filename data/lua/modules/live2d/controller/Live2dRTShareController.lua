module("modules.live2d.controller.Live2dRTShareController", package.seeall)

slot0 = class("Live2dRTShareController", BaseController)
slot1 = UnityEngine.SystemInfo

function slot0.onInit(slot0)
	slot0:reInit()
end

function slot0.reInit(slot0)
	slot0:_clearAll()
end

function slot0._clearAll(slot0)
	TaskDispatcher.cancelTask(slot0._checkRT, slot0)

	slot0._minType = CharacterVoiceEnum.RTShareType.Normal
	slot0._maxType = CharacterVoiceEnum.RTShareType.FullScreen
	slot0._debugLog = false
	slot0._clearTime = nil

	if slot0._typeInfoList and slot0._typeRTList then
		slot0:clearAllRT()
	end

	slot0._typeInfoList = {}
	slot0._typeRTList = {}
end

function slot0.addConstEvents(slot0)
	GameSceneMgr.instance:registerCallback(SceneEventName.ExitScene, slot0._onExistScene, slot0)
end

function slot0._onExistScene(slot0)
	slot0:_clearAll()
end

function slot0.clearAllRT(slot0)
	for slot4 = slot0._maxType, slot0._minType, -1 do
		if slot0:_getRTInfoList(slot4).rt then
			UnityEngine.RenderTexture.ReleaseTemporary(slot5.rt)
			slot0:_replaceRT(slot4)

			slot5.rt = nil

			if slot0._debugLog then
				logError(string.format("Live2dRTShareController:clearAllRT shareType:%s", slot4))
			end
		end

		slot5.orthographicSize = nil
	end
end

function slot0._replaceRT(slot0, slot1)
	slot0._defaultRT = slot0._defaultRT or UnityEngine.RenderTexture.GetTemporary(8, 8, 0, UnityEngine.RenderTextureFormat.ARGB32)

	for slot6, slot7 in ipairs(slot0:_getTypeInfoList(slot1)) do
		if not gohelper.isNil(slot7.camera) then
			slot7.camera.targetTexture = slot0._defaultRT

			if not gohelper.isNil(slot7.image) then
				slot7.image.texture = nil

				recthelper.setSize(slot7.image.rectTransform, 0, 0)
			end
		end
	end
end

function slot0._getRT(slot0, slot1, slot2, slot3, slot4, slot5)
	if slot0:_getRTInfoList(slot3).orthographicSize ~= slot2 then
		slot0:clearAllRT()

		slot6.orthographicSize = slot2

		if slot3 == CharacterVoiceEnum.RTShareType.FullScreen then
			slot6.rt = slot1.targetTexture

			if slot0._debugLog then
				logError(string.format("Live2dRTShareController:_reuseRT orthographicSize:%s shareType:%s", slot2, slot3))
			end
		else
			slot6.rt = slot0:_createRT(slot2, slot3, slot4, slot5)
		end
	end

	return slot6.rt
end

function slot0._getTextureSizeByCameraSize(slot0, slot1)
	slot2, slot3 = GuiLive2d.GetScaleByDevice()

	return GuiLive2d.getTextureSizeByCameraSize(slot1) * slot3 * slot2
end

function slot0._getTextureSize(slot0, slot1, slot2, slot3, slot4)
	if slot0:_isBloomType(slot2) and CharacterVoiceEnum.BloomCameraSize[slot3] then
		return slot0:_getTextureSizeByCameraSize(slot5)
	end

	return slot0:_getTextureSizeByCameraSize(slot1)
end

function slot0._createRT(slot0, slot1, slot2, slot3, slot4)
	if uv0.maxTextureSize < slot0:_getTextureSize(slot1, slot2, slot3, slot4) then
		slot5 = slot6
	end

	if slot0._debugLog then
		logError(string.format("Live2dRTShareController:_createRT orthographicSize:%s textureSize:%s shareType:%s", slot1, slot5, slot2))
	end

	if slot2 == CharacterVoiceEnum.RTShareType.BloomOpen then
		return UnityEngine.RenderTexture.GetTemporary(slot5, slot5, 0, UnityEngine.RenderTextureFormat.ARGBHalf)
	end

	return UnityEngine.RenderTexture.GetTemporary(slot5, slot5, 0, UnityEngine.RenderTextureFormat.ARGB32)
end

function slot0._getRTInfoList(slot0, slot1)
	if not slot0._typeRTList[slot1] then
		slot0._typeRTList[slot1] = {}
	end

	return slot2
end

function slot0._getTypeInfoList(slot0, slot1)
	if not slot0._typeInfoList[slot1] then
		slot0._typeInfoList[slot1] = {}
	end

	return slot2
end

function slot0.addShareInfo(slot0, slot1, slot2, slot3, slot4, slot5)
	if not slot1 or not slot2 or not slot3 or not slot4 or not slot5 then
		logError(string.format("addShareInfo error camera:%s image:%s shareType:%s heroId:%s skinId:%s", slot1, slot2, slot3, slot4, slot5))

		return
	end

	if slot0._minType > slot3 or slot3 > slot0._maxType then
		logError(string.format("addShareInfo error shareType:%s", slot3))

		return
	end

	for slot10, slot11 in ipairs(slot0:_getTypeInfoList(slot3)) do
		if slot11.camera == slot1 and slot11.image == slot2 then
			logError(string.format("addShareInfo error same camera:%s image:%s shareType:%s", slot1, slot2, slot3))

			return
		end
	end

	table.insert(slot6, {
		camera = slot1,
		orthographicSize = slot1.orthographicSize,
		textureSize = slot0:_getTextureSizeByCameraSize(slot1.orthographicSize),
		image = slot2,
		shareType = slot3,
		heroId = slot4,
		skinId = slot5
	})

	if slot0._debugLog then
		logError(string.format("addShareInfo camera:%s orthographicSize:%s image:%s shareType:%s num:%s", slot1, slot1.orthographicSize, slot2, slot3, #slot6))
	end

	slot0._clearTime = nil

	slot0:_checkRT()
	TaskDispatcher.cancelTask(slot0._checkRT, slot0)
	TaskDispatcher.runRepeat(slot0._checkRT, slot0, 0)
end

function slot0._getTopInfoList(slot0)
	for slot4 = slot0._maxType, slot0._minType, -1 do
		if #slot0:_getTypeInfoList(slot4) > 0 then
			return slot5, slot4
		end
	end

	return slot0:_getTypeInfoList(slot0._minType), slot0._minType
end

function slot0._isBloomType(slot0, slot1)
	return slot1 == CharacterVoiceEnum.RTShareType.BloomClose or slot1 == CharacterVoiceEnum.RTShareType.BloomOpen
end

function slot0._checkRT(slot0)
	slot1, slot2 = slot0:_getTopInfoList()

	if #slot1 == 0 then
		slot0._clearTime = slot0._clearTime or Time.time

		if Time.time - slot0._clearTime > 1 then
			TaskDispatcher.cancelTask(slot0._checkRT, slot0)

			slot0._clearTime = nil

			slot0:clearAllRT()
		end

		return
	end

	slot3 = nil

	for slot7 = #slot1, 1, -1 do
		if gohelper.isNil(slot1[slot7].camera) or gohelper.isNil(slot8.image) then
			table.remove(slot1, slot7)

			slot8 = nil

			if slot0._debugLog then
				logError(string.format("Live2dRTShareController:_checkRT remove frame:%s index:%s shareType:%s remain:%s", Time.frameCount, slot7, slot2, #slot1))
			end
		end

		if slot8 and slot2 == CharacterVoiceEnum.RTShareType.Normal then
			slot9 = slot0:_getRT(slot8.camera, slot8.orthographicSize, slot8.shareType, slot8.heroId, slot8.skinId)
			slot8.camera.targetTexture = slot9
			slot8.image.texture = slot9

			slot8.image:SetNativeSize()

			slot3 = slot8

			break
		elseif slot8 and slot8.image.gameObject.activeInHierarchy then
			slot9 = slot0:_getRT(slot8.camera, slot8.orthographicSize, slot8.shareType, slot8.heroId, slot8.skinId)
			slot8.camera.targetTexture = slot9
			slot8.image.texture = slot9
			slot10 = slot9.width
			slot11 = slot9.height

			if slot0:_isBloomType(slot2) then
				slot12 = slot8.textureSize
				slot10 = slot12
				slot11 = slot12
			end

			recthelper.setSize(slot8.image.rectTransform, slot10, slot11)

			slot3 = slot8

			break
		end
	end

	for slot7, slot8 in ipairs(slot1) do
		if not gohelper.isNil(slot8.camera) then
			slot8.camera.enabled = slot8 == slot3
		end
	end

	slot0._clearTime = nil
end

slot0.instance = slot0.New()

return slot0
