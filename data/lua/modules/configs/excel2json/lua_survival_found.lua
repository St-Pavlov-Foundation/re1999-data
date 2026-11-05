-- chunkname: @modules/configs/excel2json/lua_survival_found.lua

module("modules.configs.excel2json.lua_survival_found", package.seeall)

local lua_survival_found = {}
local fields = {
	id = 1,
	desc = 3,
	tagMax = 2
}
local primaryKey = {
	"id"
}
local mlStringKey = {
	desc = 1
}
local _configList, _configDict
local configPath = "configs.survival_found_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_survival_found, "configList", _configList)
	rawset(lua_survival_found, "configDict", _configDict)
end

setmetatable(lua_survival_found, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_survival_found.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_survival_found, "configList", nil)
	rawset(lua_survival_found, "configDict", nil)
end

return lua_survival_found
