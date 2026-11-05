-- chunkname: @modules/configs/excel2json/lua_story_leadherospine.lua

module("modules.configs.excel2json.lua_story_leadherospine", package.seeall)

local lua_story_leadherospine = {}
local fields = {
	id = 1,
	icon = 2,
	resType = 3,
	path = 4
}
local primaryKey = {
	"id"
}
local mlStringKey = {}
local _configList, _configDict
local configPath = "configs.story_leadherospine_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_story_leadherospine, "configList", _configList)
	rawset(lua_story_leadherospine, "configDict", _configDict)
end

setmetatable(lua_story_leadherospine, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_story_leadherospine.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_story_leadherospine, "configList", nil)
	rawset(lua_story_leadherospine, "configDict", nil)
end

return lua_story_leadherospine
