-- chunkname: @modules/configs/excel2json/lua_activity184_puzzle_episode.lua

module("modules.configs.excel2json.lua_activity184_puzzle_episode", package.seeall)

local lua_activity184_puzzle_episode = {}
local fields = {
	titile = 10,
	titleTxt = 7,
	date = 6,
	txt = 9,
	target = 5,
	illustrationCount = 8,
	staticShape = 4,
	id = 2,
	size = 3,
	activityId = 1
}
local primaryKey = {
	"activityId",
	"id"
}
local mlStringKey = {
	txt = 2,
	titleTxt = 1,
	titile = 3
}
local _configList, _configDict
local configPath = "configs.activity184_puzzle_episode_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_activity184_puzzle_episode, "configList", _configList)
	rawset(lua_activity184_puzzle_episode, "configDict", _configDict)
end

setmetatable(lua_activity184_puzzle_episode, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_activity184_puzzle_episode.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_activity184_puzzle_episode, "configList", nil)
	rawset(lua_activity184_puzzle_episode, "configDict", nil)
end

return lua_activity184_puzzle_episode
