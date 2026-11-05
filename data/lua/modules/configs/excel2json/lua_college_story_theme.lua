-- chunkname: @modules/configs/excel2json/lua_college_story_theme.lua

module("modules.configs.excel2json.lua_college_story_theme", package.seeall)

local lua_college_story_theme = {}
local fields = {
	id = 1,
	title = 2,
	pic = 3,
	uiPos = 4
}
local primaryKey = {
	"id"
}
local mlStringKey = {
	title = 1
}
local _configList, _configDict
local configPath = "configs.college_story_theme_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_college_story_theme, "configList", _configList)
	rawset(lua_college_story_theme, "configDict", _configDict)
end

setmetatable(lua_college_story_theme, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_college_story_theme.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_college_story_theme, "configList", nil)
	rawset(lua_college_story_theme, "configDict", nil)
end

return lua_college_story_theme
