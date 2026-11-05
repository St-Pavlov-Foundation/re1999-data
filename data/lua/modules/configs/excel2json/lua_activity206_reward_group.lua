-- chunkname: @modules/configs/excel2json/lua_activity206_reward_group.lua

module("modules.configs.excel2json.lua_activity206_reward_group", package.seeall)

local lua_activity206_reward_group = {}
local fields = {
	groupId = 1,
	rewardId2Prob = 2
}
local primaryKey = {
	"groupId"
}
local mlStringKey = {}
local _configList, _configDict
local configPath = "configs.activity206_reward_group_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_activity206_reward_group, "configList", _configList)
	rawset(lua_activity206_reward_group, "configDict", _configDict)
end

setmetatable(lua_activity206_reward_group, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_activity206_reward_group.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_activity206_reward_group, "configList", nil)
	rawset(lua_activity206_reward_group, "configDict", nil)
end

return lua_activity206_reward_group
