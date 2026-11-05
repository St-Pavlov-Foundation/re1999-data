-- chunkname: @modules/configs/excel2json/lua_rouge_reward.lua

module("modules.configs.excel2json.lua_rouge_reward", package.seeall)

local lua_rouge_reward = {}
local fields = {
	stage = 4,
	value = 6,
	preId = 3,
	type = 7,
	season = 1,
	offset = 11,
	pos = 5,
	rewardName = 9,
	rewardType = 10,
	id = 2,
	icon = 8
}
local primaryKey = {
	"season",
	"id"
}
local mlStringKey = {
	rewardName = 1
}
local _configList, _configDict
local configPath = "configs.rouge_reward_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_rouge_reward, "configList", _configList)
	rawset(lua_rouge_reward, "configDict", _configDict)
end

setmetatable(lua_rouge_reward, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_rouge_reward.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_rouge_reward, "configList", nil)
	rawset(lua_rouge_reward, "configDict", nil)
end

return lua_rouge_reward
