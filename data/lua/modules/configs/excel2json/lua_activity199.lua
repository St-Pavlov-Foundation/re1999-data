-- chunkname: @modules/configs/excel2json/lua_activity199.lua

module("modules.configs.excel2json.lua_activity199", package.seeall)

local lua_activity199 = {}
local fields = {
	activityId = 1,
	heroIds = 2
}
local primaryKey = {
	"activityId"
}
local mlStringKey = {}
local _configList, _configDict
local configPath = "configs.activity199_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_activity199, "configList", _configList)
	rawset(lua_activity199, "configDict", _configDict)
end

setmetatable(lua_activity199, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_activity199.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_activity199, "configList", nil)
	rawset(lua_activity199, "configDict", nil)
end

return lua_activity199
