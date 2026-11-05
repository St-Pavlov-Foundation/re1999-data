-- chunkname: @modules/configs/excel2json/lua_v4a1_library_const.lua

module("modules.configs.excel2json.lua_v4a1_library_const", package.seeall)

local lua_v4a1_library_const = {}
local fields = {
	id = 1,
	strValue = 2
}
local primaryKey = {
	"id"
}
local mlStringKey = {}
local _configList, _configDict
local configPath = "configs.v4a1_library_const_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_v4a1_library_const, "configList", _configList)
	rawset(lua_v4a1_library_const, "configDict", _configDict)
end

setmetatable(lua_v4a1_library_const, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_v4a1_library_const.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_v4a1_library_const, "configList", nil)
	rawset(lua_v4a1_library_const, "configDict", nil)
end

return lua_v4a1_library_const
