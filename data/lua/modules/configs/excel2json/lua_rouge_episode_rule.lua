-- chunkname: @modules/configs/excel2json/lua_rouge_episode_rule.lua

module("modules.configs.excel2json.lua_rouge_episode_rule", package.seeall)

local lua_rouge_episode_rule = {}
local fields = {
	version = 1
}
local primaryKey = {}
local mlStringKey = {}
local _configList, _configDict
local configPath = "configs.rouge_episode_rule_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_rouge_episode_rule, "configList", _configList)
	rawset(lua_rouge_episode_rule, "configDict", _configDict)
end

setmetatable(lua_rouge_episode_rule, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_rouge_episode_rule.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_rouge_episode_rule, "configList", nil)
	rawset(lua_rouge_episode_rule, "configDict", nil)
end

return lua_rouge_episode_rule
