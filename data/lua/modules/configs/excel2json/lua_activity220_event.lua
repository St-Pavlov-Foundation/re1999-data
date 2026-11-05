-- chunkname: @modules/configs/excel2json/lua_activity220_event.lua

module("modules.configs.excel2json.lua_activity220_event", package.seeall)

local lua_activity220_event = {}
local fields = {
	frontText = 6,
	result3reward = 10,
	npc = 5,
	type = 4,
	typeParam = 7,
	eventId = 2,
	chooseDesc = 11,
	result1reward = 8,
	result2reward = 9,
	weight = 3,
	gameId = 1
}
local primaryKey = {
	"gameId",
	"eventId"
}
local mlStringKey = {
	typeParam = 2,
	chooseDesc = 3,
	frontText = 1
}
local _configList, _configDict
local configPath = "configs.activity220_event_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_activity220_event, "configList", _configList)
	rawset(lua_activity220_event, "configDict", _configDict)
end

setmetatable(lua_activity220_event, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_activity220_event.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_activity220_event, "configList", nil)
	rawset(lua_activity220_event, "configDict", nil)
end

return lua_activity220_event
