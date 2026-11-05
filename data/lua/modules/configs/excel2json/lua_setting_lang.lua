-- chunkname: @modules/configs/excel2json/lua_setting_lang.lua

module("modules.configs.excel2json.lua_setting_lang", package.seeall)

local lua_setting_lang = {}
local fields = {
	fontasset2 = 4,
	lang = 2,
	textfontasset1 = 5,
	textfontasset2 = 6,
	shortcuts = 1,
	fontasset1 = 3
}
local primaryKey = {
	"shortcuts"
}
local mlStringKey = {}
local _configList, _configDict
local configPath = "configs.setting_lang_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_setting_lang, "configList", _configList)
	rawset(lua_setting_lang, "configDict", _configDict)
end

setmetatable(lua_setting_lang, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_setting_lang.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_setting_lang, "configList", nil)
	rawset(lua_setting_lang, "configDict", nil)
end

return lua_setting_lang
