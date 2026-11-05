-- chunkname: @modules/configs/excel2json/lua_push_box_episode.lua

module("modules.configs.excel2json.lua_push_box_episode", package.seeall)

local lua_push_box_episode = {}
local fields = {
	fan_duration = 8,
	name = 2,
	enemy_alarm = 7,
	layout = 3,
	light_alarm = 9,
	enemy_act = 6,
	id = 1,
	wall = 4,
	step = 5
}
local primaryKey = {
	"id"
}
local mlStringKey = {
	name = 1
}
local _configList, _configDict
local configPath = "configs.push_box_episode_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_push_box_episode, "configList", _configList)
	rawset(lua_push_box_episode, "configDict", _configDict)
end

setmetatable(lua_push_box_episode, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_push_box_episode.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_push_box_episode, "configList", nil)
	rawset(lua_push_box_episode, "configDict", nil)
end

return lua_push_box_episode
