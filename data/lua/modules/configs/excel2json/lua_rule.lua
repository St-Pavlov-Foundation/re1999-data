-- chunkname: @modules/configs/excel2json/lua_rule.lua

module("modules.configs.excel2json.lua_rule", package.seeall)

local lua_rule = {}
local fields = {
	effect = 7,
	name = 5,
	type = 2,
	id = 1,
	icon = 3,
	iconTag = 4,
	desc = 6
}
local primaryKey = {
	"id"
}
local mlStringKey = {
	desc = 2,
	name = 1
}
local _configList, _configDict
local configPath = "configs.rule_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_rule, "configList", _configList)
	rawset(lua_rule, "configDict", _configDict)
end

setmetatable(lua_rule, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_rule.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_rule, "configList", nil)
	rawset(lua_rule, "configDict", nil)
end

return lua_rule
