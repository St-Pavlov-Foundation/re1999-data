-- chunkname: @modules/configs/excel2json/lua_sodache_level.lua

module("modules.configs.excel2json.lua_sodache_level", package.seeall)

local lua_sodache_level = {}
local fields = {
	desc = 3,
	effect = 4,
	globalAttri = 6,
	cosume = 2,
	effectDesc = 5,
	level = 1
}
local primaryKey = {
	"level"
}
local mlStringKey = {
	effectDesc = 2,
	desc = 1
}
local _configList, _configDict
local configPath = "configs.sodache_level_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_sodache_level, "configList", _configList)
	rawset(lua_sodache_level, "configDict", _configDict)
end

setmetatable(lua_sodache_level, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_sodache_level.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_sodache_level, "configList", nil)
	rawset(lua_sodache_level, "configDict", nil)
end

return lua_sodache_level
