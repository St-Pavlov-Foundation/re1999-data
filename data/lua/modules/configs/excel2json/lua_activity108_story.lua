-- chunkname: @modules/configs/excel2json/lua_activity108_story.lua

module("modules.configs.excel2json.lua_activity108_story", package.seeall)

local lua_activity108_story = {}
local fields = {
	id = 1,
	story = 3,
	bind = 4,
	params = 2
}
local primaryKey = {
	"id"
}
local mlStringKey = {}
local _configList, _configDict
local configPath = "configs.activity108_story_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_activity108_story, "configList", _configList)
	rawset(lua_activity108_story, "configDict", _configDict)
end

setmetatable(lua_activity108_story, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_activity108_story.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_activity108_story, "configList", nil)
	rawset(lua_activity108_story, "configDict", nil)
end

return lua_activity108_story
