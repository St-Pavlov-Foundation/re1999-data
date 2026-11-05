-- chunkname: @modules/configs/excel2json/lua_match3_const.lua

module("modules.configs.excel2json.lua_match3_const", package.seeall)

local lua_match3_const = {}
local fields = {
	id = 1,
	constKey = 2,
	value = 3,
	value2 = 4,
	desc = 5
}
local primaryKey = {
	"id"
}
local mlStringKey = {
	desc = 1
}
local _configList, _configDict
local configPath = "configs.match3_const_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_match3_const, "configList", _configList)
	rawset(lua_match3_const, "configDict", _configDict)
end

setmetatable(lua_match3_const, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_match3_const.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_match3_const, "configList", nil)
	rawset(lua_match3_const, "configDict", nil)
end

return lua_match3_const
