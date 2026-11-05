-- chunkname: @modules/configs/excel2json/lua_activity128_rewards.lua

module("modules.configs.excel2json.lua_activity128_rewards", package.seeall)

local lua_activity128_rewards = {}
local fields = {
	reward = 5,
	display = 6,
	rewardPointNum = 4,
	id = 2,
	stage = 3,
	activityId = 1
}
local primaryKey = {
	"activityId",
	"id"
}
local mlStringKey = {}
local _configList, _configDict
local configPath = "configs.activity128_rewards_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_activity128_rewards, "configList", _configList)
	rawset(lua_activity128_rewards, "configDict", _configDict)
end

setmetatable(lua_activity128_rewards, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_activity128_rewards.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_activity128_rewards, "configList", nil)
	rawset(lua_activity128_rewards, "configDict", nil)
end

return lua_activity128_rewards
