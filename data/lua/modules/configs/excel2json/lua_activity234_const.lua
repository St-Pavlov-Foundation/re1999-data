-- chunkname: @modules/configs/excel2json/lua_activity234_const.lua

module("modules.configs.excel2json.lua_activity234_const", package.seeall)

local lua_activity234_const = {}
local fields = {
	id = 1,
	strValue = 2
}
local primaryKey = {
	"id"
}
local mlStringKey = {}
local _configList, _configDict
local configPath = "configs.activity234_const_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_activity234_const, "configList", _configList)
	rawset(lua_activity234_const, "configDict", _configDict)
end

setmetatable(lua_activity234_const, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_activity234_const.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_activity234_const, "configList", nil)
	rawset(lua_activity234_const, "configDict", nil)
end

return lua_activity234_const
