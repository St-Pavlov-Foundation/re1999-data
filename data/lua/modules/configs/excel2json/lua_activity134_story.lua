-- chunkname: @modules/configs/excel2json/lua_activity134_story.lua

module("modules.configs.excel2json.lua_activity134_story", package.seeall)

local lua_activity134_story = {}
local fields = {
	storyType = 2,
	charaterIcon = 4,
	id = 1,
	formMan = 5,
	desc = 3
}
local primaryKey = {
	"id",
	"storyType"
}
local mlStringKey = {
	formMan = 2,
	desc = 1
}
local _configList, _configDict
local configPath = "configs.activity134_story_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_activity134_story, "configList", _configList)
	rawset(lua_activity134_story, "configDict", _configDict)
end

setmetatable(lua_activity134_story, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_activity134_story.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_activity134_story, "configList", nil)
	rawset(lua_activity134_story, "configDict", nil)
end

return lua_activity134_story
