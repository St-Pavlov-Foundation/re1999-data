-- chunkname: @modules/configs/excel2json/lua_summoned.lua

module("modules.configs.excel2json.lua_summoned", package.seeall)

local lua_summoned = {}
local fields = {
	group = 4,
	enterTime = 14,
	includeTypes = 5,
	closeTime = 15,
	keyForEntiySummon = 18,
	enterAudio = 16,
	aniEffect = 10,
	maxLevel = 3,
	skills = 6,
	uniqueSkills = 7,
	closeAudio = 17,
	level = 2,
	stanceId = 9,
	closeEffect = 13,
	enterEffect = 11,
	additionRule = 8,
	loopEffect = 12,
	id = 1
}
local primaryKey = {
	"id",
	"level"
}
local mlStringKey = {}
local _configList, _configDict
local configPath = "configs.summoned_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_summoned, "configList", _configList)
	rawset(lua_summoned, "configDict", _configDict)
end

setmetatable(lua_summoned, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_summoned.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_summoned, "configList", nil)
	rawset(lua_summoned, "configDict", nil)
end

return lua_summoned
