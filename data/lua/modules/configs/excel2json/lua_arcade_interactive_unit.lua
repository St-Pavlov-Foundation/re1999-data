-- chunkname: @modules/configs/excel2json/lua_arcade_interactive_unit.lua

module("modules.configs.excel2json.lua_arcade_interactive_unit", package.seeall)

local lua_arcade_interactive_unit = {}
local fields = {
	optionID = 10,
	name = 2,
	effectAfter = 9,
	type = 3,
	grid = 12,
	nodePortalLimit = 5,
	pos = 13,
	desc = 4,
	sceneIcon = 19,
	effectActing = 8,
	icon = 18,
	resPath = 14,
	spbehaviorID = 11,
	limit = 6,
	posOffset = 16,
	category = 17,
	id = 1,
	scale = 15,
	effectBefore = 7
}
local primaryKey = {
	"id"
}
local mlStringKey = {
	desc = 2,
	name = 1
}
local _configList, _configDict
local configPath = "configs.arcade_interactive_unit_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_arcade_interactive_unit, "configList", _configList)
	rawset(lua_arcade_interactive_unit, "configDict", _configDict)
end

setmetatable(lua_arcade_interactive_unit, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_arcade_interactive_unit.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_arcade_interactive_unit, "configList", nil)
	rawset(lua_arcade_interactive_unit, "configDict", nil)
end

return lua_arcade_interactive_unit
