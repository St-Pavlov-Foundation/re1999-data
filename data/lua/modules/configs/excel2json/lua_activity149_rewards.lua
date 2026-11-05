-- chunkname: @modules/configs/excel2json/lua_activity149_rewards.lua

module("modules.configs.excel2json.lua_activity149_rewards", package.seeall)

local lua_activity149_rewards = {}
local fields = {
	id = 1,
	reward = 4,
	activityId = 2,
	rewardPointNum = 3
}
local primaryKey = {
	"id"
}
local mlStringKey = {}
local _configList, _configDict
local configPath = "configs.activity149_rewards_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_activity149_rewards, "configList", _configList)
	rawset(lua_activity149_rewards, "configDict", _configDict)
end

setmetatable(lua_activity149_rewards, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_activity149_rewards.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_activity149_rewards, "configList", nil)
	rawset(lua_activity149_rewards, "configDict", nil)
end

return lua_activity149_rewards
