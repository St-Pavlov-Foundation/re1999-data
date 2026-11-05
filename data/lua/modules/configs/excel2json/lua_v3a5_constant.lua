-- chunkname: @modules/configs/excel2json/lua_v3a5_constant.lua

module("modules.configs.excel2json.lua_v3a5_constant", package.seeall)

local lua_v3a5_constant = {}
local fields = {
	value = 2,
	id = 1,
	value2 = 3
}
local primaryKey = {
	"id"
}
local mlStringKey = {}
local _configList, _configDict
local configPath = "configs.v3a5_constant_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_v3a5_constant, "configList", _configList)
	rawset(lua_v3a5_constant, "configDict", _configDict)
end

setmetatable(lua_v3a5_constant, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_v3a5_constant.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_v3a5_constant, "configList", nil)
	rawset(lua_v3a5_constant, "configDict", nil)
end

return lua_v3a5_constant
