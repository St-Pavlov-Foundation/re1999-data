-- chunkname: @modules/configs/excel2json/lua_college_const.lua

module("modules.configs.excel2json.lua_college_const", package.seeall)

local lua_college_const = {}
local fields = {
	value = 2,
	id = 1,
	mlvalue = 3
}
local primaryKey = {
	"id"
}
local mlStringKey = {
	mlvalue = 1
}
local _configList, _configDict
local configPath = "configs.college_const_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_college_const, "configList", _configList)
	rawset(lua_college_const, "configDict", _configDict)
end

setmetatable(lua_college_const, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_college_const.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_college_const, "configList", nil)
	rawset(lua_college_const, "configDict", nil)
end

return lua_college_const
