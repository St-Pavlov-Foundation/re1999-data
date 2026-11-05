-- chunkname: @modules/configs/excel2json/lua_rouge_last_reward.lua

module("modules.configs.excel2json.lua_rouge_last_reward", package.seeall)

local lua_rouge_last_reward = {}
local fields = {
	id = 2,
	title = 5,
	iconName = 7,
	type = 4,
	season = 1,
	version = 3,
	desc = 6
}
local primaryKey = {
	"season",
	"id"
}
local mlStringKey = {
	desc = 2,
	title = 1
}
local _configList, _configDict
local configPath = "configs.rouge_last_reward_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_rouge_last_reward, "configList", _configList)
	rawset(lua_rouge_last_reward, "configDict", _configDict)
end

setmetatable(lua_rouge_last_reward, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_rouge_last_reward.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_rouge_last_reward, "configList", nil)
	rawset(lua_rouge_last_reward, "configDict", nil)
end

return lua_rouge_last_reward
