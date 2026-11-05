-- chunkname: @modules/configs/excel2json/lua_activity_publicity.lua

module("modules.configs.excel2json.lua_activity_publicity", package.seeall)

local lua_activity_publicity = {}
local fields = {
	jumpId = 7,
	slogan = 5,
	activityId = 8,
	type = 2,
	id = 1,
	title = 4,
	showItemId = 6,
	activityBonus = 3
}
local primaryKey = {
	"id",
	"type"
}
local mlStringKey = {
	slogan = 2,
	title = 1
}
local _configList, _configDict
local configPath = "configs.activity_publicity_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_activity_publicity, "configList", _configList)
	rawset(lua_activity_publicity, "configDict", _configDict)
end

setmetatable(lua_activity_publicity, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_activity_publicity.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_activity_publicity, "configList", nil)
	rawset(lua_activity_publicity, "configDict", nil)
end

return lua_activity_publicity
