-- chunkname: @modules/configs/excel2json/lua_arcade_survivor_hall_unit.lua

module("modules.configs.excel2json.lua_arcade_survivor_hall_unit", package.seeall)

local lua_arcade_survivor_hall_unit = {}
local fields = {
	resName = 6,
	name = 2,
	isOpenTip = 12,
	reddot = 10,
	grid = 4,
	nameOffset = 9,
	pos = 5,
	desc = 3,
	posOffset = 8,
	lockObj = 15,
	difficulty = 14,
	lockToast = 16,
	id = 1,
	talkGroupIds = 11,
	scale = 7,
	enterViewName = 13
}
local primaryKey = {
	"id"
}
local mlStringKey = {
	desc = 2,
	name = 1
}
local _configList, _configDict
local configPath = "configs.arcade_survivor_hall_unit_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_arcade_survivor_hall_unit, "configList", _configList)
	rawset(lua_arcade_survivor_hall_unit, "configDict", _configDict)
end

setmetatable(lua_arcade_survivor_hall_unit, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_arcade_survivor_hall_unit.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_arcade_survivor_hall_unit, "configList", nil)
	rawset(lua_arcade_survivor_hall_unit, "configDict", nil)
end

return lua_arcade_survivor_hall_unit
