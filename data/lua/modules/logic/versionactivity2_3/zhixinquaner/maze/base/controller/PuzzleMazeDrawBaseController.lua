module("modules.logic.versionactivity2_3.zhixinquaner.maze.base.controller.PuzzleMazeDrawBaseController", package.seeall)

slot0 = class("PuzzleMazeDrawBaseController", BaseController)
slot1 = PuzzleEnum.dir.left
slot2 = PuzzleEnum.dir.right
slot3 = PuzzleEnum.dir.down
slot4 = PuzzleEnum.dir.up

function slot0.onInitFinish(slot0)
end

function slot0.addConstEvents(slot0)
end

function slot0.reInit(slot0)
	slot0:release()
end

function slot0.release(slot0)
	slot0._curPosX = nil
	slot0._curPosY = nil
	slot0._passedPosX = nil
	slot0._passedPosY = nil
	slot0._passedCheckPoint = nil
	slot0._alertMoMap = nil
	slot0._nextDir = nil
	slot0._nextForwardX = nil
	slot0._nextForwardY = nil
	slot0._nextProgressX = nil
	slot0._nextProgressY = nil
	slot0._lineDirty = nil
end

function slot0.openGame(slot0, slot1)
	if not slot0._modelInst then
		logError("进入游戏失败:未配置Model实例")

		return
	end

	slot0:startGame(slot1)
end

function slot0.setModelInst(slot0, slot1)
	slot0._modelInst = slot1
end

function slot0.goStartPoint(slot0)
	slot1, slot2 = slot0._modelInst:getStartPoint()
	slot0._curPosX = slot1
	slot0._curPosY = slot2

	table.insert(slot0._passedPosX, slot1)
	table.insert(slot0._passedPosY, slot2)
end

function slot0.startGame(slot0, slot1)
	slot0:release()
	slot0._modelInst:startGame(slot1)

	slot0._passedPosX = {}
	slot0._passedPosY = {}
	slot0._passedCheckPoint = {}
	slot0._alertMoMap = {}

	slot0:goStartPoint()
end

function slot0.restartGame(slot0)
	if slot0._modelInst:getElementCo() then
		slot0:startGame(slot1)
	end
end

function slot0.isGameClear(slot0)
	slot1, slot2 = slot0._modelInst:getEndPoint()

	if not slot0:hasAlertObj() and slot0._curPosX == slot1 and slot0._curPosY == slot2 then
		for slot7, slot8 in pairs(slot0._modelInst:getList()) do
			if slot8.objType == PuzzleEnum.MazeObjType.CheckPoint and not slot0._passedCheckPoint[slot8] then
				return false
			end
		end

		return true
	end

	return false
end

function slot0.goPassLine(slot0, slot1, slot2, slot3, slot4, slot5, slot6)
	slot0._nextDir = nil
	slot0._nextForwardX = slot0._curPosX ~= slot1 and slot1 or slot3
	slot0._nextForwardY = slot0._curPosY ~= slot2 and slot2 or slot4

	if slot0._curPosX ~= slot1 or slot0._curPosX ~= slot3 then
		slot8 = slot8 or {}

		if (slot0._curPosX < slot3 and uv0 or uv1) == uv0 then
			for slot12 = slot0._curPosX + 1, slot1 do
				table.insert(slot8, {
					uv1,
					slot12,
					slot2
				})
			end

			slot0._nextForwardX = slot3
		else
			for slot12 = slot0._curPosX - 1, slot3, -1 do
				table.insert(slot8, {
					uv0,
					slot12,
					slot2
				})
			end

			slot0._nextForwardX = slot1
		end

		slot6 = nil
	end

	if slot0._curPosY ~= slot2 or slot0._curPosY ~= slot4 then
		if slot7 ~= nil then
			slot0._nextForwardX = nil
			slot0._nextForwardY = nil

			return false
		end

		slot8 = slot8 or {}

		if (slot0._curPosY < slot4 and uv2 or uv3) == uv2 then
			for slot12 = slot0._curPosY + 1, slot2 do
				table.insert(slot8, {
					uv3,
					slot1,
					slot12
				})
			end

			slot0._nextForwardY = slot4
		else
			for slot12 = slot0._curPosY - 1, slot4, -1 do
				table.insert(slot8, {
					uv2,
					slot1,
					slot12
				})
			end

			slot0._nextForwardY = slot2
		end

		slot5 = nil
	end

	slot0._nextDir = slot7
	slot0._nextProgressX = slot5
	slot0._nextProgressY = slot6

	if slot8 and #slot8 > 0 then
		return slot0:processPath(slot8, slot5, slot6)
	end

	return false
end

