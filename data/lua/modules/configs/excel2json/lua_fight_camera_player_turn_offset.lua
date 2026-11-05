-- chunkname: @modules/configs/excel2json/lua_fight_camera_player_turn_offset.lua

module("modules.configs.excel2json.lua_fight_camera_player_turn_offset", package.seeall)

local lua_fight_camera_player_turn_offset = {}
local fields = {
	id = 1,
	offset = 2
}
local primaryKey = {
	"id"
}
local mlStringKey = {}
local _configList, _configDict
local configPath = "configs.fight_camera_player_turn_offset_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_fight_camera_player_turn_offset, "configList", _configList)
	rawset(lua_fight_camera_player_turn_offset, "configDict", _configDict)
end

setmetatable(lua_fight_camera_player_turn_offset, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_fight_camera_player_turn_offset.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_fight_camera_player_turn_offset, "configList", nil)
	rawset(lua_fight_camera_player_turn_offset, "configDict", nil)
end

return lua_fight_camera_player_turn_offset
