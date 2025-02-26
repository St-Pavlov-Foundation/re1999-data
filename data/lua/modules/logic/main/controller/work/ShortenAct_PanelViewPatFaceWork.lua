module("modules.logic.main.controller.work.ShortenAct_PanelViewPatFaceWork", package.seeall)

slot0 = string.format
slot1 = class("ShortenAct_PanelViewPatFaceWork", PatFaceWorkBase)

function slot1._viewName(slot0)
	return PatFaceConfig.instance:getPatFaceViewName(slot0._patFaceId)
end

function slot1._actId(slot0)
	return PatFaceConfig.instance:getPatFaceActivityId(slot0._patFaceId)
end

function slot1.checkCanPat(slot0)
	return ActivityHelper.getActivityStatus(slot0:_actId(), true) == ActivityEnum.ActivityStatus.Normal
end

function slot1.startPat(slot0)
	slot0:_startBlock()
	ViewMgr.instance:registerCallback(ViewEvent.OnOpenViewFinish, slot0._onOpenViewFinish, slot0)
	ViewMgr.instance:registerCallback(ViewEvent.OnCloseViewFinish, slot0._onCloseViewFinish, slot0)
	Activity189Controller.instance:registerCallback(Activity189Event.onReceiveGetAct189InfoReply, slot0._onReceiveGetAct189InfoReply, slot0)
	Activity189Controller.instance:sendGetAct189InfoRequest(slot0:_actId())
end

function slot1.clearWork(slot0)
	slot0:_endBlock()
	Activity189Controller.instance:unregisterCallback(Activity189Event.onReceiveGetAct189InfoReply, slot0._onReceiveGetAct189InfoReply, slot0)
	ViewMgr.instance:unregisterCallback(ViewEvent.OnCloseViewFinish, slot0._onCloseViewFinish, slot0)
	ViewMgr.instance:unregisterCallback(ViewEvent.OnOpenViewFinish, slot0._onOpenViewFinish, slot0)
end

function slot1._onOpenViewFinish(slot0, slot1)
	if slot1 ~= slot0:_viewName() then
		return
	end

	slot0:_endBlock()
end

function slot1._onCloseViewFinish(slot0, slot1)
	if slot1 ~= slot0:_viewName() then
		return
	end

	if ViewMgr.instance:isOpen(slot2) then
		return
	end

	slot0:patComplete()
end

function slot1._onReceiveGetAct189InfoReply(slot0)
	slot1 = slot0:_viewName()

	if not slot0:_isClaimable() then
		slot0:patComplete()

		return
	end

	if string.nilorempty(slot1) then
		logError(uv0("excel:P拍脸表.xlsx - sheet:export_拍脸 error id: %s, patFaceActivityId: %s, 没配 'patFaceViewName' !!", slot0._patFaceId, slot0:_actId()))
		slot0:patComplete()

		return
	end

	if not ViewName[slot1] then
		logError(uv0("excel:P拍脸表.xlsx - sheet:export_拍脸 id: %s, patFaceActivityId: %s, patFaceViewName: %s, error: modules_views.%s 不存在", slot0._patFaceId, slot0:_actId(), slot1, slot1))
		slot0:patComplete()

		return
	end

	ViewMgr.instance:openView(slot1)
end

function slot1._endBlock(slot0)
	if not slot0:_isBlock() then
		return
	end

	UIBlockMgr.instance:endBlock()
end

function slot1._startBlock(slot0)
	if slot0:_isBlock() then
		return
	end

	UIBlockMgr.instance:startBlock()
end

function slot1._isBlock(slot0)
	return UIBlockMgr.instance:isBlock() and true or false
end

function slot1._isClaimable(slot0)
	return Activity189Model.instance:isClaimable(slot0:_actId())
end

return slot1
