-- chunkname: @modules/configs/excel2json/lua_fight_dnsz.lua

module("modules.configs.excel2json.lua_fight_dnsz", package.seeall)

local lua_fight_dnsz = {}
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
local configPath = "configs.fight_dnsz_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_fight_dnsz, "configList", _configList)
	rawset(lua_fight_dnsz, "configDict", _configDict)
end

setmetatable(lua_fight_dnsz, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_fight_dnsz.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_fight_dnsz, "configList", nil)
	rawset(lua_fight_dnsz, "configDict", nil)
end

return lua_fight_dnsz
