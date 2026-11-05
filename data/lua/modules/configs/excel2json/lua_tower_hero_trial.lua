-- chunkname: @modules/configs/excel2json/lua_tower_hero_trial.lua

module("modules.configs.excel2json.lua_tower_hero_trial", package.seeall)

local lua_tower_hero_trial = {}
local fields = {
	season = 1,
	endTime = 3,
	heroIds = 4,
	startTime = 2
}
local primaryKey = {
	"season"
}
local mlStringKey = {}
local _configList, _configDict
local configPath = "configs.tower_hero_trial_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_tower_hero_trial, "configList", _configList)
	rawset(lua_tower_hero_trial, "configDict", _configDict)
end

setmetatable(lua_tower_hero_trial, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_tower_hero_trial.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_tower_hero_trial, "configList", nil)
	rawset(lua_tower_hero_trial, "configDict", nil)
end

return lua_tower_hero_trial
