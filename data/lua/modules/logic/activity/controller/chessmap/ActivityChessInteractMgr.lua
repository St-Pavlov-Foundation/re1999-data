module("modules.logic.activity.controller.chessmap.ActivityChessInteractMgr", package.seeall)

slot0 = class("ActivityChessInteractMgr")

function slot0.ctor(slot0)
	slot0._list = {}
	slot0._dict = {}
end

function slot0.add(slot0, slot1)
	slot2 = slot1.id

	slot0:remove(slot2)

	slot0._dict[slot2] = slot1

	table.insert(slot0._list, slot1)
end

function slot0.remove(slot0, slot1)
	if slot0._dict[slot1] then
		slot0._dict[slot1] = nil

		for slot6, slot7 in ipairs(slot0._list) do
			if slot7 == slot2 then
				table.remove(slot0._list, slot6)
				slot7:dispose()

				return true
			end
		end
	end

	return false
end

function slot0.getList(slot0)
	return slot0._list
end

function slot0.get(slot0, slot1)
	if slot0._dict then
		return slot0._dict[slot1]
	end

	return nil
end

function slot0.removeAll(slot0)
	for slot4, slot5 in ipairs(slot0._list) do
		slot5:dispose()
	end

	slot0._list = {}
	slot0._dict = {}
end

function slot0.sortRenderOrder(slot0, slot1)
	if slot0.config and slot1.config and (ActivityChessEnum.Res2SortOrder[slot0.config.avatar] or 0) ~= (ActivityChessEnum.Res2SortOrder[slot1.config.avatar] or 0) then
		return slot2 < slot3
	end

	return slot0.id < slot1.id
end

function slot0.getRenderOrder(slot0)
	if slot0.config then
		return ActivityChessEnum.Res2SortOrder[slot0.config.avatar] or 0
	end

	return 0
end

function slot0.dispose(slot0)
	if slot0._list then
		for slot4, slot5 in ipairs(slot0._list) do
			slot5:dispose()
		end

		slot0._list = nil
		slot0._dict = nil
	end
end

return slot0
