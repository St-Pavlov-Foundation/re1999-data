-- chunkname: @modules/configs/excel2json/lua_survival_npc.lua

module("modules.configs.excel2json.lua_survival_npc", package.seeall)

local lua_survival_npc = {}
local fields = {
	npcDesc = 14,
	name = 2,
	waterResource = 9,
	rotate = 10,
	transferId = 21,
	choiceText = 13,
	reward = 18,
	desc = 7,
	surBehavior = 23,
	subType = 15,
	cost = 20,
	copyIds = 25,
	tag = 17,
	recruitment = 19,
	worldLevel = 24,
	smallIcon = 12,
	versions = 5,
	extendCost = 3,
	priority = 26,
	incidentalRange = 29,
	incidental = 28,
	headIcon = 11,
	rare = 16,
	resource = 8,
	roll = 27,
	renown = 30,
	behavior = 22,
	seasons = 6,
	id = 1,
	exp = 31,
	takeOut = 4
}
local primaryKey = {
	"id"
}
local mlStringKey = {
	npcDesc = 4,
	name = 1,
	choiceText = 3,
	desc = 2
}
local _configList, _configDict
local configPath = "configs.survival_npc_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_survival_npc, "configList", _configList)
	rawset(lua_survival_npc, "configDict", _configDict)
end

setmetatable(lua_survival_npc, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_survival_npc.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_survival_npc, "configList", nil)
	rawset(lua_survival_npc, "configDict", nil)
end

return lua_survival_npc
