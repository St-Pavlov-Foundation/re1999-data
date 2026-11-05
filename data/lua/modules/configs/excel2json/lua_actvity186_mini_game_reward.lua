-- chunkname: @modules/configs/excel2json/lua_actvity186_mini_game_reward.lua

module("modules.configs.excel2json.lua_actvity186_mini_game_reward", package.seeall)

local lua_actvity186_mini_game_reward = {}
local fields = {
	rewardId = 2,
	blessingdes = 6,
	type = 1,
	blessingtitle = 5,
	prob = 3,
	bonus = 4
}
local primaryKey = {
	"type",
	"rewardId"
}
local mlStringKey = {
	blessingtitle = 1,
	blessingdes = 2
}
local _configList, _configDict
local configPath = "configs.actvity186_mini_game_reward_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_actvity186_mini_game_reward, "configList", _configList)
	rawset(lua_actvity186_mini_game_reward, "configDict", _configDict)
end

setmetatable(lua_actvity186_mini_game_reward, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_actvity186_mini_game_reward.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_actvity186_mini_game_reward, "configList", nil)
	rawset(lua_actvity186_mini_game_reward, "configDict", nil)
end

return lua_actvity186_mini_game_reward
