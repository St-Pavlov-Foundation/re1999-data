module("modules.logic.versionactivity2_7.lengzhou6.model.LocalEliminateChessModel", package.seeall)

slot0 = class("LocalEliminateChessModel")
slot1 = {
	{
		x = 1,
		y = 0
	},
	{
		x = -1,
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
	}
}

function slot0.ctor(slot0)
	slot0._changePoints = {}
	slot0._tempEliminateCheckResults = {}
	slot0._weights = {
		1,
		1,
		1,
		1
	}
end

function slot0.initByData(slot0, slot1)
	math.randomseed(os.time())

	if slot0.cells == nil then
		slot0.cells = {}
	end

	slot0._row = #slot1

	for slot5 = 1, #slot1 do
		if slot0.cells[slot5] == nil then
			slot0.cells[slot5] = {}
		end

		slot6 = slot1[slot5]
		slot0._col = #slot6

		for slot10 = 1, #slot6 do
			if slot0.cells[slot5][slot10] == nil then
				slot11 = slot0:createNewCell(slot5, slot10, EliminateEnum_2_7.ChessState.Normal, slot6[slot10])
			else
				slot0:initCell(slot11, slot5, slot10, EliminateEnum_2_7.ChessState.Normal, slot12)
			end

			slot11:setStartXY(slot5, slot0._col + 1)
			slot11:setXY(slot5, slot10)
		end
	end

	slot0._initData = slot1
end

function slot0.getInitData(slot0)
	return slot0._initData
end

function slot0.getAllCell(slot0)
	return slot0.cells
end

function slot0.getCell(slot0, slot1, slot2)
	if slot0.cells == nil or slot0.cells[slot1] == nil then
		return nil
	end

	return slot0.cells[slot1][slot2]
end

function slot0.getCellRowAndCol(slot0)
	return slot0._row, slot0._col
end

function slot0.setEliminateDieEffect(slot0, slot1)
	slot0._dieEffect = slot1
end

function slot0.getEliminateDieEffect(slot0)
	return slot0._dieEffect
end

