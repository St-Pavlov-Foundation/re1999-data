-- chunkname: @modules/configs/excel2json/lua_activity166_const_global.lua

module("modules.configs.excel2json.lua_activity166_const_global", package.seeall)

local lua_activity166_const_global = {}
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
local configPath = "configs.activity166_const_global_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_activity166_const_global, "configList", _configList)
	rawset(lua_activity166_const_global, "configDict", _configDict)
end

setmetatable(lua_activity166_const_global, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_activity166_const_global.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_activity166_const_global, "configList", nil)
	rawset(lua_activity166_const_global, "configDict", nil)
end

return lua_activity166_const_global
