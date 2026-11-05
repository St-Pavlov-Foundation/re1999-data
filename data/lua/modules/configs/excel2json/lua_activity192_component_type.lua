-- chunkname: @modules/configs/excel2json/lua_activity192_component_type.lua

module("modules.configs.excel2json.lua_activity192_component_type", package.seeall)

local lua_activity192_component_type = {}
local fields = {
	id = 1,
	name = 2,
	path = 3
}
local primaryKey = {
	"id"
}
local mlStringKey = {}
local _configList, _configDict
local configPath = "configs.activity192_component_type_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_activity192_component_type, "configList", _configList)
	rawset(lua_activity192_component_type, "configDict", _configDict)
end

setmetatable(lua_activity192_component_type, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_activity192_component_type.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_activity192_component_type, "configList", nil)
	rawset(lua_activity192_component_type, "configDict", nil)
end

return lua_activity192_component_type
