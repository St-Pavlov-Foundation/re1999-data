-- chunkname: @modules/configs/excel2json/lua_summon_pool_package.lua

module("modules.configs.excel2json.lua_summon_pool_package", package.seeall)

local lua_summon_pool_package = {}
local fields = {
	posOffset = 8,
	packageRecommend = 4,
	showLimit = 6,
	packageEffect = 5,
	id = 1,
	packageRecommendSwitch = 3,
	className = 7,
	order = 2
}
local primaryKey = {
	"id",
	"order"
}
local mlStringKey = {}
local _configList, _configDict
local configPath = "configs.summon_pool_package_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_summon_pool_package, "configList", _configList)
	rawset(lua_summon_pool_package, "configDict", _configDict)
end

setmetatable(lua_summon_pool_package, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_summon_pool_package.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_summon_pool_package, "configList", nil)
	rawset(lua_summon_pool_package, "configDict", nil)
end

return lua_summon_pool_package
