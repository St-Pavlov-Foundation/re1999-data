-- chunkname: @modules/configs/excel2json/lua_survival_level.lua

module("modules.configs.excel2json.lua_survival_level", package.seeall)

local lua_survival_level = {}
local fields = {
	id = 1,
	exp = 2
}
local primaryKey = {
	"id"
}
local mlStringKey = {}
local _configList, _configDict
local configPath = "configs.survival_level_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_survival_level, "configList", _configList)
	rawset(lua_survival_level, "configDict", _configDict)
end

setmetatable(lua_survival_level, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_survival_level.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_survival_level, "configList", nil)
	rawset(lua_survival_level, "configDict", nil)
end

return lua_survival_level
