-- chunkname: @modules/configs/excel2json/lua_auto_chess_lose_streak_reward.lua

module("modules.configs.excel2json.lua_auto_chess_lose_streak_reward", package.seeall)

local lua_auto_chess_lose_streak_reward = {}
local fields = {
	levelId = 2,
	loseStreak = 3,
	activityId = 1,
	bonusCoin = 4
}
local primaryKey = {
	"activityId",
	"levelId"
}
local mlStringKey = {}
local _configList, _configDict
local configPath = "configs.auto_chess_lose_streak_reward_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_auto_chess_lose_streak_reward, "configList", _configList)
	rawset(lua_auto_chess_lose_streak_reward, "configDict", _configDict)
end

setmetatable(lua_auto_chess_lose_streak_reward, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_auto_chess_lose_streak_reward.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_auto_chess_lose_streak_reward, "configList", nil)
	rawset(lua_auto_chess_lose_streak_reward, "configDict", nil)
end

return lua_auto_chess_lose_streak_reward
