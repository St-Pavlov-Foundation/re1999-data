module("modules.logic.dungeon.view.rolestory.RoleStoryDispatchTalkItemTween", package.seeall)

slot0 = class("RoleStoryDispatchTalkItemTween", UserDataDispose)

function slot0.ctor(slot0)
	slot0:__onInit()
end

function slot0.playTween(slot0, slot1, slot2, slot3, slot4, slot5)
	slot0:killTween()

	slot0.callback = slot3
	slot0.callbackObj = slot4
	slot0.text = slot1
	slot0.content = slot2
	slot0.scrollContent = slot5

	TaskDispatcher.runDelay(slot0._delayShow, slot0, 0.05)
end

function slot0._delayShow(slot0)
	slot0:initText()

	slot0.canvasGroup.alpha = 1
	slot0.tweenId = ZProj.TweenHelper.DOTweenFloat(1, slot0.characterCount, slot0.delayTime, slot0.frameCallback, slot0.onTextFinished, slot0, nil, EaseType.Linear)

	slot0:moveContent()
end

function slot0.moveContent(slot0)
	slot1 = slot0.scrollContent.transform
	slot2 = recthelper.getHeight(slot1.parent)
	slot0.moveId = ZProj.TweenHelper.DOAnchorPosY(slot1, math.max(math.max(recthelper.getHeight(slot1) - slot2, 0), recthelper.getAnchorY(slot0.transform.parent) + recthelper.getHeight(slot0.transform.parent) - slot2), slot0.delayTime * 0.8, nil, , , EaseType.Linear)
end

function slot0._doCallback(slot0)
	slot0.callback = nil
	slot0.callbackObj = nil

	if slot0.callback then
		slot1(slot0.callbackObj)
	end
end

function slot0.frameCallback(slot0, slot1)
	slot2 = UnityEngine.Screen.width
	slot3 = CameraMgr.instance:getUICamera()

	for slot7, slot8 in ipairs(slot0.lineInfoList) do
		slot9 = slot8[1]
		slot11 = slot8[3]

		if slot8[2] <= slot1 and slot1 <= slot11 then
			slot12 = slot0.textInfo.characterInfo
			slot14 = slot12[slot9.lastVisibleCharacterIndex]
			slot21 = slot12[slot9.firstVisibleCharacterIndex].bottomLeft
			slot15 = slot3:WorldToScreenPoint(slot0.transform:TransformPoint(slot21))
			slot16 = slot15

			for slot21 = slot9.firstVisibleCharacterIndex, slot9.lastVisibleCharacterIndex do
				if slot3:WorldToScreenPoint(slot0.transform:TransformPoint(slot12[slot21].bottomLeft)).y < slot15.y then
					slot17 = slot23.y
				end
			end

			slot16.y = slot17
			slot24 = slot13.topLeft
			slot18 = slot3:WorldToScreenPoint(slot0.transform:TransformPoint(slot24))
			slot19 = slot18

			for slot24 = slot9.firstVisibleCharacterIndex, slot9.lastVisibleCharacterIndex do
				if slot18.y < slot3:WorldToScreenPoint(slot0.transform:TransformPoint(slot12[slot24].topLeft)).y then
					slot20 = slot26.y
				end
			end

			slot19.y = slot20
			slot21 = slot3:WorldToScreenPoint(slot0.transform:TransformPoint(slot14.bottomRight))

			if slot7 == 1 then
				slot0._conMat:SetFloat(slot0._LineMinYId, slot16.y)

				slot25 = slot0._LineMaxYId
				slot26 = slot19.y + 10

				slot0._conMat:SetFloat(slot25, slot26)

				for slot25, slot26 in pairs(slot0._subMeshs) do
					if slot26.materialForRendering then
						slot26.materialForRendering:SetFloat(slot0._LineMinYId, slot16.y)
						slot26.materialForRendering:SetFloat(slot0._LineMaxYId, slot19.y + 10)
						slot26.materialForRendering:EnableKeyword("_GRADUAL_ON")
					end
				end
			else
				slot0._conMat:SetFloat(slot0._LineMinYId, slot16.y)

				slot25 = slot0._LineMaxYId
				slot26 = slot19.y

				slot0._conMat:SetFloat(slot25, slot26)

				for slot25, slot26 in pairs(slot0._subMeshs) do
					if slot26.materialForRendering then
						slot26.materialForRendering:SetFloat(slot0._LineMinYId, slot16.y)
						slot26.materialForRendering:SetFloat(slot0._LineMaxYId, slot19.y)
						slot26.materialForRendering:EnableKeyword("_GRADUAL_ON")
					end
				end
			end

			slot22 = slot0.gameObject

			gohelper.setActive(slot22, false)
			gohelper.setActive(slot22, true)
			transformhelper.setLocalPos(slot0.transform, slot0._contentX, slot0._contentY, 1 - Mathf.Lerp(slot16.x - 10, slot21.x + 10, slot10 == slot11 and 1 or (slot1 - slot10) / (slot11 - slot10)) / slot2)
		end
	end
