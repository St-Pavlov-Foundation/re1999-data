-- chunkname: @modules/configs/excel2json/lua_activity194_item.lua

module("modules.configs.excel2json.lua_activity194_item", package.seeall)

local lua_activity194_item = {}
local fields = {
	itemId = 1,
	name = 5,
	buffId = 3,
	isUse = 2,
	picture = 4
}
local primaryKey = {
	"itemId"
}
local mlStringKey = {
	name = 1
}
local _configList, _configDict
local configPath = "configs.activity194_item_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_activity194_item, "configList", _configList)
	rawset(lua_activity194_item, "configDict", _configDict)
end

setmetatable(lua_activity194_item, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_activity194_item.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_activity194_item, "configList", nil)
	rawset(lua_activity194_item, "configDict", nil)
end

return lua_activity194_item
