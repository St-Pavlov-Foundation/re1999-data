-- chunkname: @modules/configs/excel2json/lua_eliminate_reward.lua

module("modules.configs.excel2json.lua_eliminate_reward", package.seeall)

local lua_eliminate_reward = {}
local fields = {
	jumpId = 5,
	star = 4,
	bonus = 6,
	id = 1,
	activityId = 2,
	desc = 3
}
local primaryKey = {
	"id"
}
local mlStringKey = {
	desc = 1
}
local _configList, _configDict
local configPath = "configs.eliminate_reward_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_eliminate_reward, "configList", _configList)
	rawset(lua_eliminate_reward, "configDict", _configDict)
end

setmetatable(lua_eliminate_reward, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_eliminate_reward.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_eliminate_reward, "configList", nil)
	rawset(lua_eliminate_reward, "configDict", nil)
end

return lua_eliminate_reward
