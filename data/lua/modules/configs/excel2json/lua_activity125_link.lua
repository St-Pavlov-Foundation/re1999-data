-- chunkname: @modules/configs/excel2json/lua_activity125_link.lua

module("modules.configs.excel2json.lua_activity125_link", package.seeall)

local lua_activity125_link = {}
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
local configPath = "configs.activity125_link_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_activity125_link, "configList", _configList)
	rawset(lua_activity125_link, "configDict", _configDict)
end

setmetatable(lua_activity125_link, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_activity125_link.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_activity125_link, "configList", nil)
	rawset(lua_activity125_link, "configDict", nil)
end

return lua_activity125_link
