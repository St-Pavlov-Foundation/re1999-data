-- chunkname: @modules/configs/excel2json/lua_arcade_survivor_const.lua

module("modules.configs.excel2json.lua_arcade_survivor_const", package.seeall)

local lua_arcade_survivor_const = {}
local fields = {
	value = 2,
	id = 1,
	mlvalue = 3
}
local primaryKey = {
	"id"
}
local mlStringKey = {
	mlvalue = 1
}
local _configList, _configDict
local configPath = "configs.arcade_survivor_const_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_arcade_survivor_const, "configList", _configList)
	rawset(lua_arcade_survivor_const, "configDict", _configDict)
end

setmetatable(lua_arcade_survivor_const, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_arcade_survivor_const.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_arcade_survivor_const, "configList", nil)
	rawset(lua_arcade_survivor_const, "configDict", nil)
end

return lua_arcade_survivor_const
