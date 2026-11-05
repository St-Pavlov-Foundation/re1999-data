-- chunkname: @modules/configs/excel2json/lua_story_activity_open.lua

module("modules.configs.excel2json.lua_story_activity_open", package.seeall)

local lua_story_activity_open = {}
local fields = {
	part = 2,
	chapter = 1,
	labelRes = 5,
	titleEn = 4,
	title = 3,
	storyBg = 6
}
local primaryKey = {
	"chapter",
	"part"
}
local mlStringKey = {
	title = 1
}
local _configList, _configDict
local configPath = "configs.story_activity_open_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_story_activity_open, "configList", _configList)
	rawset(lua_story_activity_open, "configDict", _configDict)
end

setmetatable(lua_story_activity_open, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_story_activity_open.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_story_activity_open, "configList", nil)
	rawset(lua_story_activity_open, "configDict", nil)
end

return lua_story_activity_open
