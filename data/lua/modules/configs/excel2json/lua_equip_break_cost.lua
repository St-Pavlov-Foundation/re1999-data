-- chunkname: @modules/configs/excel2json/lua_equip_break_cost.lua

module("modules.configs.excel2json.lua_equip_break_cost", package.seeall)

local lua_equip_break_cost = {}
local fields = {
	cost = 4,
	scoreCost = 5,
	breakLevel = 2,
	rare = 1,
	level = 3
}
local primaryKey = {
	"rare",
	"breakLevel"
}
local mlStringKey = {}
local _configList, _configDict
local configPath = "configs.equip_break_cost_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_equip_break_cost, "configList", _configList)
	rawset(lua_equip_break_cost, "configDict", _configDict)
end

setmetatable(lua_equip_break_cost, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_equip_break_cost.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_equip_break_cost, "configList", nil)
	rawset(lua_equip_break_cost, "configDict", nil)
end

return lua_equip_break_cost
