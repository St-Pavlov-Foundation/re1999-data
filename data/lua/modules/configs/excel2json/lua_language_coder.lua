-- chunkname: @modules/configs/excel2json/lua_language_coder.lua

module("modules.configs.excel2json.lua_language_coder", package.seeall)

local lua_language_coder = {}
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
local configPath = "configs.language_coder_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_language_coder, "configList", _configList)
	rawset(lua_language_coder, "configDict", _configDict)
end

setmetatable(lua_language_coder, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_language_coder.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_language_coder, "configList", nil)
	rawset(lua_language_coder, "configDict", nil)
end

return lua_language_coder
