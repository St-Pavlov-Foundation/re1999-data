-- chunkname: @modules/configs/excel2json/lua_arcade_reward.lua

module("modules.configs.excel2json.lua_arcade_reward", package.seeall)

local lua_arcade_reward = {}
local fields = {
	reward = 3,
	score = 2,
	special = 4,
	id = 1,
	activityId = 5
}
local primaryKey = {
	"id"
}
local mlStringKey = {}
local _configList, _configDict
local configPath = "configs.arcade_reward_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_arcade_reward, "configList", _configList)
	rawset(lua_arcade_reward, "configDict", _configDict)
end

setmetatable(lua_arcade_reward, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_arcade_reward.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_arcade_reward, "configList", nil)
	rawset(lua_arcade_reward, "configDict", nil)
end

return lua_arcade_reward
