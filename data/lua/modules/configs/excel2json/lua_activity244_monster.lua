-- chunkname: @modules/configs/excel2json/lua_activity244_monster.lua

module("modules.configs.excel2json.lua_activity244_monster", package.seeall)

local lua_activity244_monster = {}
local fields = {
	id = 1,
	image = 5,
	template = 2,
	career = 7,
	skillTemplate = 3,
	icon = 4,
	mesh = 6,
	level = 8
}
local primaryKey = {
	"id"
}
local mlStringKey = {}

function lua_activity244_monster.onLoad(json)
	lua_activity244_monster.configList, lua_activity244_monster.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_activity244_monster
