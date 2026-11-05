-- chunkname: @modules/configs/excel2json/lua_character_motion_play_cut.lua

module("modules.configs.excel2json.lua_character_motion_play_cut", package.seeall)

local lua_character_motion_play_cut = {}
local fields = {
	whenStopped = 4,
	heroId = 1,
	skinId = 2,
	whenNotStopped = 5,
	motion = 3
}
local primaryKey = {
	"heroId",
	"skinId"
}
local mlStringKey = {}
local _configList, _configDict
local configPath = "configs.character_motion_play_cut_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_character_motion_play_cut, "configList", _configList)
	rawset(lua_character_motion_play_cut, "configDict", _configDict)
end

setmetatable(lua_character_motion_play_cut, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_character_motion_play_cut.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_character_motion_play_cut, "configList", nil)
	rawset(lua_character_motion_play_cut, "configDict", nil)
end

return lua_character_motion_play_cut
