-- chunkname: @modules/configs/excel2json/lua_character_limited_voice.lua

module("modules.configs.excel2json.lua_character_limited_voice", package.seeall)

local lua_character_limited_voice = {}
local fields = {
	twcontent = 6,
	encontent = 5,
	frcontent = 10,
	audio = 2,
	decontent = 9,
	thaicontent = 11,
	content = 4,
	jpcontent = 7,
	kocontent = 8,
	id = 1,
	addaudio = 3
}
local primaryKey = {
	"id"
}
local mlStringKey = {}
local _configList, _configDict
local configPath = "configs.character_limited_voice_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_character_limited_voice, "configList", _configList)
	rawset(lua_character_limited_voice, "configDict", _configDict)
end

setmetatable(lua_character_limited_voice, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_character_limited_voice.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_character_limited_voice, "configList", nil)
	rawset(lua_character_limited_voice, "configDict", nil)
end

return lua_character_limited_voice
