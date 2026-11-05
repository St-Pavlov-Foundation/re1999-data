-- chunkname: @modules/configs/excel2json/lua_survival_equip_slot.lua

module("modules.configs.excel2json.lua_survival_equip_slot", package.seeall)

local lua_survival_equip_slot = {}
local fields = {
	effect1 = 10,
	slot3 = 4,
	slot6 = 7,
	slot1 = 2,
	slot4 = 5,
	slot7 = 8,
	slot2 = 3,
	id = 1,
	slot5 = 6,
	slot8 = 9
}
local primaryKey = {
	"id"
}
local mlStringKey = {}
local _configList, _configDict
local configPath = "configs.survival_equip_slot_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_survival_equip_slot, "configList", _configList)
	rawset(lua_survival_equip_slot, "configDict", _configDict)
end

setmetatable(lua_survival_equip_slot, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_survival_equip_slot.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_survival_equip_slot, "configList", nil)
	rawset(lua_survival_equip_slot, "configDict", nil)
end

return lua_survival_equip_slot
