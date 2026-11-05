-- chunkname: @modules/configs/excel2json/lua_racing_effect.lua

module("modules.configs.excel2json.lua_racing_effect", package.seeall)

local lua_racing_effect = {}
local fields = {
	param = 4,
	effectType = 3,
	id = 1,
	carAnimation = 2,
	limit = 5
}
local primaryKey = {
	"id"
}
local mlStringKey = {}
local _configList, _configDict
local configPath = "configs.racing_effect_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_racing_effect, "configList", _configList)
	rawset(lua_racing_effect, "configDict", _configDict)
end

setmetatable(lua_racing_effect, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_racing_effect.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_racing_effect, "configList", nil)
	rawset(lua_racing_effect, "configDict", nil)
end

return lua_racing_effect
