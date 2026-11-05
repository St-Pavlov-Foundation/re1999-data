-- chunkname: @modules/configs/excel2json/lua_fight_boss_evolution_client.lua

module("modules.configs.excel2json.lua_fight_boss_evolution_client", package.seeall)

local lua_fight_boss_evolution_client = {}
local fields = {
	nextSkinId = 2,
	id = 1,
	timeline = 3
}
local primaryKey = {
	"id"
}
local mlStringKey = {}
local _configList, _configDict
local configPath = "configs.fight_boss_evolution_client_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_fight_boss_evolution_client, "configList", _configList)
	rawset(lua_fight_boss_evolution_client, "configDict", _configDict)
end

setmetatable(lua_fight_boss_evolution_client, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_fight_boss_evolution_client.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_fight_boss_evolution_client, "configList", nil)
	rawset(lua_fight_boss_evolution_client, "configDict", nil)
end

return lua_fight_boss_evolution_client
