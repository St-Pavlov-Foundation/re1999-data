module("modules.logic.versionactivity1_4.act136.view.Activity136MainBtnItem", package.seeall)

slot0 = class("Activity136MainBtnItem", ActCenterItemBase)

function slot0.onOpen(slot0)
	slot0.redDot = RedDotController.instance:addNotEventRedDot(slot0._goactivityreddot, Activity136Model.isShowRedDot, Activity136Model.instance)
end

function slot0.onRefresh(slot0)
	UISpriteSetMgr.instance:setMainSprite(slot0._imgitem, slot0:isShowActivityEffect() and slot0:getMainActAtmosphereConfig().mainViewActBtnPrefix .. "icon_5" or "icon_5", true)
	slot0:_refreshRedDot()
end

function slot0.onAddEvent(slot0)
	Activity136Controller.instance:registerCallback(Activity136Event.ActivityDataUpdate, slot0.refreshRedDot, slot0)
end

function slot0.onRemoveEvent(slot0)
	Activity136Controller.instance:unregisterCallback(Activity136Event.ActivityDataUpdate, slot0.refreshRedDot, slot0)
end

function slot0.onClick(slot0)
	Activity136Controller.instance:openActivity136View()
end

function slot0._refreshRedDot(slot0)
	slot0.redDot:refreshRedDot()
end

return slot0
