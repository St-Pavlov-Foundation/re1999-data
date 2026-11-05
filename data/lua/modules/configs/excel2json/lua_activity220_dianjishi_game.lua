-- chunkname: @modules/configs/excel2json/lua_activity220_dianjishi_game.lua

module("modules.configs.excel2json.lua_activity220_dianjishi_game", package.seeall)

local lua_activity220_dianjishi_game = {}
local fields = {
	mapIcon = 3,
	startPos = 4,
	mapScale = 5,
	areaSplitSize = 6,
	targetDesc = 2,
	gameId = 1
}
local primaryKey = {
	"gameId"
}
local mlStringKey = {
	targetDesc = 1
}
local _configList, _configDict
local configPath = "configs.activity220_dianjishi_game_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_activity220_dianjishi_game, "configList", _configList)
	rawset(lua_activity220_dianjishi_game, "configDict", _configDict)
end

setmetatable(lua_activity220_dianjishi_game, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_activity220_dianjishi_game.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_activity220_dianjishi_game, "configList", nil)
	rawset(lua_activity220_dianjishi_game, "configDict", nil)
end

return lua_activity220_dianjishi_game
