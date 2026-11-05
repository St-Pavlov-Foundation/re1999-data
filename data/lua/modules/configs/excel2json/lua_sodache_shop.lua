-- chunkname: @modules/configs/excel2json/lua_sodache_shop.lua

module("modules.configs.excel2json.lua_sodache_shop", package.seeall)

local lua_sodache_shop = {}
local fields = {
	id = 1,
	name = 2,
	type = 3
}
local primaryKey = {
	"id"
}
local mlStringKey = {
	name = 1
}
local _configList, _configDict
local configPath = "configs.sodache_shop_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_sodache_shop, "configList", _configList)
	rawset(lua_sodache_shop, "configDict", _configDict)
end

setmetatable(lua_sodache_shop, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_sodache_shop.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_sodache_shop, "configList", nil)
	rawset(lua_sodache_shop, "configDict", nil)
end

return lua_sodache_shop
