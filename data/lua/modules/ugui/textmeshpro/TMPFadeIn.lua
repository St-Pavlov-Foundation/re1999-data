module("modules.ugui.textmeshpro.TMPFadeIn", package.seeall)

slot0 = class("TMPFadeIn", LuaCompBase)
slot1 = 0.03

function slot0.init(slot0, slot1)
	slot0._contentGO = slot1
	slot0._norDiaGO = gohelper.findChild(slot1, "go_normalcontent")
	slot0._txtcontentcn = gohelper.findChildText(slot0._norDiaGO, "txt_contentcn")
	slot0._conMat = slot0._txtcontentcn.fontMaterial
	slot2 = UnityEngine.Shader
	slot0._LineMinYId = slot2.PropertyToID("_LineMinY")
	slot0._LineMaxYId = slot2.PropertyToID("_LineMaxY")
end

function slot0.hideDialog(slot0)
	if slot0._conTweenId then
		ZProj.TweenHelper.KillById(slot0._conTweenId)

		slot0._conTweenId = nil
	end

	gohelper.setActive(slot0._norDiaGO, false)

	slot1, slot2, slot3 = transformhelper.getLocalPos(slot0._txtcontentcn.transform)

	transformhelper.setLocalPos(slot0._txtcontentcn.transform, slot1, slot2, 1)
end

function slot0.playNormalText(slot0, slot1, slot2, slot3)
	slot0._conMat:EnableKeyword("_GRADUAL_ON")

	slot4 = UnityEngine.Screen.height

	slot0._conMat:SetFloat(slot0._LineMinYId, slot4)
	slot0._conMat:SetFloat(slot0._LineMaxYId, slot4)
	gohelper.setActive(slot0._norDiaGO, true)

	slot0._txt = slot1
	slot0._finishCallback = slot2
	slot0._finishCallbackObj = slot3
	slot5, slot6, slot7 = transformhelper.getLocalPos(slot0._txtcontentcn.transform)

	transformhelper.setLocalPos(slot0._txtcontentcn.transform, slot5, slot6, 1)

	slot0._txtcontentcn.text = slot0._txt

	TaskDispatcher.runDelay(slot0._delayShow, slot0, 0)
end

function slot0._delayShow(slot0)
	slot1 = CameraMgr.instance:getUICamera()
	slot2 = slot0._txtcontentcn:GetTextInfo(slot0._txt)
	slot0._textInfo = slot2
	slot0._lineInfoList = {}
	slot3 = 0
	slot4 = slot0._txtcontentcn.transform

	for slot8 = 1, slot2.lineCount do
		slot9 = slot2.lineInfo[slot8 - 1]
		slot10 = slot3 + 1
		slot3 = slot3 + slot9.visibleCharacterCount
		slot11 = slot0._textInfo.characterInfo
		slot12 = slot11[slot9.firstVisibleCharacterIndex]
		slot13 = slot11[slot9.lastVisibleCharacterIndex]
		slot17 = slot1:WorldToScreenPoint(slot4:TransformPoint(slot12.topLeft)).y

		for slot21 = slot9.firstVisibleCharacterIndex, slot9.lastVisibleCharacterIndex do
			if slot1:WorldToScreenPoint(slot4:TransformPoint(slot11[slot21].bottomLeft)).y < slot1:WorldToScreenPoint(slot4:TransformPoint(slot12.bottomLeft)).y then
				slot16 = slot23.y
			end

			if slot17 < slot1:WorldToScreenPoint(slot4:TransformPoint(slot22.topLeft)).y then
				slot17 = slot24.y
			end
		end

		slot14.y = slot16
		slot15.y = slot17

		table.insert(slot0._lineInfoList, {
			slot9,
			slot10,
			slot3,
			slot14,
			slot15,
			slot1:WorldToScreenPoint(slot4:TransformPoint(slot13.bottomRight))
		})
	end

	slot0._contentX, slot0._contentY, _ = transformhelper.getLocalPos(slot0._txtcontentcn.transform)
	slot0._curLine = nil
	slot5 = uv0 * slot3

	if slot0._conTweenId then
		ZProj.TweenHelper.KillById(slot0._conTweenId)

		slot0._conTweenId = nil
	end

	slot0._conTweenId = ZProj.TweenHelper.DOTweenFloat(1, slot3, slot5, slot0._conUpdate, slot0.conFinished, slot0)
end

function slot0._conUpdate(slot0, slot1)
	slot2 = UnityEngine.Screen.width

	for slot6, slot7 in ipairs(slot0._lineInfoList) do
		slot8 = slot7[1]
		slot10 = slot7[3]

		if slot7[2] <= slot1 and slot1 <= slot10 and slot9 ~= slot10 then
			slot11 = slot7[4]
			slot13 = slot7[6]

			if slot0._curLine ~= slot6 then
				slot0._curLine = slot6

				slot0._conMat:SetFloat(slot0._LineMinYId, slot11.y)
				slot0._conMat:SetFloat(slot0._LineMaxYId, slot7[5].y)

				slot14 = slot0._txtcontentcn.gameObject

				gohelper.setActive(slot14, false)
				gohelper.setActive(slot14, true)
			end

			transformhelper.setLocalPos(slot0._txtcontentcn.transform, slot0._contentX, slot0._contentY, 1 - Mathf.Lerp(slot11.x, slot13.x, (slot1 - slot9) / (slot10 - slot9)) / slot2)
		end
	end
end

function slot0.isPlaying(slot0)
	return slot0._conTweenId and true or false
end

function slot0.conFinished(slot0)
	if slot0._conTweenId then
		ZProj.TweenHelper.KillById(slot0._conTweenId)

		slot0._conTweenId = nil
	end

	slot0:_disable_GRADUAL_ON()

	slot1, slot2, slot3 = transformhelper.getLocalPos(slot0._txtcontentcn.transform)

	transformhelper.setLocalPos(slot0._txtcontentcn.transform, slot1, slot2, 0)

	if slot0._finishCallback then
		slot0._finishCallback(slot0._finishCallbackObj)
	end
end

function slot0._disable_GRADUAL_ON(slot0)
	if slot0._txtcontentcn.gameObject:GetComponentsInChildren(gohelper.Type_TMP_SubMeshUI, true) then
		for slot6 = 0, slot1.Length - 1 do
			if not gohelper.isNil(slot1[slot6].sharedMaterial) then
				slot8:DisableKeyword("_GRADUAL_ON")
				slot8:SetFloat(slot0._LineMinYId, 0)
				slot8:SetFloat(slot0._LineMaxYId, 0)
			end
		end
	end

	slot0._conMat:DisableKeyword("_GRADUAL_ON")
	slot0._conMat:SetFloat(slot0._LineMinYId, 0)
	slot0._conMat:SetFloat(slot0._LineMaxYId, 0)
end

function slot0.onDestroy(slot0)
	slot0:onDestroyView()
end

function slot0.onDestroyView(slot0)
	TaskDispatcher.cancelTask(slot0._delayShow, slot0)
	GameUtil.onDestroyViewMember_TweenId(slot0, "_conTweenId")
end

return slot0
