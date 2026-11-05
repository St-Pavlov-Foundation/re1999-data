-- chunkname: @modules/configs/excel2json/lua_auto_chess_enemy_formation.lua

module("modules.configs.excel2json.lua_auto_chess_enemy_formation", package.seeall)

local lua_auto_chess_enemy_formation = {}
local fields = {
	index5 = 9,
	index3 = 7,
	zoneId = 4,
	index1Buff = 10,
	index3Buff = 12,
	index4 = 8,
	round = 3,
	index2Buff = 11,
	index4Buff = 13,
	index2 = 6,
	index5Buff = 14,
	enemyId = 2,
	id = 1,
	index1 = 5
}
local primaryKey = {
	"id"
}
local mlStringKey = {}
local _configList, _configDict
local configPath = "configs.auto_chess_enemy_formation_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_auto_chess_enemy_formation, "configList", _configList)
	rawset(lua_auto_chess_enemy_formation, "configDict", _configDict)
end

setmetatable(lua_auto_chess_enemy_formation, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_auto_chess_enemy_formation.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_auto_chess_enemy_formation, "configList", nil)
	rawset(lua_auto_chess_enemy_formation, "configDict", nil)
end

return lua_auto_chess_enemy_formation
