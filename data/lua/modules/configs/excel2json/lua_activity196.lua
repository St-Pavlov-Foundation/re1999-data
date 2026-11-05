-- chunkname: @modules/configs/excel2json/lua_activity196.lua

module("modules.configs.excel2json.lua_activity196", package.seeall)

local lua_activity196 = {}
local fields = {
	id = 1,
	code = 3,
	activityId = 2,
	bonus = 4
}
local primaryKey = {
	"id"
}
local mlStringKey = {}
local _configList, _configDict
local configPath = "configs.activity196_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_activity196, "configList", _configList)
	rawset(lua_activity196, "configDict", _configDict)
end

setmetatable(lua_activity196, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_activity196.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_activity196, "configList", nil)
	rawset(lua_activity196, "configDict", nil)
end

return lua_activity196
