-- chunkname: @modules/configs/excel2json/lua_activity157_mission.lua

module("modules.configs.excel2json.lua_activity157_mission", package.seeall)

local lua_activity157_mission = {}
local fields = {
	groupId = 3,
	area = 9,
	storyId = 7,
	linePrefab = 8,
	pos = 6,
	elementId = 5,
	missionId = 2,
	activityId = 1,
	order = 4
}
local primaryKey = {
	"activityId",
	"missionId"
}
local mlStringKey = {}
local _configList, _configDict
local configPath = "configs.activity157_mission_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_activity157_mission, "configList", _configList)
	rawset(lua_activity157_mission, "configDict", _configDict)
end

setmetatable(lua_activity157_mission, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_activity157_mission.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_activity157_mission, "configList", nil)
	rawset(lua_activity157_mission, "configDict", nil)
end

return lua_activity157_mission
