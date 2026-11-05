-- chunkname: @modules/configs/excel2json/lua_rouge2_middle_layer.lua

module("modules.configs.excel2json.lua_rouge2_middle_layer", package.seeall)

local lua_rouge2_middle_layer = {}
local fields = {
	nameWeather = 3,
	name = 2,
	path = 11,
	dayOrNight = 12,
	pointPos = 7,
	empty = 13,
	leavePosUnlock = 10,
	pathPointPos = 8,
	pathSelect = 5,
	leavePos = 9,
	id = 1,
	nextLayer = 4,
	mapRes = 6
}
local primaryKey = {
	"id"
}
local mlStringKey = {
	nameWeather = 2,
	name = 1
}
local _configList, _configDict
local configPath = "configs.rouge2_middle_layer_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_rouge2_middle_layer, "configList", _configList)
	rawset(lua_rouge2_middle_layer, "configDict", _configDict)
end

setmetatable(lua_rouge2_middle_layer, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_rouge2_middle_layer.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_rouge2_middle_layer, "configList", nil)
	rawset(lua_rouge2_middle_layer, "configDict", nil)
end

return lua_rouge2_middle_layer
