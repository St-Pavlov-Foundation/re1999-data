-- chunkname: @modules/configs/excel2json/lua_explore_unit.lua

module("modules.configs.excel2json.lua_explore_unit", package.seeall)

local lua_explore_unit = {}
local fields = {
	mapIcon2 = 6,
	asset = 9,
	type = 1,
	mapIconShow = 8,
	mapIcon = 5,
	icon2 = 4,
	icon = 3,
	mapActiveIcon = 7,
	isShow = 2
}
local primaryKey = {
	"type"
}
local mlStringKey = {}
local _configList, _configDict
local configPath = "configs.explore_unit_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_explore_unit, "configList", _configList)
	rawset(lua_explore_unit, "configDict", _configDict)
end

setmetatable(lua_explore_unit, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_explore_unit.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_explore_unit, "configList", nil)
	rawset(lua_explore_unit, "configDict", nil)
end

return lua_explore_unit
