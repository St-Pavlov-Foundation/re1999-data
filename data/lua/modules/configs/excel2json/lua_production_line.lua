-- chunkname: @modules/configs/excel2json/lua_production_line.lua

module("modules.configs.excel2json.lua_production_line", package.seeall)

local lua_production_line = {}
local fields = {
	reserve = 5,
	name = 2,
	logic = 4,
	type = 3,
	id = 1,
	initFormula = 6,
	needRoomLevel = 8,
	levelGroup = 7
}
local primaryKey = {
	"id"
}
local mlStringKey = {
	name = 1
}
local _configList, _configDict
local configPath = "configs.production_line_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_production_line, "configList", _configList)
	rawset(lua_production_line, "configDict", _configDict)
end

setmetatable(lua_production_line, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_production_line.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_production_line, "configList", nil)
	rawset(lua_production_line, "configDict", nil)
end

return lua_production_line
