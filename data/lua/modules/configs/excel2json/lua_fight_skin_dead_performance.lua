-- chunkname: @modules/configs/excel2json/lua_fight_skin_dead_performance.lua

module("modules.configs.excel2json.lua_fight_skin_dead_performance", package.seeall)

local lua_fight_skin_dead_performance = {}
local fields = {
	id = 1,
	actType5 = 10,
	actType1 = 2,
	actParam8 = 17,
	actParam5 = 11,
	actType2 = 4,
	actParam1 = 3,
	actType3 = 6,
	actType6 = 12,
	actParam6 = 13,
	actType4 = 8,
	actType7 = 14,
	actParam7 = 15,
	actParam2 = 5,
	actType8 = 16,
	actParam4 = 9,
	actParam3 = 7
}
local primaryKey = {
	"id"
}
local mlStringKey = {}
local _configList, _configDict
local configPath = "configs.fight_skin_dead_performance_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_fight_skin_dead_performance, "configList", _configList)
	rawset(lua_fight_skin_dead_performance, "configDict", _configDict)
end

setmetatable(lua_fight_skin_dead_performance, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_fight_skin_dead_performance.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_fight_skin_dead_performance, "configList", nil)
	rawset(lua_fight_skin_dead_performance, "configDict", nil)
end

return lua_fight_skin_dead_performance
