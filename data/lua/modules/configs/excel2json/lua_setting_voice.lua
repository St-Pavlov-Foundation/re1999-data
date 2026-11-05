-- chunkname: @modules/configs/excel2json/lua_setting_voice.lua

module("modules.configs.excel2json.lua_setting_voice", package.seeall)

local lua_setting_voice = {}
local fields = {
	shortcuts = 1,
	tips = 2
}
local primaryKey = {
	"shortcuts"
}
local mlStringKey = {
	tips = 1
}
local _configList, _configDict
local configPath = "configs.setting_voice_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_setting_voice, "configList", _configList)
	rawset(lua_setting_voice, "configDict", _configDict)
end

setmetatable(lua_setting_voice, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_setting_voice.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_setting_voice, "configList", nil)
	rawset(lua_setting_voice, "configDict", nil)
end

return lua_setting_voice
