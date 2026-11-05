-- chunkname: @modules/configs/excel2json/lua_push_box_activity.lua

module("modules.configs.excel2json.lua_push_box_activity", package.seeall)

local lua_push_box_activity = {}
local fields = {
	stageId = 2,
	episodeIds = 3,
	activityId = 1,
	openDay = 4
}
local primaryKey = {
	"activityId",
	"stageId"
}
local mlStringKey = {}
local _configList, _configDict
local configPath = "configs.push_box_activity_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_push_box_activity, "configList", _configList)
	rawset(lua_push_box_activity, "configDict", _configDict)
end

setmetatable(lua_push_box_activity, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_push_box_activity.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_push_box_activity, "configList", nil)
	rawset(lua_push_box_activity, "configDict", nil)
end

return lua_push_box_activity
