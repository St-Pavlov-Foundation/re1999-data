-- chunkname: @modules/configs/excel2json/lua_activity241_option.lua

module("modules.configs.excel2json.lua_activity241_option", package.seeall)

local lua_activity241_option = {}
local fields = {
	activityId = 1,
	optionId = 2,
	optionName = 3
}
local primaryKey = {
	"activityId",
	"optionId"
}
local mlStringKey = {
	optionName = 1
}
local _configList, _configDict
local configPath = "configs.activity241_option_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_activity241_option, "configList", _configList)
	rawset(lua_activity241_option, "configDict", _configDict)
end

setmetatable(lua_activity241_option, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_activity241_option.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_activity241_option, "configList", nil)
	rawset(lua_activity241_option, "configDict", nil)
end

return lua_activity241_option
