-- chunkname: @modules/logic/versionactivity4_1/peishita/helper/PeiShiTaGameHelper.lua

module("modules.logic.versionactivity4_1.peishita.helper.PeiShiTaGameHelper", package.seeall)

local PeiShiTaGameHelper = class("PeiShiTaGameHelper")

local function addCell(cells, x, y)
	if PeiShiTaCellHelper.isValidCell(x, y) then
		cells[PeiShiTaCellHelper.cellKey(x, y)] = true
	end
end

function PeiShiTaGameHelper.getHunterVisionCells(gameMo)
	local cells = {}

	if PeiShiTaCellHelper.hasCrossbow() then
		return cells
	end

	local alertRange = PeiShiTaEnum.Range.HunterAlertRange
	local hunters = gameMo:getUnitsByType(PeiShiTaEnum.UnitType.Hunter) or {}

	for _, unit in ipairs(hunters) do
		for i = -alertRange, alertRange do
			addCell(cells, unit.initPos.x + i, unit.initPos.y)
			addCell(cells, unit.initPos.x, unit.initPos.y + i)
		end
	end

	return cells
end

function PeiShiTaGameHelper.getSchulzVisionCells(gameMo)
	local cells = {}
	local schulz = PeiShiTaGameModel.instance:findSchulzUnit()

	if not schulz then
		return cells
	end

	local sx, sy = schulz.pos.x, schulz.pos.y

	for x = 1, PeiShiTaEnum.BoardSize.Column do
		cells[PeiShiTaCellHelper.cellKey(x, sy)] = true
	end

	for y = 1, PeiShiTaEnum.BoardSize.Row do
		cells[PeiShiTaCellHelper.cellKey(sx, y)] = true
	end

	return cells
end

function PeiShiTaGameHelper.getShootableRangeCells(gameMo)
	local cells = {}

	if not PeiShiTaCellHelper.hasCrossbow() then
		return cells
	end

	local hitRange = PeiShiTaEnum.Range.HunterHitRange
	local hunters = gameMo:getUnitsByType(PeiShiTaEnum.UnitType.Hunter) or {}

	for _, unit in ipairs(hunters) do
		for dx = -hitRange, hitRange do
			for dy = -hitRange, hitRange do
				addCell(cells, unit.pos.x + dx, unit.pos.y + dy)
			end
		end
	end

	return cells
end

function PeiShiTaGameHelper.buildCellTypeMap(gameMo)
	local shootable = PeiShiTaGameHelper.getShootableRangeCells(gameMo)
	local schulz = PeiShiTaGameHelper.getSchulzVisionCells(gameMo)
	local hunter = PeiShiTaGameHelper.getHunterVisionCells(gameMo)
	local cellTypeMap = {}

	for x = 1, PeiShiTaEnum.BoardSize.Column do
		for y = 1, PeiShiTaEnum.BoardSize.Row do
			local key = PeiShiTaCellHelper.cellKey(x, y)
			local cellType = PeiShiTaEnum.CellType.Default

			if shootable[key] then
				cellType = PeiShiTaEnum.CellType.ShootableRange
			elseif hunter[key] then
				cellType = PeiShiTaEnum.CellType.HunterVision
			elseif schulz[key] then
				cellType = PeiShiTaEnum.CellType.SchulzVision
			end

			cellTypeMap[key] = cellType
		end
	end

	return cellTypeMap
end

function PeiShiTaGameHelper.findHunterAttackTarget(gameMo)
	if PeiShiTaCellHelper.hasCrossbow() then
		return nil
	end

	local player = gameMo:getUnitById(gameMo.playerId)

	if not player then
		return nil
	end

	local px, py = player.pos.x, player.pos.y
	local target, minDist
	local hunters = gameMo:getUnitsByType(PeiShiTaEnum.UnitType.Hunter) or {}

	for _, unit in ipairs(hunters) do
		local dist = math.abs(unit.pos.x - px) + math.abs(unit.pos.y - py)
		local inRange = (unit.pos.x == px or unit.pos.y == py) and dist <= PeiShiTaEnum.Range.HunterAlertRange

		if inRange and (not minDist or dist < minDist) then
			target, minDist = unit, dist
		end
	end

	return target
end

function PeiShiTaGameHelper.findShootableHunter(gameMo)
	if not PeiShiTaCellHelper.hasCrossbow() then
		return nil
	end

	local player = gameMo:getUnitById(gameMo.playerId)

	if not player then
		return nil
	end

	local px, py = player.pos.x, player.pos.y
	local hitRange = PeiShiTaEnum.Range.HunterHitRange
	local hunters = gameMo:getUnitsByType(PeiShiTaEnum.UnitType.Hunter) or {}

	for _, unit in ipairs(hunters) do
		if hitRange >= math.abs(unit.pos.x - px) and hitRange >= math.abs(unit.pos.y - py) then
			return unit
		end
	end

	return nil
end

function PeiShiTaGameHelper.findSchulzKillTarget(gameMo)
	local player = gameMo:getUnitById(gameMo.playerId)

	if not player then
		return nil
	end

	local px, py = player.pos.x, player.pos.y
	local schulz = PeiShiTaGameModel.instance:findSchulzUnit()

	if not schulz then
		return nil
	end

	local sx, sy = schulz.pos.x, schulz.pos.y
	local killMinDist = PeiShiTaEnum.Range.SchulzKillMinDist
	local hunters = gameMo:getUnitsByType(PeiShiTaEnum.UnitType.Hunter) or {}

	for _, unit in ipairs(hunters) do
		local hx, hy = unit.pos.x, unit.pos.y
		local sameColumn = px == hx and hx == sx and hy > math.min(py, sy) and hy < math.max(py, sy) and killMinDist <= math.abs(py - hy)
		local sameRow = py == hy and hy == sy and hx > math.min(px, sx) and hx < math.max(px, sx) and killMinDist <= math.abs(px - hx)

		if sameColumn or sameRow then
			return unit
		end
	end

	return nil
end

function PeiShiTaGameHelper.gridToLocalPos(x, y)
	local boardSize = PeiShiTaEnum.BoardSize
	local centerX = (1 + boardSize.Column) / 2
	local centerY = (1 + boardSize.Row) / 2
	local localX = (x - centerX) * boardSize.CellSize
	local localY = (centerY - y) * boardSize.CellSize

	return localX, localY
end

function PeiShiTaGameHelper.calcMoveDir(startX, startY, endX, endY)
	local direction = PeiShiTaEnum.Direction.Right

	if startX < endX then
		direction = PeiShiTaEnum.Direction.Right
	elseif endX < startX then
		direction = PeiShiTaEnum.Direction.Left
	elseif startY < endY then
		direction = PeiShiTaEnum.Direction.Down
	elseif endY < startY then
		direction = PeiShiTaEnum.Direction.Up
	end

	return direction
end

return PeiShiTaGameHelper
