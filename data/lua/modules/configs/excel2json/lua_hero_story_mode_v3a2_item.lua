-- chunkname: @modules/configs/excel2json/lua_hero_story_mode_v3a2_item.lua

module("modules.configs.excel2json.lua_hero_story_mode_v3a2_item", package.seeall)

local lua_hero_story_mode_v3a2_item = {}
local fields = {
	unlock = 6,
	name = 2,
	id = 1,
	image = 3,
	sourceDesc = 5,
	desc = 4
}
local primaryKey = {
	"id"
}
local mlStringKey = {
	name = 1,
	sourceDesc = 3,
	desc = 2
}
local _configList, _configDict
local configPath = "configs.hero_story_mode_v3a2_item_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_hero_story_mode_v3a2_item, "configList", _configList)
	rawset(lua_hero_story_mode_v3a2_item, "configDict", _configDict)
end

setmetatable(lua_hero_story_mode_v3a2_item, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_hero_story_mode_v3a2_item.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_hero_story_mode_v3a2_item, "configList", nil)
	rawset(lua_hero_story_mode_v3a2_item, "configDict", nil)
end

return lua_hero_story_mode_v3a2_item
