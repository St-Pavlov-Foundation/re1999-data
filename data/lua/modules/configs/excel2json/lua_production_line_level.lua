-- chunkname: @modules/configs/excel2json/lua_production_line_level.lua

module("modules.configs.excel2json.lua_production_line_level", package.seeall)

local lua_production_line_level = {}
local fields = {
	cost = 4,
	effect = 3,
	changeFormulaId = 5,
	id = 2,
	groupId = 1,
	icon = 7,
	needRoomLevel = 8,
	modulePart = 6
}
local primaryKey = {
	"groupId",
	"id"
}
local mlStringKey = {}
local _configList, _configDict
local configPath = "configs.production_line_level_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_production_line_level, "configList", _configList)
	rawset(lua_production_line_level, "configDict", _configDict)
end

setmetatable(lua_production_line_level, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_production_line_level.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_production_line_level, "configList", nil)
	rawset(lua_production_line_level, "configDict", nil)
end

return lua_production_line_level
