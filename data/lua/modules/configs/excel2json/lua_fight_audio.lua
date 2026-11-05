-- chunkname: @modules/configs/excel2json/lua_fight_audio.lua

module("modules.configs.excel2json.lua_fight_audio", package.seeall)

local lua_fight_audio = {}
local fields = {
	id = 1,
	bankName = 3,
	weapon = 4,
	eventName = 2
}
local primaryKey = {
	"id"
}
local mlStringKey = {}
local _configList, _configDict
local configPath = "configs.fight_audio_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_fight_audio, "configList", _configList)
	rawset(lua_fight_audio, "configDict", _configDict)
end

setmetatable(lua_fight_audio, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_fight_audio.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_fight_audio, "configList", nil)
	rawset(lua_fight_audio, "configDict", nil)
end

return lua_fight_audio
