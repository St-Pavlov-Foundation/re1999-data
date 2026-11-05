-- chunkname: @modules/configs/excel2json/lua_explore_hero_effect.lua

module("modules.configs.excel2json.lua_explore_hero_effect", package.seeall)

local lua_explore_hero_effect = {}
local fields = {
	audioId = 5,
	status = 1,
	index = 2,
	effectPath = 3,
	hangPath = 4
}
local primaryKey = {
	"status",
	"index"
}
local mlStringKey = {}
local _configList, _configDict
local configPath = "configs.explore_hero_effect_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_explore_hero_effect, "configList", _configList)
	rawset(lua_explore_hero_effect, "configDict", _configDict)
end

setmetatable(lua_explore_hero_effect, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_explore_hero_effect.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_explore_hero_effect, "configList", nil)
	rawset(lua_explore_hero_effect, "configDict", nil)
end

return lua_explore_hero_effect
