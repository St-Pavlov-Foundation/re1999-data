-- chunkname: @modules/configs/excel2json/lua_fishing_map_block.lua

module("modules.configs.excel2json.lua_fishing_map_block", package.seeall)

local lua_fishing_map_block = {}
local _configList, _configDict
local configPath = "configs.fishing_map_block_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = lua_fishing_map_block.json_parse(config)

	rawset(lua_fishing_map_block, "configList", _configList)
	rawset(lua_fishing_map_block, "configDict", _configDict)
end

setmetatable(lua_fishing_map_block, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_fishing_map_block.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_fishing_map_block, "configList", nil)
	rawset(lua_fishing_map_block, "configDict", nil)
end

function lua_fishing_map_block.json_parse(json)
	local configList = {}
	local configDict = {}

	for _, cfg in ipairs(json) do
		table.insert(configList, cfg)

		local mapCfgDict = configDict[cfg.mapId]

		if not mapCfgDict then
			mapCfgDict = {}
			configDict[cfg.mapId] = mapCfgDict
		end

		mapCfgDict[cfg.defineId] = cfg
	end

	return configList, configDict
end

return lua_fishing_map_block
