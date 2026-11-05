-- chunkname: @modules/configs/excel2json/lua_assassin_const.lua

module("modules.configs.excel2json.lua_assassin_const", package.seeall)

local lua_assassin_const = {}
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
local configPath = "configs.assassin_const_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_assassin_const, "configList", _configList)
	rawset(lua_assassin_const, "configDict", _configDict)
end

setmetatable(lua_assassin_const, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_assassin_const.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_assassin_const, "configList", nil)
	rawset(lua_assassin_const, "configDict", nil)
end

return lua_assassin_const
