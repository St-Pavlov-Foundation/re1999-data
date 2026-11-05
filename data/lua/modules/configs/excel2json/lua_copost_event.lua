-- chunkname: @modules/configs/excel2json/lua_copost_event.lua

module("modules.configs.excel2json.lua_copost_event", package.seeall)

local lua_copost_event = {}
local fields = {
	frontEventId = 2,
	eventTextId = 6,
	needchaText = 10,
	allTime = 8,
	chaId = 11,
	eventCoordinate = 4,
	reduceTime = 12,
	eventType = 3,
	charaProfile = 9,
	eventTitleId = 5,
	id = 1,
	chaNum = 7,
	bonus = 13
}
local primaryKey = {
	"id"
}
local mlStringKey = {
	needchaText = 2,
	eventTitleId = 1
}
local _configList, _configDict
local configPath = "configs.copost_event_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_copost_event, "configList", _configList)
	rawset(lua_copost_event, "configDict", _configDict)
end

setmetatable(lua_copost_event, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_copost_event.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_copost_event, "configList", nil)
	rawset(lua_copost_event, "configDict", nil)
end

return lua_copost_event
