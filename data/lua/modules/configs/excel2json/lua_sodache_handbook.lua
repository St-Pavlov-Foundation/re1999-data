-- chunkname: @modules/configs/excel2json/lua_sodache_handbook.lua

module("modules.configs.excel2json.lua_sodache_handbook", package.seeall)

local lua_sodache_handbook = {}
local fields = {
	id = 1,
	eleId = 2,
	tab2 = 4,
	tab1 = 3
}
local primaryKey = {
	"id"
}
local mlStringKey = {}
local _configList, _configDict
local configPath = "configs.sodache_handbook_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_sodache_handbook, "configList", _configList)
	rawset(lua_sodache_handbook, "configDict", _configDict)
end

setmetatable(lua_sodache_handbook, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_sodache_handbook.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_sodache_handbook, "configList", nil)
	rawset(lua_sodache_handbook, "configDict", nil)
end

return lua_sodache_handbook
