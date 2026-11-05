-- chunkname: @modules/configs/excel2json/lua_assassin_stealth_map_grid.lua

module("modules.configs.excel2json.lua_assassin_stealth_map_grid", package.seeall)

local lua_assassin_stealth_map_grid = {}
local _configList, _configDict
local configPath = "configs.assassin_stealth_map_grid_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = lua_assassin_stealth_map_grid.json_parse(config)

	rawset(lua_assassin_stealth_map_grid, "configList", _configList)
	rawset(lua_assassin_stealth_map_grid, "configDict", _configDict)
end

setmetatable(lua_assassin_stealth_map_grid, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_assassin_stealth_map_grid.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_assassin_stealth_map_grid, "configList", nil)
	rawset(lua_assassin_stealth_map_grid, "configDict", nil)
end

function lua_assassin_stealth_map_grid.json_parse(json)
	local configList = {}
	local configDict = {}

	for _, cfg in ipairs(json) do
		table.insert(configList, cfg)

		local mapCfgDict = configDict[cfg.mapId]

		if not mapCfgDict then
			mapCfgDict = {}
			configDict[cfg.mapId] = mapCfgDict
		end

		mapCfgDict[cfg.gridId] = cfg
	end

	return configList, configDict
end

return lua_assassin_stealth_map_grid
