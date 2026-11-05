-- chunkname: @modules/configs/excel2json/lua_simple_polarization.lua

module("modules.configs.excel2json.lua_simple_polarization", package.seeall)

local lua_simple_polarization = {}
local fields = {
	desc = 3,
	name = 2,
	level = 1
}
local primaryKey = {
	"level"
}
local mlStringKey = {
	desc = 2,
	name = 1
}
local _configList, _configDict
local configPath = "configs.simple_polarization_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_simple_polarization, "configList", _configList)
	rawset(lua_simple_polarization, "configDict", _configDict)
end

setmetatable(lua_simple_polarization, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_simple_polarization.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_simple_polarization, "configList", nil)
	rawset(lua_simple_polarization, "configDict", nil)
end

return lua_simple_polarization
