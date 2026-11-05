-- chunkname: @modules/configs/excel2json/lua_activity194_option_result.lua

module("modules.configs.excel2json.lua_activity194_option_result", package.seeall)

local lua_activity194_option_result = {}
local fields = {
	picture = 2,
	name = 3,
	effect = 5,
	resultId = 1,
	desc = 4
}
local primaryKey = {
	"resultId"
}
local mlStringKey = {
	desc = 2,
	name = 1
}
local _configList, _configDict
local configPath = "configs.activity194_option_result_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_activity194_option_result, "configList", _configList)
	rawset(lua_activity194_option_result, "configDict", _configDict)
end

setmetatable(lua_activity194_option_result, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_activity194_option_result.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_activity194_option_result, "configList", nil)
	rawset(lua_activity194_option_result, "configDict", nil)
end

return lua_activity194_option_result
