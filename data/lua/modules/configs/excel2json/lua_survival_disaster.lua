-- chunkname: @modules/configs/excel2json/lua_survival_disaster.lua

module("modules.configs.excel2json.lua_survival_disaster", package.seeall)

local lua_survival_disaster = {}
local fields = {
	block = 2,
	name = 3,
	disasterDesc = 5,
	level = 6,
	id = 1,
	recommend = 4
}
local primaryKey = {
	"id"
}
local mlStringKey = {
	disasterDesc = 2,
	name = 1
}
local _configList, _configDict
local configPath = "configs.survival_disaster_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_survival_disaster, "configList", _configList)
	rawset(lua_survival_disaster, "configDict", _configDict)
end

setmetatable(lua_survival_disaster, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_survival_disaster.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_survival_disaster, "configList", nil)
	rawset(lua_survival_disaster, "configDict", nil)
end

return lua_survival_disaster
