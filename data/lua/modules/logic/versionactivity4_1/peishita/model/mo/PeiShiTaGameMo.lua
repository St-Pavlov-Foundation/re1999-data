-- chunkname: @modules/logic/versionactivity4_1/peishita/model/mo/PeiShiTaGameMo.lua

module("modules.logic.versionactivity4_1.peishita.model.mo.PeiShiTaGameMo", package.seeall)

local PeiShiTaGameMo = pureTable("PeiShiTaGameMo")

function PeiShiTaGameMo:ctor()
	self.actId = 0
	self.gameId = 0
	self.playerId = 0
	self.unitList = {}
	self.unitById = {}
	self.unitByPos = {}
	self.unitByType = {}
	self.toolDic = {}
	self.isFinished = false
	self.isSuccess = false
end

function PeiShiTaGameMo:updateFromGameConfig(gameConfig)
	if not gameConfig then
		return
	end

	self.gameId = gameConfig.gameId or self.gameId

	local mapData = PeiShiTaGameConfig.instance:getMapData(gameConfig.mapId)
	local srcList = mapData and mapData.unitList or {}

	self.unitList = {}
	self.unitById = {}
	self.unitByPos = {}
	self.unitByType = {}

	for _, src in ipairs(srcList) do
		local unit = {
			id = src.id,
			pos = {
				x = src.x,
				y = src.y
			},
			config = src.config,
			initPos = {
				x = src.x,
				y = src.y
			}
		}

		table.insert(self.unitList, unit)

		self.unitById[unit.id] = unit

		self:_addToPos(unit)
		self:_addToType(unit)

		if unit.config and unit.config.type == PeiShiTaEnum.UnitType.Player then
			self.playerId = unit.id
		end
	end

	self.toolDic = {}
	self.isFinished = false
	self.isSuccess = false
end

function PeiShiTaGameMo:_addToPos(unit)
	self.unitByPos[PeiShiTaCellHelper.cellKey(unit.pos.x, unit.pos.y)] = unit
end

function PeiShiTaGameMo:_removeFromPos(unit)
	self.unitByPos[PeiShiTaCellHelper.cellKey(unit.pos.x, unit.pos.y)] = nil
end

function PeiShiTaGameMo:_addToType(unit)
	local unitType = unit.config and unit.config.type

	if not unitType then
		return
	end

	local list = self.unitByType[unitType]

	if not list then
		list = {}
		self.unitByType[unitType] = list
	end

	table.insert(list, unit)
end

function PeiShiTaGameMo:_removeFromType(unit)
	local unitType = unit.config and unit.config.type

	if not unitType then
		return
	end

	local list = self.unitByType[unitType]

	if not list then
		return
	end

	for i, u in ipairs(list) do
		if u == unit then
			table.remove(list, i)

			break
		end
	end

	if #list == 0 then
		self.unitByType[unitType] = nil
	end
end

function PeiShiTaGameMo:addUnit(unit)
	self.unitById[unit.id] = unit

	self:_addToPos(unit)
	self:_addToType(unit)
end

function PeiShiTaGameMo:removeUnit(unit)
	for i, u in ipairs(self.unitList) do
		if u == unit then
			table.remove(self.unitList, i)

			break
		end
	end

	self.unitById[unit.id] = nil

	self:_removeFromPos(unit)
	self:_removeFromType(unit)
end

function PeiShiTaGameMo:updateUnitPos(unit, x, y)
	self:_removeFromPos(unit)

	unit.pos.x = x
	unit.pos.y = y

	self:_addToPos(unit)
end

function PeiShiTaGameMo:getUnitById(id)
	return self.unitById[id]
end

function PeiShiTaGameMo:getUnitByPos(x, y)
	return self.unitByPos[PeiShiTaCellHelper.cellKey(x, y)]
end

function PeiShiTaGameMo:getUnitsByType(unitType)
	return self.unitByType[unitType]
end

return PeiShiTaGameMo
