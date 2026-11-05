-- chunkname: @modules/configs/excel2json/lua_activity108_rule.lua

module("modules.configs.excel2json.lua_activity108_rule", package.seeall)

local lua_activity108_rule = {}
local fields = {
	rules = 2,
	id = 1,
	threat = 3
}
local primaryKey = {
	"id"
}
local mlStringKey = {}
local _configList, _configDict
local configPath = "configs.activity108_rule_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_activity108_rule, "configList", _configList)
	rawset(lua_activity108_rule, "configDict", _configDict)
end

setmetatable(lua_activity108_rule, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_activity108_rule.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_activity108_rule, "configList", nil)
	rawset(lua_activity108_rule, "configDict", nil)
end

return lua_activity108_rule
