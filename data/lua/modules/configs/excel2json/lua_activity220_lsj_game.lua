-- chunkname: @modules/configs/excel2json/lua_activity220_lsj_game.lua

module("modules.configs.excel2json.lua_activity220_lsj_game", package.seeall)

local lua_activity220_lsj_game = {}
local fields = {
	groupId = 1,
	source = 3,
	gameId = 2
}
local primaryKey = {
	"groupId"
}
local mlStringKey = {}
local _configList, _configDict
local configPath = "configs.activity220_lsj_game_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_activity220_lsj_game, "configList", _configList)
	rawset(lua_activity220_lsj_game, "configDict", _configDict)
end

setmetatable(lua_activity220_lsj_game, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_activity220_lsj_game.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_activity220_lsj_game, "configList", nil)
	rawset(lua_activity220_lsj_game, "configDict", nil)
end

return lua_activity220_lsj_game
