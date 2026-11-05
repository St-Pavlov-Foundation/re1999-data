-- chunkname: @modules/configs/excel2json/lua_eliminate_battle_endless_library_round.lua

module("modules.configs.excel2json.lua_eliminate_battle_endless_library_round", package.seeall)

local lua_eliminate_battle_endless_library_round = {}
local fields = {
	id = 1,
	endlessLibraryRound = 2,
	randomIds = 3
}
local primaryKey = {
	"id"
}
local mlStringKey = {}
local _configList, _configDict
local configPath = "configs.eliminate_battle_endless_library_round_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_eliminate_battle_endless_library_round, "configList", _configList)
	rawset(lua_eliminate_battle_endless_library_round, "configDict", _configDict)
end

setmetatable(lua_eliminate_battle_endless_library_round, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_eliminate_battle_endless_library_round.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_eliminate_battle_endless_library_round, "configList", nil)
	rawset(lua_eliminate_battle_endless_library_round, "configDict", nil)
end

return lua_eliminate_battle_endless_library_round
