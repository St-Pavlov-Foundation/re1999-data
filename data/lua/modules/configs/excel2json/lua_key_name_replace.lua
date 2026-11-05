-- chunkname: @modules/configs/excel2json/lua_key_name_replace.lua

module("modules.configs.excel2json.lua_key_name_replace", package.seeall)

local lua_key_name_replace = {}
local fields = {
	replacedName = 2,
	name = 1
}
local primaryKey = {
	"name"
}
local mlStringKey = {}
local _configList, _configDict
local configPath = "configs.key_name_replace_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_key_name_replace, "configList", _configList)
	rawset(lua_key_name_replace, "configDict", _configDict)
end

setmetatable(lua_key_name_replace, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_key_name_replace.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_key_name_replace, "configList", nil)
	rawset(lua_key_name_replace, "configDict", nil)
end

return lua_key_name_replace
