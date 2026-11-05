-- chunkname: @modules/configs/excel2json/lua_activity_dungeon.lua

module("modules.configs.excel2json.lua_activity_dungeon", package.seeall)

local lua_activity_dungeon = {}
local fields = {
	hardChapterId = 5,
	story3ChapterId = 4,
	id = 1,
	story1ChapterId = 2,
	story2ChapterId = 3
}
local primaryKey = {
	"id"
}
local mlStringKey = {}
local _configList, _configDict
local configPath = "configs.activity_dungeon_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_activity_dungeon, "configList", _configList)
	rawset(lua_activity_dungeon, "configDict", _configDict)
end

setmetatable(lua_activity_dungeon, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_activity_dungeon.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_activity_dungeon, "configList", nil)
	rawset(lua_activity_dungeon, "configDict", nil)
end

return lua_activity_dungeon
