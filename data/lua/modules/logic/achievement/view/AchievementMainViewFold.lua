module("modules.logic.achievement.view.AchievementMainViewFold", package.seeall)

slot0 = class("AchievementMainViewFold", BaseView)

function slot0.onInitView(slot0)
	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0.addEvents(slot0)
end

function slot0.removeEvents(slot0)
end

function slot0._editableInitView(slot0)
	slot0._modlInst = AchievementMainTileModel.instance

	slot0:addEventCb(AchievementMainController.instance, AchievementEvent.OnClickGroupFoldBtn, slot0.onClickGroupFoldBtn, slot0)
end

function slot0.onDestroyView(slot0)
end

function slot0.onOpen(slot0)
end

function slot0.onClose(slot0)
	slot0:removeEventCb(AchievementMainController.instance, AchievementEvent.OnClickGroupFoldBtn, slot0.onClickGroupFoldBtn, slot0)
	TaskDispatcher.cancelTask(slot0.onEndPlayGroupFadeAnim, slot0)
	TaskDispatcher.cancelTask(slot0.onPreEndPlayGroupFadeAnim, slot0)
	TaskDispatcher.cancelTask(slot0.onDispatchAchievementFadeAnimationEvent, slot0)

	slot0._modifyMap = nil

	slot0:onEndPlayGroupFadeAnim()
end

function slot0.onClickGroupFoldBtn(slot0, slot1, slot2)
	slot0:onStartPlayGroupFadeAnim()
	slot0:doAchievementFadeAnimation(slot1, slot2)
end

function slot0.onStartPlayGroupFadeAnim(slot0)
	UIBlockMgrExtend.setNeedCircleMv(false)
	UIBlockMgr.instance:startBlock("AchievementMainViewFold_BeginPlayGroupFadeAnim")
end

function slot0.onEndPlayGroupFadeAnim(slot0)
	UIBlockMgrExtend.setNeedCircleMv(true)
	UIBlockMgr.instance:endBlock("AchievementMainViewFold_BeginPlayGroupFadeAnim")
end

slot1 = 0.001
slot2 = 0.0003
slot3 = 0
slot4 = 0.35

function slot0.doAchievementFadeAnimation(slot0, slot1, slot2)
	slot4 = AchievementMainCommonModel.instance:getCurrentFilterType()
	slot0._isFold = slot2
	slot0._modifyGroupId = slot1
	slot8 = nil
	slot9 = 0
	slot0._modifyMap = slot0:getUserDataTb_()
	slot10 = slot0:getCurRenderCellCount(slot1, slot5, slot2)

	for slot17 = slot2 and slot10 or 1, slot2 and 1 or slot10, slot2 and -1 or 1 do
		slot18 = slot5[slot17]
		slot0._modifyMap[slot18] = true

		slot18:clearOverrideLineHeight()

		if not slot2 and not slot18.isGroupTop then
			slot3:addAt(slot18, slot3:getIndex(AchievementMainCommonModel.instance:getCurViewExcuteModelInstance():getCurGroupMoList(slot1) and slot5[1]) + slot17 - 1)
		end

		slot19 = slot0:getEffectParams(slot4, slot2, slot18, slot8)

		if not slot2 and not slot18.isGroupTop then
			slot18:overrideLineHeight(0)
		end

		TaskDispatcher.runDelay(slot0.onDispatchAchievementFadeAnimationEvent, slot19, slot9)

		slot9 = slot9 + slot19.duration
		slot8 = slot18
	end

	if slot2 then
		slot0:onBeginFoldIn(slot0._modifyGroupId, slot0._isFold)
	end

	TaskDispatcher.cancelTask(slot0.onPreEndPlayGroupFadeAnim, slot0)
	TaskDispatcher.runDelay(slot0.onPreEndPlayGroupFadeAnim, slot0, slot9)
	TaskDispatcher.cancelTask(slot0.onEndPlayGroupFadeAnim, slot0)
	TaskDispatcher.runDelay(slot0.onEndPlayGroupFadeAnim, slot0, slot9)
