-- chunkname: @modules/configs/excel2json/lua_talent_upgrade_item.lua

module("modules.configs.excel2json.lua_talent_upgrade_item", package.seeall)

local lua_talent_upgrade_item = {}
local fields = {
	effect = 8,
	name = 2,
	useDesc = 5,
	useTitle = 7,
	id = 1,
	icon = 3,
	expireSeconds = 4,
	desc = 6
}
local primaryKey = {
	"id"
}
local mlStringKey = {
	useTitle = 4,
	name = 1,
	useDesc = 2,
	desc = 3
}
local _configList, _configDict
local configPath = "configs.talent_upgrade_item_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_talent_upgrade_item, "configList", _configList)
	rawset(lua_talent_upgrade_item, "configDict", _configDict)
end

setmetatable(lua_talent_upgrade_item, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_talent_upgrade_item.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_talent_upgrade_item, "configList", nil)
	rawset(lua_talent_upgrade_item, "configDict", nil)
end

return lua_talent_upgrade_item
