-- chunkname: @modules/configs/excel2json/lua_243_const.lua

module("modules.configs.excel2json.lua_243_const", package.seeall)

local lua_243_const = {}
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
local mlStringKey = {
	value2 = 1
}
local _configList, _configDict
local configPath = "configs.243_const_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_243_const, "configList", _configList)
	rawset(lua_243_const, "configDict", _configDict)
end

setmetatable(lua_243_const, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_243_const.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_243_const, "configList", nil)
	rawset(lua_243_const, "configDict", nil)
end

return lua_243_const
