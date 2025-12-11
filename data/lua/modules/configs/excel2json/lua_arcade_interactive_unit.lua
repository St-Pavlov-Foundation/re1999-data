-- chunkname: @modules/configs/excel2json/lua_arcade_interactive_unit.lua

module("modules.configs.excel2json.lua_arcade_interactive_unit", package.seeall)

local lua_arcade_interactive_unit = {}
local fields = {
	name = 2,
	spbehaviorID = 7,
	optionID = 6,
	type = 3,
	grid = 8,
	pos = 9,
	limit = 5,
	desc = 4,
	posOffset = 12,
	scale = 11,
	sceneIcon = 15,
	category = 13,
	id = 1,
	icon = 14,
	resPath = 10
}
local primaryKey = {
	"id"
}
local mlStringKey = {
	desc = 2,
	name = 1
}

function lua_arcade_interactive_unit.onLoad(json)
	lua_arcade_interactive_unit.configList, lua_arcade_interactive_unit.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_arcade_interactive_unit
