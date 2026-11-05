-- chunkname: @modules/configs/excel2json/lua_hero_story_mode_v4a0_option.lua

module("modules.configs.excel2json.lua_hero_story_mode_v4a0_option", package.seeall)

local lua_hero_story_mode_v4a0_option = {}
local fields = {
	id = 1,
	type = 4,
	content = 2,
	result = 3
}
local primaryKey = {
	"id"
}
local mlStringKey = {
	content = 1,
	result = 2
}
local _configList, _configDict
local configPath = "configs.hero_story_mode_v4a0_option_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_hero_story_mode_v4a0_option, "configList", _configList)
	rawset(lua_hero_story_mode_v4a0_option, "configDict", _configDict)
end

setmetatable(lua_hero_story_mode_v4a0_option, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_hero_story_mode_v4a0_option.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_hero_story_mode_v4a0_option, "configList", nil)
	rawset(lua_hero_story_mode_v4a0_option, "configDict", nil)
end

return lua_hero_story_mode_v4a0_option
