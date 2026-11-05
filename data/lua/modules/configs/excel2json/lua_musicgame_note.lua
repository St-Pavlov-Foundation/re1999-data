-- chunkname: @modules/configs/excel2json/lua_musicgame_note.lua

module("modules.configs.excel2json.lua_musicgame_note", package.seeall)

local lua_musicgame_note = {}
local fields = {
	id = 1,
	name = 2,
	icon = 3,
	audioId = 4
}
local primaryKey = {
	"id"
}
local mlStringKey = {
	name = 1
}
local _configList, _configDict
local configPath = "configs.musicgame_note_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_musicgame_note, "configList", _configList)
	rawset(lua_musicgame_note, "configDict", _configDict)
end

setmetatable(lua_musicgame_note, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_musicgame_note.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_musicgame_note, "configList", nil)
	rawset(lua_musicgame_note, "configDict", nil)
end

return lua_musicgame_note
