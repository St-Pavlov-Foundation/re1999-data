-- chunkname: @modules/configs/excel2json/lua_hero_story_dispatch_talk.lua

module("modules.configs.excel2json.lua_hero_story_dispatch_talk", package.seeall)

local lua_hero_story_dispatch_talk = {}
local fields = {
	speaker = 5,
	id = 1,
	heroid = 6,
	type = 2,
	color = 4,
	content = 3
}
local primaryKey = {
	"id"
}
local mlStringKey = {
	content = 1,
	speaker = 2
}
local _configList, _configDict
local configPath = "configs.hero_story_dispatch_talk_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_hero_story_dispatch_talk, "configList", _configList)
	rawset(lua_hero_story_dispatch_talk, "configDict", _configDict)
end

setmetatable(lua_hero_story_dispatch_talk, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_hero_story_dispatch_talk.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_hero_story_dispatch_talk, "configList", nil)
	rawset(lua_hero_story_dispatch_talk, "configDict", nil)
end

return lua_hero_story_dispatch_talk
