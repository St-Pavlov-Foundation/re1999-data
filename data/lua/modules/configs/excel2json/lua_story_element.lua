-- chunkname: @modules/configs/excel2json/lua_story_element.lua

module("modules.configs.excel2json.lua_story_element", package.seeall)

local lua_story_element = {}
local fields = {
	id = 1,
	elementId = 2
}
local primaryKey = {
	"id"
}
local mlStringKey = {}
local _configList, _configDict
local configPath = "configs.story_element_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_story_element, "configList", _configList)
	rawset(lua_story_element, "configDict", _configDict)
end

setmetatable(lua_story_element, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_story_element.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_story_element, "configList", nil)
	rawset(lua_story_element, "configDict", nil)
end

return lua_story_element
