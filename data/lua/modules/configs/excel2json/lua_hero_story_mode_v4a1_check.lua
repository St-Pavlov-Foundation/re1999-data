-- chunkname: @modules/configs/excel2json/lua_hero_story_mode_v4a1_check.lua

module("modules.configs.excel2json.lua_hero_story_mode_v4a1_check", package.seeall)

local lua_hero_story_mode_v4a1_check = {}
local fields = {
	group = 2,
	hide1 = 5,
	itemName = 4,
	type = 3,
	id = 1,
	hide2 = 6,
	storyId = 7
}
local primaryKey = {
	"id"
}
local mlStringKey = {
	itemName = 1
}
local _configList, _configDict
local configPath = "configs.hero_story_mode_v4a1_check_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_hero_story_mode_v4a1_check, "configList", _configList)
	rawset(lua_hero_story_mode_v4a1_check, "configDict", _configDict)
end

setmetatable(lua_hero_story_mode_v4a1_check, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_hero_story_mode_v4a1_check.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_hero_story_mode_v4a1_check, "configList", nil)
	rawset(lua_hero_story_mode_v4a1_check, "configDict", nil)
end

return lua_hero_story_mode_v4a1_check
