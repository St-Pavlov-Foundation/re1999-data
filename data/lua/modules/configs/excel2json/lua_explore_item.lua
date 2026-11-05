-- chunkname: @modules/configs/excel2json/lua_explore_item.lua

module("modules.configs.excel2json.lua_explore_item", package.seeall)

local lua_explore_item = {}
local fields = {
	icon = 6,
	name = 3,
	interactEffect = 11,
	type = 2,
	effect = 10,
	isClientStackable = 9,
	desc = 4,
	audioId = 7,
	desc2 = 5,
	id = 1,
	isStackable = 8,
	isReserve = 12
}
local primaryKey = {
	"id"
}
local mlStringKey = {
	desc2 = 3,
	name = 1,
	desc = 2
}
local _configList, _configDict
local configPath = "configs.explore_item_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_explore_item, "configList", _configList)
	rawset(lua_explore_item, "configDict", _configDict)
end

setmetatable(lua_explore_item, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_explore_item.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_explore_item, "configList", nil)
	rawset(lua_explore_item, "configDict", nil)
end

return lua_explore_item
