-- chunkname: @modules/configs/excel2json/lua_stress_identity.lua

module("modules.configs.excel2json.lua_stress_identity", package.seeall)

local lua_stress_identity = {}
local fields = {
	param = 6,
	effect = 5,
	name = 2,
	typeParam = 4,
	isNoShow = 7,
	desc = 8,
	id = 1,
	uiType = 9,
	identity = 3
}
local primaryKey = {
	"id"
}
local mlStringKey = {
	desc = 2,
	name = 1
}
local _configList, _configDict
local configPath = "configs.stress_identity_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_stress_identity, "configList", _configList)
	rawset(lua_stress_identity, "configDict", _configDict)
end

setmetatable(lua_stress_identity, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_stress_identity.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_stress_identity, "configList", nil)
	rawset(lua_stress_identity, "configDict", nil)
end

return lua_stress_identity
