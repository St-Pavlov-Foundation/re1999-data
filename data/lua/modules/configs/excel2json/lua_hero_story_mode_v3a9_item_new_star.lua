-- chunkname: @modules/configs/excel2json/lua_hero_story_mode_v3a9_item_new_star.lua

module("modules.configs.excel2json.lua_hero_story_mode_v3a9_item_new_star", package.seeall)

local lua_hero_story_mode_v3a9_item_new_star = {}
local fields = {
	level = 5,
	min = 2,
	starDesc = 4,
	id = 1,
	max = 3
}
local primaryKey = {
	"id"
}
local mlStringKey = {
	level = 2,
	starDesc = 1
}
local _configList, _configDict
local configPath = "configs.hero_story_mode_v3a9_item_new_star_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_hero_story_mode_v3a9_item_new_star, "configList", _configList)
	rawset(lua_hero_story_mode_v3a9_item_new_star, "configDict", _configDict)
end

setmetatable(lua_hero_story_mode_v3a9_item_new_star, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_hero_story_mode_v3a9_item_new_star.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_hero_story_mode_v3a9_item_new_star, "configList", nil)
	rawset(lua_hero_story_mode_v3a9_item_new_star, "configDict", nil)
end

return lua_hero_story_mode_v3a9_item_new_star
