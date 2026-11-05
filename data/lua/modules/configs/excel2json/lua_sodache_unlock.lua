-- chunkname: @modules/configs/excel2json/lua_sodache_unlock.lua

module("modules.configs.excel2json.lua_sodache_unlock", package.seeall)

local lua_sodache_unlock = {}
local fields = {
	id = 1,
	condition = 2,
	desc = 3
}
local primaryKey = {
	"id"
}
local mlStringKey = {
	desc = 1
}
local _configList, _configDict
local configPath = "configs.sodache_unlock_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_sodache_unlock, "configList", _configList)
	rawset(lua_sodache_unlock, "configDict", _configDict)
end

setmetatable(lua_sodache_unlock, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_sodache_unlock.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_sodache_unlock, "configList", nil)
	rawset(lua_sodache_unlock, "configDict", nil)
end

return lua_sodache_unlock
