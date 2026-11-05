-- chunkname: @modules/configs/excel2json/lua_activity145_game.lua

module("modules.configs.excel2json.lua_activity145_game", package.seeall)

local lua_activity145_game = {}
local fields = {
	id = 1,
	value1 = 2,
	value2 = 3
}
local primaryKey = {
	"id"
}
local mlStringKey = {}
local _configList, _configDict
local configPath = "configs.activity145_game_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_activity145_game, "configList", _configList)
	rawset(lua_activity145_game, "configDict", _configDict)
end

setmetatable(lua_activity145_game, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_activity145_game.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_activity145_game, "configList", nil)
	rawset(lua_activity145_game, "configDict", nil)
end

return lua_activity145_game
