-- chunkname: @modules/configs/excel2json/lua_fight_device.lua

module("modules.configs.excel2json.lua_fight_device", package.seeall)

local lua_fight_device = {}
local fields = {
	powerSkill = 2,
	specialPowerSkill = 3,
	skill1 = 4,
	skill2 = 5,
	id = 1,
	uniqueSkill = 6
}
local primaryKey = {
	"id"
}
local mlStringKey = {}
local _configList, _configDict
local configPath = "configs.fight_device_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_fight_device, "configList", _configList)
	rawset(lua_fight_device, "configDict", _configDict)
end

setmetatable(lua_fight_device, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_fight_device.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_fight_device, "configList", nil)
	rawset(lua_fight_device, "configDict", nil)
end

return lua_fight_device
