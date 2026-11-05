-- chunkname: @modules/configs/excel2json/lua_activity218_dailydifficultly.lua

module("modules.configs.excel2json.lua_activity218_dailydifficultly", package.seeall)

local lua_activity218_dailydifficultly = {}
local fields = {
	difficulty = 2,
	day = 1
}
local primaryKey = {
	"day"
}
local mlStringKey = {}
local _configList, _configDict
local configPath = "configs.activity218_dailydifficultly_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_activity218_dailydifficultly, "configList", _configList)
	rawset(lua_activity218_dailydifficultly, "configDict", _configDict)
end

setmetatable(lua_activity218_dailydifficultly, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_activity218_dailydifficultly.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_activity218_dailydifficultly, "configList", nil)
	rawset(lua_activity218_dailydifficultly, "configDict", nil)
end

return lua_activity218_dailydifficultly
