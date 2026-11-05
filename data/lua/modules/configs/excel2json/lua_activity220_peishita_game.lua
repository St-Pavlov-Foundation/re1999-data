-- chunkname: @modules/configs/excel2json/lua_activity220_peishita_game.lua

module("modules.configs.excel2json.lua_activity220_peishita_game", package.seeall)

local lua_activity220_peishita_game = {}
local fields = {
	targetDesc = 4,
	mapId = 3,
	activityId = 1,
	gameId = 2
}
local primaryKey = {
	"activityId",
	"gameId"
}
local mlStringKey = {
	targetDesc = 1
}
local _configList, _configDict
local configPath = "configs.activity220_peishita_game_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_activity220_peishita_game, "configList", _configList)
	rawset(lua_activity220_peishita_game, "configDict", _configDict)
end

setmetatable(lua_activity220_peishita_game, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_activity220_peishita_game.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_activity220_peishita_game, "configList", nil)
	rawset(lua_activity220_peishita_game, "configDict", nil)
end

return lua_activity220_peishita_game
