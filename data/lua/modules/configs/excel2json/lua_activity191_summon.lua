-- chunkname: @modules/configs/excel2json/lua_activity191_summon.lua

module("modules.configs.excel2json.lua_activity191_summon", package.seeall)

local lua_activity191_summon = {}
local fields = {
	monsterId = 6,
	name = 4,
	priority = 2,
	relation = 9,
	headIcon = 7,
	career = 5,
	summonType = 3,
	id = 1,
	icon = 8
}
local primaryKey = {
	"id"
}
local mlStringKey = {
	name = 1
}
local _configList, _configDict
local configPath = "configs.activity191_summon_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_activity191_summon, "configList", _configList)
	rawset(lua_activity191_summon, "configDict", _configDict)
end

setmetatable(lua_activity191_summon, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_activity191_summon.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_activity191_summon, "configList", nil)
	rawset(lua_activity191_summon, "configDict", nil)
end

return lua_activity191_summon
