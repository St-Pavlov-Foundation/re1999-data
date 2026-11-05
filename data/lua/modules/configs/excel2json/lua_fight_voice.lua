-- chunkname: @modules/configs/excel2json/lua_fight_voice.lua

module("modules.configs.excel2json.lua_fight_voice", package.seeall)

local lua_fight_voice = {}
local fields = {
	audio_type3 = 4,
	audio_type9 = 10,
	audio_type4 = 5,
	skinId = 1,
	audio_type1 = 2,
	audio_type10 = 11,
	audio_type2 = 3,
	audio_type7 = 8,
	audio_type8 = 9,
	audio_type5 = 6,
	audio_type6 = 7
}
local primaryKey = {
	"skinId"
}
local mlStringKey = {}
local _configList, _configDict
local configPath = "configs.fight_voice_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_fight_voice, "configList", _configList)
	rawset(lua_fight_voice, "configDict", _configDict)
end

setmetatable(lua_fight_voice, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_fight_voice.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_fight_voice, "configList", nil)
	rawset(lua_fight_voice, "configDict", nil)
end

return lua_fight_voice
