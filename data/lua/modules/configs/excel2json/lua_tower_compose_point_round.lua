-- chunkname: @modules/configs/excel2json/lua_tower_compose_point_round.lua

module("modules.configs.excel2json.lua_tower_compose_point_round", package.seeall)

local lua_tower_compose_point_round = {}
local fields = {
	round = 1,
	bossPointAdd = 2
}
local primaryKey = {
	"round"
}
local mlStringKey = {}
local _configList, _configDict
local configPath = "configs.tower_compose_point_round_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_tower_compose_point_round, "configList", _configList)
	rawset(lua_tower_compose_point_round, "configDict", _configDict)
end

setmetatable(lua_tower_compose_point_round, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_tower_compose_point_round.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_tower_compose_point_round, "configList", nil)
	rawset(lua_tower_compose_point_round, "configDict", nil)
end

return lua_tower_compose_point_round
