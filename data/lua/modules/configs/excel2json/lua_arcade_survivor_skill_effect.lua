-- chunkname: @modules/configs/excel2json/lua_arcade_survivor_skill_effect.lua

module("modules.configs.excel2json.lua_arcade_survivor_skill_effect", package.seeall)

local lua_arcade_survivor_skill_effect = {}
local fields = {
	triggerPoint = 3,
	triggerShowId = 13,
	conditionParam = 6,
	type = 9,
	param = 10,
	target = 11,
	condition = 5,
	triggerRate = 8,
	triggerParam = 4,
	subEffect = 2,
	levelMaxTriggerCount = 7,
	casterShowId = 12,
	id = 1,
	targetShowId = 14
}
local primaryKey = {
	"id"
}
local mlStringKey = {}
local _configList, _configDict
local configPath = "configs.arcade_survivor_skill_effect_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_arcade_survivor_skill_effect, "configList", _configList)
	rawset(lua_arcade_survivor_skill_effect, "configDict", _configDict)
end

setmetatable(lua_arcade_survivor_skill_effect, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_arcade_survivor_skill_effect.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_arcade_survivor_skill_effect, "configList", nil)
	rawset(lua_arcade_survivor_skill_effect, "configDict", nil)
end

return lua_arcade_survivor_skill_effect
