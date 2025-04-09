module("modules.logic.versionactivity2_7.act191.model.Activity191Model", package.seeall)

slot0 = class("Activity191Model", BaseModel)

function slot0.onInit(slot0)
	slot0:reInit()
end

function slot0.reInit(slot0)
	slot0.actMoDic = {}
end

function slot0.setActInfo(slot0, slot1, slot2)
	slot0.curActId = slot1

	if not slot0.actMoDic[slot1] then
		slot0.actMoDic[slot1] = Act191MO.New()
	end

	slot0.actMoDic[slot1]:initBadgeInfo(slot1)
	slot0.actMoDic[slot1]:init(slot2)
	Act191StatController.instance:setActInfo(slot1, slot0.actMoDic[slot1])
end

function slot0.getCurActId(slot0)
	return slot0.curActId
end

function slot0.getActInfo(slot0, slot1)
	return slot0.actMoDic[slot1 or slot0.curActId]
end

function slot0.setGameEndInfo(slot0, slot1)
	slot0.endInfo = slot1
end

slot0.instance = slot0.New()

return slot0
