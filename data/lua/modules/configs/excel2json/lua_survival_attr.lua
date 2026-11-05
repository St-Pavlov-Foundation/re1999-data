-- chunkname: @modules/configs/excel2json/lua_survival_attr.lua

module("modules.configs.excel2json.lua_survival_attr", package.seeall)

local lua_survival_attr = {}
local fields = {
	id = 1,
	name = 2,
	flag = 3,
	desc = 4
}
local primaryKey = {
	"id"
}
local mlStringKey = {
	desc = 2,
	name = 1
}
local _configList, _configDict
local configPath = "configs.survival_attr_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_survival_attr, "configList", _configList)
	rawset(lua_survival_attr, "configDict", _configDict)
end

setmetatable(lua_survival_attr, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_survival_attr.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_survival_attr, "configList", nil)
	rawset(lua_survival_attr, "configDict", nil)
end

return lua_survival_attr
