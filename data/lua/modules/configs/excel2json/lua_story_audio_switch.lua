-- chunkname: @modules/configs/excel2json/lua_story_audio_switch.lua

module("modules.configs.excel2json.lua_story_audio_switch", package.seeall)

local lua_story_audio_switch = {}
local fields = {
	switchgroup = 2,
	id = 1,
	switchstate = 3
}
local primaryKey = {
	"id"
}
local mlStringKey = {}
local _configList, _configDict
local configPath = "configs.story_audio_switch_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_story_audio_switch, "configList", _configList)
	rawset(lua_story_audio_switch, "configDict", _configDict)
end

setmetatable(lua_story_audio_switch, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_story_audio_switch.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_story_audio_switch, "configList", nil)
	rawset(lua_story_audio_switch, "configDict", nil)
end

return lua_story_audio_switch
