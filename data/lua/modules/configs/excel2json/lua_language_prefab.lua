-- chunkname: @modules/configs/excel2json/lua_language_prefab.lua

module("modules.configs.excel2json.lua_language_prefab", package.seeall)

local lua_language_prefab = {}
local fields = {
	id = 1,
	lang = 2
}
local primaryKey = {
	"id"
}
local mlStringKey = {
	lang = 1
}
local _configList, _configDict
local configPath = "configs.language_prefab_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_language_prefab, "configList", _configList)
	rawset(lua_language_prefab, "configDict", _configDict)
end

setmetatable(lua_language_prefab, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_language_prefab.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_language_prefab, "configList", nil)
	rawset(lua_language_prefab, "configDict", nil)
end

return lua_language_prefab
