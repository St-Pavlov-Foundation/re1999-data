module("modules.logic.versionactivity2_7.lengzhou6.controller.step.EliminateChessDebug2_7Step", package.seeall)

slot0 = class("EliminateChessDebug2_7Step", EliminateChessStepBase)

function slot0.onStart(slot0)
	if not isDebugBuild then
		slot0:onDone(true)

		return
	end

	slot2 = LocalEliminateChessModel.instance:getAllCell()
	slot3 = "\n"

	for slot7 = #LengZhou6EliminateChessItemController.instance:getChess(), 1, -1 do
		slot8 = ""

		for slot12 = 1, #slot1[slot7] do
			slot13 = 0
			slot14 = -1

			if slot1[slot12][slot7] ~= nil and slot1[slot12][slot7]:getData() ~= nil then
				for slot20 = 1, #slot15:getStatus() do
					slot13 = slot13 + slot16[slot20]
				end

				slot14 = slot15.id
			end

			slot8 = slot8 .. slot14 .. "[" .. slot13 .. "]" .. " "
		end

		slot3 = slot3 .. slot8 .. "\n"
	end

	slot4 = "\n"

	for slot8 = #slot2, 1, -1 do
		slot9 = ""

		for slot13 = 1, #slot2[slot8] do
			for slot20 = 1, #slot2[slot13][slot8]:getStatus() do
				slot16 = 0 + slot15[slot20]
			end

			slot9 = slot9 .. slot14.id .. "[" .. slot16 .. "]" .. " "
		end

		slot4 = slot4 .. slot9 .. "\n"
	end

	logNormal("chessStr = " .. slot3)
	logNormal("chessMOStr = " .. slot4)
	slot0:onDone(true)
end

return slot0
