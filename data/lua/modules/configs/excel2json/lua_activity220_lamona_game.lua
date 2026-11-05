-- chunkname: @modules/configs/excel2json/lua_activity220_lamona_game.lua

module("modules.configs.excel2json.lua_activity220_lamona_game", package.seeall)

local lua_activity220_lamona_game = {}
local fields = {
	mapId = 2,
	propCount = 5,
	propId = 4,
	targetDesc = 3,
	gameId = 1
}
local primaryKey = {
	"gameId"
}
local mlStringKey = {
	targetDesc = 1
}
local _configList, _configDict
local configPath = "configs.activity220_lamona_game_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_activity220_lamona_game, "configList", _configList)
	rawset(lua_activity220_lamona_game, "configDict", _configDict)
end

setmetatable(lua_activity220_lamona_game, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_activity220_lamona_game.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_activity220_lamona_game, "configList", nil)
	rawset(lua_activity220_lamona_game, "configDict", nil)
end

return lua_activity220_lamona_game
