-- chunkname: @modules/configs/excel2json/lua_activity192_game.lua

module("modules.configs.excel2json.lua_activity192_game", package.seeall)

local lua_activity192_game = {}
local fields = {
	cubeOpenAnim = 4,
	cubeSwitchAnim = 5,
	removeCount = 3,
	panelImage = 6,
	id = 1,
	scenePath = 7,
	maps = 2
}
local primaryKey = {
	"id"
}
local mlStringKey = {}
local _configList, _configDict
local configPath = "configs.activity192_game_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_activity192_game, "configList", _configList)
	rawset(lua_activity192_game, "configDict", _configDict)
end

setmetatable(lua_activity192_game, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_activity192_game.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_activity192_game, "configList", nil)
	rawset(lua_activity192_game, "configDict", nil)
end

return lua_activity192_game
