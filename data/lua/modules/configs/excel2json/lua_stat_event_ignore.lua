-- chunkname: @modules/configs/excel2json/lua_stat_event_ignore.lua

module("modules.configs.excel2json.lua_stat_event_ignore", package.seeall)

local lua_stat_event_ignore = {}
local fields = {
	id = 1,
	propertyValue = 2
}
local primaryKey = {
	"id"
}
local mlStringKey = {}
local _configList, _configDict
local configPath = "configs.stat_event_ignore_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_stat_event_ignore, "configList", _configList)
	rawset(lua_stat_event_ignore, "configDict", _configDict)
end

setmetatable(lua_stat_event_ignore, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_stat_event_ignore.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_stat_event_ignore, "configList", nil)
	rawset(lua_stat_event_ignore, "configDict", nil)
end

return lua_stat_event_ignore
