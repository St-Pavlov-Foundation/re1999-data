-- chunkname: @modules/configs/excel2json/lua_activity244_counter.lua

module("modules.configs.excel2json.lua_activity244_counter", package.seeall)

local lua_activity244_counter = {}
local fields = {
	desc = 5,
	multiplier = 4,
	attackerCareer = 2,
	id = 1,
	defenderCareer = 3
}
local primaryKey = {
	"id"
}
local mlStringKey = {
	desc = 1
}
local _configList, _configDict
local configPath = "configs.activity244_counter_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_activity244_counter, "configList", _configList)
	rawset(lua_activity244_counter, "configDict", _configDict)
end

setmetatable(lua_activity244_counter, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_activity244_counter.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_activity244_counter, "configList", nil)
	rawset(lua_activity244_counter, "configDict", nil)
end

return lua_activity244_counter
