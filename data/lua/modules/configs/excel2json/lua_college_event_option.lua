-- chunkname: @modules/configs/excel2json/lua_college_event_option.lua

module("modules.configs.excel2json.lua_college_event_option", package.seeall)

local lua_college_event_option = {}
local fields = {
	id = 1,
	label = 2,
	description = 3,
	optionType = 4
}
local primaryKey = {
	"id"
}
local mlStringKey = {
	description = 2,
	label = 1
}
local _configList, _configDict
local configPath = "configs.college_event_option_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_college_event_option, "configList", _configList)
	rawset(lua_college_event_option, "configDict", _configDict)
end

setmetatable(lua_college_event_option, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_college_event_option.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_college_event_option, "configList", nil)
	rawset(lua_college_event_option, "configDict", nil)
end

return lua_college_event_option
