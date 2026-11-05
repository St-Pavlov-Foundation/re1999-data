-- chunkname: @modules/configs/excel2json/lua_character_special_interaction_voice.lua

module("modules.configs.excel2json.lua_character_special_interaction_voice", package.seeall)

local lua_character_special_interaction_voice = {}
local fields = {
	waitVoiceParams = 4,
	protectionTime = 6,
	time = 2,
	timeoutVoice = 5,
	id = 1,
	statusParams = 7,
	waitVoice = 3
}
local primaryKey = {
	"id"
}
local mlStringKey = {}
local _configList, _configDict
local configPath = "configs.character_special_interaction_voice_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_character_special_interaction_voice, "configList", _configList)
	rawset(lua_character_special_interaction_voice, "configDict", _configDict)
end

setmetatable(lua_character_special_interaction_voice, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_character_special_interaction_voice.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_character_special_interaction_voice, "configList", nil)
	rawset(lua_character_special_interaction_voice, "configDict", nil)
end

return lua_character_special_interaction_voice
