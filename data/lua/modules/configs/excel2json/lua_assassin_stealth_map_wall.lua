-- chunkname: @modules/configs/excel2json/lua_assassin_stealth_map_wall.lua

module("modules.configs.excel2json.lua_assassin_stealth_map_wall", package.seeall)

local lua_assassin_stealth_map_wall = {}
local _configList, _configDict
local configPath = "configs.assassin_stealth_map_wall_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = lua_assassin_stealth_map_wall.json_parse(config)

	rawset(lua_assassin_stealth_map_wall, "configList", _configList)
	rawset(lua_assassin_stealth_map_wall, "configDict", _configDict)
end

setmetatable(lua_assassin_stealth_map_wall, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_assassin_stealth_map_wall.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_assassin_stealth_map_wall, "configList", nil)
	rawset(lua_assassin_stealth_map_wall, "configDict", nil)
end

function lua_assassin_stealth_map_wall.json_parse(json)
	local configList = {}
	local configDict = {}

	for _, cfg in ipairs(json) do
		table.insert(configList, cfg)

		local mapCfgDict = configDict[cfg.mapId]

		if not mapCfgDict then
			mapCfgDict = {}
			configDict[cfg.mapId] = mapCfgDict
		end

		mapCfgDict[cfg.wallId] = cfg
	end

	return configList, configDict
end

return lua_assassin_stealth_map_wall
