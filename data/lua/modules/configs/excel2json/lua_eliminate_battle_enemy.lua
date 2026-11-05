-- chunkname: @modules/configs/excel2json/lua_eliminate_battle_enemy.lua

module("modules.configs.excel2json.lua_eliminate_battle_enemy", package.seeall)

local lua_eliminate_battle_enemy = {}
local fields = {
	id = 1,
	icon = 2,
	hp = 3,
	loop = 4
}
local primaryKey = {
	"id"
}
local mlStringKey = {}
local _configList, _configDict
local configPath = "configs.eliminate_battle_enemy_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_eliminate_battle_enemy, "configList", _configList)
	rawset(lua_eliminate_battle_enemy, "configDict", _configDict)
end

setmetatable(lua_eliminate_battle_enemy, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_eliminate_battle_enemy.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_eliminate_battle_enemy, "configList", nil)
	rawset(lua_eliminate_battle_enemy, "configDict", nil)
end

return lua_eliminate_battle_enemy
