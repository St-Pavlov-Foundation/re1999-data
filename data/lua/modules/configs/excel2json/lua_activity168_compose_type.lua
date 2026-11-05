-- chunkname: @modules/configs/excel2json/lua_activity168_compose_type.lua

module("modules.configs.excel2json.lua_activity168_compose_type", package.seeall)

local lua_activity168_compose_type = {}
local fields = {
	name = 3,
	composeType = 2,
	activityId = 1,
	costItems = 4
}
local primaryKey = {
	"activityId",
	"composeType"
}
local mlStringKey = {
	name = 1
}
local _configList, _configDict
local configPath = "configs.activity168_compose_type_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_activity168_compose_type, "configList", _configList)
	rawset(lua_activity168_compose_type, "configDict", _configDict)
end

setmetatable(lua_activity168_compose_type, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_activity168_compose_type.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_activity168_compose_type, "configList", nil)
	rawset(lua_activity168_compose_type, "configDict", nil)
end

return lua_activity168_compose_type
