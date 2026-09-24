-- chunkname: @modules/configs/excel2json/lua_activity244_character_skill.lua

module("modules.configs.excel2json.lua_activity244_character_skill", package.seeall)

local lua_activity244_character_skill = {}
local fields = {
	effect1 = 12,
	skillText = 5,
	name = 3,
	target1 = 11,
	effect3 = 18,
	desc = 6,
	condition4 = 19,
	condition3 = 16,
	target4 = 20,
	effect4 = 21,
	skillId = 1,
	condition2 = 13,
	effect2 = 15,
	target2 = 14,
	skillType = 2,
	target3 = 17,
	energyCost = 9,
	effectType = 8,
	skillTag = 7,
	condition1 = 10,
	skillTextType = 4
}
local primaryKey = {
	"skillId"
}
local mlStringKey = {
	skillText = 2,
	name = 1,
	skillTag = 4,
	desc = 3
}

function lua_activity244_character_skill.onLoad(json)
	lua_activity244_character_skill.configList, lua_activity244_character_skill.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_activity244_character_skill
