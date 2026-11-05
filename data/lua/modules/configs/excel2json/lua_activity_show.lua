-- chunkname: @modules/configs/excel2json/lua_activity_show.lua

module("modules.configs.excel2json.lua_activity_show", package.seeall)

local lua_activity_show = {}
local fields = {
	jumpId = 6,
	taskDesc = 4,
	centerId = 7,
	actDesc = 3,
	id = 2,
	activityId = 1,
	showBonus = 5
}
local primaryKey = {
	"activityId",
	"id"
}
local mlStringKey = {
	taskDesc = 2,
	actDesc = 1
}
local _configList, _configDict
local configPath = "configs.activity_show_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_activity_show, "configList", _configList)
	rawset(lua_activity_show, "configDict", _configDict)
end

setmetatable(lua_activity_show, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_activity_show.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_activity_show, "configList", nil)
	rawset(lua_activity_show, "configDict", nil)
end

return lua_activity_show
