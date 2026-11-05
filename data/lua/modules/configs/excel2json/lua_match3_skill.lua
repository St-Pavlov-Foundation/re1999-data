-- chunkname: @modules/configs/excel2json/lua_match3_skill.lua

module("modules.configs.excel2json.lua_match3_skill", package.seeall)

local lua_match3_skill = {}
local fields = {
	energyCost = 4,
	name = 3,
	triggerType = 5,
	skillId = 1,
	desc = 7,
	skillType = 2,
	effectGroupId = 6
}
local primaryKey = {
	"skillId"
}
local mlStringKey = {
	desc = 2,
	name = 1
}
local _configList, _configDict
local configPath = "configs.match3_skill_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_match3_skill, "configList", _configList)
	rawset(lua_match3_skill, "configDict", _configDict)
end

setmetatable(lua_match3_skill, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_match3_skill.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_match3_skill, "configList", nil)
	rawset(lua_match3_skill, "configDict", nil)
end

return lua_match3_skill
