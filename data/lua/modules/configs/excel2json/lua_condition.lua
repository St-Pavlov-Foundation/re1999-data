-- chunkname: @modules/configs/excel2json/lua_condition.lua

module("modules.configs.excel2json.lua_condition", package.seeall)

local lua_condition = {}
local fields = {
	desc = 3,
	progress = 5,
	type = 2,
	id = 1,
	attr = 4
}
local primaryKey = {
	"id"
}
local mlStringKey = {
	desc = 1
}
local _configList, _configDict
local configPath = "configs.condition_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_condition, "configList", _configList)
	rawset(lua_condition, "configDict", _configDict)
end

setmetatable(lua_condition, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_condition.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_condition, "configList", nil)
	rawset(lua_condition, "configDict", nil)
end

return lua_condition
