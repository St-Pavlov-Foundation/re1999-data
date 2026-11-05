-- chunkname: @modules/configs/excel2json/lua_hero_story_mode_v3a4_base.lua

module("modules.configs.excel2json.lua_hero_story_mode_v3a4_base", package.seeall)

local lua_hero_story_mode_v3a4_base = {}
local fields = {
	finishAudio = 6,
	name = 2,
	pauseTime = 5,
	storyId = 3,
	id = 1,
	finishAudioTime = 7,
	preId = 8,
	gameId = 4
}
local primaryKey = {
	"id"
}
local mlStringKey = {
	name = 1
}
local _configList, _configDict
local configPath = "configs.hero_story_mode_v3a4_base_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_hero_story_mode_v3a4_base, "configList", _configList)
	rawset(lua_hero_story_mode_v3a4_base, "configDict", _configDict)
end

setmetatable(lua_hero_story_mode_v3a4_base, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_hero_story_mode_v3a4_base.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_hero_story_mode_v3a4_base, "configList", nil)
	rawset(lua_hero_story_mode_v3a4_base, "configDict", nil)
end

return lua_hero_story_mode_v3a4_base
