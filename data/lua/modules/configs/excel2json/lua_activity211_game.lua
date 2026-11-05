-- chunkname: @modules/configs/excel2json/lua_activity211_game.lua

module("modules.configs.excel2json.lua_activity211_game", package.seeall)

local lua_activity211_game = {}
local fields = {
	desc = 5,
	shadowBg = 4,
	groupId = 1,
	targetDesc = 3,
	gameId = 2
}
local primaryKey = {
	"groupId"
}
local mlStringKey = {
	targetDesc = 1,
	desc = 2
}
local _configList, _configDict
local configPath = "configs.activity211_game_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_activity211_game, "configList", _configList)
	rawset(lua_activity211_game, "configDict", _configDict)
end

setmetatable(lua_activity211_game, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_activity211_game.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_activity211_game, "configList", nil)
	rawset(lua_activity211_game, "configDict", nil)
end

return lua_activity211_game
