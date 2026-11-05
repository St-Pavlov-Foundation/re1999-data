-- chunkname: @modules/configs/excel2json/lua_activity113_dungeon.lua

module("modules.configs.excel2json.lua_activity113_dungeon", package.seeall)

local lua_activity113_dungeon = {}
local fields = {
	openDay = 3,
	activityId = 2,
	chapterId = 1
}
local primaryKey = {
	"chapterId"
}
local mlStringKey = {}
local _configList, _configDict
local configPath = "configs.activity113_dungeon_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_activity113_dungeon, "configList", _configList)
	rawset(lua_activity113_dungeon, "configDict", _configDict)
end

setmetatable(lua_activity113_dungeon, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_activity113_dungeon.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_activity113_dungeon, "configList", nil)
	rawset(lua_activity113_dungeon, "configDict", nil)
end

return lua_activity113_dungeon
