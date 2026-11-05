-- chunkname: @modules/configs/excel2json/lua_summon_pool_infallible.lua

module("modules.configs.excel2json.lua_summon_pool_infallible", package.seeall)

local lua_summon_pool_infallible = {}
local fields = {
	id = 1,
	prefabPath = 2
}
local primaryKey = {
	"id"
}
local mlStringKey = {}
local _configList, _configDict
local configPath = "configs.summon_pool_infallible_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_summon_pool_infallible, "configList", _configList)
	rawset(lua_summon_pool_infallible, "configDict", _configDict)
end

setmetatable(lua_summon_pool_infallible, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_summon_pool_infallible.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_summon_pool_infallible, "configList", nil)
	rawset(lua_summon_pool_infallible, "configDict", nil)
end

return lua_summon_pool_infallible
