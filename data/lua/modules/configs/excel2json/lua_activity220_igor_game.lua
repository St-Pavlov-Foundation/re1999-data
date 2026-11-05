-- chunkname: @modules/configs/excel2json/lua_activity220_igor_game.lua

module("modules.configs.excel2json.lua_activity220_igor_game", package.seeall)

local lua_activity220_igor_game = {}
local fields = {
	soldier = 4,
	gameid = 1,
	enemyId = 3,
	rules = 5,
	oursideId = 2
}
local primaryKey = {
	"gameid"
}
local mlStringKey = {}
local _configList, _configDict
local configPath = "configs.activity220_igor_game_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_activity220_igor_game, "configList", _configList)
	rawset(lua_activity220_igor_game, "configDict", _configDict)
end

setmetatable(lua_activity220_igor_game, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_activity220_igor_game.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_activity220_igor_game, "configList", nil)
	rawset(lua_activity220_igor_game, "configDict", nil)
end

return lua_activity220_igor_game
