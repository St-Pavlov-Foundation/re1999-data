-- chunkname: @modules/configs/excel2json/lua_trigger_action.lua

module("modules.configs.excel2json.lua_trigger_action", package.seeall)

local lua_trigger_action = {}
local fields = {
	param15 = 17,
	param1 = 3,
	actionType = 2,
	param12 = 14,
	param8 = 10,
	param6 = 8,
	param5 = 7,
	param2 = 4,
	param14 = 16,
	param13 = 15,
	param9 = 11,
	param7 = 9,
	param11 = 13,
	param10 = 12,
	id = 1,
	param4 = 6,
	param3 = 5
}
local primaryKey = {
	"id"
}
local mlStringKey = {}
local _configList, _configDict
local configPath = "configs.trigger_action_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_trigger_action, "configList", _configList)
	rawset(lua_trigger_action, "configDict", _configDict)
end

setmetatable(lua_trigger_action, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_trigger_action.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_trigger_action, "configList", nil)
	rawset(lua_trigger_action, "configDict", nil)
end

return lua_trigger_action
