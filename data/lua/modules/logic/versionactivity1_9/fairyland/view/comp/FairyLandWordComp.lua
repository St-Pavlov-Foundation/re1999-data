module("modules.logic.versionactivity1_9.fairyland.view.comp.FairyLandWordComp", package.seeall)

slot0 = class("FairyLandWordComp", LuaCompBase)
slot0.WordInterval = 3.5
slot0.WordTxtPosYOffset = 5
slot0.WordTxtPosXOffset = 2
slot0.WordTxtInterval = 0.1
slot0.WordTxtOpen = 0.5
slot0.WordTxtIdle = 1.1
slot0.WordTxtClose = 0.5
slot0.WordLine2Delay = 1

function slot0.ctor(slot0, slot1)
	slot0._co = slot1.co
	slot0._res1 = slot1.res1
	slot0._res2 = slot1.res2
end

function slot0.init(slot0, slot1)
	slot0.go = slot1

	slot0:createTxt()
end

function slot0.createTxt(slot0)
	slot1 = uv0.WordTxtOpen + uv0.WordTxtIdle + uv0.WordTxtClose
	slot0._allAnimWork = {}
	slot3 = string.format("——%s", slot0._co.answer)
	slot4 = LuaUtil.getUCharArr(slot0._co.question) or {}
	slot5 = 0
	slot6 = 1

	for slot10 = 1, #slot4 do
		slot11, slot12 = slot0:getRes(slot0.go, slot0._res1)
		slot12.text = slot4[slot10]

		transformhelper.setLocalPosXY(slot11.transform, slot5, slot6 % 2 == 1 and -uv0.WordTxtPosYOffset or uv0.WordTxtPosYOffset)

		slot5 = slot5 + slot12.preferredWidth + uv0.WordTxtPosXOffset

		table.insert(slot0._allAnimWork, {
			playAnim = "open",
			anim = slot11,
			time = (slot6 - 1) * uv0.WordTxtInterval
		})

		slot6 = slot6 + 1
	end

	slot7 = LuaUtil.getUCharArr(slot3) or {}

	for slot11 = 1, #slot7 do
		slot12, slot13 = slot0:getRes(slot0.go, slot0._res2)
		slot13.text = slot7[slot11]

		transformhelper.setLocalPosXY(slot12.transform, slot5, slot6 % 2 == 1 and -uv0.WordTxtPosYOffset or uv0.WordTxtPosYOffset)

		slot5 = slot5 + slot13.preferredWidth + uv0.WordTxtPosXOffset

		table.insert(slot0._allAnimWork, {
			playAnim = "open",
			anim = slot12,
			time = (slot6 - 1) * uv0.WordTxtInterval
		})

		slot6 = slot6 + 1
	end

	slot8 = slot1 + uv0.WordTxtInterval * (#slot4 - 1)
	slot9 = 0

	if #slot7 > 0 then
		slot9 = slot1 + uv0.WordTxtInterval * (#slot7 - 1)
	end

	slot10 = math.max(slot8, slot9)

	table.sort(slot0._allAnimWork, uv0.sortAnim)
	recthelper.setAnchor(slot0.go.transform, -slot5 + 40, 0)
	slot0:nextStep()
end

function slot0.nextStep(slot0)
	TaskDispatcher.cancelTask(slot0.nextStep, slot0)

	if not table.remove(slot0._allAnimWork, 1) then
		return
	end

	if slot1.destroy then
		gohelper.destroy(slot0.go)

		return
	elseif slot1.playAnim == "open" then
		slot1.anim.enabled = true
	else
		slot1.anim:Play(slot1.playAnim, 0, 0)
	end

	if not slot0._allAnimWork[1] then
		return
	end

	TaskDispatcher.runDelay(slot0.nextStep, slot0, slot2.time - slot1.time)
end

function slot0.sortAnim(slot0, slot1)
	return slot0.time < slot1.time
end

slot1 = typeof(UnityEngine.Animator)

function slot0.getRes(slot0, slot1, slot2)
	slot3 = gohelper.clone(slot2, slot1)
	slot5 = slot3:GetComponent(uv0)

	gohelper.setActive(slot3, true)
	slot5:Play("open", 0, 0)
	slot5:Update(0)

	slot5.enabled = false

	return slot5, gohelper.findChildTextMesh(slot3, "txt")
end

function slot0.onDestroy(slot0)
	TaskDispatcher.cancelTask(slot0.nextStep, slot0)
end

return slot0
