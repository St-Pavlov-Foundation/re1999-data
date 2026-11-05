-- chunkname: @modules/configs/excel2json/lua_critter_interaction_audio.lua

module("modules.configs.excel2json.lua_critter_interaction_audio", package.seeall)

local lua_critter_interaction_audio = {}
local fields = {
	animName = 2,
	critterId = 1,
	audioId = 3
}
local primaryKey = {
	"critterId",
	"animName"
}
local mlStringKey = {}
local _configList, _configDict
local configPath = "configs.critter_interaction_audio_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_critter_interaction_audio, "configList", _configList)
	rawset(lua_critter_interaction_audio, "configDict", _configDict)
end

setmetatable(lua_critter_interaction_audio, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_critter_interaction_audio.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_critter_interaction_audio, "configList", nil)
	rawset(lua_critter_interaction_audio, "configDict", nil)
end

return lua_critter_interaction_audio
