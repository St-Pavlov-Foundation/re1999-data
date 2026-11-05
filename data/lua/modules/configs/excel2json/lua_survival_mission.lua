-- chunkname: @modules/configs/excel2json/lua_survival_mission.lua

module("modules.configs.excel2json.lua_survival_mission", package.seeall)

local lua_survival_mission = {}
local fields = {
	desc = 6,
	name = 2,
	worldLevel = 17,
	rotate = 11,
	grid = 10,
	choiceText = 13,
	isRepeat = 18,
	camera = 12,
	incidental = 20,
	subType = 15,
	roleId = 22,
	copyIds = 16,
	exp = 23,
	subItem = 24,
	versions = 4,
	priority = 7,
	incidentalRange = 21,
	group = 3,
	roll = 19,
	resource = 8,
	enforce = 14,
	seasons = 5,
	id = 1,
	waterResource = 9
}
local primaryKey = {
	"id"
}
local mlStringKey = {
	choiceText = 3,
	name = 1,
	desc = 2
}
local _configList, _configDict
local configPath = "configs.survival_mission_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_survival_mission, "configList", _configList)
	rawset(lua_survival_mission, "configDict", _configDict)
end

setmetatable(lua_survival_mission, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_survival_mission.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_survival_mission, "configList", nil)
	rawset(lua_survival_mission, "configDict", nil)
end

return lua_survival_mission
