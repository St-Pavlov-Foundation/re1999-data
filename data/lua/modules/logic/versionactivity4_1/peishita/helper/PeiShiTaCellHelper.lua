-- chunkname: @modules/logic/versionactivity4_1/peishita/helper/PeiShiTaCellHelper.lua

module("modules.logic.versionactivity4_1.peishita.helper.PeiShiTaCellHelper", package.seeall)

local PeiShiTaCellHelper = class("PeiShiTaCellHelper")

function PeiShiTaCellHelper.calcTargetPos(fromX, fromY, dir)
	local tx, ty = fromX, fromY

	if dir == PeiShiTaEnum.Direction.Up then
		ty = ty - 1
	elseif dir == PeiShiTaEnum.Direction.Down then
		ty = ty + 1
	elseif dir == PeiShiTaEnum.Direction.Left then
		tx = tx - 1
	elseif dir == PeiShiTaEnum.Direction.Right then
		tx = tx + 1
	end

	return tx, ty
end

function PeiShiTaCellHelper.isValidCell(x, y)
	if x < 1 or x > PeiShiTaEnum.BoardSize.Column then
		return false
	end

	if y < 1 or y > PeiShiTaEnum.BoardSize.Row then
		return false
	end

	return true
end

function PeiShiTaCellHelper.cellKey(x, y)
	return x .. "_" .. y
end

function PeiShiTaCellHelper.getCellUnit(gameMo, x, y)
	if not gameMo then
		return nil
	end

	return gameMo:getUnitByPos(x, y)
end

function PeiShiTaCellHelper.hasCrossbow()
	return PeiShiTaGameModel.instance:getToolCount(PeiShiTaEnum.ToolId.Crossbow) > 0
end

function PeiShiTaCellHelper.canRemoveObstacle(obstacleType)
	if obstacleType ~= PeiShiTaEnum.UnitType.Obstacle then
		return false
	end

	local axeCount = PeiShiTaGameModel.instance:getToolCount(PeiShiTaEnum.ToolId.Axe)

	return axeCount > 0
end

function PeiShiTaCellHelper.canEnterCell(gameMo, x, y)
	if not PeiShiTaCellHelper.isValidCell(x, y) then
		return false
	end

	local unit = PeiShiTaCellHelper.getCellUnit(gameMo, x, y)

	if unit then
		local unitType = unit.config.type

		if unitType == PeiShiTaEnum.UnitType.Obstacle then
			return PeiShiTaCellHelper.canRemoveObstacle(unitType)
		elseif unitType == PeiShiTaEnum.UnitType.Hunter then
			return PeiShiTaCellHelper.hasCrossbow()
		elseif unitType == PeiShiTaEnum.UnitType.Schulz then
			return false
		end
	end

	return true
end

function PeiShiTaCellHelper.triggerCellEffect(gameMo, unit, flow, tx, ty, dir)
	if not unit then
		return
	end

	local effectFunc = PeiShiTaCellHelper["triggerEffect_" .. unit.config.type]

	if effectFunc then
		effectFunc(gameMo, unit, flow, tx, ty, dir)
	end
end

function PeiShiTaCellHelper.triggerEffect_3(gameMo, unit, flow, tx, ty, dir)
	flow:addWork(FunctionWork.New(PeiShiTaGameController.instance.dispatchEvent, PeiShiTaGameController.instance, PeiShiTaEvent.OnUnitRemove, unit, unit.pos.x, unit.pos.y))
	flow:addWork(FunctionWork.New(PeiShiTaGameModel.removeUnitById, PeiShiTaGameModel.instance, unit.id))
	flow:addWork(WaitEventWork.New(PeiShiTaEnum.WaitDieDoneKey .. unit.id))
	PeiShiTaCellHelper.commonMoveFlow(gameMo, unit, flow, tx, ty, dir)
	flow:addWork(FunctionWork.New(PeiShiTaGameModel.removeTool, PeiShiTaGameModel.instance, PeiShiTaEnum.ToolId.Axe, 1))
end

function PeiShiTaCellHelper.triggerEffect_4(gameMo, unit, flow, tx, ty, dir)
	flow:addWork(FunctionWork.New(PeiShiTaGameModel.addTool, PeiShiTaGameModel.instance, unit.config.id, 1))
	flow:addWork(FunctionWork.New(PeiShiTaGameController.instance.dispatchEvent, PeiShiTaGameController.instance, PeiShiTaEvent.OnUnitRemove, unit, unit.pos.x, unit.pos.y))
	flow:addWork(FunctionWork.New(PeiShiTaGameModel.removeUnitById, PeiShiTaGameModel.instance, unit.id))
end

function PeiShiTaCellHelper.triggerEffect_6(gameMo, unit, flow, tx, ty, dir)
	flow:addWork(FunctionWork.New(PeiShiTaGameModel.setFinished, PeiShiTaGameModel.instance, true))
	flow:addWork(WaitEventWork.New(PeiShiTaEnum.WaitLeaveAnimDoneKey))
end

function PeiShiTaCellHelper.commonMoveFlow(gameMo, unit, flow, tx, ty, dir)
	local waitEvent = PeiShiTaEnum.WaitMoveAnimDoneKey .. tostring(gameMo.playerId)

	flow:addWork(FunctionWork.New(PeiShiTaGameController.instance.dispatchEvent, PeiShiTaGameController.instance, PeiShiTaEvent.OnPlayerMove, tx, ty, dir))
	flow:addWork(WaitEventWork.New(waitEvent))
end

return PeiShiTaCellHelper
