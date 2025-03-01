module("modules.logic.rouge.map.map.itemcomp.RougeMapLeaveItem", package.seeall)

slot0 = class("RougeMapLeaveItem", RougeMapBaseItem)

function slot0.init(slot0, slot1)
	uv0.super.init(slot0)

	slot0.map = slot1

	slot0:setId(RougeMapEnum.LeaveId)
	slot0:createGo()
	slot0:addEventCb(RougeMapController.instance, RougeMapEvent.onReceivePieceChoiceEvent, slot0.refreshActive, slot0)
	slot0:addEventCb(RougeMapController.instance, RougeMapEvent.onMiddleActorBeforeMove, slot0.onMiddleActorBeforeMove, slot0)
	slot0:addEventCb(RougeMapController.instance, RougeMapEvent.onExitPieceChoiceEvent, slot0.onExitPieceChoiceEvent, slot0)
end

function slot0.createGo(slot0)
	slot0.go = gohelper.clone(slot0.map.middleLayerLeavePrefab, slot0.map.goLayerPiecesContainer)
	slot0.transform = slot0.go.transform
	slot1, slot2 = RougeMapModel.instance:getMiddleLayerLeavePos()

	transformhelper.setLocalPos(slot0.transform, slot1, slot2, RougeMapHelper.getOffsetZ(slot2))

	slot0.scenePos = slot0.transform.position

	slot0:refreshActive()
end

function slot0.refreshActive(slot0)
	gohelper.setActive(slot0.go, slot0:isActive())
end

function slot0.getScenePos(slot0)
	return slot0.scenePos
end

function slot0.getClickArea(slot0)
	return RougeMapEnum.LeaveItemClickArea
end

function slot0.onClick(slot0)
	logNormal("on click leave item")
	RougeMapController.instance:moveToLeaveItem(slot0.onMoveDone, slot0)
end

function slot0.onMoveDone(slot0)
	if slot0:_checkIsSelectEndingFourth() then
		slot2, slot3 = slot0:_getNeedPlayEndingFourthStories()

		if slot3 then
			StoryController.instance:playStories(slot2, nil, slot0._sendMoveRpc, slot0)

			return
		end
	end

	slot0:_sendMoveRpc()
end

function slot0._checkIsSelectEndingFourth(slot0)
	slot1 = RougeMapModel.instance:getPieceList()

	if string.splitToNumber(lua_rouge_const.configDict[RougeEnum.Const.FourthEndingChoiceIds].value, "#") and slot1 then
		for slot7, slot8 in ipairs(slot1) do
			if slot8.finish and slot8.selectId and tabletool.indexOf(slot3, slot8.selectId) then
				return true
			end
		end
	end
end

function slot0._getNeedPlayEndingFourthStories(slot0)
	slot2 = {}

	for slot6, slot7 in ipairs(string.splitToNumber(lua_rouge_const.configDict[RougeEnum.Const.FourthEndingStoryId].value2, "#")) do
		if not StoryModel.instance:isStoryFinished(slot7) then
			slot2 = slot1

			break
		end
	end

	return slot2, slot2 and #slot2 > 0
end

function slot0._sendMoveRpc(slot0)
	RougeRpc.instance:sendRougePieceMoveRequest(RougeMapEnum.PathSelectIndex)
end

function slot0.isActive(slot0)
	if slot0.onPieceView then
		return false
	end

	slot1 = RougeMapModel.instance:getMiddleLayerCo()

	return RougeMapUnlockHelper.checkIsUnlock(slot1.leavePosUnlockType, slot1.leavePosUnlockParam)
end

function slot0.onMiddleActorBeforeMove(slot0, slot1)
	if slot1.pieceId == RougeMapEnum.LeaveId then
		return
	end

	slot0.onPieceView = true

	slot0:refreshActive()
end

function slot0.onExitPieceChoiceEvent(slot0)
	slot0.onPieceView = false

	slot0:refreshActive()
end

return slot0
