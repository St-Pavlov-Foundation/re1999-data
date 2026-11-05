-- chunkname: @modules/configs/excel2json/lua_magic_dnsz.lua

module("modules.configs.excel2json.lua_magic_dnsz", package.seeall)

local lua_magic_dnsz = {}
local fields = {
	id = 2,
	progress = 3,
	level = 1
}
local primaryKey = {
	"level"
}
local mlStringKey = {}
local _configList, _configDict
local configPath = "configs.magic_dnsz_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_magic_dnsz, "configList", _configList)
	rawset(lua_magic_dnsz, "configDict", _configDict)
end

setmetatable(lua_magic_dnsz, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_magic_dnsz.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_magic_dnsz, "configList", nil)
	rawset(lua_magic_dnsz, "configDict", nil)
end

return lua_magic_dnsz
