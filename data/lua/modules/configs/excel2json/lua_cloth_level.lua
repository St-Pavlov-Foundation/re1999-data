-- chunkname: @modules/configs/excel2json/lua_cloth_level.lua

module("modules.configs.excel2json.lua_cloth_level", package.seeall)

local lua_cloth_level = {}
local fields = {
	usePower1 = 15,
	passiveSkills = 13,
	usePower3 = 23,
	recover = 8,
	death = 11,
	desc = 12,
	allLimit1 = 17,
	move = 6,
	skill2 = 18,
	maxPower = 3,
	cd2 = 20,
	initial = 9,
	skill4 = 26,
	defeat = 10,
	use = 4,
	level = 2,
	compose = 7,
	allLimit2 = 21,
	allLimit3 = 25,
	usePower4 = 27,
	cd4 = 28,
	allLimit4 = 29,
	exp = 30,
	skill3 = 22,
	usePower2 = 19,
	useDeviceCard = 5,
	skill1 = 14,
	cd3 = 24,
	id = 1,
	cd1 = 16
}
local primaryKey = {
	"id",
	"level"
}
local mlStringKey = {
	desc = 1
}
local _configList, _configDict
local configPath = "configs.cloth_level_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_cloth_level, "configList", _configList)
	rawset(lua_cloth_level, "configDict", _configDict)
end

setmetatable(lua_cloth_level, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_cloth_level.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_cloth_level, "configList", nil)
	rawset(lua_cloth_level, "configDict", nil)
end

return lua_cloth_level
