-- chunkname: @modules/configs/excel2json/lua_monster_skill_template.lua

module("modules.configs.excel2json.lua_monster_skill_template", package.seeall)

local lua_monster_skill_template = {}
local fields = {
	uniqueSkill_point = 14,
	name = 2,
	gender = 7,
	career = 8,
	uniqueSkill = 13,
	skin = 15,
	nameEng = 3,
	baseStress = 20,
	race = 23,
	camp = 19,
	dmgType = 10,
	identity = 22,
	career_weak = 9,
	activeSkill = 12,
	powerMax = 17,
	des = 4,
	passiveSkill = 11,
	instance = 6,
	property = 18,
	resistance = 16,
	template = 5,
	id = 1,
	maxStress = 21
}
local primaryKey = {
	"id"
}
local mlStringKey = {
	property = 3,
	name = 1,
	des = 2
}
local _configList, _configDict
local configPath = "configs.monster_skill_template_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_monster_skill_template, "configList", _configList)
	rawset(lua_monster_skill_template, "configDict", _configDict)
end

setmetatable(lua_monster_skill_template, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_monster_skill_template.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_monster_skill_template, "configList", nil)
	rawset(lua_monster_skill_template, "configDict", nil)
end

return lua_monster_skill_template
