-- chunkname: @modules/configs/excel2json/lua_arcade_passive_skill.lua

module("modules.configs.excel2json.lua_arcade_passive_skill", package.seeall)

local lua_arcade_passive_skill = {}
local fields = {
	condition1 = 4,
	effect5 = 30,
	condition2 = 10,
	triggerPoint5 = 29,
	skillDesc = 2,
	triggerPoint2 = 11,
	atkEffectId1 = 7,
	limit3 = 21,
	effectId3 = 20,
	effectId4 = 26,
	condition3 = 16,
	effectId1 = 8,
	condition5 = 28,
	limit2 = 15,
	effect2 = 12,
	triggerPoint3 = 17,
	triggerPoint4 = 23,
	limit5 = 33,
	atkEffectId2 = 13,
	triggerOrder = 3,
	atkEffectId4 = 25,
	limit1 = 9,
	id = 1,
	effect1 = 6,
	effectId5 = 32,
	effect3 = 18,
	limit4 = 27,
	atkEffectId3 = 19,
	effect4 = 24,
	effectId2 = 14,
	atkEffectId5 = 31,
	condition4 = 22,
	triggerPoint1 = 5
}
local primaryKey = {
	"id"
}
local mlStringKey = {
	skillDesc = 1
}
local _configList, _configDict
local configPath = "configs.arcade_passive_skill_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_arcade_passive_skill, "configList", _configList)
	rawset(lua_arcade_passive_skill, "configDict", _configDict)
end

setmetatable(lua_arcade_passive_skill, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_arcade_passive_skill.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_arcade_passive_skill, "configList", nil)
	rawset(lua_arcade_passive_skill, "configDict", nil)
end

return lua_arcade_passive_skill
