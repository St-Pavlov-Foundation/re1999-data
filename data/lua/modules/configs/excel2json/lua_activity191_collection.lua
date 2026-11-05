-- chunkname: @modules/configs/excel2json/lua_activity191_collection.lua

module("modules.configs.excel2json.lua_activity191_collection", package.seeall)

local lua_activity191_collection = {}
local fields = {
	label = 8,
	tag2 = 7,
	replaceDesc = 10,
	desc = 9,
	tag = 6,
	title = 5,
	rare = 3,
	unique = 4,
	weight = 12,
	id = 1,
	icon = 11,
	activityId = 2
}
local primaryKey = {
	"id"
}
local mlStringKey = {
	label = 2,
	title = 1,
	replaceDesc = 4,
	desc = 3
}
local _configList, _configDict
local configPath = "configs.activity191_collection_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_activity191_collection, "configList", _configList)
	rawset(lua_activity191_collection, "configDict", _configDict)
end

setmetatable(lua_activity191_collection, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_activity191_collection.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_activity191_collection, "configList", nil)
	rawset(lua_activity191_collection, "configDict", nil)
end

return lua_activity191_collection
