-- chunkname: @modules/configs/excel2json/lua_activity160_mission.lua

module("modules.configs.excel2json.lua_activity160_mission", package.seeall)

local lua_activity160_mission = {}
local fields = {
	bonus = 5,
	desc = 6,
	preId = 4,
	sort = 7,
	id = 2,
	episodeId = 8,
	activityId = 1,
	mailId = 3
}
local primaryKey = {
	"activityId",
	"id"
}
local mlStringKey = {
	desc = 1
}
local _configList, _configDict
local configPath = "configs.activity160_mission_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_activity160_mission, "configList", _configList)
	rawset(lua_activity160_mission, "configDict", _configDict)
end

setmetatable(lua_activity160_mission, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_activity160_mission.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_activity160_mission, "configList", nil)
	rawset(lua_activity160_mission, "configDict", nil)
end

return lua_activity160_mission
