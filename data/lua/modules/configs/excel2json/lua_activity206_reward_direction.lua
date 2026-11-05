-- chunkname: @modules/configs/excel2json/lua_activity206_reward_direction.lua

module("modules.configs.excel2json.lua_activity206_reward_direction", package.seeall)

local lua_activity206_reward_direction = {}
local fields = {
	activityId = 1,
	name = 9,
	guaranteeCount = 6,
	pic = 10,
	nextDayDecRate = 4,
	haveGuarantee = 5,
	rewardGroupId = 7,
	baseRate = 3,
	directionId = 2,
	des = 8
}
local primaryKey = {
	"activityId",
	"directionId"
}
local mlStringKey = {
	name = 2,
	des = 1
}
local _configList, _configDict
local configPath = "configs.activity206_reward_direction_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_activity206_reward_direction, "configList", _configList)
	rawset(lua_activity206_reward_direction, "configDict", _configDict)
end

setmetatable(lua_activity206_reward_direction, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_activity206_reward_direction.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_activity206_reward_direction, "configList", nil)
	rawset(lua_activity206_reward_direction, "configDict", nil)
end

return lua_activity206_reward_direction
