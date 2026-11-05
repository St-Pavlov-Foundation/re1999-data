-- chunkname: @modules/configs/excel2json/lua_fight_ble_crystal.lua

module("modules.configs.excel2json.lua_fight_ble_crystal", package.seeall)

local lua_fight_ble_crystal = {}
local fields = {
	smallIcon = 6,
	name = 3,
	iconBg = 5,
	cardTimeline = 8,
	skin = 1,
	nameColor = 7,
	id = 2,
	icon = 4,
	skill3Timeline = 9
}
local primaryKey = {
	"skin",
	"id"
}
local mlStringKey = {
	name = 1
}
local _configList, _configDict
local configPath = "configs.fight_ble_crystal_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_fight_ble_crystal, "configList", _configList)
	rawset(lua_fight_ble_crystal, "configDict", _configDict)
end

setmetatable(lua_fight_ble_crystal, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_fight_ble_crystal.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_fight_ble_crystal, "configList", nil)
	rawset(lua_fight_ble_crystal, "configDict", nil)
end

return lua_fight_ble_crystal
