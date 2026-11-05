-- chunkname: @modules/configs/excel2json/lua_sodache_const.lua

module("modules.configs.excel2json.lua_sodache_const", package.seeall)

local lua_sodache_const = {}
local fields = {
	value = 2,
	id = 1,
	mlvalue = 3
}
local primaryKey = {
	"id"
}
local mlStringKey = {
	mlvalue = 1
}
local _configList, _configDict
local configPath = "configs.sodache_const_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_sodache_const, "configList", _configList)
	rawset(lua_sodache_const, "configDict", _configDict)
end

setmetatable(lua_sodache_const, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_sodache_const.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_sodache_const, "configList", nil)
	rawset(lua_sodache_const, "configDict", nil)
end

return lua_sodache_const
