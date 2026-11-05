-- chunkname: @modules/configs/excel2json/lua_activity210_game.lua

module("modules.configs.excel2json.lua_activity210_game", package.seeall)

local lua_activity210_game = {}
local fields = {
	battleGroup = 3,
	mapId = 2,
	gameTarget = 4,
	battleTime = 7,
	loseTarget = 5,
	skill = 6,
	battledesc = 8,
	targetDesc = 9,
	gameId = 1
}
local primaryKey = {
	"gameId"
}
local mlStringKey = {}
local _configList, _configDict
local configPath = "configs.activity210_game_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_activity210_game, "configList", _configList)
	rawset(lua_activity210_game, "configDict", _configDict)
end

setmetatable(lua_activity210_game, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_activity210_game.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_activity210_game, "configList", nil)
	rawset(lua_activity210_game, "configDict", nil)
end

return lua_activity210_game
