-- chunkname: @modules/configs/excel2json/lua_activity220_peishita_unit.lua

module("modules.configs.excel2json.lua_activity220_peishita_unit", package.seeall)

local lua_activity220_peishita_unit = {}
local fields = {
	id = 1,
	icon = 4,
	resName = 3,
	type = 2
}
local primaryKey = {
	"id"
}
local mlStringKey = {}
local _configList, _configDict
local configPath = "configs.activity220_peishita_unit_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_activity220_peishita_unit, "configList", _configList)
	rawset(lua_activity220_peishita_unit, "configDict", _configDict)
end

setmetatable(lua_activity220_peishita_unit, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_activity220_peishita_unit.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_activity220_peishita_unit, "configList", nil)
	rawset(lua_activity220_peishita_unit, "configDict", nil)
end

return lua_activity220_peishita_unit
