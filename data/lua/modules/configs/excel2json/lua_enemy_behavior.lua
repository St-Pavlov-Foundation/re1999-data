-- chunkname: @modules/configs/excel2json/lua_enemy_behavior.lua

module("modules.configs.excel2json.lua_enemy_behavior", package.seeall)

local lua_enemy_behavior = {}
local fields = {
	effectRound = 3,
	chessId = 4,
	strategy = 6,
	behaviorGroup = 2,
	id = 1,
	effectCondition = 5
}
local primaryKey = {
	"id"
}
local mlStringKey = {}
local _configList, _configDict
local configPath = "configs.enemy_behavior_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_enemy_behavior, "configList", _configList)
	rawset(lua_enemy_behavior, "configDict", _configDict)
end

setmetatable(lua_enemy_behavior, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_enemy_behavior.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_enemy_behavior, "configList", nil)
	rawset(lua_enemy_behavior, "configDict", nil)
end

return lua_enemy_behavior