end

function slot0.onTextFinished(slot0)
	slot0:killTween()

	slot1, slot8, slot3 = transformhelper.getLocalPos(slot0.transform)

	transformhelper.setLocalPos(slot0.transform, slot1, slot8, 0)

	slot7 = "_GRADUAL_ON"

	slot0._conMat:DisableKeyword(slot7)

	for slot7, slot8 in pairs(slot0._subMeshs) do
		if slot8.materialForRendering then
			slot8.materialForRendering:DisableKeyword("_GRADUAL_ON")
		end
	end

	slot0:_doCallback()
end

function slot0.initText(slot0)
	slot0.transform = slot0.text.transform
	slot0.gameObject = slot0.text.gameObject
	slot0.canvasGroup = slot0.gameObject:GetComponent(typeof(UnityEngine.CanvasGroup))
	slot0._subMeshs = {}
	slot0._conMat = slot0.text.fontMaterial

	slot0._conMat:EnableKeyword("_GRADUAL_ON")
	slot0._conMat:DisableKeyword("_DISSOLVE_ON")

	slot1 = UnityEngine.Shader
	slot0._LineMinYId = slot1.PropertyToID("_LineMinY")
	slot0._LineMaxYId = slot1.PropertyToID("_LineMaxY")
	slot0._contentX, slot0._contentY, _ = transformhelper.getLocalPos(slot0.transform)

	if slot0.gameObject:GetComponentsInChildren(typeof(TMPro.TMP_SubMeshUI), true) then
		slot3 = slot2:GetEnumerator()

		while slot3:MoveNext() do
			table.insert(slot0._subMeshs, slot3.Current.gameObject:GetComponent(typeof(TMPro.TMP_SubMeshUI)))
		end
	end

	slot0.textInfo = slot0.text:GetTextInfo(slot0.content)
	slot0.lineInfoList = {}
	slot3 = 0

	for slot7 = 1, slot0.textInfo.lineCount do
		slot8 = slot0.textInfo.lineInfo[slot7 - 1]

		table.insert(slot0.lineInfoList, {
			slot8,
			slot3 + 1,
			slot3 + slot8.visibleCharacterCount
		})
	end

	slot0.characterCount = slot3
	slot0.delayTime = slot0:getDelayTime(slot3)
end

function slot0.getDelayTime(slot0, slot1)
	return 0.08 * slot1 / 4
end

function slot0.killTween(slot0)
	if slot0.tweenId then
		ZProj.TweenHelper.KillById(slot0.tweenId)

		slot0.tweenId = nil
	end

	if slot0.moveId then
		ZProj.TweenHelper.KillById(slot0.moveId)

		slot0.moveId = nil
	end

	TaskDispatcher.cancelTask(slot0._delayShow, slot0)
end

function slot0.destroy(slot0)
	slot0:killTween()
	slot0:__onDispose()
end

return slot0
