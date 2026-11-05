-- chunkname: @modules/configs/excel2json/lua_rouge_map_rule.lua

module("modules.configs.excel2json.lua_rouge_map_rule", package.seeall)

local lua_rouge_map_rule = {}
local fields = {
	group = 3,
	id = 1,
	type = 2,
	addCollection = 4,
	desc = 5
}
local primaryKey = {
	"id"
}
local mlStringKey = {
	desc = 1
}
local _configList, _configDict
local configPath = "configs.rouge_map_rule_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_rouge_map_rule, "configList", _configList)
	rawset(lua_rouge_map_rule, "configDict", _configDict)
end

setmetatable(lua_rouge_map_rule, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_rouge_map_rule.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_rouge_map_rule, "configList", nil)
	rawset(lua_rouge_map_rule, "configDict", nil)
end

return lua_rouge_map_rule
