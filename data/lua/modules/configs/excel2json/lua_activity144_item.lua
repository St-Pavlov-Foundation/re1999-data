-- chunkname: @modules/configs/excel2json/lua_activity144_item.lua

module("modules.configs.excel2json.lua_activity144_item", package.seeall)

local lua_activity144_item = {}
local fields = {
	isStackable = 9,
	name = 2,
	useDesc = 3,
	isShow = 10,
	effect = 11,
	sources = 12,
	rare = 7,
	desc = 4,
	subType = 5,
	id = 1,
	icon = 6,
	highQuality = 8
}
local primaryKey = {
	"id"
}
local mlStringKey = {
	name = 1,
	useDesc = 2,
	desc = 3
}
local _configList, _configDict
local configPath = "configs.activity144_item_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_activity144_item, "configList", _configList)
	rawset(lua_activity144_item, "configDict", _configDict)
end

setmetatable(lua_activity144_item, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_activity144_item.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_activity144_item, "configList", nil)
	rawset(lua_activity144_item, "configDict", nil)
end

return lua_activity144_item
