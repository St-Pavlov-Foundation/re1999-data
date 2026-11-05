-- chunkname: @modules/configs/excel2json/lua_survival_building.lua

module("modules.configs.excel2json.lua_survival_building", package.seeall)

local lua_survival_building = {}
local fields = {
	destruction = 10,
	name = 4,
	ruins = 8,
	type = 3,
	repairCost = 11,
	unlockCondition = 6,
	effect = 12,
	unName = 5,
	sort = 13,
	desc = 14,
	id = 1,
	icon = 9,
	lvUpCost = 7,
	level = 2
}
local primaryKey = {
	"id",
	"level"
}
local mlStringKey = {
	desc = 2,
	name = 1
}
local _configList, _configDict
local configPath = "configs.survival_building_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_survival_building, "configList", _configList)
	rawset(lua_survival_building, "configDict", _configDict)
end

setmetatable(lua_survival_building, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_survival_building.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_survival_building, "configList", nil)
	rawset(lua_survival_building, "configDict", nil)
end

return lua_survival_building
