-- chunkname: @modules/configs/excel2json/lua_equip_strengthen_cost.lua

module("modules.configs.excel2json.lua_equip_strengthen_cost", package.seeall)

local lua_equip_strengthen_cost = {}
local fields = {
	scoreCost = 4,
	attributeRate = 5,
	exp = 3,
	rare = 1,
	level = 2
}
local primaryKey = {
	"rare",
	"level"
}
local mlStringKey = {}
local _configList, _configDict
local configPath = "configs.equip_strengthen_cost_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_equip_strengthen_cost, "configList", _configList)
	rawset(lua_equip_strengthen_cost, "configDict", _configDict)
end

setmetatable(lua_equip_strengthen_cost, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_equip_strengthen_cost.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_equip_strengthen_cost, "configList", nil)
	rawset(lua_equip_strengthen_cost, "configDict", nil)
end

return lua_equip_strengthen_cost
