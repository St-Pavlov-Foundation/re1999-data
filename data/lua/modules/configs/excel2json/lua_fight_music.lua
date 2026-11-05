-- chunkname: @modules/configs/excel2json/lua_fight_music.lua

module("modules.configs.excel2json.lua_fight_music", package.seeall)

local lua_fight_music = {}
local fields = {
	param = 5,
	battleId = 2,
	monster = 3,
	switch = 6,
	id = 1,
	invokeType = 4
}
local primaryKey = {
	"id",
	"battleId",
	"monster",
	"invokeType",
	"param"
}
local mlStringKey = {}
local _configList, _configDict
local configPath = "configs.fight_music_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_fight_music, "configList", _configList)
	rawset(lua_fight_music, "configDict", _configDict)
end

setmetatable(lua_fight_music, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_fight_music.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_fight_music, "configList", nil)
	rawset(lua_fight_music, "configDict", nil)
end

return lua_fight_music
