-- chunkname: @modules/configs/excel2json/lua_hero_story_mode_v3a9_item.lua

module("modules.configs.excel2json.lua_hero_story_mode_v3a9_item", package.seeall)

local lua_hero_story_mode_v3a9_item = {}
local fields = {
	storyPic = 8,
	unlock = 6,
	itemName = 4,
	type = 3,
	id = 1,
	group = 2,
	sourceDesc = 7,
	itemDesc1 = 5
}
local primaryKey = {
	"id"
}
local mlStringKey = {
	sourceDesc = 3,
	itemName = 1,
	itemDesc1 = 2
}
local _configList, _configDict
local configPath = "configs.hero_story_mode_v3a9_item_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_hero_story_mode_v3a9_item, "configList", _configList)
	rawset(lua_hero_story_mode_v3a9_item, "configDict", _configDict)
end

setmetatable(lua_hero_story_mode_v3a9_item, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_hero_story_mode_v3a9_item.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_hero_story_mode_v3a9_item, "configList", nil)
	rawset(lua_hero_story_mode_v3a9_item, "configDict", nil)
end

return lua_hero_story_mode_v3a9_item
