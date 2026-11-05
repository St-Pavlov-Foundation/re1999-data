-- chunkname: @modules/configs/excel2json/lua_fight_ble_skill_2_crystal.lua

module("modules.configs.excel2json.lua_fight_ble_skill_2_crystal", package.seeall)

local lua_fight_ble_skill_2_crystal = {}
local fields = {
	crystal = 2,
	skillId = 1
}
local primaryKey = {
	"skillId"
}
local mlStringKey = {}
local _configList, _configDict
local configPath = "configs.fight_ble_skill_2_crystal_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_fight_ble_skill_2_crystal, "configList", _configList)
	rawset(lua_fight_ble_skill_2_crystal, "configDict", _configDict)
end

setmetatable(lua_fight_ble_skill_2_crystal, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_fight_ble_skill_2_crystal.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_fight_ble_skill_2_crystal, "configList", nil)
	rawset(lua_fight_ble_skill_2_crystal, "configDict", nil)
end

return lua_fight_ble_skill_2_crystal
