-- chunkname: @modules/configs/excel2json/lua_fishing_map_building.lua

module("modules.configs.excel2json.lua_fishing_map_building", package.seeall)

local lua_fishing_map_building = {}
local _configList, _configDict
local configPath = "configs.fishing_map_building_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = lua_fishing_map_building.json_parse(config)

	rawset(lua_fishing_map_building, "configList", _configList)
	rawset(lua_fishing_map_building, "configDict", _configDict)
end

setmetatable(lua_fishing_map_building, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_fishing_map_building.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_fishing_map_building, "configList", nil)
	rawset(lua_fishing_map_building, "configDict", nil)
end

function lua_fishing_map_building.json_parse(json)
	local configList = {}
	local configDict = {}

	for _, cfg in ipairs(json) do
		cfg.isFishingBuilding = true

		table.insert(configList, cfg)

		local mapCfgDict = configDict[cfg.mapId]

		if not mapCfgDict then
			mapCfgDict = {}
			configDict[cfg.mapId] = mapCfgDict
		end

		mapCfgDict[cfg.uid] = cfg
	end

	return configList, configDict
end

return lua_fishing_map_building
