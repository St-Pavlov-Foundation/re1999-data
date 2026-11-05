-- chunkname: @modules/configs/excel2json/lua_trad_episode.lua

module("modules.configs.excel2json.lua_trad_episode", package.seeall)

local lua_trad_episode = {}
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
local configPath = "configs.trad_episode_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_trad_episode, "configList", _configList)
	rawset(lua_trad_episode, "configDict", _configDict)
end

setmetatable(lua_trad_episode, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_trad_episode.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_trad_episode, "configList", nil)
	rawset(lua_trad_episode, "configDict", nil)
end

return lua_trad_episode
