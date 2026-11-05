-- chunkname: @modules/configs/excel2json/lua_activity155_drop.lua

module("modules.configs.excel2json.lua_activity155_drop", package.seeall)

local lua_activity155_drop = {}
local fields = {
	itemId1 = 4,
	itemId2 = 5,
	chapterId = 3,
	id = 1,
	activityId = 2
}
local primaryKey = {
	"id",
	"activityId"
}
local mlStringKey = {}
local _configList, _configDict
local configPath = "configs.activity155_drop_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_activity155_drop, "configList", _configList)
	rawset(lua_activity155_drop, "configDict", _configDict)
end

setmetatable(lua_activity155_drop, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_activity155_drop.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_activity155_drop, "configList", nil)
	rawset(lua_activity155_drop, "configDict", nil)
end

return lua_activity155_drop
