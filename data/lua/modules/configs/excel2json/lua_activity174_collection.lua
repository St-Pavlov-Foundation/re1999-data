-- chunkname: @modules/configs/excel2json/lua_activity174_collection.lua

module("modules.configs.excel2json.lua_activity174_collection", package.seeall)

local lua_activity174_collection = {}
local fields = {
	season = 2,
	icon = 6,
	unique = 7,
	coinValue = 8,
	id = 1,
	title = 4,
	rare = 3,
	desc = 5
}
local primaryKey = {
	"id"
}
local mlStringKey = {
	desc = 2,
	title = 1
}
local _configList, _configDict
local configPath = "configs.activity174_collection_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_activity174_collection, "configList", _configList)
	rawset(lua_activity174_collection, "configDict", _configDict)
end

setmetatable(lua_activity174_collection, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_activity174_collection.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_activity174_collection, "configList", nil)
	rawset(lua_activity174_collection, "configDict", nil)
end

return lua_activity174_collection
