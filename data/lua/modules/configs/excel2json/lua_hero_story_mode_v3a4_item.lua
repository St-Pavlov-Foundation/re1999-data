-- chunkname: @modules/configs/excel2json/lua_hero_story_mode_v3a4_item.lua

module("modules.configs.excel2json.lua_hero_story_mode_v3a4_item", package.seeall)

local lua_hero_story_mode_v3a4_item = {}
local fields = {
	itemId = 1,
	name = 3,
	point = 2,
	resource = 4
}
local primaryKey = {
	"itemId"
}
local mlStringKey = {
	name = 1
}
local _configList, _configDict
local configPath = "configs.hero_story_mode_v3a4_item_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_hero_story_mode_v3a4_item, "configList", _configList)
	rawset(lua_hero_story_mode_v3a4_item, "configDict", _configDict)
end

setmetatable(lua_hero_story_mode_v3a4_item, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_hero_story_mode_v3a4_item.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_hero_story_mode_v3a4_item, "configList", nil)
	rawset(lua_hero_story_mode_v3a4_item, "configDict", nil)
end

return lua_hero_story_mode_v3a4_item
