-- chunkname: @modules/configs/excel2json/lua_match3_item.lua

module("modules.configs.excel2json.lua_match3_item", package.seeall)

local lua_match3_item = {}
local fields = {
	itemId = 1,
	itemType = 3,
	name = 2,
	quality = 5,
	desc = 7,
	icon = 6,
	maxNum = 4
}
local primaryKey = {
	"itemId"
}
local mlStringKey = {
	desc = 2,
	name = 1
}
local _configList, _configDict
local configPath = "configs.match3_item_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_match3_item, "configList", _configList)
	rawset(lua_match3_item, "configDict", _configDict)
end

setmetatable(lua_match3_item, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_match3_item.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_match3_item, "configList", nil)
	rawset(lua_match3_item, "configDict", nil)
end

return lua_match3_item
