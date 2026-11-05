-- chunkname: @modules/configs/excel2json/lua_atomic_avg_game.lua

module("modules.configs.excel2json.lua_atomic_avg_game", package.seeall)

local lua_atomic_avg_game = {}
local fields = {
	id = 1,
	content = 2,
	storyId = 3
}
local primaryKey = {
	"id"
}
local mlStringKey = {
	content = 1
}
local _configList, _configDict
local configPath = "configs.atomic_avg_game_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_atomic_avg_game, "configList", _configList)
	rawset(lua_atomic_avg_game, "configDict", _configDict)
end

setmetatable(lua_atomic_avg_game, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_atomic_avg_game.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_atomic_avg_game, "configList", nil)
	rawset(lua_atomic_avg_game, "configDict", nil)
end

return lua_atomic_avg_game
