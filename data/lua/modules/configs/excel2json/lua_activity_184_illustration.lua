-- chunkname: @modules/configs/excel2json/lua_activity_184_illustration.lua

module("modules.configs.excel2json.lua_activity_184_illustration", package.seeall)

local lua_activity_184_illustration = {}
local fields = {
	path = 5,
	id = 2,
	shape = 4,
	activityId = 1,
	attribute = 3
}
local primaryKey = {
	"activityId",
	"id"
}
local mlStringKey = {}
local _configList, _configDict
local configPath = "configs.activity_184_illustration_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_activity_184_illustration, "configList", _configList)
	rawset(lua_activity_184_illustration, "configDict", _configDict)
end

setmetatable(lua_activity_184_illustration, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_activity_184_illustration.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_activity_184_illustration, "configList", nil)
	rawset(lua_activity_184_illustration, "configDict", nil)
end

return lua_activity_184_illustration
