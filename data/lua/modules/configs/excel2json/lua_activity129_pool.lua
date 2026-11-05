-- chunkname: @modules/configs/excel2json/lua_activity129_pool.lua

module("modules.configs.excel2json.lua_activity129_pool", package.seeall)

local lua_activity129_pool = {}
local fields = {
	cost = 6,
	name = 4,
	nameEn = 5,
	type = 3,
	maxDraw = 7,
	activityId = 1,
	poolId = 2
}
local primaryKey = {
	"activityId",
	"poolId"
}
local mlStringKey = {
	nameEn = 2,
	name = 1
}
local _configList, _configDict
local configPath = "configs.activity129_pool_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_activity129_pool, "configList", _configList)
	rawset(lua_activity129_pool, "configDict", _configDict)
end

setmetatable(lua_activity129_pool, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_activity129_pool.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_activity129_pool, "configList", nil)
	rawset(lua_activity129_pool, "configDict", nil)
end

return lua_activity129_pool
