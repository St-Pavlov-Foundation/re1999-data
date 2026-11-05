-- chunkname: @modules/configs/excel2json/lua_stress_rule.lua

module("modules.configs.excel2json.lua_stress_rule", package.seeall)

local lua_stress_rule = {}
local fields = {
	param = 5,
	targetLimit = 4,
	type = 2,
	id = 1,
	isNoShow = 6,
	target = 3,
	desc = 7
}
local primaryKey = {
	"id"
}
local mlStringKey = {
	desc = 1
}
local _configList, _configDict
local configPath = "configs.stress_rule_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_stress_rule, "configList", _configList)
	rawset(lua_stress_rule, "configDict", _configDict)
end

setmetatable(lua_stress_rule, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_stress_rule.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_stress_rule, "configList", nil)
	rawset(lua_stress_rule, "configDict", nil)
end

return lua_stress_rule
