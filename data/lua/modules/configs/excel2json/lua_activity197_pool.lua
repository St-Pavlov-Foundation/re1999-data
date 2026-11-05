-- chunkname: @modules/configs/excel2json/lua_activity197_pool.lua

module("modules.configs.excel2json.lua_activity197_pool", package.seeall)

local lua_activity197_pool = {}
local fields = {
	index = 3,
	bonus = 4,
	activityId = 1,
	poolId = 2
}
local primaryKey = {
	"activityId",
	"poolId",
	"index"
}
local mlStringKey = {}
local _configList, _configDict
local configPath = "configs.activity197_pool_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_activity197_pool, "configList", _configList)
	rawset(lua_activity197_pool, "configDict", _configDict)
end

setmetatable(lua_activity197_pool, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_activity197_pool.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_activity197_pool, "configList", nil)
	rawset(lua_activity197_pool, "configDict", nil)
end

return lua_activity197_pool