end

function slot0.onBeginFoldIn(slot0, slot1, slot2)
	if AchievementMainCommonModel.instance:getCurViewExcuteModelInstance():getCurGroupMoList(slot1) then
		for slot8 = 1, #slot4 do
			if not slot0._modifyMap[slot4[slot8]] then
				slot9:setIsFold(slot2)
				slot9:clearOverrideLineHeight()
				slot3:remove(slot9)
			end
		end

		slot3:onModelUpdate()
	end
end

function slot0.onPreEndPlayGroupFadeAnim(slot0)
	if AchievementMainCommonModel.instance:getCurViewExcuteModelInstance():getCurGroupMoList(slot0._modifyGroupId) then
		for slot8 = 1, #slot2 do
			slot9 = slot2[slot8]

			slot9:setIsFold(slot0._isFold)
			slot9:clearOverrideLineHeight()

			if not slot0._isFold and not slot0._modifyMap[slot9] then
				slot1:addAt(slot9, slot1:getIndex(slot2 and slot2[1]) + slot8 - 1)
			end
		end

		slot1:onModelUpdate()
	end
end

function slot0.getEffectParams(slot0, slot1, slot2, slot3, slot4)
	slot5 = slot3:getLineHeight(slot1, not slot2)
	slot6 = slot3:getLineHeight(slot1, slot2)

	return {
		mo = slot3,
		isFold = slot2,
		orginLineHeight = slot5,
		targetLineHeight = slot6,
		duration = Mathf.Clamp(math.abs(slot6 - slot5) * (slot2 and uv0 or uv1), uv2, uv3),
		lastModifyMO = slot4
	}
end

function slot0.onDispatchAchievementFadeAnimationEvent(slot0)
	slot2 = slot0.lastModifyMO

	if slot0.isFold and slot2 and not slot2.isGroupTop then
		AchievementMainCommonModel.instance:getCurViewExcuteModelInstance():remove(slot2)
	end

	AchievementMainController.instance:dispatchEvent(AchievementEvent.OnPlayGroupFadeAnim, slot0)
end

slot5 = 3

function slot0.getCurRenderCellCount(slot0, slot1, slot2, slot3)
	slot6 = slot0.viewContainer:getScrollView(AchievementMainCommonModel.instance:getCurrentScrollType()):getCsScroll()
	slot7 = 0

	return Mathf.Clamp((slot3 or slot0:getCurRenderCellCountWhileFoldIn(slot1, slot2, slot6)) and slot0:getCurRenderCellCountWhileFoldOut(slot1, slot2, slot5, slot6), 1, uv0)
end

function slot0.getCurRenderCellCountWhileFoldIn(slot0, slot1, slot2, slot3)
	slot5 = 0
	slot8 = recthelper.getHeight(slot3.transform)

	for slot13 = 1, #slot2 do
		if Mathf.Clamp(slot8 - slot3.VerticalScrollPixel, 0, slot8) - slot2[slot13]:getLineHeight(AchievementMainCommonModel.instance:getCurrentFilterType(), false) > 0 then
			slot6 = 0 + 1
		else
			break
		end
	end

	return slot6
end

function slot0.getCurRenderCellCountWhileFoldOut(slot0, slot1, slot2, slot3, slot4)
	slot6 = {
		[slot11._mo.id] = slot11
	}
	slot7 = 0

	for slot11, slot12 in pairs(slot3._cellCompDict) do
		if slot11._mo.groupId == slot1 then
			-- Nothing
		end
	end

	for slot11 = 1, #slot2 do
		slot14 = slot6[slot2[slot11].id] and slot13._index - 1 or -1

		if not slot13 then
			break
		end

		if not slot4:IsVisual(slot14) then
			break
		end

		slot7 = slot7 + 1
	end

	return slot7
end

return slot0
