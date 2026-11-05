-- chunkname: @modules/configs/excel2json/lua_activity174_effect.lua

module("modules.configs.excel2json.lua_activity174_effect", package.seeall)

local lua_activity174_effect = {}
local fields = {
	season = 2,
	id = 1,
	typeParam = 4,
	type = 3
}
local primaryKey = {
	"id"
}
local mlStringKey = {}
local _configList, _configDict
local configPath = "configs.activity174_effect_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_activity174_effect, "configList", _configList)
	rawset(lua_activity174_effect, "configDict", _configDict)
end

setmetatable(lua_activity174_effect, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_activity174_effect.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_activity174_effect, "configList", nil)
	rawset(lua_activity174_effect, "configDict", nil)
end

return lua_activity174_effect
