-- chunkname: @modules/configs/excel2json/lua_survival_search.lua

module("modules.configs.excel2json.lua_survival_search", package.seeall)

local lua_survival_search = {}
local fields = {
	drop = 15,
	name = 2,
	desc = 6,
	rotate = 11,
	grid = 10,
	choiceText = 13,
	copyIds = 18,
	camera = 12,
	worldLevel = 19,
	subType = 17,
	isRepeat = 20,
	consume = 14,
	incidental = 22,
	exp = 24,
	versions = 4,
	priority = 7,
	incidentalRange = 23,
	group = 3,
	roll = 21,
	resource = 8,
	enforce = 16,
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
local configPath = "configs.survival_search_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_survival_search, "configList", _configList)
	rawset(lua_survival_search, "configDict", _configDict)
end

setmetatable(lua_survival_search, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_survival_search.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_survival_search, "configList", nil)
	rawset(lua_survival_search, "configDict", nil)
end

return lua_survival_search
