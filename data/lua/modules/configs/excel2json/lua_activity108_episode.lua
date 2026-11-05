-- chunkname: @modules/configs/excel2json/lua_activity108_episode.lua

module("modules.configs.excel2json.lua_activity108_episode", package.seeall)

local lua_activity108_episode = {}
local fields = {
	period = 5,
	mapId = 2,
	actpoint = 6,
	epilogue = 8,
	day = 4,
	showBoss = 10,
	res = 3,
	id = 1,
	showExhibits = 9,
	preface = 7
}
local primaryKey = {
	"id"
}
local mlStringKey = {
	epilogue = 2,
	preface = 1
}
local _configList, _configDict
local configPath = "configs.activity108_episode_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_activity108_episode, "configList", _configList)
	rawset(lua_activity108_episode, "configDict", _configDict)
end

setmetatable(lua_activity108_episode, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_activity108_episode.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_activity108_episode, "configList", nil)
	rawset(lua_activity108_episode, "configDict", nil)
end

return lua_activity108_episode
