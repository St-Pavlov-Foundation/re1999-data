-- chunkname: @modules/configs/excel2json/lua_activity191_init_build.lua

module("modules.configs.excel2json.lua_activity191_init_build", package.seeall)

local lua_activity191_init_build = {}
local fields = {
	name = 3,
	randHero = 8,
	item = 7,
	rewardHero = 10,
	randItem = 9,
	hero = 6,
	rewardItem = 11,
	desc = 4,
	style = 2,
	coin = 5,
	activityId = 1
}
local primaryKey = {
	"activityId",
	"style"
}
local mlStringKey = {
	desc = 2,
	name = 1
}
local _configList, _configDict
local configPath = "configs.activity191_init_build_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_activity191_init_build, "configList", _configList)
	rawset(lua_activity191_init_build, "configDict", _configDict)
end

setmetatable(lua_activity191_init_build, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_activity191_init_build.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_activity191_init_build, "configList", nil)
	rawset(lua_activity191_init_build, "configDict", nil)
end

return lua_activity191_init_build
