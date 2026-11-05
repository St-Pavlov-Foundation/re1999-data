-- chunkname: @modules/configs/excel2json/lua_activity157_mission_group.lua

module("modules.configs.excel2json.lua_activity157_mission_group", package.seeall)

local lua_activity157_mission_group = {}
local fields = {
	type = 3,
	mapName = 4,
	activityId = 1,
	missionGroupId = 2
}
local primaryKey = {
	"activityId",
	"missionGroupId"
}
local mlStringKey = {
	mapName = 1
}
local _configList, _configDict
local configPath = "configs.activity157_mission_group_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_activity157_mission_group, "configList", _configList)
	rawset(lua_activity157_mission_group, "configDict", _configDict)
end

setmetatable(lua_activity157_mission_group, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_activity157_mission_group.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_activity157_mission_group, "configList", nil)
	rawset(lua_activity157_mission_group, "configDict", nil)
end

return lua_activity157_mission_group
