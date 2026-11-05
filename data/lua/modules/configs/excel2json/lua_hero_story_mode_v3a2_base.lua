-- chunkname: @modules/configs/excel2json/lua_hero_story_mode_v3a2_base.lua

module("modules.configs.excel2json.lua_hero_story_mode_v3a2_base", package.seeall)

local lua_hero_story_mode_v3a2_base = {}
local fields = {
	id = 1,
	unlockItem = 4,
	preId = 3,
	storyId = 2
}
local primaryKey = {
	"id"
}
local mlStringKey = {}
local _configList, _configDict
local configPath = "configs.hero_story_mode_v3a2_base_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_hero_story_mode_v3a2_base, "configList", _configList)
	rawset(lua_hero_story_mode_v3a2_base, "configDict", _configDict)
end

setmetatable(lua_hero_story_mode_v3a2_base, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_hero_story_mode_v3a2_base.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_hero_story_mode_v3a2_base, "configList", nil)
	rawset(lua_hero_story_mode_v3a2_base, "configDict", nil)
end

return lua_hero_story_mode_v3a2_base
