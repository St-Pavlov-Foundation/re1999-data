-- chunkname: @modules/configs/excel2json/lua_activity189.lua

module("modules.configs.excel2json.lua_activity189", package.seeall)

local lua_activity189 = {}
local fields = {
	id = 1,
	activityId = 2,
	bonus = 3
}
local primaryKey = {
	"id"
}
local mlStringKey = {}
local _configList, _configDict
local configPath = "configs.activity189_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_activity189, "configList", _configList)
	rawset(lua_activity189, "configDict", _configDict)
end

setmetatable(lua_activity189, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_activity189.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_activity189, "configList", nil)
	rawset(lua_activity189, "configDict", nil)
end

return lua_activity189
