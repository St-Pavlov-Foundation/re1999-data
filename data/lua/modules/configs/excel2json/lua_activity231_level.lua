-- chunkname: @modules/configs/excel2json/lua_activity231_level.lua

module("modules.configs.excel2json.lua_activity231_level", package.seeall)

local lua_activity231_level = {}
local fields = {
	exp = 3,
	activityId = 1,
	level = 2
}
local primaryKey = {
	"activityId",
	"level"
}
local mlStringKey = {}
local _configList, _configDict
local configPath = "configs.activity231_level_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_activity231_level, "configList", _configList)
	rawset(lua_activity231_level, "configDict", _configDict)
end

setmetatable(lua_activity231_level, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_activity231_level.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_activity231_level, "configList", nil)
	rawset(lua_activity231_level, "configDict", nil)
end

return lua_activity231_level
