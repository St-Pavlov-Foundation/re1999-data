-- chunkname: @modules/configs/excel2json/lua_fight_replace_skill_behavior_effect.lua

module("modules.configs.excel2json.lua_fight_replace_skill_behavior_effect", package.seeall)

local lua_fight_replace_skill_behavior_effect = {}
local fields = {
	audioId = 5,
	effect = 3,
	id = 1,
	skillBehaviorId = 2,
	effectHangPoint = 4
}
local primaryKey = {
	"id",
	"skillBehaviorId"
}
local mlStringKey = {}
local _configList, _configDict
local configPath = "configs.fight_replace_skill_behavior_effect_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_fight_replace_skill_behavior_effect, "configList", _configList)
	rawset(lua_fight_replace_skill_behavior_effect, "configDict", _configDict)
end

setmetatable(lua_fight_replace_skill_behavior_effect, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_fight_replace_skill_behavior_effect.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_fight_replace_skill_behavior_effect, "configList", nil)
	rawset(lua_fight_replace_skill_behavior_effect, "configDict", nil)
end

return lua_fight_replace_skill_behavior_effect
