-- chunkname: @modules/configs/excel2json/lua_fight_ble_crystal_desc.lua

module("modules.configs.excel2json.lua_fight_ble_crystal_desc", package.seeall)

local lua_fight_ble_crystal_desc = {}
local fields = {
	id = 1,
	num = 2,
	tag = 4,
	desc = 3
}
local primaryKey = {
	"id",
	"num"
}
local mlStringKey = {
	tag = 2,
	desc = 1
}
local _configList, _configDict
local configPath = "configs.fight_ble_crystal_desc_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_fight_ble_crystal_desc, "configList", _configList)
	rawset(lua_fight_ble_crystal_desc, "configDict", _configDict)
end

setmetatable(lua_fight_ble_crystal_desc, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_fight_ble_crystal_desc.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_fight_ble_crystal_desc, "configList", nil)
	rawset(lua_fight_ble_crystal_desc, "configDict", nil)
end

return lua_fight_ble_crystal_desc
