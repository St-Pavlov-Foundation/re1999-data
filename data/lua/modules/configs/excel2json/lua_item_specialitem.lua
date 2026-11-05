-- chunkname: @modules/configs/excel2json/lua_item_specialitem.lua

module("modules.configs.excel2json.lua_item_specialitem", package.seeall)

local lua_item_specialitem = {}
local fields = {
	name = 2,
	id = 1,
	icon = 3,
	rare = 5,
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
local configPath = "configs.item_specialitem_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_item_specialitem, "configList", _configList)
	rawset(lua_item_specialitem, "configDict", _configDict)
end

setmetatable(lua_item_specialitem, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_item_specialitem.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_item_specialitem, "configList", nil)
	rawset(lua_item_specialitem, "configDict", nil)
end

return lua_item_specialitem
