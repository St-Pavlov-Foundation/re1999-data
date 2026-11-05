-- chunkname: @modules/configs/excel2json/lua_formula.lua

module("modules.configs.excel2json.lua_formula", package.seeall)

local lua_formula = {}
local fields = {
	showType = 3,
	needEpisodeId = 13,
	needRoomLevel = 11,
	type = 2,
	needProductionLevel = 12,
	name = 4,
	produce = 8,
	desc = 17,
	costMaterial = 5,
	icon = 14,
	costReserve = 9,
	order = 10,
	costTime = 7,
	useDesc = 16,
	rare = 15,
	costScore = 6,
	id = 1
}
local primaryKey = {
	"id"
}
local mlStringKey = {
	name = 1,
	useDesc = 2,
	desc = 3
}
local _configList, _configDict
local configPath = "configs.formula_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_formula, "configList", _configList)
	rawset(lua_formula, "configDict", _configDict)
end

setmetatable(lua_formula, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_formula.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_formula, "configList", nil)
	rawset(lua_formula, "configDict", nil)
end

return lua_formula
