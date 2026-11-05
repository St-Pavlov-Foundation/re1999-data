-- chunkname: @modules/configs/excel2json/lua_activity244_challenge_reward.lua

module("modules.configs.excel2json.lua_activity244_challenge_reward", package.seeall)

local lua_activity244_challenge_reward = {}
local fields = {
	id = 2,
	score = 3,
	activityId = 1,
	rewardId = 4
}
local primaryKey = {
	"activityId",
	"id"
}
local mlStringKey = {}
local _configList, _configDict
local configPath = "configs.activity244_challenge_reward_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_activity244_challenge_reward, "configList", _configList)
	rawset(lua_activity244_challenge_reward, "configDict", _configDict)
end

setmetatable(lua_activity244_challenge_reward, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_activity244_challenge_reward.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_activity244_challenge_reward, "configList", nil)
	rawset(lua_activity244_challenge_reward, "configDict", nil)
end

return lua_activity244_challenge_reward
