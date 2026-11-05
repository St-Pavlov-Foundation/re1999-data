-- chunkname: @modules/configs/excel2json/lua_activity231_invention.lua

module("modules.configs.excel2json.lua_activity231_invention", package.seeall)

local lua_activity231_invention = {}
local fields = {
	name = 5,
	type = 3,
	id = 2,
	icon = 6,
	activityId = 1,
	recipe = 4
}
local primaryKey = {
	"activityId",
	"id"
}
local mlStringKey = {
	name = 1
}
local _configList, _configDict
local configPath = "configs.activity231_invention_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_activity231_invention, "configList", _configList)
	rawset(lua_activity231_invention, "configDict", _configDict)
end

setmetatable(lua_activity231_invention, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_activity231_invention.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_activity231_invention, "configList", nil)
	rawset(lua_activity231_invention, "configDict", nil)
end

return lua_activity231_invention
