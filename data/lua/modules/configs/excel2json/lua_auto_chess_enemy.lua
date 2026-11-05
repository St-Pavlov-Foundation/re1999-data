-- chunkname: @modules/configs/excel2json/lua_auto_chess_enemy.lua

module("modules.configs.excel2json.lua_auto_chess_enemy", package.seeall)

local lua_auto_chess_enemy = {}
local fields = {
	id = 1,
	masterId = 2,
	mutation = 3
}
local primaryKey = {
	"id"
}
local mlStringKey = {}
local _configList, _configDict
local configPath = "configs.auto_chess_enemy_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_auto_chess_enemy, "configList", _configList)
	rawset(lua_auto_chess_enemy, "configDict", _configDict)
end

setmetatable(lua_auto_chess_enemy, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_auto_chess_enemy.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_auto_chess_enemy, "configList", nil)
	rawset(lua_auto_chess_enemy, "configDict", nil)
end

return lua_auto_chess_enemy
