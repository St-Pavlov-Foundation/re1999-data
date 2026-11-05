-- chunkname: @modules/configs/excel2json/lua_activity192_map.lua

module("modules.configs.excel2json.lua_activity192_map", package.seeall)

local lua_activity192_map = {}
local _configList, _configDict
local configPath = "configs.activity192_map_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = lua_activity192_map.json_parse(config)

	rawset(lua_activity192_map, "configList", _configList)
	rawset(lua_activity192_map, "configDict", _configDict)
end

setmetatable(lua_activity192_map, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_activity192_map.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_activity192_map, "configList", nil)
	rawset(lua_activity192_map, "configDict", nil)
end

function lua_activity192_map.json_parse(json)
	local configList = {}
	local configDict = {}

	for _, cfg in ipairs(json) do
		table.insert(configList, cfg)

		local mapCfgDict = configDict[cfg.mapId]

		if not mapCfgDict then
			mapCfgDict = {}
			configDict[cfg.mapId] = mapCfgDict
		end

		mapCfgDict[cfg.componentId] = cfg
	end

	return configList, configDict
end

return lua_activity192_map
