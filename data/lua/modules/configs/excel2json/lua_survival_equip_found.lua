-- chunkname: @modules/configs/excel2json/lua_survival_equip_found.lua

module("modules.configs.excel2json.lua_survival_equip_found", package.seeall)

local lua_survival_equip_found = {}
local fields = {
	icon2 = 6,
	name = 5,
	power = 11,
	desc1 = 3,
	value = 8,
	desc = 2,
	icon4 = 9,
	icon3 = 7,
	id = 1,
	icon = 4,
	level = 10
}
local primaryKey = {
	"id"
}
local mlStringKey = {
	desc1 = 2,
	name = 3,
	desc = 1
}
local _configList, _configDict
local configPath = "configs.survival_equip_found_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_survival_equip_found, "configList", _configList)
	rawset(lua_survival_equip_found, "configDict", _configDict)
end

setmetatable(lua_survival_equip_found, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_survival_equip_found.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_survival_equip_found, "configList", nil)
	rawset(lua_survival_equip_found, "configDict", nil)
end

return lua_survival_equip_found
