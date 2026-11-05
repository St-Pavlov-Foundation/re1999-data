-- chunkname: @modules/configs/excel2json/lua_activity191_item.lua

module("modules.configs.excel2json.lua_activity191_item", package.seeall)

local lua_activity191_item = {}
local fields = {
	rare = 6,
	name = 3,
	id = 1,
	icon = 5,
	activityId = 2,
	desc = 4
}
local primaryKey = {
	"id"
}
local mlStringKey = {
	desc = 2,
	name = 1
}
local _configList, _configDict
local configPath = "configs.activity191_item_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_activity191_item, "configList", _configList)
	rawset(lua_activity191_item, "configDict", _configDict)
end

setmetatable(lua_activity191_item, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_activity191_item.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_activity191_item, "configList", nil)
	rawset(lua_activity191_item, "configDict", nil)
end

return lua_activity191_item
