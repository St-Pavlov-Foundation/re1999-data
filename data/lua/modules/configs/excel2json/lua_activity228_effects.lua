-- chunkname: @modules/configs/excel2json/lua_activity228_effects.lua

module("modules.configs.excel2json.lua_activity228_effects", package.seeall)

local lua_activity228_effects = {}
local fields = {
	param = 2,
	effectId = 1
}
local primaryKey = {
	"effectId"
}
local mlStringKey = {}
local _configList, _configDict
local configPath = "configs.activity228_effects_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_activity228_effects, "configList", _configList)
	rawset(lua_activity228_effects, "configDict", _configDict)
end

setmetatable(lua_activity228_effects, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_activity228_effects.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_activity228_effects, "configList", nil)
	rawset(lua_activity228_effects, "configDict", nil)
end

return lua_activity228_effects
