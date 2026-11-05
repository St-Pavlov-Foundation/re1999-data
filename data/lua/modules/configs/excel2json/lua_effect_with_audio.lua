-- chunkname: @modules/configs/excel2json/lua_effect_with_audio.lua

module("modules.configs.excel2json.lua_effect_with_audio", package.seeall)

local lua_effect_with_audio = {}
local fields = {
	id = 1,
	effect = 2,
	audioId = 3,
	once = 4
}
local primaryKey = {
	"id"
}
local mlStringKey = {}
local _configList, _configDict
local configPath = "configs.effect_with_audio_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_effect_with_audio, "configList", _configList)
	rawset(lua_effect_with_audio, "configDict", _configDict)
end

setmetatable(lua_effect_with_audio, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_effect_with_audio.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_effect_with_audio, "configList", nil)
	rawset(lua_effect_with_audio, "configDict", nil)
end

return lua_effect_with_audio
