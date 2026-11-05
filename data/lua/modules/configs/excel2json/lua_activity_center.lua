-- chunkname: @modules/configs/excel2json/lua_activity_center.lua

module("modules.configs.excel2json.lua_activity_center", package.seeall)

local lua_activity_center = {}
local fields = {
	sortPriority = 5,
	name = 2,
	id = 1,
	reddotid = 3,
	icon = 4
}
local primaryKey = {
	"id"
}
local mlStringKey = {
	name = 1
}
local _configList, _configDict
local configPath = "configs.activity_center_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_activity_center, "configList", _configList)
	rawset(lua_activity_center, "configDict", _configDict)
end

setmetatable(lua_activity_center, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_activity_center.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_activity_center, "configList", nil)
	rawset(lua_activity_center, "configDict", nil)
end

return lua_activity_center
