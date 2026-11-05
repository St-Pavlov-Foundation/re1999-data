-- chunkname: @modules/configs/excel2json/lua_eliminate_battle_cost.lua

module("modules.configs.excel2json.lua_eliminate_battle_cost", package.seeall)

local lua_eliminate_battle_cost = {}
local fields = {
	id = 1,
	value = 2
}
local primaryKey = {
	"id"
}
local mlStringKey = {}
local _configList, _configDict
local configPath = "configs.eliminate_battle_cost_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_eliminate_battle_cost, "configList", _configList)
	rawset(lua_eliminate_battle_cost, "configDict", _configDict)
end

setmetatable(lua_eliminate_battle_cost, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_eliminate_battle_cost.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_eliminate_battle_cost, "configList", nil)
	rawset(lua_eliminate_battle_cost, "configDict", nil)
end

return lua_eliminate_battle_cost
