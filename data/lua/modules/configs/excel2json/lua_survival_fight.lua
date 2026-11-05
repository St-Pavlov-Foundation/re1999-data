-- chunkname: @modules/configs/excel2json/lua_survival_fight.lua

module("modules.configs.excel2json.lua_survival_fight", package.seeall)

local lua_survival_fight = {}
local fields = {
	fightLevel = 20,
	name = 2,
	choiceText = 14,
	rotate = 11,
	grid = 10,
	warningRange = 15,
	skip = 17,
	camera = 12,
	transferId = 18,
	subType = 21,
	desc = 6,
	copyIds = 22,
	battleId = 19,
	worldLevel = 23,
	isRepeat = 24,
	incidental = 26,
	versions = 4,
	priority = 7,
	exp = 28,
	incidentalRange = 27,
	group = 3,
	roll = 25,
	subItem = 29,
	resource = 8,
	enforce = 16,
	behavior = 13,
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
local configPath = "configs.survival_fight_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_survival_fight, "configList", _configList)
	rawset(lua_survival_fight, "configDict", _configDict)
end

setmetatable(lua_survival_fight, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_survival_fight.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_survival_fight, "configList", nil)
	rawset(lua_survival_fight, "configDict", nil)
end

return lua_survival_fight
