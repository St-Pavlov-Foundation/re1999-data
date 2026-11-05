-- chunkname: @modules/configs/excel2json/lua_store.lua

module("modules.configs.excel2json.lua_store", package.seeall)

local lua_store = {}
local fields = {
	id = 1,
	refreshCost = 3,
	autoRefreshTime = 2,
	needClearStore = 4
}
local primaryKey = {
	"id"
}
local mlStringKey = {}
local _configList, _configDict
local configPath = "configs.store_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_store, "configList", _configList)
	rawset(lua_store, "configDict", _configDict)
end

setmetatable(lua_store, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_store.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_store, "configList", nil)
	rawset(lua_store, "configDict", nil)
end

return lua_store
