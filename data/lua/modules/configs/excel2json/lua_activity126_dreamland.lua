-- chunkname: @modules/configs/excel2json/lua_activity126_dreamland.lua

module("modules.configs.excel2json.lua_activity126_dreamland", package.seeall)

local lua_activity126_dreamland = {}
local fields = {
	indicator = 5,
	num = 6,
	dreamCards = 7,
	battleIds = 8,
	id = 1,
	cardSkill = 4,
	activityId = 2,
	desc = 3
}
local primaryKey = {
	"id"
}
local mlStringKey = {
	desc = 1
}
local _configList, _configDict
local configPath = "configs.activity126_dreamland_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_activity126_dreamland, "configList", _configList)
	rawset(lua_activity126_dreamland, "configDict", _configDict)
end

setmetatable(lua_activity126_dreamland, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_activity126_dreamland.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_activity126_dreamland, "configList", nil)
	rawset(lua_activity126_dreamland, "configDict", nil)
end

return lua_activity126_dreamland
