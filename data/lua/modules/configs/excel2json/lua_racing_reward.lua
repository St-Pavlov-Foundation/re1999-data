-- chunkname: @modules/configs/excel2json/lua_racing_reward.lua

module("modules.configs.excel2json.lua_racing_reward", package.seeall)

local lua_racing_reward = {}
local fields = {
	bonus = 3,
	star = 2,
	episodeId = 1
}
local primaryKey = {
	"episodeId",
	"star"
}
local mlStringKey = {}
local _configList, _configDict
local configPath = "configs.racing_reward_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_racing_reward, "configList", _configList)
	rawset(lua_racing_reward, "configDict", _configDict)
end

setmetatable(lua_racing_reward, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_racing_reward.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_racing_reward, "configList", nil)
	rawset(lua_racing_reward, "configDict", nil)
end

return lua_racing_reward
