-- chunkname: @modules/configs/excel2json/lua_sodache_init_event.lua

module("modules.configs.excel2json.lua_sodache_init_event", package.seeall)

local lua_sodache_init_event = {}
local fields = {
	group = 2,
	eventGroup = 5,
	plot = 7,
	example = 4,
	id = 1,
	eventId = 6,
	difficulty = 3
}
local primaryKey = {
	"id"
}
local mlStringKey = {}
local _configList, _configDict
local configPath = "configs.sodache_init_event_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_sodache_init_event, "configList", _configList)
	rawset(lua_sodache_init_event, "configDict", _configDict)
end

setmetatable(lua_sodache_init_event, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_sodache_init_event.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_sodache_init_event, "configList", nil)
	rawset(lua_sodache_init_event, "configDict", nil)
end

return lua_sodache_init_event
