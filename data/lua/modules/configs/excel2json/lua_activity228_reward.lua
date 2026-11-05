-- chunkname: @modules/configs/excel2json/lua_activity228_reward.lua

module("modules.configs.excel2json.lua_activity228_reward", package.seeall)

local lua_activity228_reward = {}
local fields = {
	reward = 2,
	important = 3,
	rewardId = 1
}
local primaryKey = {
	"rewardId"
}
local mlStringKey = {}
local _configList, _configDict
local configPath = "configs.activity228_reward_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_activity228_reward, "configList", _configList)
	rawset(lua_activity228_reward, "configDict", _configDict)
end

setmetatable(lua_activity228_reward, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_activity228_reward.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_activity228_reward, "configList", nil)
	rawset(lua_activity228_reward, "configDict", nil)
end

return lua_activity228_reward
