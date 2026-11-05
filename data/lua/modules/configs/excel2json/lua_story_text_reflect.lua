-- chunkname: @modules/configs/excel2json/lua_story_text_reflect.lua

module("modules.configs.excel2json.lua_story_text_reflect", package.seeall)

local lua_story_text_reflect = {}
local fields = {
	id = 1,
	normalText = 3,
	magicText = 2
}
local primaryKey = {
	"id"
}
local mlStringKey = {}
local _configList, _configDict
local configPath = "configs.story_text_reflect_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_story_text_reflect, "configList", _configList)
	rawset(lua_story_text_reflect, "configDict", _configDict)
end

setmetatable(lua_story_text_reflect, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_story_text_reflect.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_story_text_reflect, "configList", nil)
	rawset(lua_story_text_reflect, "configDict", nil)
end

return lua_story_text_reflect
