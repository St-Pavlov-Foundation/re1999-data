-- chunkname: @modules/configs/excel2json/lua_activity220_lamona_unit.lua

module("modules.configs.excel2json.lua_activity220_lamona_unit", package.seeall)

local lua_activity220_lamona_unit = {}
local fields = {
	changeGhostTempAttrs = 7,
	effectRangeUnitId = 5,
	imgName = 9,
	type = 2,
	icon = 10,
	desc = 4,
	changeGhostAttrs = 6,
	id = 1,
	removeAfterEffect = 8,
	attributeList = 3
}
local primaryKey = {
	"id"
}
local mlStringKey = {
	desc = 1
}
local _configList, _configDict
local configPath = "configs.activity220_lamona_unit_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_activity220_lamona_unit, "configList", _configList)
	rawset(lua_activity220_lamona_unit, "configDict", _configDict)
end

setmetatable(lua_activity220_lamona_unit, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_activity220_lamona_unit.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_activity220_lamona_unit, "configList", nil)
	rawset(lua_activity220_lamona_unit, "configDict", nil)
end

return lua_activity220_lamona_unit
