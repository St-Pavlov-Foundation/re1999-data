-- chunkname: @modules/configs/excel2json/lua_activity191_ex_level.lua

module("modules.configs.excel2json.lua_activity191_ex_level", package.seeall)

local lua_activity191_ex_level = {}
local fields = {
	desc = 3,
	monsterId = 1,
	skillLevel = 2
}
local primaryKey = {
	"monsterId",
	"skillLevel"
}
local mlStringKey = {
	desc = 1
}
local _configList, _configDict
local configPath = "configs.activity191_ex_level_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_activity191_ex_level, "configList", _configList)
	rawset(lua_activity191_ex_level, "configDict", _configDict)
end

setmetatable(lua_activity191_ex_level, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_activity191_ex_level.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_activity191_ex_level, "configList", nil)
	rawset(lua_activity191_ex_level, "configDict", nil)
end

return lua_activity191_ex_level
