-- chunkname: @modules/configs/excel2json/lua_sodache_event.lua

module("modules.configs.excel2json.lua_sodache_event", package.seeall)

local lua_sodache_event = {}
local fields = {
	retain = 10,
	name = 5,
	typeParam = 3,
	type = 2,
	group = 4,
	path = 7,
	desc = 6,
	probability = 11,
	dropPreview = 9,
	id = 1,
	battleList = 8
}
local primaryKey = {
	"id"
}
local mlStringKey = {
	desc = 2,
	name = 1
}
local _configList, _configDict
local configPath = "configs.sodache_event_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_sodache_event, "configList", _configList)
	rawset(lua_sodache_event, "configDict", _configDict)
end

setmetatable(lua_sodache_event, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_sodache_event.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_sodache_event, "configList", nil)
	rawset(lua_sodache_event, "configDict", nil)
end

return lua_sodache_event
