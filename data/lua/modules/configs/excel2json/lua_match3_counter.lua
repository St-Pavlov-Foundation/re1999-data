-- chunkname: @modules/configs/excel2json/lua_match3_counter.lua

module("modules.configs.excel2json.lua_match3_counter", package.seeall)

local lua_match3_counter = {}
local fields = {
	multiplier = 4,
	defenderElementId = 3,
	id = 1,
	attackerElementId = 2,
	desc = 5
}
local primaryKey = {
	"id"
}
local mlStringKey = {
	desc = 1
}
local _configList, _configDict
local configPath = "configs.match3_counter_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_match3_counter, "configList", _configList)
	rawset(lua_match3_counter, "configDict", _configDict)
end

setmetatable(lua_match3_counter, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_match3_counter.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_match3_counter, "configList", nil)
	rawset(lua_match3_counter, "configDict", nil)
end

return lua_match3_counter
