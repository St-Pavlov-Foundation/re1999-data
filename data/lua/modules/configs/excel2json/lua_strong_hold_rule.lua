-- chunkname: @modules/configs/excel2json/lua_strong_hold_rule.lua

module("modules.configs.excel2json.lua_strong_hold_rule", package.seeall)

local lua_strong_hold_rule = {}
local fields = {
	skillIds = 6,
	id = 1,
	fixValue = 4,
	desc = 2,
	prohibitSkillTags = 5,
	fixType = 3,
	addSkillIds = 7,
	effectIds = 8,
	putLimit = 9,
	startEffectRound = 10,
	endEffectRound = 11
}
local primaryKey = {
	"id"
}
local mlStringKey = {
	desc = 1
}
local _configList, _configDict
local configPath = "configs.strong_hold_rule_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_strong_hold_rule, "configList", _configList)
	rawset(lua_strong_hold_rule, "configDict", _configDict)
end

setmetatable(lua_strong_hold_rule, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_strong_hold_rule.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_strong_hold_rule, "configList", nil)
	rawset(lua_strong_hold_rule, "configDict", nil)
end

return lua_strong_hold_rule
