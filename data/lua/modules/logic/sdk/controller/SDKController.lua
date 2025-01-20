module("modules.logic.sdk.controller.SDKController", package.seeall)

slot0 = class("SDKController", BaseController)

function slot0.onInit(slot0)
end

function slot0.reInit(slot0)
end

function slot0.addConstEvents(slot0)
end

function slot0.openSDKExitView(slot0, slot1, slot2)
	ViewMgr.instance:openView(ViewName.SDKExitGameView, {
		loginCallback = slot1,
		exitCallback = slot2
	})
end

slot0.instance = slot0.New()

return slot0
