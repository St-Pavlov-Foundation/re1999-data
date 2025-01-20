module("modules.logic.versionactivity1_6.act152.controller.Activity152Controller", package.seeall)

slot0 = class("Activity152Controller", BaseController)

function slot0.onInit(slot0)
end

function slot0.reInit(slot0)
	if slot0._popupFlow then
		slot0._popupFlow:destroy()

		slot0._popupFlow = nil
	end

	TaskDispatcher.cancelTask(slot0._checkGiftUnlock, slot0)
end

function slot0.addConstEvents(slot0)
	ActivityController.instance:registerCallback(ActivityEvent.RefreshActivityState, slot0._checkActivityInfo, slot0)
	MainController.instance:registerCallback(MainEvent.OnMainPopupFlowFinish, slot0._startCheckGiftUnlock, slot0)
	GameStateMgr.instance:registerCallback(GameStateEvent.onApplicationPause, slot0._onApplicationPause, slot0)
end

function slot0._checkActivityInfo(slot0)
	if ActivityModel.instance:isActOnLine(ActivityEnum.Activity.NewYearEve) then
		Activity152Rpc.instance:sendGet152InfoRequest(ActivityEnum.Activity.NewYearEve)
	end
end

function slot0._onApplicationPause(slot0, slot1)
	if slot1 then
		slot0:_startCheckGiftUnlock()
	end
end

function slot0._startCheckGiftUnlock(slot0)
	if not ActivityModel.instance:isActOnLine(ActivityEnum.Activity.NewYearEve) then
		return
	end

	if slot0._popupFlow then
		slot0._popupFlow:destroy()

		slot0._popupFlow = nil
	end

	TaskDispatcher.cancelTask(slot0._checkGiftUnlock, slot0)

	if (#Activity152Model.instance:getPresentUnaccepted() > 0 and 0.5 or Activity152Model.instance:getNextUnlockLimitTime() + 0.5) > 0 then
		TaskDispatcher.runDelay(slot0._checkGiftUnlock, slot0, slot2)
	end
end

function slot0._checkGiftUnlock(slot0)
	slot0._popupFlow = FlowSequence.New()

	slot0._popupFlow:addWork(Activity152PatFaceWork.New())
	slot0._popupFlow:registerDoneListener(slot0._stopShowSequence, slot0)
	slot0._popupFlow:start()
end

function slot0._stopShowSequence(slot0)
	if slot0._popupFlow then
		slot0._popupFlow:destroy()

		slot0._popupFlow = nil
	end

	slot0:_startCheckGiftUnlock()
end

function slot0.openNewYearGiftView(slot0, slot1)
	ViewMgr.instance:openView(ViewName.NewYearEveGiftView, slot1)
end

slot0.instance = slot0.New()

return slot0
