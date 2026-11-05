-- chunkname: @modules/configs/excel2json/lua_activity120_interact_effect.lua

module("modules.configs.excel2json.lua_activity120_interact_effect", package.seeall)

local lua_activity120_interact_effect = {}
local fields = {
	id = 1,
	effectType = 2,
	avatar = 4,
	piontName = 3
}
local primaryKey = {
	"id"
}
local mlStringKey = {}
local _configList, _configDict
local configPath = "configs.activity120_interact_effect_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_activity120_interact_effect, "configList", _configList)
	rawset(lua_activity120_interact_effect, "configDict", _configDict)
end

setmetatable(lua_activity120_interact_effect, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_activity120_interact_effect.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_activity120_interact_effect, "configList", nil)
	rawset(lua_activity120_interact_effect, "configDict", nil)
end

return lua_activity120_interact_effect
