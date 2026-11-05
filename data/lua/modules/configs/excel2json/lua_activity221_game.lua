-- chunkname: @modules/configs/excel2json/lua_activity221_game.lua

module("modules.configs.excel2json.lua_activity221_game", package.seeall)

local lua_activity221_game = {}
local fields = {
	maxBuff = 7,
	mapId = 1,
	time = 2,
	targets = 3,
	useSkill = 8,
	type7Weight = 5,
	targetDesc = 4,
	type7Num = 6
}
local primaryKey = {
	"mapId"
}
local mlStringKey = {
	targetDesc = 1
}
local _configList, _configDict
local configPath = "configs.activity221_game_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_activity221_game, "configList", _configList)
	rawset(lua_activity221_game, "configDict", _configDict)
end

setmetatable(lua_activity221_game, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_activity221_game.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_activity221_game, "configList", nil)
	rawset(lua_activity221_game, "configDict", nil)
end

return lua_activity221_game
