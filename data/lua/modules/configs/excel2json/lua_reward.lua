-- chunkname: @modules/configs/excel2json/lua_reward.lua

module("modules.configs.excel2json.lua_reward", package.seeall)

local lua_reward = {}
local fields = {
	reward_id = 1,
	rewardGroup1 = 4,
	dailyDrop = 2,
	rewardGroup2 = 5,
	rewardGroup3 = 6,
	rewardGroup4 = 7,
	dailyGainWarning = 3,
	rewardGroup5 = 8,
	rewardGroup6 = 9,
	rewardGroup7 = 10,
	rewardGroup8 = 11
}
local primaryKey = {
	"reward_id"
}
local mlStringKey = {}
local _configList, _configDict
local configPath = "configs.reward_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_reward, "configList", _configList)
	rawset(lua_reward, "configDict", _configDict)
end

setmetatable(lua_reward, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_reward.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_reward, "configList", nil)
	rawset(lua_reward, "configDict", nil)
end

return lua_reward
