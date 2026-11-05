-- chunkname: @modules/configs/excel2json/lua_assassin_career_skill_mapping.lua

module("modules.configs.excel2json.lua_assassin_career_skill_mapping", package.seeall)

local lua_assassin_career_skill_mapping = {}
local fields = {
	targetCheck = 11,
	name = 4,
	prerequisite = 14,
	type = 8,
	addSkill = 7,
	targetEff = 13,
	id = 1,
	desc = 6,
	range = 10,
	icon = 5,
	cost = 9,
	effect = 16,
	timesLimit = 18,
	roundLimit = 17,
	target = 12,
	assassinHeroId = 3,
	careerId = 2,
	triggerNode = 15
}
local primaryKey = {
	"id"
}
local mlStringKey = {
	desc = 2,
	name = 1
}
local _configList, _configDict
local configPath = "configs.assassin_career_skill_mapping_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_assassin_career_skill_mapping, "configList", _configList)
	rawset(lua_assassin_career_skill_mapping, "configDict", _configDict)
end

setmetatable(lua_assassin_career_skill_mapping, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_assassin_career_skill_mapping.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_assassin_career_skill_mapping, "configList", nil)
	rawset(lua_assassin_career_skill_mapping, "configDict", nil)
end

return lua_assassin_career_skill_mapping
