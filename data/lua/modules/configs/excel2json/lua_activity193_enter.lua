-- chunkname: @modules/configs/excel2json/lua_activity193_enter.lua

module("modules.configs.excel2json.lua_activity193_enter", package.seeall)

local lua_activity193_enter = {}
local fields = {
	times = 6,
	name = 2,
	id = 1,
	icon = 5,
	targetDesc = 4,
	desc = 3
}
local primaryKey = {
	"id"
}
local mlStringKey = {
	name = 1,
	targetDesc = 3,
	desc = 2
}
local _configList, _configDict
local configPath = "configs.activity193_enter_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_activity193_enter, "configList", _configList)
	rawset(lua_activity193_enter, "configDict", _configDict)
end

setmetatable(lua_activity193_enter, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_activity193_enter.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_activity193_enter, "configList", nil)
	rawset(lua_activity193_enter, "configDict", nil)
end

return lua_activity193_enter
