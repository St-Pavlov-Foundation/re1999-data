-- chunkname: @modules/configs/excel2json/lua_activity149_const.lua

module("modules.configs.excel2json.lua_activity149_const", package.seeall)

local lua_activity149_const = {}
local fields = {
	id = 1,
	value = 2
}
local primaryKey = {
	"id"
}
local mlStringKey = {}
local _configList, _configDict
local configPath = "configs.activity149_const_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_activity149_const, "configList", _configList)
	rawset(lua_activity149_const, "configDict", _configDict)
end

setmetatable(lua_activity149_const, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_activity149_const.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_activity149_const, "configList", nil)
	rawset(lua_activity149_const, "configDict", nil)
end

return lua_activity149_const
