-- chunkname: @modules/configs/excel2json/lua_racing_const.lua

module("modules.configs.excel2json.lua_racing_const", package.seeall)

local lua_racing_const = {}
local fields = {
	id = 2,
	value = 3,
	activityId = 1,
	value2 = 4
}
local primaryKey = {
	"activityId",
	"id"
}
local mlStringKey = {}
local _configList, _configDict
local configPath = "configs.racing_const_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_racing_const, "configList", _configList)
	rawset(lua_racing_const, "configDict", _configDict)
end

setmetatable(lua_racing_const, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_racing_const.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_racing_const, "configList", nil)
	rawset(lua_racing_const, "configDict", nil)
end

return lua_racing_const
