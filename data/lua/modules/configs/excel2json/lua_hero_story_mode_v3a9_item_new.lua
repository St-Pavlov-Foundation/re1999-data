-- chunkname: @modules/configs/excel2json/lua_hero_story_mode_v3a9_item_new.lua

module("modules.configs.excel2json.lua_hero_story_mode_v3a9_item_new", package.seeall)

local lua_hero_story_mode_v3a9_item_new = {}
local fields = {
	id = 1,
	item = 3,
	itemNew = 2
}
local primaryKey = {
	"id"
}
local mlStringKey = {
	itemNew = 1
}
local _configList, _configDict
local configPath = "configs.hero_story_mode_v3a9_item_new_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_hero_story_mode_v3a9_item_new, "configList", _configList)
	rawset(lua_hero_story_mode_v3a9_item_new, "configDict", _configDict)
end

setmetatable(lua_hero_story_mode_v3a9_item_new, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_hero_story_mode_v3a9_item_new.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_hero_story_mode_v3a9_item_new, "configList", nil)
	rawset(lua_hero_story_mode_v3a9_item_new, "configDict", nil)
end

return lua_hero_story_mode_v3a9_item_new
