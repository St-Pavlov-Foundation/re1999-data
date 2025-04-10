module("modules.logic.versionactivity2_7.lengzhou6.model.LocalEliminateChessUtils", package.seeall)

slot0 = class("LocalEliminateChessUtils")
slot1 = {
	{
		x = 1,
		y = 0
	},
	{
		x = -1,
		y = 0
	},
	{
		x = 2,
		y = 0
	},
	{
		x = -2,
		y = 0
	}
}
slot2 = {
	{
		x = 0,
		y = 1
	},
	{
		x = 0,
		y = -1
	},
	{
		x = 0,
		y = 2
	},
	{
		x = 0,
		y = -2
	}
}

function slot3(slot0, slot1, slot2)
	slot4 = {}
	slot5 = slot2 > 1 and slot0[slot1][slot2 - 1] or nil
	slot6 = slot2 > 2 and slot0[slot1][slot2 - 2] or nil
	slot7 = slot1 > 1 and slot0[slot1 - 1][slot2] or nil
	slot8 = slot1 > 2 and slot0[slot1 - 2][slot2] or nil

	for slot12, slot13 in ipairs(EliminateEnum_2_7.AllChessID) do
		slot14 = true

		if slot5 and slot6 and slot13 == slot5 and slot13 == slot6 then
			slot14 = false
		end

		if slot7 and slot8 and slot13 == slot7 and slot13 == slot8 then
			slot14 = false
		end

		if slot14 then
			table.insert(slot4, slot13)
		end
	end

	return slot4
end

function slot4(slot0, slot1)
	print("生成的不可消除棋盘：")

	for slot5 = 1, slot1 do
		print(table.concat(slot0[slot5], " "))
	end
end

function slot0.generateUnsolvableBoard(slot0, slot1)
	math.randomseed(os.time())

	slot2 = {
		[slot6] = {}
	}

	for slot6 = 1, slot0 do
	end

	for slot6 = 1, slot0 do
		for slot10 = 1, slot1 do
			if #uv0(slot2, slot6, slot10) == 0 then
				return nil
			end

			slot2[slot6][slot10] = slot11[math.random(#slot11)]
		end
	end

	uv1(slot2, slot0)

	return slot2
end

function slot0.canEliminate(slot0, slot1, slot2)
	slot3 = {}

	for slot7 = 1, slot1 do
		for slot11 = 1, slot2 do
			if not slot0[slot7][slot11]:haveStatus(EliminateEnum.ChessState.Die) then
				slot14 = uv0.instance.checkWithDirection(slot7, slot11, uv2, slot1, slot2, slot0)

				if #uv0.instance.checkWithDirection(slot7, slot11, uv1, slot1, slot2, slot0) == 2 then
					tabletool.clear(slot3)

					for slot18 = 1, #slot13 do
						table.insert(slot3, slot13[slot18])
					end

					slot15, slot16 = uv0.instance._findTypeXY(slot0, slot1, slot2, slot12.id, slot13)

					if slot15 ~= nil then
						table.insert(slot3, {
							x = slot15,
							y = slot16
						})

						return slot3
					end
				end

				if #slot14 == 2 then
					tabletool.clear(slot3)

					for slot18 = 1, #slot14 do
						table.insert(slot3, slot14[slot18])
					end

					slot15, slot16 = uv0.instance._findTypeXY(slot0, slot1, slot2, slot12.id, slot14)

					if slot15 ~= nil then
						table.insert(slot3, {
							x = slot15,
							y = slot16
						})

						return slot3
					end
				end
			end
		end
	end

	return slot3
end

function slot0.checkWithDirection(slot0, slot1, slot2, slot3, slot4, slot5)
	slot6 = {}
	slot7 = {
		[slot0 + slot1 * slot4] = true
	}

	table.insert(slot6, {
		x = slot0,
		y = slot1
	})

	slot8 = 1
	slot9 = slot6[slot8]
	slot8 = slot8 + 1

	if slot5[slot9.x][slot9.y] then
		for slot14 = 1, #slot2 do
			slot18 = slot1 + slot2[slot14].y

			if slot0 + slot2[slot14].x >= 1 and slot3 >= slot17 and slot18 >= 1 and slot4 >= slot18 and not slot7[slot17 + slot18 * slot4] and slot5[slot17] ~= nil then
				if slot5[slot17][slot18] == nil then
					-- Nothing
				elseif slot10.id == slot5[slot17][slot18].id and slot10.id ~= EliminateEnum.InvalidId and slot10.id ~= EliminateEnum_2_7.ChessTypeToIndex.stone then
					slot7[slot17 + slot18 * slot4] = true
					slot19 = -1
					slot20 = -1

					if math.abs(slot15) == 1 or math.abs(slot16) == 1 then
						slot19 = slot0 + slot15 * 2
						slot20 = slot1 + slot16 * 2
					end

					if math.abs(slot15) == 2 or math.abs(slot16) == 2 then
						slot19 = slot0 + (slot15 ~= 0 and slot15 / 2 or slot15)
						slot20 = slot1 + (slot16 ~= 0 and slot16 / 2 or slot16)
					end

					if slot19 >= 1 and slot20 >= 1 and slot19 <= slot3 and slot20 <= slot4 and slot5[slot19][slot20] ~= nil and not slot21:haveStatus(EliminateEnum.ChessState.Frost) and LocalEliminateChessModel.instance:getSpEffect(slot19, slot20) == nil and slot21.id ~= EliminateEnum_2_7.ChessTypeToIndex.stone and slot21.id ~= EliminateEnum_2_7.InvalidId then
						table.insert(slot6, {
							x = slot17,
							y = slot18
						})
					end
				end
			end
		end
	end

	return slot6
end

function slot0._findTypeXY(slot0, slot1, slot2, slot3, slot4)
	if slot0 == nil then
		return nil, 
	end

	for slot8 = 1, slot1 do
		for slot12 = 1, slot2 do
			if slot0[slot8][slot12].id == slot3 and not slot13:haveStatus(EliminateEnum.ChessState.Frost) and LocalEliminateChessModel.instance:getSpEffect(slot8, slot12) == nil and slot13.id ~= EliminateEnum_2_7.ChessTypeToIndex.stone then
				slot14 = true

				if slot4 ~= nil then
					for slot18 = 1, #slot4 do
						if slot4[slot18].x == slot8 and slot19.y == slot12 then
							slot14 = false

							break
						end
					end
				end

				if slot14 then
					return slot8, slot12
				end
			end
		end
	end

	return nil, 
end

slot5 = {
	8,
	7,
	6,
	8,
	7,
	6,
	8,
	7,
	6
}

function slot0.getFixDropId()
	if not LengZhou6Controller.instance:isNeedForceDrop() then
		return nil
	end

	return table.remove(uv0, 1)
end

function slot0.getChessPos(slot0, slot1)
	return (slot0 - 1) * EliminateEnum_2_7.ChessWidth + EliminateEnum_2_7.ChessIntervalX * (slot0 - 1), (slot1 - 1) * EliminateEnum_2_7.ChessHeight + EliminateEnum_2_7.ChessIntervalY * (slot1 - 1)
end

slot0.instance = slot0.New()

return slot0
