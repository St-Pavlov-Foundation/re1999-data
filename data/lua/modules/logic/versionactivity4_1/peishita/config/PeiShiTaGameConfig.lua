-- chunkname: @modules/logic/versionactivity4_1/peishita/config/PeiShiTaGameConfig.lua

module("modules.logic.versionactivity4_1.peishita.config.PeiShiTaGameConfig", package.seeall)

local PeiShiTaGameConfig = class("PeiShiTaGameConfig", BaseConfig)

function PeiShiTaGameConfig:reqConfigNames()
	return {
		"activity220_peishita_game",
		"activity220_peishita_map",
		"activity220_peishita_unit_type",
		"activity220_peishita_unit",
		"activity220_peishita_const"
	}
end

function PeiShiTaGameConfig:onConfigLoaded(configName, configTable)
	return
end

function PeiShiTaGameConfig:getGame(actId, gameId)
	local gameDict = lua_activity220_peishita_game.configDict[actId]

	return gameDict and gameDict[gameId]
end

function PeiShiTaGameConfig:getMapData(mapId)
	local mapCo = lua_activity220_peishita_map.configDict[mapId]

	if not mapCo then
		return nil
	end

	if not self._mapDataDict then
		self._mapDataDict = {}
	end

	local mapData = self._mapDataDict[mapId]

	if mapData then
		return mapData
	end

	local unitList = {}
	local cells = not string.nilorempty(mapCo.bgContent) and cjson.decode(mapCo.bgContent) or {}

	for i, cell in ipairs(cells) do
		local unitCo = self:getUnit(cell.unitIds)

		if not unitCo then
			logError("PeiShiTaGameConfig:getMapData 单位配置不存在, unitId = " .. tostring(cell.unitIds))
		end

		table.insert(unitList, {
			id = i,
			config = unitCo,
			x = cell.x,
			y = cell.y
		})
	end

	mapData = {
		unitList = unitList
	}
	self._mapDataDict[mapId] = mapData

	return mapData
end

function PeiShiTaGameConfig:getUnit(unitId)
	return lua_activity220_peishita_unit.configDict[unitId]
end

function PeiShiTaGameConfig:getUnitListByType(unitType)
	local unitCoList = {}

	for _, unitCo in ipairs(lua_activity220_peishita_unit.configList) do
		if unitCo.type == unitType then
			table.insert(unitCoList, unitCo)
		end
	end

	return unitCoList
end

function PeiShiTaGameConfig:getUnitType(unitTypeId)
	return lua_activity220_peishita_unit_type.configDict[unitTypeId]
end

function PeiShiTaGameConfig:getConstValue(constId, isNumber)
	local co = lua_activity220_peishita_const.configDict[constId]
	local value = co and co.value

	if value and isNumber then
		return tonumber(value)
	end

	return value
end

function PeiShiTaGameConfig:getUnitMoveTime(unitType)
	return self:getConstValue(PeiShiTaEnum.UnitMoveTimeConstId[unitType], true)
end

PeiShiTaGameConfig.instance = PeiShiTaGameConfig.New()

return PeiShiTaGameConfig
