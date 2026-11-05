-- chunkname: @modules/configs/excel2json/lua_activity161_reward.lua

module("modules.configs.excel2json.lua_activity161_reward", package.seeall)

local lua_activity161_reward = {}
local fields = {
	rewardId = 3,
	bonus = 4,
	activityId = 1,
	paintedNum = 2
}
local primaryKey = {
	"activityId",
	"paintedNum"
}
local mlStringKey = {}
local _configList, _configDict
local configPath = "configs.activity161_reward_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_activity161_reward, "configList", _configList)
	rawset(lua_activity161_reward, "configDict", _configDict)
end

setmetatable(lua_activity161_reward, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_activity161_reward.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_activity161_reward, "configList", nil)
	rawset(lua_activity161_reward, "configDict", nil)
end

return lua_activity161_reward
