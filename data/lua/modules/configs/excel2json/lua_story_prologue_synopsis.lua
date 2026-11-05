-- chunkname: @modules/configs/excel2json/lua_story_prologue_synopsis.lua

module("modules.configs.excel2json.lua_story_prologue_synopsis", package.seeall)

local lua_story_prologue_synopsis = {}
local fields = {
	prologues = 2,
	id = 1,
	content = 3
}
local primaryKey = {
	"id"
}
local mlStringKey = {
	content = 1
}
local _configList, _configDict
local configPath = "configs.story_prologue_synopsis_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_story_prologue_synopsis, "configList", _configList)
	rawset(lua_story_prologue_synopsis, "configDict", _configDict)
end

setmetatable(lua_story_prologue_synopsis, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_story_prologue_synopsis.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_story_prologue_synopsis, "configList", nil)
	rawset(lua_story_prologue_synopsis, "configDict", nil)
end

return lua_story_prologue_synopsis
