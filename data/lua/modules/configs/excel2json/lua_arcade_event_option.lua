-- chunkname: @modules/configs/excel2json/lua_arcade_event_option.lua

module("modules.configs.excel2json.lua_arcade_event_option", package.seeall)

local lua_arcade_event_option = {}
local fields = {
	param = 5,
	descChange = 6,
	type = 2,
	id = 1,
	optionDesc = 3,
	condition = 4
}
local primaryKey = {
	"id"
}
local mlStringKey = {
	descChange = 2,
	optionDesc = 1
}
local _configList, _configDict
local configPath = "configs.arcade_event_option_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_arcade_event_option, "configList", _configList)
	rawset(lua_arcade_event_option, "configDict", _configDict)
end

setmetatable(lua_arcade_event_option, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_arcade_event_option.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_arcade_event_option, "configList", nil)
	rawset(lua_arcade_event_option, "configDict", nil)
end

return lua_arcade_event_option
