-- chunkname: @modules/configs/excel2json/lua_weekwalk_level.lua

module("modules.configs.excel2json.lua_weekwalk_level", package.seeall)

local lua_weekwalk_level = {}
local fields = {
	id = 1,
	bonus = 3,
	desc = 2
}
local primaryKey = {
	"id"
}
local mlStringKey = {
	desc = 1
}
local _configList, _configDict
local configPath = "configs.weekwalk_level_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_weekwalk_level, "configList", _configList)
	rawset(lua_weekwalk_level, "configDict", _configDict)
end

setmetatable(lua_weekwalk_level, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_weekwalk_level.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_weekwalk_level, "configList", nil)
	rawset(lua_weekwalk_level, "configDict", nil)
end

return lua_weekwalk_level
