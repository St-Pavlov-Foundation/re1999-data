-- chunkname: @modules/configs/excel2json/lua_activity246_reward.lua

module("modules.configs.excel2json.lua_activity246_reward", package.seeall)

local lua_activity246_reward = {}
local fields = {
	reward = 2,
	type = 4,
	rewardId = 1,
	rewardicon = 5,
	area = 3
}
local primaryKey = {
	"rewardId"
}
local mlStringKey = {}
local _configList, _configDict
local configPath = "configs.activity246_reward_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_activity246_reward, "configList", _configList)
	rawset(lua_activity246_reward, "configDict", _configDict)
end

setmetatable(lua_activity246_reward, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_activity246_reward.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_activity246_reward, "configList", nil)
	rawset(lua_activity246_reward, "configDict", nil)
end

return lua_activity246_reward
