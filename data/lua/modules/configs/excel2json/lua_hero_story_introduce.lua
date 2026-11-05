-- chunkname: @modules/configs/excel2json/lua_hero_story_introduce.lua

module("modules.configs.excel2json.lua_hero_story_introduce", package.seeall)

local lua_hero_story_introduce = {}
local fields = {
	id = 1,
	name = 2,
	desc = 4,
	resource = 3
}
local primaryKey = {
	"id"
}
local mlStringKey = {
	desc = 2,
	name = 1
}
local _configList, _configDict
local configPath = "configs.hero_story_introduce_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_hero_story_introduce, "configList", _configList)
	rawset(lua_hero_story_introduce, "configDict", _configDict)
end

setmetatable(lua_hero_story_introduce, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_hero_story_introduce.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_hero_story_introduce, "configList", nil)
	rawset(lua_hero_story_introduce, "configDict", nil)
end

return lua_hero_story_introduce
