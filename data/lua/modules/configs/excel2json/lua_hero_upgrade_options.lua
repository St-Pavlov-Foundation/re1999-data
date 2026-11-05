-- chunkname: @modules/configs/excel2json/lua_hero_upgrade_options.lua

module("modules.configs.excel2json.lua_hero_upgrade_options", package.seeall)

local lua_hero_upgrade_options = {}
local fields = {
	unlockCondition = 2,
	addBuff = 11,
	replaceBigSkill = 8,
	replaceSkillGroup1 = 6,
	delBuff = 12,
	title = 3,
	desc = 4,
	replaceSkillGroup2 = 7,
	id = 1,
	addPassiveSkill = 10,
	showSkillId = 5,
	replacePassiveSkill = 9
}
local primaryKey = {
	"id"
}
local mlStringKey = {
	desc = 2,
	title = 1
}
local _configList, _configDict
local configPath = "configs.hero_upgrade_options_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_hero_upgrade_options, "configList", _configList)
	rawset(lua_hero_upgrade_options, "configDict", _configDict)
end

setmetatable(lua_hero_upgrade_options, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_hero_upgrade_options.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_hero_upgrade_options, "configList", nil)
	rawset(lua_hero_upgrade_options, "configDict", nil)
end

return lua_hero_upgrade_options
