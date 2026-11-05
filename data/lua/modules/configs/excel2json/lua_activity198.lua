-- chunkname: @modules/configs/excel2json/lua_activity198.lua

module("modules.configs.excel2json.lua_activity198", package.seeall)

local lua_activity198 = {}
local fields = {
	activityId = 1,
	num = 3,
	skinIds = 2,
	bonus = 4
}
local primaryKey = {
	"activityId"
}
local mlStringKey = {}
local _configList, _configDict
local configPath = "configs.activity198_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_activity198, "configList", _configList)
	rawset(lua_activity198, "configDict", _configDict)
end

setmetatable(lua_activity198, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_activity198.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_activity198, "configList", nil)
	rawset(lua_activity198, "configDict", nil)
end

return lua_activity198
