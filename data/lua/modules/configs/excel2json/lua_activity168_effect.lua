-- chunkname: @modules/configs/excel2json/lua_activity168_effect.lua

module("modules.configs.excel2json.lua_activity168_effect", package.seeall)

local lua_activity168_effect = {}
local fields = {
	effectParams = 3,
	effectType = 2,
	desc = 4,
	effectId = 1
}
local primaryKey = {
	"effectId"
}
local mlStringKey = {
	desc = 1
}
local _configList, _configDict
local configPath = "configs.activity168_effect_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_activity168_effect, "configList", _configList)
	rawset(lua_activity168_effect, "configDict", _configDict)
end

setmetatable(lua_activity168_effect, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_activity168_effect.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_activity168_effect, "configList", nil)
	rawset(lua_activity168_effect, "configDict", nil)
end

return lua_activity168_effect
