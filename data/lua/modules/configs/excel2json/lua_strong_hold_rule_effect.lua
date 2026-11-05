-- chunkname: @modules/configs/excel2json/lua_strong_hold_rule_effect.lua

module("modules.configs.excel2json.lua_strong_hold_rule_effect", package.seeall)

local lua_strong_hold_rule_effect = {}
local fields = {
	effectName = 2,
	effectParams = 3,
	id = 1
}
local primaryKey = {
	"id"
}
local mlStringKey = {}
local _configList, _configDict
local configPath = "configs.strong_hold_rule_effect_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_strong_hold_rule_effect, "configList", _configList)
	rawset(lua_strong_hold_rule_effect, "configDict", _configDict)
end

setmetatable(lua_strong_hold_rule_effect, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_strong_hold_rule_effect.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_strong_hold_rule_effect, "configList", nil)
	rawset(lua_strong_hold_rule_effect, "configDict", nil)
end

return lua_strong_hold_rule_effect
