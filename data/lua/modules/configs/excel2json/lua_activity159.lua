-- chunkname: @modules/configs/excel2json/lua_activity159.lua

module("modules.configs.excel2json.lua_activity159", package.seeall)

local lua_activity159 = {}
local fields = {
	bonus = 3,
	activityId = 1,
	day = 2
}
local primaryKey = {
	"activityId",
	"day"
}
local mlStringKey = {}
local _configList, _configDict
local configPath = "configs.activity159_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_activity159, "configList", _configList)
	rawset(lua_activity159, "configDict", _configDict)
end

setmetatable(lua_activity159, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_activity159.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_activity159, "configList", nil)
	rawset(lua_activity159, "configDict", nil)
end

return lua_activity159
