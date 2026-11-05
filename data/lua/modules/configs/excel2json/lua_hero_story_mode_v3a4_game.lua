-- chunkname: @modules/configs/excel2json/lua_hero_story_mode_v3a4_game.lua

module("modules.configs.excel2json.lua_hero_story_mode_v3a4_game", package.seeall)

local lua_hero_story_mode_v3a4_game = {}
local fields = {
	nodeSlot = 4,
	nodeId = 2,
	nodeName = 3,
	nodeItemId = 6,
	audioId = 7,
	nodePoint = 5,
	audioTime = 8,
	gameId = 1
}
local primaryKey = {
	"gameId",
	"nodeId"
}
local mlStringKey = {
	nodeName = 1
}
local _configList, _configDict
local configPath = "configs.hero_story_mode_v3a4_game_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_hero_story_mode_v3a4_game, "configList", _configList)
	rawset(lua_hero_story_mode_v3a4_game, "configDict", _configDict)
end

setmetatable(lua_hero_story_mode_v3a4_game, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_hero_story_mode_v3a4_game.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_hero_story_mode_v3a4_game, "configList", nil)
	rawset(lua_hero_story_mode_v3a4_game, "configDict", nil)
end

return lua_hero_story_mode_v3a4_game
