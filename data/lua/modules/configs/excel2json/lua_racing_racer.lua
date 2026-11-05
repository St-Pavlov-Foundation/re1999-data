-- chunkname: @modules/configs/excel2json/lua_racing_racer.lua

module("modules.configs.excel2json.lua_racing_racer", package.seeall)

local lua_racing_racer = {}
local fields = {
	id = 1,
	name = 2,
	wrongPercent = 15,
	desc1 = 19,
	skillPic = 16,
	baseSpeed = 5,
	pos = 13,
	baseAcceleration = 6,
	ultimateId = 17,
	pic = 9,
	img = 11,
	desc = 20,
	display = 22,
	cost = 18,
	powerSpeed = 3,
	team = 21,
	uiPic = 10,
	initialEffect = 8,
	maxSpeed = 7,
	dolphinPrefab = 14,
	difficult = 4,
	scale = 12
}
local primaryKey = {
	"id"
}
local mlStringKey = {
	team = 4,
	name = 1,
	desc = 3,
	desc1 = 2
}
local _configList, _configDict
local configPath = "configs.racing_racer_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_racing_racer, "configList", _configList)
	rawset(lua_racing_racer, "configDict", _configDict)
end

setmetatable(lua_racing_racer, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_racing_racer.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_racing_racer, "configList", nil)
	rawset(lua_racing_racer, "configDict", nil)
end

return lua_racing_racer
