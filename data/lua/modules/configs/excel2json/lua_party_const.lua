-- chunkname: @modules/configs/excel2json/lua_party_const.lua

module("modules.configs.excel2json.lua_party_const", package.seeall)

local lua_party_const = {}
local fields = {
	value = 2,
	id = 1,
	value2 = 3
}
local primaryKey = {
	"id"
}
local mlStringKey = {
	value2 = 1
}
local _configList, _configDict
local configPath = "configs.party_const_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_party_const, "configList", _configList)
	rawset(lua_party_const, "configDict", _configDict)
end

setmetatable(lua_party_const, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_party_const.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_party_const, "configList", nil)
	rawset(lua_party_const, "configDict", nil)
end

return lua_party_const
