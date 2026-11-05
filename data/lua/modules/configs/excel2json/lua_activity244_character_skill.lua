-- chunkname: @modules/configs/excel2json/lua_activity244_character_skill.lua

module("modules.configs.excel2json.lua_activity244_character_skill", package.seeall)

local lua_activity244_character_skill = {}
local fields = {
	effect1 = 16,
	name = 3,
	skillText = 5,
	target1 = 15,
	effectPos = 9,
	rangesize = 8,
	condition3 = 20,
	desc = 6,
	effect3 = 22,
	condition4 = 23,
	target4 = 24,
	skillId = 1,
	effect4 = 25,
	condition2 = 17,
	effect2 = 19,
	initialEnergy = 12,
	target2 = 18,
	rangeType = 7,
	skillType = 2,
	target3 = 21,
	energyCost = 13,
	effectType = 11,
	skillTag = 10,
	condition1 = 14,
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
local _configList, _configDict
local configPath = "configs.activity244_character_skill_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_activity244_character_skill, "configList", _configList)
	rawset(lua_activity244_character_skill, "configDict", _configDict)
end

setmetatable(lua_activity244_character_skill, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_activity244_character_skill.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_activity244_character_skill, "configList", nil)
	rawset(lua_activity244_character_skill, "configDict", nil)
end

return lua_activity244_character_skill
