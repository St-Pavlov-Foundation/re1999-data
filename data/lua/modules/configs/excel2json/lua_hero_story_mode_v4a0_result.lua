-- chunkname: @modules/configs/excel2json/lua_hero_story_mode_v4a0_result.lua

module("modules.configs.excel2json.lua_hero_story_mode_v4a0_result", package.seeall)

local lua_hero_story_mode_v4a0_result = {}
local fields = {
	desc2 = 4,
	desc1 = 3,
	id = 1,
	title = 2,
	score1 = 5
}
local primaryKey = {
	"id"
}
local mlStringKey = {
	desc2 = 3,
	title = 1,
	desc1 = 2
}
local _configList, _configDict
local configPath = "configs.hero_story_mode_v4a0_result_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_hero_story_mode_v4a0_result, "configList", _configList)
	rawset(lua_hero_story_mode_v4a0_result, "configDict", _configDict)
end

setmetatable(lua_hero_story_mode_v4a0_result, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_hero_story_mode_v4a0_result.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_hero_story_mode_v4a0_result, "configList", nil)
	rawset(lua_hero_story_mode_v4a0_result, "configDict", nil)
end

return lua_hero_story_mode_v4a0_result
