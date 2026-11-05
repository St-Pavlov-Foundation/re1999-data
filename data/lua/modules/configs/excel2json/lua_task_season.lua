-- chunkname: @modules/configs/excel2json/lua_task_season.lua

module("modules.configs.excel2json.lua_task_season", package.seeall)

local lua_task_season = {}
local fields = {
	sortId = 12,
	isOnline = 5,
	listenerType = 8,
	activity104EquipBonus = 14,
	maxFinishCount = 11,
	jumpId = 15,
	desc = 7,
	listenerParam = 9,
	minType = 4,
	seasonId = 2,
	minTypeId = 3,
	id = 1,
	maxProgress = 10,
	bgType = 6,
	bonus = 13
}
local primaryKey = {
	"id"
}
local mlStringKey = {
	desc = 2,
	minType = 1
}
local _configList, _configDict
local configPath = "configs.task_season_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_task_season, "configList", _configList)
	rawset(lua_task_season, "configDict", _configDict)
end

setmetatable(lua_task_season, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_task_season.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_task_season, "configList", nil)
	rawset(lua_task_season, "configDict", nil)
end

return lua_task_season
