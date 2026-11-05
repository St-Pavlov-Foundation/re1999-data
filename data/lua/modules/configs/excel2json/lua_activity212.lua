-- chunkname: @modules/configs/excel2json/lua_activity212.lua

module("modules.configs.excel2json.lua_activity212", package.seeall)

local lua_activity212 = {}
local fields = {
	id = 1,
	link = 3,
	activityId = 2
}
local primaryKey = {
	"id"
}
local mlStringKey = {}
local _configList, _configDict
local configPath = "configs.activity212_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_activity212, "configList", _configList)
	rawset(lua_activity212, "configDict", _configDict)
end

setmetatable(lua_activity212, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_activity212.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_activity212, "configList", nil)
	rawset(lua_activity212, "configDict", nil)
end

return lua_activity212
