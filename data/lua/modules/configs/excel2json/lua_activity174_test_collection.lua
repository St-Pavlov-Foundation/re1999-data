-- chunkname: @modules/configs/excel2json/lua_activity174_test_collection.lua

module("modules.configs.excel2json.lua_activity174_test_collection", package.seeall)

local lua_activity174_test_collection = {}
local fields = {
	icon = 5,
	unique = 6,
	costCoin = 7,
	id = 1,
	title = 3,
	rare = 2,
	desc = 4
}
local primaryKey = {
	"id"
}
local mlStringKey = {
	desc = 2,
	title = 1
}
local _configList, _configDict
local configPath = "configs.activity174_test_collection_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_activity174_test_collection, "configList", _configList)
	rawset(lua_activity174_test_collection, "configDict", _configDict)
end

setmetatable(lua_activity174_test_collection, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_activity174_test_collection.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_activity174_test_collection, "configList", nil)
	rawset(lua_activity174_test_collection, "configDict", nil)
end

return lua_activity174_test_collection
