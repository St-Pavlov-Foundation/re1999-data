-- chunkname: @modules/configs/excel2json/lua_hero_story_mode_v4a1_role.lua

module("modules.configs.excel2json.lua_hero_story_mode_v4a1_role", package.seeall)

local lua_hero_story_mode_v4a1_role = {}
local fields = {
	stats = 3,
	name = 2,
	res = 5,
	id = 1,
	desc = 4
}
local primaryKey = {
	"id"
}
local mlStringKey = {
	desc = 2,
	name = 1
}
local _configList, _configDict
local configPath = "configs.hero_story_mode_v4a1_role_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_hero_story_mode_v4a1_role, "configList", _configList)
	rawset(lua_hero_story_mode_v4a1_role, "configDict", _configDict)
end

setmetatable(lua_hero_story_mode_v4a1_role, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_hero_story_mode_v4a1_role.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_hero_story_mode_v4a1_role, "configList", nil)
	rawset(lua_hero_story_mode_v4a1_role, "configDict", nil)
end

return lua_hero_story_mode_v4a1_role
