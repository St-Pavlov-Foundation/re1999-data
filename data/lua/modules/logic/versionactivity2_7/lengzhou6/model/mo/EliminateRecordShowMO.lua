module("modules.logic.versionactivity2_7.lengzhou6.model.mo.EliminateRecordShowMO", package.seeall)

slot0 = class("EliminateRecordShowMO")

function slot0.ctor(slot0)
	slot0._eliminateList = {}
	slot0._changeTypeList = {}
	slot0._moveList = {}
	slot0._newList = {}
end

function slot0.getEliminate(slot0)
	return slot0._eliminateList
end

function slot0.getChangeType(slot0)
	return slot0._changeTypeList
end

function slot0.getMove(slot0)
	return slot0._moveList
end

function slot0.getNew(slot0)
	return slot0._newList
end

function slot0.addEliminate(slot0, slot1, slot2, slot3)
	table.insert(slot0._eliminateList, slot1)
	table.insert(slot0._eliminateList, slot2)
	table.insert(slot0._eliminateList, slot3)
end

function slot0.addChangeType(slot0, slot1, slot2, slot3)
	table.insert(slot0._changeTypeList, slot1)
	table.insert(slot0._changeTypeList, slot2)
	table.insert(slot0._changeTypeList, slot3)
end

function slot0.addMove(slot0, slot1, slot2, slot3, slot4)
	table.insert(slot0._moveList, slot1)
	table.insert(slot0._moveList, slot2)
	table.insert(slot0._moveList, slot3)
	table.insert(slot0._moveList, slot4)
end

function slot0.addNew(slot0, slot1, slot2)
	table.insert(slot0._newList, slot1)
	table.insert(slot0._newList, slot2)
end

function slot0.reset(slot0)
	tabletool.clear(slot0._eliminateList)
	tabletool.clear(slot0._changeTypeList)
	tabletool.clear(slot0._moveList)
	tabletool.clear(slot0._newList)
end

return slot0
