-- chunkname: @modules/configs/excel2json/lua_investigate_reward.lua

module("modules.configs.excel2json.lua_investigate_reward", package.seeall)

local lua_investigate_reward = {}
local fields = {
	listenerParam = 4,
	minType = 2,
	listenerType = 3,
	desc = 6,
	bonus = 7,
	maxProgress = 5,
	jumpId = 8,
	taskId = 1
}
local primaryKey = {
	"taskId"
}
local mlStringKey = {
	desc = 2,
	minType = 1
}
local _configList, _configDict
local configPath = "configs.investigate_reward_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_investigate_reward, "configList", _configList)
	rawset(lua_investigate_reward, "configDict", _configDict)
end

setmetatable(lua_investigate_reward, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_investigate_reward.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_investigate_reward, "configList", nil)
	rawset(lua_investigate_reward, "configDict", nil)
end

return lua_investigate_reward
