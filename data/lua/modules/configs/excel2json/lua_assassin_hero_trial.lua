-- chunkname: @modules/configs/excel2json/lua_assassin_hero_trial.lua

module("modules.configs.excel2json.lua_assassin_hero_trial", package.seeall)

local lua_assassin_hero_trial = {}
local fields = {
	heroImg = 5,
	heroIcon = 4,
	secondCareer = 3,
	entityIcon = 6,
	assassinHeroId = 1,
	model = 8,
	career = 2,
	unlock = 7
}
local primaryKey = {
	"assassinHeroId"
}
local mlStringKey = {}
local _configList, _configDict
local configPath = "configs.assassin_hero_trial_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_assassin_hero_trial, "configList", _configList)
	rawset(lua_assassin_hero_trial, "configDict", _configDict)
end

setmetatable(lua_assassin_hero_trial, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_assassin_hero_trial.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_assassin_hero_trial, "configList", nil)
	rawset(lua_assassin_hero_trial, "configDict", nil)
end

return lua_assassin_hero_trial
