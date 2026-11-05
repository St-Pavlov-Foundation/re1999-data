-- chunkname: @modules/configs/excel2json/lua_statistics_ignore.lua

module("modules.configs.excel2json.lua_statistics_ignore", package.seeall)

local lua_statistics_ignore = {}
local fields = {
	id = 1
}
local primaryKey = {
	"id"
}
local mlStringKey = {}
local _configList, _configDict
local configPath = "configs.statistics_ignore_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_statistics_ignore, "configList", _configList)
	rawset(lua_statistics_ignore, "configDict", _configDict)
end

setmetatable(lua_statistics_ignore, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_statistics_ignore.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_statistics_ignore, "configList", nil)
	rawset(lua_statistics_ignore, "configDict", nil)
end

return lua_statistics_ignore
