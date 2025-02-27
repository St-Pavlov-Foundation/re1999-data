module("modules.logic.rouge.define.RougeBaseDLCViewComp", package.seeall)

slot0 = class("RougeBaseDLCViewComp", BaseViewExtended)

function slot0._updateVersion(slot0)
	slot0:killAllChildView()

	for slot6, slot7 in pairs(slot0:getVersions() or {}) do
		if _G[string.format("%s_%s_%s", slot0.viewName, slot0:getSeason(), slot7)] then
			slot0:openSubView(slot9, slot9.AssetUrl or slot0.viewGO, gohelper.findChild(slot0.viewGO, slot9.ParentObjPath or "") or slot0.viewGO, slot0.viewParam)
		end
	end
end

function slot0.onOpen(slot0)
	slot0:addEventCb(RougeDLCController.instance, RougeEvent.UpdateRougeVersion, slot0._updateVersion, slot0)
	slot0:_updateVersion()
end

function slot0.getSeason(slot0)
	return RougeOutsideModel.instance:season()
end

function slot0.getVersions(slot0)
	return RougeOutsideModel.instance:getRougeGameRecord() and slot1:getVersionIds()
end

return slot0
