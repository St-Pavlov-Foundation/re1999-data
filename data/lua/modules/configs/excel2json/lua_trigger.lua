-- chunkname: @modules/configs/excel2json/lua_trigger.lua

module("modules.configs.excel2json.lua_trigger", package.seeall)

local lua_trigger = {}
local fields = {
	id = 1,
	param2 = 8,
	param4 = 10,
	param1 = 7,
	param8 = 14,
	limitOneTurn = 6,
	limit = 5,
	param7 = 13,
	triggerType = 3,
	param6 = 12,
	param10 = 16,
	param5 = 11,
	battleId = 2,
	actionList = 4,
	param9 = 15,
	param3 = 9
}
local primaryKey = {
	"id"
}
local mlStringKey = {}
local _configList, _configDict
local configPath = "configs.trigger_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_trigger, "configList", _configList)
	rawset(lua_trigger, "configDict", _configDict)
end

setmetatable(lua_trigger, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_trigger.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_trigger, "configList", nil)
	rawset(lua_trigger, "configDict", nil)
end

return lua_trigger
