-- chunkname: @modules/configs/excel2json/lua_activity196_const.lua

module("modules.configs.excel2json.lua_activity196_const", package.seeall)

local lua_activity196_const = {}
local fields = {
	activityId = 1,
	time = 2
}
local primaryKey = {
	"activityId"
}
local mlStringKey = {}
local _configList, _configDict
local configPath = "configs.activity196_const_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_activity196_const, "configList", _configList)
	rawset(lua_activity196_const, "configDict", _configDict)
end

setmetatable(lua_activity196_const, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_activity196_const.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_activity196_const, "configList", nil)
	rawset(lua_activity196_const, "configDict", nil)
end

return lua_activity196_const