function slot0.randomCell(slot0)
	if isDebugBuild then
		slot0:printInfo("打乱棋盘前:")
	end

	slot1 = {}
	slot2 = {}

	for slot6 = 1, slot0._col do
		for slot10 = 1, slot0._row do
			if slot0:_canEx(slot6, slot10) then
				table.insert(slot2, slot6)
				table.insert(slot2, slot10)
			end
		end
	end

	slot3 = math.floor(#slot2 / 2)
	slot4 = {}
	slot5, slot6 = nil

	while slot3 > #slot4 do
		slot8 = false

		for slot12 = 1, #slot4 do
			if slot4[slot12] == math.random(1, slot3) then
				slot8 = true

				break
			end
		end

		if not slot8 then
			table.insert(slot4, slot7)

			if slot5 == nil then
				slot5 = slot7
			elseif slot6 == nil then
				slot6 = slot7
			end

			if slot6 ~= nil and slot5 ~= nil then
				slot9 = slot2[slot5 * 2 - 1]
				slot10 = slot2[slot5 * 2]
				slot11 = slot2[slot6 * 2 - 1]
				slot12 = slot2[slot6 * 2]

				table.insert(slot1, slot9)
				table.insert(slot1, slot10)
				table.insert(slot1, slot11)
				table.insert(slot1, slot12)
				slot0:addChangePoints(slot9, slot10)
				slot0:addChangePoints(slot11, slot12)
				slot0:_exchangeCell(slot9, slot10, slot11, slot12)

				slot5, slot6 = nil
			end
		end
	end

	if isDebugBuild then
		slot0:printInfo("打乱棋盘后:")
	end

	return slot1
end

function slot0._canEx(slot0, slot1, slot2)
	if slot0.cells[slot1][slot2] == nil then
		return false
	end

	return slot3.id ~= -1 and not slot3:haveStatus(EliminateEnum_2_7.ChessState.Frost) and slot3.id ~= EliminateEnum_2_7.ChessTypeToIndex.stone
end

function slot0.resetCreateWeight(slot0)
	slot0._weights = {
		1,
		1,
		1,
		1
	}
end

function slot0.changeCreateWeight(slot0, slot1, slot2)
	slot3 = nil

	for slot7 = 1, #EliminateEnum_2_7.AllChessType do
		if EliminateEnum_2_7.AllChessType[slot7] == slot1 then
			slot3 = slot7
		end
	end

	if slot3 ~= nil then
		slot0._weights[slot3] = slot0._weights[slot3] * slot2
	end
end

function slot0.changeCellState(slot0, slot1, slot2, slot3)
	if slot0.cells == nil or slot0.cells[slot1] == nil or slot0.cells[slot1][slot2] == nil then
		return
	end

	slot0.cells[slot1][slot2]:addStatus(slot3)

	if isDebugBuild then
		slot0:printInfo("改变状态: ")
	end
end

function slot0.changeCellId(slot0, slot1, slot2, slot3)
	if slot0.cells == nil or slot0.cells[slot1][slot2] == nil then
		return nil
	end

	slot4 = slot0.cells[slot1][slot2]

	slot4:setChessId(slot3)
	slot4:setStatus(EliminateEnum_2_7.ChessState.Normal)

	if isDebugBuild then
		slot0:printInfo("改变棋子类型：")
	end

	return slot4
end

function slot0.exchangeCell(slot0, slot1, slot2, slot3, slot4, slot5)
	if isDebugBuild then
		slot0:printInfo("交换前: ")
	end

	if slot5 then
		slot0:_exchangeCell(slot1, slot2, slot3, slot4)
	end

	slot0:addChangePoints(slot1, slot2)
	slot0:addChangePoints(slot3, slot4)

	if isDebugBuild then
		slot0:printInfo("交换后")
	end

	if not slot0:check(false, true) then
		if slot5 then
			slot0:_exchangeCell(slot3, slot4, slot1, slot2)
		end

		if isDebugBuild then
			slot0:printInfo("还原")
		end

		return false
	end

	return true
end

function slot0.eliminateCross(slot0, slot1, slot2)
	slot3 = {}
	slot4 = true

	for slot9 = 1, slot0._row do
		if slot0.cells[slot9][slot2].id ~= EliminateEnum_2_7.InvalidId and slot10:getEliminateID() ~= EliminateEnum_2_7.ChessType.stone then
			function (slot0, slot1)
				uv0 = true

				for slot6 = 1, #uv1 / 2 do
					if uv1[slot6 * 2 - 1] == slot0 and uv1[slot6 * 2] == slot1 then
						uv0 = false

						break
					end
				end

				if uv0 then
					table.insert(uv1, slot0)
					table.insert(uv1, slot1)
				end
			end(slot9, slot2)
		end
	end

	for slot9 = 1, slot0._col do
		if slot0.cells[slot1][slot9].id ~= EliminateEnum_2_7.InvalidId and slot10:getEliminateID() ~= EliminateEnum_2_7.ChessType.stone then
			slot5(slot1, slot9)
		end
	end

	for slot10 = 1, #slot3 / 2 do
		slot13 = {}

		table.insert(slot13, {
			x = slot3[slot10 * 2 - 1],
			y = slot3[slot10 * 2]
		})
		table.insert(slot0._tempEliminateCheckResults, {
			eliminatePoints = slot13,
			eliminateType = EliminateEnum_2_7.eliminateType.base,
			eliminateX = slot1,
			eliminateY = slot2,
			skillEffect = LengZhou6Enum.SkillEffect.EliminationCross
		})
	end

	slot0:setEliminateDieEffect(LengZhou6Enum.SkillEffect.EliminationCross)
end

function slot0.eliminateRange(slot0, slot1, slot2, slot3)
	slot3 = (slot3 - 1) / 2

	for slot7 = -slot3, slot3 do
		for slot11 = -slot3, slot3 do
			slot13 = slot2 + slot11

			if slot1 + slot7 > 0 and slot12 <= slot0._row and slot13 > 0 and slot13 <= slot0._col and slot0.cells[slot1][slot2].id ~= EliminateEnum_2_7.InvalidId then
				slot15 = {}

				table.insert(slot15, {
					x = slot12,
					y = slot13
				})
				table.insert(slot0._tempEliminateCheckResults, {
					eliminatePoints = slot15,
					eliminateType = EliminateEnum_2_7.eliminateType.base,
					eliminateX = slot1,
					eliminateY = slot2,
					skillEffect = LengZhou6Enum.SkillEffect.EliminationRange
				})
			end
		end
	end

	slot0:setEliminateDieEffect(LengZhou6Enum.SkillEffect.EliminationRange)
end

function slot0.checkEliminate(slot0)
	if slot0._eliminateCount == nil then
		slot0:setEliminateCount(1)
	else
		slot0:setEliminateCount(slot0._eliminateCount + 1)
	end

	slot0:AddEliminateRecord()
	slot0:eliminate()

	if isDebugBuild then
		slot0:printInfo("消除处理后")
	end

	slot0:tidyUp()

	if isDebugBuild then
		slot0:printInfo("整理处理后")
	end

	slot0:fill()

	if isDebugBuild then
		slot0:printInfo("填充处理后")
		slot0:printInfo("消除次数：" .. slot0._eliminateCount .. "次")
	end
end

function slot0.eliminate(slot0)
	if #slot0._tempEliminateCheckResults <= 0 then
		return
	end

	slot1 = slot0:getCurEliminateRecordData()
	slot2 = slot0:getEliminateRecordShowData()

	for slot6 = 1, #slot0._tempEliminateCheckResults do
		slot7 = slot0._tempEliminateCheckResults[slot6]
		slot8 = slot7.newCellStatus
		slot12 = slot7.eliminateType
		slot13 = slot7.skillEffect
		slot14 = false
		slot16 = slot0.cells[slot7.eliminateX][slot7.eliminateY]:haveStatus(EliminateEnum_2_7.ChessState.SpecialSkill)

		if slot7.eliminatePoints ~= nil then
			slot17 = nil
			slot18 = 0

			for slot23 = 1, #slot7.eliminatePoints do
				slot26 = slot0.cells[slot7.eliminatePoints[slot23].x][slot7.eliminatePoints[slot23].y]
				slot17 = slot26:getEliminateID()

				if slot26:haveStatus(EliminateEnum_2_7.ChessState.SpecialSkill) then
					slot19 = 0 + 1
				end

				slot18 = slot18 + 1

				if not slot26:haveStatus(EliminateEnum_2_7.ChessState.Frost) then
					slot27 = true
					slot28 = false

					if slot8 ~= nil and slot8 == EliminateEnum_2_7.ChessState.SpecialSkill and (not slot16 or slot9 ~= slot24 or slot25 ~= slot10) and not slot14 then
						slot28 = true
						slot27 = false
					end

					if slot28 and not slot14 then
						slot26:addStatus(EliminateEnum_2_7.ChessState.SpecialSkill)
						slot2:addChangeType(slot24, slot25, EliminateEnum_2_7.ChessState.Normal)

						slot14 = true
					end

					if slot27 then
						slot26:setStatus(EliminateEnum_2_7.ChessState.Die)
						slot26:setChessId(EliminateEnum_2_7.InvalidId)
						slot2:addEliminate(slot24, slot25, slot13)
					end
				else
					slot26:setStatus(EliminateEnum_2_7.ChessState.Normal)
					slot2:addChangeType(slot24, slot25, EliminateEnum_2_7.ChessState.Frost)
				end
			end

			if slot17 ~= nil then
				slot1:setEliminateType(slot17, slot12, slot18, slot19)
			end
		end
	end

	tabletool.clear(slot0._tempEliminateCheckResults)
end

function slot0.tidyUp(slot0)
	slot1 = slot0:getEliminateRecordShowData()

	for slot5 = 1, slot0._row do
		for slot9 = 1, slot0._col do
			if slot0.cells[slot5][slot9]:haveStatus(EliminateEnum_2_7.ChessState.Die) and slot0:findNextStartIndex(slot9 + 1, slot5, slot0._row) ~= -1 then
				slot0:_exchangeCell(slot5, slot9, slot5, slot11)
				slot0:addChangePoints(slot5, slot9)
				slot0:addChangePoints(slot5, slot11)
				slot1:addMove(slot5, slot11, slot5, slot9)
			end
		end
	end
end

function slot0.findNextStartIndex(slot0, slot1, slot2, slot3)
	for slot7 = slot1, slot3 do
		if slot0.cells[slot2][slot7] and slot8:getStatus() and slot8:haveStatus(EliminateEnum_2_7.ChessState.Frost) then
			break
		end

		if slot9 and not slot8:haveStatus(EliminateEnum_2_7.ChessState.Frost) and not slot8:haveStatus(EliminateEnum_2_7.ChessState.Die) then
			return slot7
		end
	end

	return -1
end

function slot0.fill(slot0)
	slot1 = slot0:getEliminateRecordShowData()

	for slot5 = 1, slot0._row do
		for slot9 = 1, slot0._col do
			slot11 = slot0.cells[slot5][slot9] and slot10:getStatus()

			if slot10:haveStatus(EliminateEnum_2_7.ChessState.Die) and slot0:findNextSpecialIndex(slot9 + 1, slot5, slot0._row) == -1 then
				slot0:createNewCell(slot5, slot9, EliminateEnum_2_7.ChessState.Normal):setStartXY(slot5, slot0._row + 1)
				slot0:addChangePoints(slot5, slot9)
				slot1:addNew(slot5, slot9)
			end
		end
	end
end

function slot0.findNextSpecialIndex(slot0, slot1, slot2, slot3)
	for slot7 = slot1, slot3 do
		if slot0.cells[slot2][slot7] and slot8:getStatus() and slot8:haveStatus(EliminateEnum_2_7.ChessState.Frost) then
			return slot7
		end
	end

	return -1
end

function slot0.check(slot0, slot1, slot2)
	if slot0._changePoints ~= nil and #slot0._changePoints > 0 then
		for slot7 = 1, #slot0._changePoints / 2 do
			if slot0:checkPoint(slot0._changePoints[slot7 * 2 - 1], slot0._changePoints[slot7 * 2]) and #slot10.eliminatePoints >= 3 then
				-- Nothing
			end
		end

		slot4 = {}

		for slot8, slot9 in pairs({
			[slot8 .. "_" .. slot9] = slot10
		}) do
			for slot13 = 1, #slot9.eliminatePoints do
				slot15 = slot9.eliminatePoints[slot13].y

				if slot9.eliminatePoints[slot13].x ~= slot9.eliminateX or slot15 ~= slot9.eliminateY then
					slot16 = slot14 .. "_" .. slot15
					slot17 = false

					for slot21 = 1, #slot4 do
						if slot16 == slot4[slot21] or slot8 == slot22 then
							slot17 = true

							break
						end
					end

					if not slot17 and slot3[slot16] ~= nil and #slot18.eliminatePoints <= #slot9.eliminatePoints then
						table.insert(slot4, slot16)
					end
				end
			end
		end

		for slot8, slot9 in pairs(slot4) do
			slot3[slot9] = nil
		end

		for slot8, slot9 in pairs(slot3) do
			if slot0:canAddResult(slot9) then
				table.insert(slot0._tempEliminateCheckResults, slot9)
			end
		end
	end

	if slot1 then
		tabletool.clear(slot0._changePoints)
	end

	if #slot0._tempEliminateCheckResults > 0 then
		if slot2 then
			tabletool.clear(slot0._tempEliminateCheckResults)
		end

		return true
	end

	return false
end

function slot0.canAddResult(slot0, slot1)
	slot2 = true

	for slot6 = 1, #slot0._tempEliminateCheckResults do
		if #slot0._tempEliminateCheckResults[slot6].eliminatePoints == #slot1.eliminatePoints then
			slot10 = true

			for slot14 = 1, #slot8 do
				if slot8[slot14].x ~= slot9[slot14].x or slot15.y ~= slot16.y then
					slot10 = false

					break
				end
			end

			if slot10 then
				slot2 = false

				break
			end
		end
	end

	return slot2
end

function slot0.createNewCell(slot0, slot1, slot2, slot3, slot4)
	slot5 = EliminateChessCellMO.New()

	slot0:initCell(slot5, slot1, slot2, slot3, slot4)

	return slot5
end

function slot0.initCell(slot0, slot1, slot2, slot3, slot4, slot5)
	if slot5 == nil then
		slot1:setChessId(slot0:getRandomId())
	else
		slot1:setChessId(slot5)
	end

	slot1:setXY(slot2, slot3)
	slot1:setStatus(slot4 and slot4 or EliminateEnum_2_7.ChessState.Normal)

	slot0.cells[slot2][slot3] = slot1
end

function slot0.getRandomId(slot0)
	if LocalEliminateChessUtils.getFixDropId() ~= nil then
		return slot1
	end

	slot0._weights = slot0._weights or {
		1,
		1,
		1,
		1
	}

	return EliminateEnum_2_7.AllChessID[EliminateModelUtils.getRandomNumberByWeight(slot0._weights)]
end

function slot0._exchangeCell(slot0, slot1, slot2, slot3, slot4)
	if slot0.cells == nil or slot0.cells[slot1] == nil or slot0.cells[slot3] == nil then
		return
	end

	slot0.cells[slot1][slot2] = slot0.cells[slot3][slot4]

	slot0.cells[slot1][slot2]:setXY(slot1, slot2)
	slot0.cells[slot1][slot2]:setStartXY(slot3, slot4)

	slot0.cells[slot3][slot4] = slot0.cells[slot1][slot2]

	slot0.cells[slot3][slot4]:setXY(slot3, slot4)
	slot0.cells[slot3][slot4]:setStartXY(slot1, slot2)
end

function slot0.checkPoint(slot0, slot1, slot2)
	slot5 = {}
	slot6 = nil
	slot7 = EliminateEnum_2_7.eliminateType.three

	if #slot0:checkWithDirection(slot1, slot2, uv0, slot0._row, slot0._col) >= 5 or #slot0:checkWithDirection(slot1, slot2, uv1, slot0._row, slot0._col) >= 5 then
		slot6 = EliminateEnum_2_7.ChessState.SpecialSkill
		slot7 = EliminateEnum_2_7.eliminateType.five
	elseif #slot3 >= 3 and #slot4 >= 3 then
		slot6 = EliminateEnum_2_7.ChessState.SpecialSkill
		slot7 = EliminateEnum_2_7.eliminateType.cross
	elseif #slot3 >= 4 then
		slot6 = EliminateEnum_2_7.ChessState.SpecialSkill
		slot7 = EliminateEnum_2_7.eliminateType.four
	elseif #slot4 >= 4 then
		slot6 = EliminateEnum_2_7.ChessState.SpecialSkill
		slot7 = EliminateEnum_2_7.eliminateType.four
	end

	if #slot3 >= 3 then
		slot5 = slot3
	end

	if #slot4 >= 3 then
		slot5 = EliminateModelUtils.mergePointArray(slot5, slot4)
	end

	return {
		eliminatePoints = slot5,
		newCellStatus = slot6,
		oldCellStatus = slot0.cells[slot1][slot2]:getStatus(),
		eliminateX = slot1,
		eliminateY = slot2,
		eliminateType = slot7,
		skillEffect = LengZhou6Enum.NormalEliminateEffect
	}
end

function slot0.checkWithDirection(slot0, slot1, slot2, slot3, slot4, slot5)
	slot7 = {
		[slot1 + slot2 * slot5] = true
	}

	table.insert({}, {
		x = slot1,
		y = slot2
	})

	slot8 = 1

	while slot8 <= #slot6 do
		slot9 = slot6[slot8]
		slot8 = slot8 + 1

		if slot0.cells[slot9.x][slot9.y] then
			for slot14 = 1, #slot3 do
				slot16 = slot2 + slot3[slot14].y

				if slot1 + slot3[slot14].x >= 1 and slot4 >= slot15 and slot16 >= 1 and slot5 >= slot16 and not slot7[slot15 + slot16 * slot5] and slot0.cells[slot15] ~= nil then
					if slot0.cells[slot15][slot16] == nil then
						-- Nothing
					elseif slot10.id == slot0.cells[slot15][slot16].id and slot10.id ~= EliminateEnum_2_7.InvalidId and slot10.id ~= EliminateEnum_2_7.ChessTypeToIndex.stone then
						slot7[slot15 + slot16 * slot5] = true

						table.insert(slot6, {
							x = slot15,
							y = slot16
						})
					end
				end
			end
		end
	end

	return slot6
end

function slot0.getAllEliminateIdPos(slot0, slot1)
	slot2 = {}

	for slot6 = 1, slot0._row do
		for slot10 = 1, slot0._col do
			if slot0:getCell(slot6, slot10).id == slot1 then
				table.insert(slot2, {
					x = slot6,
					y = slot10
				})
			end
		end
	end

	return slot2
end

function slot0.canEliminate(slot0)
	if slot0.cells == nil then
		return nil
	end

	return LocalEliminateChessUtils.instance.canEliminate(slot0.cells, slot0._row, slot0._col)
end

function slot0.createInitMoveState(slot0)
	slot0:initByData(LocalEliminateChessUtils.instance.generateUnsolvableBoard(EliminateEnum_2_7.MaxRow, EliminateEnum_2_7.MaxCol))
end

function slot0.addChangePoints(slot0, slot1, slot2)
	if slot0._changePoints == nil then
		slot0._changePoints = {}
	end

	table.insert(slot0._changePoints, slot1)
	table.insert(slot0._changePoints, slot2)
end

function slot0.printInfo(slot0, slot1)
	if isDebugBuild then
		slot2 = "\n"

		for slot6 = slot0._row, 1, -1 do
			slot7 = ""

			for slot11 = 1, slot0._col do
				for slot18 = 1, #slot0.cells[slot11][slot6]:getStatus() do
					slot14 = 0 + slot13[slot18]
				end

				slot7 = slot7 .. slot12.id .. "[" .. slot14 .. "]" .. " "
			end

			slot2 = slot2 .. slot7 .. "\n"
		end

		logNormal((slot1 and slot1 or "") .. slot2)
	end
end

function slot0.recordSpEffect(slot0, slot1, slot2, slot3)
	if slot0._chessEffect == nil then
		slot0._chessEffect = {}
	end

	slot0._chessEffect[slot1 .. "_" .. slot2] = slot3

	slot0:addSpEffectCd(slot1, slot2, slot3)
end

function slot0.getSpEffect(slot0, slot1, slot2)
	if slot0._chessEffect == nil then
		return nil
	end

	return slot0._chessEffect[slot1 .. "_" .. slot2]
end

function slot0.clearAllEffect(slot0)
	if slot0._chessEffect ~= nil then
		tabletool.clear(slot0._chessEffect)
	end

	if slot0._needChessCdEffect ~= nil then
		tabletool.clear(slot0._needChessCdEffect)
	end
end

function slot0.addSpEffectCd(slot0, slot1, slot2, slot3)
	if slot0._needChessCdEffect == nil then
		slot0._needChessCdEffect = {}
	end

	if slot3 and slot3 == EliminateEnum_2_7.ChessEffect.pollution then
		table.insert(slot0._needChessCdEffect, {
			x = slot1,
			y = slot2,
			cd = LengZhou6Config.instance:getEliminateBattleCost(32),
			effect = slot3
		})
	end
end

function slot0.updateSpEffectCd(slot0)
	if slot0._needChessCdEffect == nil then
		return
	end

	slot1 = {
		[slot5] = true
	}

	for slot5 = 1, #slot0._needChessCdEffect do
		if slot0._needChessCdEffect[slot5].cd <= 0 then
			LengZhou6EliminateController.instance:dispatchEvent(LengZhou6Event.HideEffect, slot6.x, slot6.y, slot6.effect)
		else
			slot6.cd = slot6.cd - 1
			slot0._needChessCdEffect[slot5] = slot6
		end
	end

	for slot5 = #slot0._needChessCdEffect, 1, -1 do
		if slot1[slot5] then
			table.remove(slot0._needChessCdEffect, slot5)
		end
	end
end

function slot0.setEliminateCount(slot0, slot1)
	slot0._eliminateCount = slot1
end

function slot0.roundDataClear(slot0)
	slot0:setEliminateCount(nil)

	if slot0._allEliminateRecordData ~= nil then
		tabletool.clear(slot0._allEliminateRecordData)
	end
end

function slot0.AddEliminateRecord(slot0)
	if slot0._allEliminateRecordData == nil then
		slot0._allEliminateRecordData = {}
	end

	table.insert(slot0._allEliminateRecordData, EliminateRecordDataMO.New())
end

function slot0.getCurEliminateRecordData(slot0)
	if slot0._allEliminateRecordData == nil then
		slot0:AddEliminateRecord()
	end

	return slot0._allEliminateRecordData[#slot0._allEliminateRecordData]
end

function slot0.getAllEliminateRecordData(slot0)
	return slot0._allEliminateRecordData
end

function slot0.getEliminateRecordShowData(slot0)
	if slot0._eliminateRecordShowMo == nil then
		slot0._eliminateRecordShowMo = EliminateRecordShowMO.New()
	end

	return slot0._eliminateRecordShowMo
end

function slot0.clear(slot0)
	slot0._eliminateRecordShowMo = nil
	slot0._allEliminateRecordData = nil
	slot0.cells = nil
	slot0._weights = nil
	slot0._needChessCdEffect = nil
	slot0._chessEffect = nil
end

function slot0.testRound(slot0)
	slot1 = {}

	for slot5 = 1, 10000 do
		table.insert(slot1, EliminateEnum_2_7.ChessIndexToType[slot0:getRandomId()])
	end

	slot2 = {}

	for slot6 = 1, #slot1 do
		if slot2[slot1[slot6]] == nil then
			slot2[slot7] = 1
		else
			slot2[slot7] = slot2[slot7] + 1
		end
	end

	for slot7, slot8 in pairs(slot2) do
		slot3 = "" .. slot7 .. " : " .. slot8 / 10000 * 100 .. "%\n"
	end

	logNormal(slot3)
end

slot0.instance = slot0.New()

return slot0
