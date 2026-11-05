-- chunkname: @modules/configs/excel2json/lua_activity191_effect.lua

module("modules.configs.excel2json.lua_activity191_effect", package.seeall)

local lua_activity191_effect = {}
local fields = {
	id = 1,
	group = 2,
	typeParam = 5,
	type = 4,
	tag = 3,
	itemParam = 6
}
local primaryKey = {
	"id"
}
local mlStringKey = {}
local _configList, _configDict
local configPath = "configs.activity191_effect_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_activity191_effect, "configList", _configList)
	rawset(lua_activity191_effect, "configDict", _configDict)
end

setmetatable(lua_activity191_effect, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_activity191_effect.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_activity191_effect, "configList", nil)
	rawset(lua_activity191_effect, "configDict", nil)
end

return lua_activity191_effect
