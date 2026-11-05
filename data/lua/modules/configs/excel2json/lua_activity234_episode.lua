-- chunkname: @modules/configs/excel2json/lua_activity234_episode.lua

module("modules.configs.excel2json.lua_activity234_episode", package.seeall)

local lua_activity234_episode = {}
local fields = {
	id = 1,
	layout = 2,
	name = 4,
	lineCount = 3
}
local primaryKey = {
	"id"
}
local mlStringKey = {
	name = 1
}
local _configList, _configDict
local configPath = "configs.activity234_episode_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_activity234_episode, "configList", _configList)
	rawset(lua_activity234_episode, "configDict", _configDict)
end

setmetatable(lua_activity234_episode, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_activity234_episode.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_activity234_episode, "configList", nil)
	rawset(lua_activity234_episode, "configDict", nil)
end

return lua_activity234_episode
