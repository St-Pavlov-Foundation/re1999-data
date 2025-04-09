module("modules.logic.versionactivity2_7.lengzhou6.model.mo.EliminateChessCellMO", package.seeall)

slot0 = class("EliminateChessCellMO", EliminateChessMO)

function slot0.ctor(slot0)
	uv0.super.ctor(slot0)

	slot0._status = {}
end

function slot0.setChessId(slot0, slot1)
	uv0.super.setChessId(slot0, slot1)
	slot0:setEliminateID()
end

function slot0.setEliminateID(slot0)
	slot0._eliminateID = EliminateEnum_2_7.ChessIndexToType[slot0.id] or ""
end

function slot0.canMove(slot0)
	return slot0:haveStatus(EliminateEnum.ChessState.Frost)
end

function slot0.getEliminateID(slot0)
	if slot0._eliminateID == nil then
		logNormal("EliminateChessCellMO:getEliminateID() self._eliminateID == nil")
	end

	return slot0._eliminateID
end

function slot0.setStatus(slot0, slot1)
	if slot1 == EliminateEnum.ChessState.Normal or slot1 == EliminateEnum.ChessState.Die then
		tabletool.clear(slot0._status)
	end

	slot0:addStatus(slot1)
end

function slot0.haveStatus(slot0, slot1)
	for slot5 = 1, #slot0._status do
		if slot0._status[slot5] == slot1 then
			return true
		end
	end

	return false
end

function slot0.addStatus(slot0, slot1)
	if slot1 == EliminateEnum.ChessState.Normal or slot1 == EliminateEnum.ChessState.Die then
		tabletool.clear(slot0._status)
	end

	if not slot0:haveStatus(slot1) then
		table.insert(slot0._status, slot1)
	end
end

function slot0.unsetStatus(slot0, slot1)
	for slot5 = 1, #slot0._status do
		if slot0._status[slot5] == slot1 then
			table.remove(slot0._status, slot5)

			break
		end
	end
end

function slot0.clear(slot0)
	if slot0._status then
		tabletool.clear(slot0._status)
	end

	uv0.super.clear(slot0)
end

return slot0
