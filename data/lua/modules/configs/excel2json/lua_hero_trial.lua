-- chunkname: @modules/configs/excel2json/lua_hero_trial.lua

module("modules.configs.excel2json.lua_hero_trial", package.seeall)

local lua_hero_trial = {}
local fields = {
	equipRefine = 11,
	act104EquipId2 = 13,
	facetsId = 15,
	skin = 4,
	equipId = 9,
	heroId = 3,
	act104EquipId1 = 12,
	exSkillLv = 7,
	level = 6,
	attrId = 14,
	facetslevel = 16,
	trialTemplate = 2,
	trialType = 5,
	talent = 8,
	special = 17,
	id = 1,
	equipLv = 10
}
local primaryKey = {
	"id",
	"trialTemplate"
}
local mlStringKey = {}
local _configList, _configDict
local configPath = "configs.hero_trial_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_hero_trial, "configList", _configList)
	rawset(lua_hero_trial, "configDict", _configDict)
end

setmetatable(lua_hero_trial, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_hero_trial.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_hero_trial, "configList", nil)
	rawset(lua_hero_trial, "configDict", nil)
end

return lua_hero_trial
