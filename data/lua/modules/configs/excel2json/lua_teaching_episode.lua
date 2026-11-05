-- chunkname: @modules/configs/excel2json/lua_teaching_episode.lua

module("modules.configs.excel2json.lua_teaching_episode", package.seeall)

local lua_teaching_episode = {}
local fields = {
	teaching = 2,
	battleTasks = 5,
	taskDetail = 6,
	type = 4,
	id = 1,
	preEpisode = 7,
	detail = 3
}
local primaryKey = {
	"id"
}
local mlStringKey = {
	taskDetail = 2,
	detail = 1
}
local _configList, _configDict
local configPath = "configs.teaching_episode_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_teaching_episode, "configList", _configList)
	rawset(lua_teaching_episode, "configDict", _configDict)
end

setmetatable(lua_teaching_episode, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_teaching_episode.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_teaching_episode, "configList", nil)
	rawset(lua_teaching_episode, "configDict", nil)
end

return lua_teaching_episode
