-- chunkname: @modules/configs/excel2json/lua_hero_trial_attr.lua

module("modules.configs.excel2json.lua_hero_trial_attr", package.seeall)

local lua_hero_trial_attr = {}
local fields = {
	defense = 9,
	name = 2,
	technic = 11,
	dropDmg = 17,
	uniqueSkill = 5,
	activeSkill = 3,
	addDmg = 16,
	criDmg = 14,
	attack = 8,
	criDef = 15,
	passiveSkill = 4,
	cri = 12,
	mdefense = 10,
	recri = 13,
	noShowExSkill = 6,
	life = 7,
	id = 1
}
local primaryKey = {
	"id"
}
local mlStringKey = {
	name = 1
}
local _configList, _configDict
local configPath = "configs.hero_trial_attr_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_hero_trial_attr, "configList", _configList)
	rawset(lua_hero_trial_attr, "configDict", _configDict)
end

setmetatable(lua_hero_trial_attr, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_hero_trial_attr.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_hero_trial_attr, "configList", nil)
	rawset(lua_hero_trial_attr, "configDict", nil)
end

return lua_hero_trial_attr
