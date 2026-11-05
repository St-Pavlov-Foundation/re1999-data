-- chunkname: @modules/configs/excel2json/lua_activity206_reward.lua

module("modules.configs.excel2json.lua_activity206_reward", package.seeall)

local lua_activity206_reward = {}
local fields = {
	reward = 2,
	rewardId = 1,
	title = 4,
	pic = 5,
	des = 3
}
local primaryKey = {
	"rewardId"
}
local mlStringKey = {
	title = 2,
	des = 1
}
local _configList, _configDict
local configPath = "configs.activity206_reward_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_activity206_reward, "configList", _configList)
	rawset(lua_activity206_reward, "configDict", _configDict)
end

setmetatable(lua_activity206_reward, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_activity206_reward.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_activity206_reward, "configList", nil)
	rawset(lua_activity206_reward, "configDict", nil)
end

return lua_activity206_reward
