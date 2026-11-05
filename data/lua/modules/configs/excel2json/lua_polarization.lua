-- chunkname: @modules/configs/excel2json/lua_polarization.lua

module("modules.configs.excel2json.lua_polarization", package.seeall)

local lua_polarization = {}
local fields = {
	type = 2,
	name = 3,
	desc = 4,
	level = 1
}
local primaryKey = {
	"level",
	"type"
}
local mlStringKey = {
	desc = 2,
	name = 1
}
local _configList, _configDict
local configPath = "configs.polarization_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_polarization, "configList", _configList)
	rawset(lua_polarization, "configDict", _configDict)
end

setmetatable(lua_polarization, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_polarization.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_polarization, "configList", nil)
	rawset(lua_polarization, "configDict", nil)
end

return lua_polarization
