-- chunkname: @modules/configs/excel2json/lua_activity142_collection.lua

module("modules.configs.excel2json.lua_activity142_collection", package.seeall)

local lua_activity142_collection = {}
local fields = {
	name = 3,
	nameen = 4,
	id = 2,
	icon = 6,
	activityId = 1,
	desc = 5
}
local primaryKey = {
	"activityId",
	"id"
}
local mlStringKey = {
	desc = 2,
	name = 1
}
local _configList, _configDict
local configPath = "configs.activity142_collection_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_activity142_collection, "configList", _configList)
	rawset(lua_activity142_collection, "configDict", _configDict)
end

setmetatable(lua_activity142_collection, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_activity142_collection.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_activity142_collection, "configList", nil)
	rawset(lua_activity142_collection, "configDict", nil)
end

return lua_activity142_collection
