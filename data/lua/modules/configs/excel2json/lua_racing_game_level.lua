-- chunkname: @modules/configs/excel2json/lua_racing_game_level.lua

module("modules.configs.excel2json.lua_racing_game_level", package.seeall)

local lua_racing_game_level = {}
local fields = {
	map = 6,
	name = 3,
	video = 5,
	desc = 4,
	traceId = 2,
	starCondition = 7,
	aiRacer = 8,
	gameId = 1
}
local primaryKey = {
	"gameId"
}
local mlStringKey = {
	desc = 2,
	name = 1
}
local _configList, _configDict
local configPath = "configs.racing_game_level_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_racing_game_level, "configList", _configList)
	rawset(lua_racing_game_level, "configDict", _configDict)
end

setmetatable(lua_racing_game_level, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_racing_game_level.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_racing_game_level, "configList", nil)
	rawset(lua_racing_game_level, "configDict", nil)
end

return lua_racing_game_level
