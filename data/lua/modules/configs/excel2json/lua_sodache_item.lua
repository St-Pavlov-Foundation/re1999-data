-- chunkname: @modules/configs/excel2json/lua_sodache_item.lua

module("modules.configs.excel2json.lua_sodache_item", package.seeall)

local lua_sodache_item = {}
local fields = {
	dropWeight = 7,
	name = 2,
	dropPrice = 6,
	type = 3,
	id = 1,
	icon = 4,
	maxStack = 5
}
local primaryKey = {
	"id"
}
local mlStringKey = {
	name = 1
}
local _configList, _configDict
local configPath = "configs.sodache_item_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_sodache_item, "configList", _configList)
	rawset(lua_sodache_item, "configDict", _configDict)
end

setmetatable(lua_sodache_item, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_sodache_item.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_sodache_item, "configList", nil)
	rawset(lua_sodache_item, "configDict", nil)
end

return lua_sodache_item
