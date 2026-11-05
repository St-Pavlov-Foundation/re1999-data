-- chunkname: @modules/configs/excel2json/lua_sodache_open.lua

module("modules.configs.excel2json.lua_sodache_open", package.seeall)

local lua_sodache_open = {}
local fields = {
	id = 1,
	condition = 2
}
local primaryKey = {
	"id"
}
local mlStringKey = {}
local _configList, _configDict
local configPath = "configs.sodache_open_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_sodache_open, "configList", _configList)
	rawset(lua_sodache_open, "configDict", _configDict)
end

setmetatable(lua_sodache_open, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_sodache_open.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_sodache_open, "configList", nil)
	rawset(lua_sodache_open, "configDict", nil)
end

return lua_sodache_open
