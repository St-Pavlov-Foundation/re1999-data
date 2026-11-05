-- chunkname: @modules/configs/excel2json/lua_hero_effectiveness.lua

module("modules.configs.excel2json.lua_hero_effectiveness", package.seeall)

local lua_hero_effectiveness = {}
local fields = {
	sr = 3,
	ssr = 2,
	r = 4,
	level = 1
}
local primaryKey = {
	"level"
}
local mlStringKey = {}
local _configList, _configDict
local configPath = "configs.hero_effectiveness_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_hero_effectiveness, "configList", _configList)
	rawset(lua_hero_effectiveness, "configDict", _configDict)
end

setmetatable(lua_hero_effectiveness, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_hero_effectiveness.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_hero_effectiveness, "configList", nil)
	rawset(lua_hero_effectiveness, "configDict", nil)
end

return lua_hero_effectiveness
