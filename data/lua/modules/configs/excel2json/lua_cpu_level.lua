-- chunkname: @modules/configs/excel2json/lua_cpu_level.lua

module("modules.configs.excel2json.lua_cpu_level", package.seeall)

local lua_cpu_level = {}
local fields = {
	level = 2,
	name = 1
}
local primaryKey = {
	"name"
}
local mlStringKey = {}
local _configList, _configDict
local configPath = "configs.cpu_level_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_cpu_level, "configList", _configList)
	rawset(lua_cpu_level, "configDict", _configDict)
end

setmetatable(lua_cpu_level, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_cpu_level.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_cpu_level, "configList", nil)
	rawset(lua_cpu_level, "configDict", nil)
end

return lua_cpu_level
