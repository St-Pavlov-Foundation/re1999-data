-- chunkname: @modules/configs/excel2json/lua_rogue_event_random.lua

module("modules.configs.excel2json.lua_rogue_event_random", package.seeall)

local lua_rogue_event_random = {}
local fields = {
	event = 2,
	id = 1,
	weights = 3
}
local primaryKey = {
	"id"
}
local mlStringKey = {}
local _configList, _configDict
local configPath = "configs.rogue_event_random_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_rogue_event_random, "configList", _configList)
	rawset(lua_rogue_event_random, "configDict", _configDict)
end

setmetatable(lua_rogue_event_random, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_rogue_event_random.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_rogue_event_random, "configList", nil)
	rawset(lua_rogue_event_random, "configDict", nil)
end

return lua_rogue_event_random
