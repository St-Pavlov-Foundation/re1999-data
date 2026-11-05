-- chunkname: @modules/configs/excel2json/lua_activity248_option.lua

module("modules.configs.excel2json.lua_activity248_option", package.seeall)

local lua_activity248_option = {}
local fields = {
	id = 1,
	name = 2,
	icon = 3
}
local primaryKey = {
	"id"
}
local mlStringKey = {
	name = 1
}
local _configList, _configDict
local configPath = "configs.activity248_option_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_activity248_option, "configList", _configList)
	rawset(lua_activity248_option, "configDict", _configDict)
end

setmetatable(lua_activity248_option, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_activity248_option.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_activity248_option, "configList", nil)
	rawset(lua_activity248_option, "configDict", nil)
end

return lua_activity248_option
