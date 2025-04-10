module("modules.logic.versionactivity2_7.lengzhou6.model.EliminateModelUtils", package.seeall)

slot0 = class("EliminateModelUtils")

function slot0.mergePointArray(slot0, slot1)
	for slot6 = 1, #slot0 do
		table.insert({}, slot0[slot6])
	end

	slot3 = {}

	for slot7 = 1, #slot1 do
		slot8 = slot1[slot7]
		slot9 = false

		for slot13 = 1, #slot2 do
			if slot8.x == slot2[slot13].x and slot8.y == slot14.y then
				slot9 = true

				break
			end
		end

		if not slot9 then
			table.insert(slot3, slot8)
		end
	end

	for slot7 = 1, #slot3 do
		table.insert(slot2, slot3[slot7])
	end

	return slot2
end

function slot0.exclusivePoint(slot0, slot1)
	slot2 = {}

	for slot6 = 1, #slot0 do
		if slot0[slot6].x ~= slot1.x or slot7.y ~= slot1.y then
			table.insert(slot2, slot7)
		end
	end

	return slot2
end

function slot0.getRandomNumberByWeight(slot0)
	for slot5, slot6 in ipairs(slot0) do
		slot1 = 0 + slot6
	end

	for slot7, slot8 in ipairs(slot0) do
		if math.random() * slot1 <= 0 + slot8 then
			return slot7
		end
	end
end

return slot0
