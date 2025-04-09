module("modules.logic.versionactivity2_7.lengzhou6.model.mo.EliminateRecordDataMO", package.seeall)

slot0 = class("EliminateRecordDataMO")

function slot0.ctor(slot0)
	slot0._eliminateTypeMap = {}
end

function slot0.setEliminateType(slot0, slot1, slot2, slot3, slot4)
	if slot0._eliminateTypeMap[slot1] == nil then
		slot0._eliminateTypeMap[slot1] = {}
	end

	table.insert(slot0._eliminateTypeMap[slot1], {
		eliminateType = slot2,
		eliminateCount = slot3,
		spEliminateCount = slot4
	})
end

function slot0.getEliminateTypeMap(slot0)
	return slot0._eliminateTypeMap
end

function slot0.clearRecord(slot0)
	tabletool.clear(slot0._eliminateTypeMap)
end

return slot0
