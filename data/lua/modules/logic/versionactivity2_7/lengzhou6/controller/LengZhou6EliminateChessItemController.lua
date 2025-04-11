module("modules.logic.versionactivity2_7.lengzhou6.controller.LengZhou6EliminateChessItemController", package.seeall)

slot0 = class("LengZhou6EliminateChessItemController", EliminateChessItemController)

function slot0.InitChess(slot0)
	if LocalEliminateChessModel.instance:getAllCell() == nil then
		return
	end

	for slot5 = 1, #slot1 do
		if slot0._chess[slot5] == nil then
			slot0._chess[slot5] = {}
		end

		for slot10 = 1, #slot1[slot5] do
			slot12 = slot0:createChess(slot5, slot10)

			slot12:initData(slot6[slot10])

			slot0._chess[slot5][slot10] = slot12
		end
	end
end

function slot0.createChess(slot0, slot1, slot2)
	slot3 = slot0:getChessItemGo(string.format("chess_%d_%d", slot1, slot2), slot1, slot2)
	slot4 = MonoHelper.addNoUpdateLuaComOnceToGo(slot3, EliminateChessItem2_7, slot0)

	slot4:init(slot3)

	return slot4
end

function slot0.tempClearAllChess(slot0)
	for slot4, slot5 in pairs(slot0._chess) do
		for slot9, slot10 in pairs(slot5) do
			if slot10 ~= nil then
				slot10:onDestroy()
			end
		end
	end

	tabletool.clear(slot0._chess)
end

slot0.instance = slot0.New()

return slot0
