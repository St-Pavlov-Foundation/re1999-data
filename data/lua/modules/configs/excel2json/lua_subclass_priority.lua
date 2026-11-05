-- chunkname: @modules/configs/excel2json/lua_subclass_priority.lua

module("modules.configs.excel2json.lua_subclass_priority", package.seeall)

local lua_subclass_priority = {}
local fields = {
	id = 1,
	priority = 2
}
local primaryKey = {
	"id"
}
local mlStringKey = {}
local _configList, _configDict
local configPath = "configs.subclass_priority_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_subclass_priority, "configList", _configList)
	rawset(lua_subclass_priority, "configDict", _configDict)
end

setmetatable(lua_subclass_priority, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_subclass_priority.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_subclass_priority, "configList", nil)
	rawset(lua_subclass_priority, "configDict", nil)
end

return lua_subclass_priority
