-- chunkname: @modules/configs/excel2json/lua_activity178_resource.lua

module("modules.configs.excel2json.lua_activity178_resource", package.seeall)

local lua_activity178_resource = {}
local fields = {
	tips = 5,
	name = 3,
	id = 2,
	icon = 4,
	activityId = 1
}
local primaryKey = {
	"activityId",
	"id"
}
local mlStringKey = {
	tips = 2,
	name = 1
}
local _configList, _configDict
local configPath = "configs.activity178_resource_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_activity178_resource, "configList", _configList)
	rawset(lua_activity178_resource, "configDict", _configDict)
end

setmetatable(lua_activity178_resource, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_activity178_resource.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_activity178_resource, "configList", nil)
	rawset(lua_activity178_resource, "configDict", nil)
end

return lua_activity178_resource
