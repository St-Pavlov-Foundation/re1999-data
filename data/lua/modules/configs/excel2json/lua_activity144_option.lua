-- chunkname: @modules/configs/excel2json/lua_activity144_option.lua

module("modules.configs.excel2json.lua_activity144_option", package.seeall)

local lua_activity144_option = {}
local fields = {
	activityId = 1,
	name = 5,
	optionResults = 4,
	conditionDesc = 3,
	optionDesc = 6,
	optionId = 2
}
local primaryKey = {
	"activityId",
	"optionId"
}
local mlStringKey = {
	conditionDesc = 1,
	name = 2,
	optionDesc = 3
}
local _configList, _configDict
local configPath = "configs.activity144_option_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_activity144_option, "configList", _configList)
	rawset(lua_activity144_option, "configDict", _configDict)
end

setmetatable(lua_activity144_option, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_activity144_option.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_activity144_option, "configList", nil)
	rawset(lua_activity144_option, "configDict", nil)
end

return lua_activity144_option
