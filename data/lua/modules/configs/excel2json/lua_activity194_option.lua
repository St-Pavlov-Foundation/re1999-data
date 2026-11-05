-- chunkname: @modules/configs/excel2json/lua_activity194_option.lua

module("modules.configs.excel2json.lua_activity194_option", package.seeall)

local lua_activity194_option = {}
local fields = {
	optionResultId = 7,
	name = 2,
	effect = 6,
	optionRestriction = 5,
	conditionDesc = 3,
	optionDesc = 4,
	optionId = 1
}
local primaryKey = {
	"optionId"
}
local mlStringKey = {
	conditionDesc = 2,
	name = 1,
	optionDesc = 3
}
local _configList, _configDict
local configPath = "configs.activity194_option_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_activity194_option, "configList", _configList)
	rawset(lua_activity194_option, "configDict", _configDict)
end

setmetatable(lua_activity194_option, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_activity194_option.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_activity194_option, "configList", nil)
	rawset(lua_activity194_option, "configDict", nil)
end

return lua_activity194_option
