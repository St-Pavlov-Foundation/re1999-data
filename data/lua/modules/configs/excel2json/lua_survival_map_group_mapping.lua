-- chunkname: @modules/configs/excel2json/lua_survival_map_group_mapping.lua

module("modules.configs.excel2json.lua_survival_map_group_mapping", package.seeall)

local lua_survival_map_group_mapping = {}
local fields = {
	id = 2,
	mapId = 1
}
local primaryKey = {
	"mapId"
}
local mlStringKey = {}
local _configList, _configDict
local configPath = "configs.survival_map_group_mapping_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_survival_map_group_mapping, "configList", _configList)
	rawset(lua_survival_map_group_mapping, "configDict", _configDict)
end

setmetatable(lua_survival_map_group_mapping, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_survival_map_group_mapping.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_survival_map_group_mapping, "configList", nil)
	rawset(lua_survival_map_group_mapping, "configDict", nil)
end

return lua_survival_map_group_mapping
