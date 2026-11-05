-- chunkname: @modules/configs/excel2json/lua_summon_pool_limit_replicate.lua

module("modules.configs.excel2json.lua_summon_pool_limit_replicate", package.seeall)

local lua_summon_pool_limit_replicate = {}
local fields = {
	id = 1,
	res = 2,
	class = 3
}
local primaryKey = {
	"id"
}
local mlStringKey = {}
local _configList, _configDict
local configPath = "configs.summon_pool_limit_replicate_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_summon_pool_limit_replicate, "configList", _configList)
	rawset(lua_summon_pool_limit_replicate, "configDict", _configDict)
end

setmetatable(lua_summon_pool_limit_replicate, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_summon_pool_limit_replicate.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_summon_pool_limit_replicate, "configList", nil)
	rawset(lua_summon_pool_limit_replicate, "configDict", nil)
end

return lua_summon_pool_limit_replicate
