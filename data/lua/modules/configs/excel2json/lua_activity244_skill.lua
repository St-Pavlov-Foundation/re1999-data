-- chunkname: @modules/configs/excel2json/lua_activity244_skill.lua

module("modules.configs.excel2json.lua_activity244_skill", package.seeall)

local lua_activity244_skill = {}
local fields = {
	effect1 = 9,
	name = 3,
	targrt1 = 8,
	condition3 = 13,
	effect3 = 15,
	effectType = 5,
	effect4 = 18,
	desc = 4,
	skillId = 1,
	condition2 = 10,
	effect2 = 12,
	targrt3 = 14,
	targrt4 = 17,
	skillType = 2,
	targrt2 = 11,
	energyCost = 6,
	condition4 = 16,
	condition1 = 7
}
local primaryKey = {
	"skillId"
}
local mlStringKey = {
	desc = 2,
	name = 1
}
local _configList, _configDict
local configPath = "configs.activity244_skill_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_activity244_skill, "configList", _configList)
	rawset(lua_activity244_skill, "configDict", _configDict)
end

setmetatable(lua_activity244_skill, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_activity244_skill.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_activity244_skill, "configList", nil)
	rawset(lua_activity244_skill, "configDict", nil)
end

return lua_activity244_skill
