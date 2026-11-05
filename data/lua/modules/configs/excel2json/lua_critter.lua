-- chunkname: @modules/configs/excel2json/lua_critter.lua

module("modules.configs.excel2json.lua_critter", package.seeall)

local lua_critter = {}
local fields = {
	eventTimes = 16,
	name = 2,
	rare = 3,
	specialRate = 12,
	banishBonus = 13,
	raceTag = 11,
	catalogue = 14,
	desc = 7,
	relation = 17,
	story = 19,
	attributeIncrRate = 9,
	foodLike = 15,
	icon = 6,
	trainTime = 10,
	mutateSkin = 5,
	line = 18,
	baseAttribute = 8,
	normalSkin = 4,
	id = 1
}
local primaryKey = {
	"id"
}
local mlStringKey = {
	line = 3,
	name = 1,
	story = 4,
	desc = 2
}
local _configList, _configDict
local configPath = "configs.critter_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_critter, "configList", _configList)
	rawset(lua_critter, "configDict", _configDict)
end

setmetatable(lua_critter, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_critter.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_critter, "configList", nil)
	rawset(lua_critter, "configDict", nil)
end

return lua_critter
