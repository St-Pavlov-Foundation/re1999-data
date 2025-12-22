-- chunkname: @modules/configs/excel2json/lua_arcade_bomb.lua

module("modules.configs.excel2json.lua_arcade_bomb", package.seeall)

local lua_arcade_bomb = {}
local fields = {
	skillDesc = 3,
	name = 2,
	damage = 8,
	resPath = 5,
	icon = 13,
	target = 10,
	countdown = 9,
	addFloor = 11,
	skill = 12,
	effectDefault = 6,
	id = 1,
	shape = 4,
	scale = 7
}
local primaryKey = {
	"id"
}
local mlStringKey = {
	skillDesc = 2,
	name = 1
}

function lua_arcade_bomb.onLoad(json)
	lua_arcade_bomb.configList, lua_arcade_bomb.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_arcade_bomb
