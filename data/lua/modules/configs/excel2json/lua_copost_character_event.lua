-- chunkname: @modules/configs/excel2json/lua_copost_character_event.lua

module("modules.configs.excel2json.lua_copost_character_event", package.seeall)

local lua_copost_character_event = {}
local fields = {
	frontEventId = 2,
	eventTextId = 8,
	changeChaId = 4,
	chaId = 3,
	id = 1,
	eventCoordinate = 7,
	changeChasId = 6,
	chasId = 5
}
local primaryKey = {
	"id"
}
local mlStringKey = {}
local _configList, _configDict
local configPath = "configs.copost_character_event_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_copost_character_event, "configList", _configList)
	rawset(lua_copost_character_event, "configDict", _configDict)
end

setmetatable(lua_copost_character_event, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_copost_character_event.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_copost_character_event, "configList", nil)
	rawset(lua_copost_character_event, "configDict", nil)
end

return lua_copost_character_event
