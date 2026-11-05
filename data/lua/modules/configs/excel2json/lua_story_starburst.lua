-- chunkname: @modules/configs/excel2json/lua_story_starburst.lua

module("modules.configs.excel2json.lua_story_starburst", package.seeall)

local lua_story_starburst = {}
local fields = {
	id = 1,
	meshpath = 3,
	effpath = 2
}
local primaryKey = {
	"id"
}
local mlStringKey = {}
local _configList, _configDict
local configPath = "configs.story_starburst_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_story_starburst, "configList", _configList)
	rawset(lua_story_starburst, "configDict", _configDict)
end

setmetatable(lua_story_starburst, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_story_starburst.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_story_starburst, "configList", nil)
	rawset(lua_story_starburst, "configDict", nil)
end

return lua_story_starburst