function slot0.goPassPos(slot0, slot1, slot2)
	if slot0._curPosX ~= slot1 then
		slot4 = nil or {}

		if (slot0._curPosX < slot1 and uv0 or uv1) == uv0 then
			for slot8 = slot0._curPosX + 1, slot1 do
				table.insert(slot4, {
					uv1,
					slot8,
					slot2
				})
			end
		else
			for slot8 = slot0._curPosX - 1, slot1, -1 do
				table.insert(slot4, {
					uv0,
					slot8,
					slot2
				})
			end
		end
	end

	if slot0._curPosY ~= slot2 then
		if slot3 ~= nil then
			slot0._nextDir = nil
			slot0._nextForwardX = nil
			slot0._nextForwardY = nil

			return false
		end

		slot4 = slot4 or {}

		if (slot0._curPosY < slot2 and uv2 or uv3) == uv2 then
			for slot8 = slot0._curPosY + 1, slot2 do
				table.insert(slot4, {
					uv3,
					slot1,
					slot8
				})
			end
		else
			for slot8 = slot0._curPosY - 1, slot2, -1 do
				table.insert(slot4, {
					uv2,
					slot1,
					slot8
				})
			end
		end
	end

	slot0._nextProgressX = nil
	slot0._nextProgressY = nil

	if slot4 and #slot4 > 0 then
		slot5 = slot0:processPath(slot4)
	end

	return false
end

function slot0.processPath(slot0, slot1, slot2, slot3)
	for slot7, slot8 in ipairs(slot1) do
		slot9 = slot8[1]
		slot13 = nil

		if not slot0:isBackward(slot8[2], slot8[3]) then
			for slot17, slot18 in pairs(slot0._alertMoMap) do
				return false
			end

			slot13 = 1
		end

		if slot0._modelInst:getObjAtLine(slot0._curPosX, slot0._curPosY, slot10, slot11) and slot0._modelInst:getMapLineState(slot0._curPosX, slot0._curPosY, slot10, slot11) == PuzzleEnum.LineState.Disconnect then
			slot0._alertMoMap[slot14] = slot13
		end

		if slot12 then
			slot0._alertMoMap[PuzzleMazeHelper.getPosKey(slot0._curPosX, slot0._curPosY)] = nil

			if slot0._modelInst:getObjAtPos(slot0._curPosX, slot0._curPosY) ~= nil and slot14.objType == PuzzleEnum.MazeObjType.CheckPoint and not slot0:alreadyPassed(slot0._curPosX, slot0._curPosY, true) then
				slot0._passedCheckPoint[slot14] = slot13
			end
		else
			if slot0._modelInst:getObjAtPos(slot10, slot11) ~= nil and slot14.objType == PuzzleEnum.MazeObjType.CheckPoint then
				slot0._passedCheckPoint[slot14] = slot13
			end

			if slot0:alreadyPassed(slot10, slot11) then
				slot0._alertMoMap[PuzzleMazeHelper.getPosKey(slot10, slot11)] = slot13
			end
		end

		if slot12 then
			slot0._passedPosX[#slot0._passedPosX] = nil
			slot0._passedPosY[#slot0._passedPosY] = nil
		else
			table.insert(slot0._passedPosX, slot10)
			table.insert(slot0._passedPosY, slot11)
		end

		slot0._curPosX = slot10
		slot0._curPosY = slot11
		slot0._nextDir = slot9
		slot0._lineDirty = true
	end

	return true
end

function slot0.goBackPos(slot0)
	if #slot0._passedPosX >= 2 then
		slot0:goPassPos(slot0._passedPosX[slot1 - 1], slot0._passedPosY[slot1 - 1])
	end
end

function slot0.isBackward(slot0, slot1, slot2)
	return #slot0._passedPosX > 1 and slot0._passedPosX[#slot0._passedPosX - 1] == slot1 and slot0._passedPosY[#slot0._passedPosY - 1] == slot2
end

function slot0.alreadyPassed(slot0, slot1, slot2, slot3)
	slot4 = slot0._passedPosX and #slot0._passedPosX or 0

	for slot9 = 1, slot3 and slot4 - 1 or slot4 do
		if slot0._passedPosX[slot9] == slot1 and slot0._passedPosY[slot9] == slot2 then
			return true
		end
	end

	return false
end

function slot0.alreadyCheckPoint(slot0, slot1)
	return slot0._passedCheckPoint and slot0._passedCheckPoint[slot1] ~= nil
end

function slot0.getLastPos(slot0)
	return slot0._curPosX, slot0._curPosY
end

function slot0.getPassedPoints(slot0)
	return slot0._passedPosX, slot0._passedPosY
end

function slot0.getProgressLine(slot0)
	return slot0._nextForwardX, slot0._nextForwardY, slot0._nextProgressX, slot0._nextProgressY
end

function slot0.getAlertMap(slot0)
	return slot0._alertMoMap
end

function slot0.hasAlertObj(slot0)
	for slot4, slot5 in pairs(slot0._alertMoMap) do
		return true
	end

	return false
end

function slot0.isLineDirty(slot0)
	return slot0._lineDirty
end

function slot0.resetLineDirty(slot0)
	slot0._lineDirty = false
end

slot0.instance = slot0.New()

LuaEventSystem.addEventMechanism(slot0.instance)

return slot0
