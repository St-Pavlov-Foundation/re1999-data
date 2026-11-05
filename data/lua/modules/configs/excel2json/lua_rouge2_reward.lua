-- chunkname: @modules/configs/excel2json/lua_rouge2_reward.lua

module("modules.configs.excel2json.lua_rouge2_reward", package.seeall)

local lua_rouge2_reward = {}
local fields = {
	group = 6,
	rewardPriority = 9,
	value = 3,
	num = 5,
	maxBuyCount = 4,
	rewardImage = 8,
	id = 1,
	stage = 2,
	rewardScore = 7
}
local primaryKey = {
	"id"
}
local mlStringKey = {}
local _configList, _configDict
local configPath = "configs.rouge2_reward_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_rouge2_reward, "configList", _configList)
	rawset(lua_rouge2_reward, "configDict", _configDict)
end

setmetatable(lua_rouge2_reward, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_rouge2_reward.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_rouge2_reward, "configList", nil)
	rawset(lua_rouge2_reward, "configDict", nil)
end

return lua_rouge2_reward
