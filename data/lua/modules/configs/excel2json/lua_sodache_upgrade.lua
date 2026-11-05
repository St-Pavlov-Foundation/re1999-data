-- chunkname: @modules/configs/excel2json/lua_sodache_upgrade.lua

module("modules.configs.excel2json.lua_sodache_upgrade", package.seeall)

local lua_sodache_upgrade = {}
local fields = {
	cost = 3,
	id = 1,
	effect1 = 4,
	type = 6,
	effect2Desc = 9,
	globalAttri = 7,
	effectDesc = 5,
	effect2 = 8,
	level = 2
}
local primaryKey = {
	"id",
	"level"
}
local mlStringKey = {
	effectDesc = 1,
	effect2Desc = 2
}
local _configList, _configDict
local configPath = "configs.sodache_upgrade_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_sodache_upgrade, "configList", _configList)
	rawset(lua_sodache_upgrade, "configDict", _configDict)
end

setmetatable(lua_sodache_upgrade, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_sodache_upgrade.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_sodache_upgrade, "configList", nil)
	rawset(lua_sodache_upgrade, "configDict", nil)
end

return lua_sodache_upgrade
