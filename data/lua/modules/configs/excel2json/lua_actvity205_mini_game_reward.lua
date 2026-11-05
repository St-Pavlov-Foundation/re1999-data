-- chunkname: @modules/configs/excel2json/lua_actvity205_mini_game_reward.lua

module("modules.configs.excel2json.lua_actvity205_mini_game_reward", package.seeall)

local lua_actvity205_mini_game_reward = {}
local fields = {
	isWin = 4,
	rewardId = 2,
	rewardDesc = 5,
	type = 1,
	bonus = 3
}
local primaryKey = {
	"type",
	"rewardId"
}
local mlStringKey = {
	rewardDesc = 1
}
local _configList, _configDict
local configPath = "configs.actvity205_mini_game_reward_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_actvity205_mini_game_reward, "configList", _configList)
	rawset(lua_actvity205_mini_game_reward, "configDict", _configDict)
end

setmetatable(lua_actvity205_mini_game_reward, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_actvity205_mini_game_reward.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_actvity205_mini_game_reward, "configList", nil)
	rawset(lua_actvity205_mini_game_reward, "configDict", nil)
end

return lua_actvity205_mini_game_reward
