-- chunkname: @modules/configs/excel2json/lua_activity203_ai.lua

module("modules.configs.excel2json.lua_activity203_ai", package.seeall)

local lua_activity203_ai = {}
local fields = {
	gaptime = 3,
	assist_weight = 10,
	negative_move_weight = 8,
	attack_weight = 4,
	positive_move_weight = 6,
	hero_move_rate = 11,
	hero_go_front_ornot = 13,
	ai_index = 2,
	negative_move_trigger_rate = 9,
	attack_trigger_rate = 5,
	positive_move_trigger_rate = 7,
	id = 1,
	hero_or_soldier = 12
}
local primaryKey = {
	"id",
	"ai_index"
}
local mlStringKey = {}
local _configList, _configDict
local configPath = "configs.activity203_ai_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_activity203_ai, "configList", _configList)
	rawset(lua_activity203_ai, "configDict", _configDict)
end

setmetatable(lua_activity203_ai, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_activity203_ai.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_activity203_ai, "configList", nil)
	rawset(lua_activity203_ai, "configDict", nil)
end

return lua_activity203_ai
