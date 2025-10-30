-- chunkname: @modules/configs/excel2json/lua_rouge2_passive_skill.lua

module("modules.configs.excel2json.lua_rouge2_passive_skill", package.seeall)

local lua_rouge2_passive_skill = {}
local fields = {
	isSpecial = 10,
	name = 3,
	effectDesc = 5,
	levelUpDesc = 6,
	attribute = 9,
	imLevelUpDesc = 7,
	desc = 4,
	id = 1,
	icon = 8,
	level = 2
}
local primaryKey = {
	"id",
	"level"
}
local mlStringKey = {
	effectDesc = 3,
	name = 1,
	levelUpDesc = 4,
	imLevelUpDesc = 5,
	desc = 2
}

function lua_rouge2_passive_skill.onLoad(json)
	lua_rouge2_passive_skill.configList, lua_rouge2_passive_skill.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_rouge2_passive_skill
