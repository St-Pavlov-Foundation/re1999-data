module("modules.logic.tips.view.RoomManufactureMaterialTipViewContainer", package.seeall)

slot0 = class("RoomManufactureMaterialTipViewContainer", BaseViewContainer)

function slot0.buildViews(slot0)
	slot1 = {}

	table.insert(slot1, RoomManufactureMaterialTipView.New())

	return slot1
end

function slot0.onContainerClickModalMask(slot0)
	AudioMgr.instance:trigger(AudioEnum.UI.UI_Mail_switch)
	slot0:closeThis()
end

return slot0
