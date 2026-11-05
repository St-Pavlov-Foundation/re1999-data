-- chunkname: @modules/configs/excel2json/lua_activity231_effect.lua

module("modules.configs.excel2json.lua_activity231_effect", package.seeall)

local lua_activity231_effect = {}
local fields = {
	id = 1,
	effectVx = 3,
	desc = 2
}
local primaryKey = {
	"id"
}
local mlStringKey = {
	desc = 1
}
local _configList, _configDict
local configPath = "configs.activity231_effect_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_activity231_effect, "configList", _configList)
	rawset(lua_activity231_effect, "configDict", _configDict)
end

setmetatable(lua_activity231_effect, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_activity231_effect.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_activity231_effect, "configList", nil)
	rawset(lua_activity231_effect, "configDict", nil)
end

return lua_activity231_effect
