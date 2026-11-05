-- chunkname: @modules/configs/excel2json/lua_character_skill.lua

module("modules.configs.excel2json.lua_character_skill", package.seeall)

local lua_character_skill = {}
local fields = {
	triggerPoint = 8,
	name = 2,
	cost = 7,
	condition = 9,
	effect = 10,
	roundTriggerCountLimit = 11,
	skillPrompt = 4,
	desc = 3,
	totalTriggerCountLimit = 12,
	id = 1,
	icon = 5,
	active = 6
}
local primaryKey = {
	"id"
}
local mlStringKey = {
	name = 1,
	skillPrompt = 3,
	desc = 2
}
local _configList, _configDict
local configPath = "configs.character_skill_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_character_skill, "configList", _configList)
	rawset(lua_character_skill, "configDict", _configDict)
end

setmetatable(lua_character_skill, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_character_skill.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_character_skill, "configList", nil)
	rawset(lua_character_skill, "configDict", nil)
end

return lua_character_skill
