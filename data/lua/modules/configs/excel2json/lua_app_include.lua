-- chunkname: @modules/configs/excel2json/lua_app_include.lua

module("modules.configs.excel2json.lua_app_include", package.seeall)

local lua_app_include = {}
local fields = {
	path = 8,
	video = 7,
	guide = 6,
	heroSkinIds = 12,
	seasonIds = 5,
	roomTheme = 10,
	heroStoryIds = 11,
	story = 4,
	chapter = 3,
	character = 2,
	id = 1,
	maxWeekWalk = 9
}
local primaryKey = {
	"id"
}
local mlStringKey = {}
local _configList, _configDict
local configPath = "configs.app_include_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_app_include, "configList", _configList)
	rawset(lua_app_include, "configDict", _configDict)
end

setmetatable(lua_app_include, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_app_include.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_app_include, "configList", nil)
	rawset(lua_app_include, "configDict", nil)
end

return lua_app_include
