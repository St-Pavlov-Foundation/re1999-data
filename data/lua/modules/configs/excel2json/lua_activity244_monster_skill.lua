-- chunkname: @modules/configs/excel2json/lua_activity244_monster_skill.lua

module("modules.configs.excel2json.lua_activity244_monster_skill", package.seeall)

local lua_activity244_monster_skill = {}
local fields = {
	effect1 = 11,
	skillText = 6,
	name = 4,
	target1 = 10,
	effect3 = 17,
	desc = 7,
	target4 = 19,
	condition3 = 15,
	effect4 = 20,
	skillId = 1,
	condition2 = 12,
	effect2 = 14,
	target2 = 13,
	skillCD = 8,
	skillType = 2,
	target3 = 16,
	condition4 = 18,
	skillTag = 3,
	condition1 = 9,
	skillTextType = 5
}
local primaryKey = {
	"skillId"
}
local mlStringKey = {
	skillText = 3,
	name = 2,
	skillTag = 1,
	desc = 4
}
local _configList, _configDict
local configPath = "configs.activity244_monster_skill_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_activity244_monster_skill, "configList", _configList)
	rawset(lua_activity244_monster_skill, "configDict", _configDict)
end

setmetatable(lua_activity244_monster_skill, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_activity244_monster_skill.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_activity244_monster_skill, "configList", nil)
	rawset(lua_activity244_monster_skill, "configDict", nil)
end

return lua_activity244_monster_skill
