-- chunkname: @modules/configs/excel2json/lua_activity220_const.lua

module("modules.configs.excel2json.lua_activity220_const", package.seeall)

local lua_activity220_const = {}
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
local configPath = "configs.activity220_const_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_activity220_const, "configList", _configList)
	rawset(lua_activity220_const, "configDict", _configDict)
end

setmetatable(lua_activity220_const, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_activity220_const.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_activity220_const, "configList", nil)
	rawset(lua_activity220_const, "configDict", nil)
end

return lua_activity220_const
